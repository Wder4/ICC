
module SET ( clk , rst, en, central, radius, mode, busy, valid, candidate );

input clk, rst;
input en;
input [23:0] central;
input [11:0] radius;
input [1:0] mode;
output busy;
output valid;
output [7:0] candidate;

//===========================================================================

	reg busy, valid;
	reg [1:0] mod;
	reg [7:0] candidate;

	reg 	    [3:0] x [0:2];
	reg 	    [3:0] y [0:2];
	reg         [3:0] r [0:2];
	reg  signed [3:0] inmul;
	wire 		[7:0] mul;
	reg 	    [7:0] dst, r2_A, r2_B, r2_C; 

	reg  [3:0] xcnt, ycnt;
	reg  [3:0] mcnt;  // mul counter
	integer i;
	

	always @(posedge clk or posedge rst) begin
		mod <= rst ? 2'b0 : mode;
	end

	always @(posedge clk or posedge rst) begin
		if (rst)
			busy <= 1'b0;
		else if (en)
			busy <= 1'b1;
		else if (valid)
			busy <= 1'b0;
	end

	wire fin;
	assign fin = (ycnt == 4'h9) & (mcnt == 4'h4);
	always @(posedge clk) begin
		valid <= fin ? 1'b1 : 1'b0;
	end


// {{{
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			for (i = 0; i < 3; i = i + 1) begin
				x[i] <= 4'b0;
				y[i] <= 4'b0;
				r[i] <= 4'b0;
			end
		end
		else if (en) begin
			x[0] <= central[23:20];
			y[0] <= central[19:16];
			r[0] <= radius [11:8 ];
			x[1] <= central[15:12];
			y[1] <= central[11:8 ];
			r[1] <= radius [7 :4 ];
			x[2] <= central[7 :4 ];
			y[2] <= central[3 :0 ];
			r[2] <= radius [3 :0 ];
		end
	end
// }}}
	
	wire mcnt_rst;
	always @(posedge clk) begin
		if (~busy) begin
			xcnt <= 4'b1;
			ycnt <= 4'b1;
		end
		else if (mcnt_rst) begin
			xcnt <= xcnt[3] ? 4'b1 : (xcnt + 4'b1);
			ycnt <= ycnt + {3'b0, xcnt[3]};
		end
	end

	assign mcnt_rst = mcnt == 4'hc; 
	always @(posedge clk) begin
		if (~busy)
			mcnt <= 3'h0;
		else if (mcnt_rst)
			mcnt <= 3'h4;
		else
			mcnt <= mcnt + 3'h1;
	end

	wire mcnt6, mcnt9, mcntc;
	assign mcnt6 = mcnt == 4'h6;
	assign mcnt9 = mcnt == 4'h9;
	assign mcntc = mcnt == 4'hc;

	assign mul   = inmul * inmul;
	always @(*) begin
		case(mcnt)
			4'h1 : inmul = r[0];  // A
			4'h2 : inmul = r[1];  // B
			4'h3 : inmul = r[2];  // C
			4'h4 : inmul = x[0] - xcnt;  // A
			4'h5 : inmul = y[0] - ycnt;  
			4'h7 : inmul = x[1] - xcnt;  // B
			4'h8 : inmul = y[1] - ycnt;
			4'ha : inmul = x[2] - xcnt;  // C
			4'hb : inmul = y[2] - ycnt;
			default : inmul = 4'b0;
		endcase
	end

	wire [7:0] dst_tmp;
	assign dst_tmp = dst + mul;

	always @(posedge clk) begin
		case(mcnt)
			4'h1 : r2_A <= mul;
			4'h2 : r2_B <= mul;
			4'h3 : r2_C <= mul;
			4'h4 : dst  <= mul;
			4'h5 : dst  <= dst_tmp;
			4'h7 : dst  <= mul;
			4'h8 : dst  <= dst_tmp;
			4'ha : dst  <= mul;
			4'hb : dst  <= dst_tmp;
			default : dst <= 8'b0;
		endcase
	end


	reg iscand; 
	reg [1:0] pre_iscand; // {inB, inA}
	wire dst_small_A, dst_small_B, dst_small_C;
	assign dst_small_A = ~(dst > r2_A);
	assign dst_small_B = ~(dst > r2_B);
	assign dst_small_C = ~(dst > r2_C);
	always @(posedge clk) begin
		if (~busy) 
			pre_iscand <= 2'b0;
		else begin
			case(mcnt)
				4'h6 : pre_iscand <= {1'b0       ,   dst_small_A}; 
				4'h9 : pre_iscand <= {dst_small_B, pre_iscand[0]};
				4'hC : pre_iscand <= 2'b0;
			endcase
		end	
	end
	always @(*) begin
		case(mod)
			2'b00 : iscand = mcnt6 ? {~(dst > r2_A)} : 1'b0;
			2'b01 : iscand = mcnt9 & pre_iscand[0] ? ~(dst > r2_B) : 1'b0;
			2'b10 : begin
				case(mcnt)
					4'h6 : iscand = ~(dst > r2_A);
					4'h9 : iscand = ~(dst > r2_B);
					default : iscand = 1'b0;
				endcase
			end
			2'b11 : iscand = 1'b0;
		endcase
	end

	reg iscand_AB2;
	reg iscand_AB, iscand_BC, iscand_AC;
	always @(*) begin
		if ((mod == 2'b10) & mcnt9)
			iscand_AB2 = pre_iscand[0] ? ~(dst > r2_B) : 1'b0;
		else
			iscand_AB2 = 1'b0;
	end
	always @(*) begin
		if (&mod & mcntc) begin
			iscand_AB = pre_iscand == 2'b11 ?   dst > r2_C  : 1'b0;
			iscand_BC = pre_iscand == 2'b10 ? ~(dst > r2_C) : 1'b0; 
			iscand_AC = pre_iscand == 2'b01 ? ~(dst > r2_C) : 1'b0;
		end
		else begin
			iscand_AB = 1'b0;
			iscand_BC = 1'b0;
			iscand_AC = 1'b0;
		end
	end
	
	// candidate
	wire [7:0] formod3;
	assign formod3 = {7'b0, iscand_AB} + {7'b0, iscand_BC} + {7'b0, iscand_AC};
	always @(posedge clk) begin
		if (en)
			candidate <= 8'b0;
		else 
			candidate <= candidate + {7'b0, iscand} - {6'b0, iscand_AB2, 1'b0} + formod3;
	end



//===========================================================================
endmodule


