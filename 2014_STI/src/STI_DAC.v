module STI_DAC(clk ,reset, load, pi_data, pi_length, pi_fill, pi_msb, pi_low, pi_end,
	       so_data, so_valid,
	       oem_finish, oem_dataout, oem_addr,
	       odd1_wr, odd2_wr, odd3_wr, odd4_wr, even1_wr, even2_wr, even3_wr, even4_wr);

input		 clk, reset;
input		 load, pi_msb, pi_low, pi_end; 
input [15:0] pi_data;
input [1:0]	 pi_length;
input		 pi_fill;
output		 so_data, so_valid;

output       oem_finish, odd1_wr, odd2_wr, odd3_wr, odd4_wr, even1_wr, even2_wr, even3_wr, even4_wr;
output [4:0] oem_addr;
output [7:0] oem_dataout;

//==============================================================================
	wire send0;
	
	STI sti (.clk       (clk      ),
			 .rst       (reset    ),
			 .load_i    (load     ),
			 .pi_data_i (pi_data  ),
			 .pi_len_i  (pi_length),
			 .pi_fill_i (pi_fill  ),
			 .pi_low_i  (pi_low   ),
			 .pi_msb_i  (pi_msb   ),
			 .pi_end_i  (pi_end   ),
			 .send0_o   (send0    ),
			 .so_valid_o(so_valid ),
			 .so_data_o (so_data  ));

	DAC dac (.clk           (clk        ),
			 .rst           (reset      ),
			 .so_valid_i    (so_valid   ),
			 .so_data_i     (so_data    ),
			 .send0_i       (send0      ),
			 .o1_wr_o       (odd1_wr    ),
			 .o2_wr_o       (odd2_wr    ),
			 .o3_wr_o       (odd3_wr    ),
			 .o4_wr_o       (odd4_wr    ),
			 .e1_wr_o       (even1_wr   ),
			 .e2_wr_o       (even2_wr   ),
			 .e3_wr_o       (even3_wr   ),
			 .e4_wr_o       (even4_wr   ),
			 .oem_finish_o  (oem_finish ),
			 .oem_addr_o    (oem_addr   ),
			 .oem_dataout_o (oem_dataout));

//==============================================================================
endmodule

// {{{ STI
module STI (
	input             clk, 
	input			  rst,
	input             load_i,
	input      [15:0] pi_data_i,
	input      [ 1:0] pi_len_i,
	input             pi_fill_i,
	input  			  pi_low_i,
	input             pi_msb_i,
	input             pi_end_i,
	output reg        send0_o,
	output reg        so_valid_o,
	output reg 		  so_data_o
	);
	
	reg [15:0] pi_data;
	reg [1:0]  pi_len;
	reg pi_fill, pi_low, pi_msb;

	reg  [31:0] sti_data;
	reg  [31:0] mlsb_data;
	reg  [ 4:0] send_idx;

	reg [4:0] cnt;
	reg read_v, send_v;
	reg [1:0] STATE, NEXT;
	parameter	IDLE  = 2'h0,
				READ  = 2'h1, 
				SEND  = 2'h2,
				SEND0 = 2'h3;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			pi_data <= 16'b0;
			pi_len  <= 2'b0;
			pi_fill <= 1'b0;
			pi_low  <= 1'b0;
			pi_msb  <= 1'b0;
		end
		else if (load_i) begin
			pi_data <= pi_data_i;
			pi_len  <= pi_len_i;
			pi_fill <= pi_fill_i;
			pi_low  <= pi_low_i;
			pi_msb  <= pi_msb_i;
		end
	end

	always @(*) begin
		casez({pi_msb, pi_len})
			3'b1??  : send_idx = 5'd31;
			3'b000  : send_idx = 5'd24; // 8
			3'b001  : send_idx = 5'd16; // 16
			3'b010  : send_idx = 5'd8;  // 24
			3'b011  : send_idx = 5'd0;  // 32
			default : send_idx = 5'd31;
		endcase
	end

	always @(*) begin
		casez({pi_fill, pi_low, pi_len})
			4'b?000 : sti_data <= {pi_data[ 7:0], 24'b0};
			4'b?100 : sti_data <= {pi_data[15:8], 24'b0};
			4'b0?10 : sti_data <= {8'b0, pi_data, 8'b0 };  // 24
			4'b1?10 : sti_data <= {pi_data, 16'b0      };
			4'b0?11 : sti_data <= {16'b0, pi_data      };  // 32
			4'b1?11 : sti_data <= {pi_data, 16'b0      }; 
			default : sti_data <= {pi_data, 16'b0      };  // 16
		endcase
	end

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			read_v     <= 1'b0;
			so_valid_o <= 1'b0;
		end
		else begin
			read_v     <= load_i;
			so_valid_o <= STATE == SEND;
			send0_o    <= STATE == SEND0;
		end
	end

	always @(*) begin
		case(pi_len)
			2'b00 : send_v = cnt == 5'd7;
			2'b01 : send_v = cnt == 5'd15;
			2'b10 : send_v = cnt == 5'd23;
			2'b11 : send_v = cnt == 5'd31;
		endcase
	end

	always @(posedge clk or posedge rst) begin
		STATE <= rst ? IDLE : NEXT;
	end
	always @(*) begin
		case(STATE)
			IDLE  : NEXT = READ;
			READ  : NEXT = read_v    ? SEND : READ;
			SEND  : begin
				if (send_v & pi_end_i) 
					NEXT = SEND0;
				else if (send_v) 
					NEXT = IDLE;
				else   
				    NEXT = SEND;
			end
			default : NEXT = SEND0;
		endcase
	end

	always @(posedge clk) begin
		case (STATE)
			SEND    : cnt <= cnt + 5'b1;
			default : cnt <= 5'b0;
		endcase
	end
	always @(posedge clk) begin
		case(STATE)
			SEND    : begin
				case (pi_msb)
					1'b1 : so_data_o <= sti_data[send_idx - cnt];
					1'b0 : so_data_o <= sti_data[send_idx + cnt];
				endcase
			end
			default : so_data_o <= 1'b0;
		endcase
	end

endmodule
// }}}


// {{{ DAC
module DAC (
	input   		 clk,
	input 			 rst,
	input            so_valid_i,
	input            so_data_i,
	input            send0_i,
	output reg [7:0] oem_wr_o,
	output           o1_wr_o,
	output           o2_wr_o,
	output           o3_wr_o,
	output           o4_wr_o,
	output           e1_wr_o,
	output           e2_wr_o,
	output           e3_wr_o,
	output           e4_wr_o,
	output           oem_finish_o,
	output reg [4:0] oem_addr_o,
	output reg [7:0] oem_dataout_o
	);

	reg  [2:0] cnt;
	reg  nxt_addr;
	reg  ch_addr;
	wire stall_mem;
	wire sw_mem;
	reg  data_rdy, wr_sig;

	reg [3:0] STATE, NEXT;
	parameter	IDLE  = 4'h0,
				ODD1  = 4'h1,
				EVEN1 = 4'h2,
				ODD2  = 4'h3,
				EVEN2 = 4'h4,
				ODD3  = 4'h5,
				EVEN3 = 4'h6,
				ODD4  = 4'h7,
				EVEN4 = 4'h8,
				DONE  = 4'h9;
	
	always @(posedge clk or posedge rst) begin
		STATE <= rst ? IDLE : NEXT;
	end
	assign sw_mem    = oem_addr_o == 5'd31;
	assign stall_mem = (oem_addr_o[1:0] == 2'h3) & nxt_addr;
	always @(*) begin
		case (STATE)
			IDLE : NEXT = ODD1;
			ODD1    : begin
				casez ({wr_sig, sw_mem, stall_mem})
					3'b100  : NEXT = EVEN1;
					3'b11?  : NEXT = ODD2;
					default : NEXT = ODD1;
				endcase
			end
			EVEN1   : begin
				casez ({wr_sig, stall_mem})
					2'b10   : NEXT = ODD1;
					default : NEXT = EVEN1;
				endcase
			end
			ODD2    : begin
				casez ({wr_sig, sw_mem, stall_mem})
					3'b100  : NEXT = EVEN2;
					3'b11?  : NEXT = ODD3;
					default : NEXT = ODD2;
				endcase
			end
			EVEN2   : begin
				casez ({wr_sig, stall_mem})
					2'b10   : NEXT = ODD2;
					default : NEXT = EVEN2;
				endcase
			end
			ODD3    : begin
				casez ({wr_sig, sw_mem, stall_mem})
					3'b100  : NEXT = EVEN3;
					3'b11?  : NEXT = ODD4;
					default : NEXT = ODD3;
				endcase
			end
			EVEN3   : begin
				casez ({wr_sig, stall_mem})
					2'b10   : NEXT = ODD3;
					default : NEXT = EVEN3;
				endcase
			end
			ODD4    : begin
				casez ({wr_sig, sw_mem, stall_mem})
					3'b100  : NEXT = EVEN4;
					3'b11?  : NEXT = DONE;
					default : NEXT = ODD4;
				endcase
			end
			EVEN4   : begin
				casez ({wr_sig, stall_mem})
					2'b10   : NEXT = ODD4;
					default : NEXT = EVEN4;
				endcase
			end
			default : NEXT = DONE;
		endcase
	end
	assign oem_finish_o = STATE == DONE;
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			data_rdy <= 1'b0;
			wr_sig   <= 1'b0;
			ch_addr  <= 1'b0;
		end
		else begin
			data_rdy <= cnt == 3'b0;
			wr_sig   <= data_rdy;
			ch_addr  <= nxt_addr & wr_sig;
		end
	end
	always @(posedge clk or posedge rst) begin
		if (rst)
			cnt <= 3'h7;
		else begin
			case ({so_valid_i, send0_i})
				2'b00 : cnt <= 3'h7;
				2'b10 : cnt <= cnt - 3'h1;
				2'b01 : cnt <= cnt - 3'h1;
				default : cnt <= 3'h7;
			endcase
		end
	end	

	always @(posedge clk or posedge rst) begin
		if (rst) 
			nxt_addr <= 1'b0;
		else if (wr_sig)
			nxt_addr <= nxt_addr + 1'b1; 
	end

	always @(posedge clk or posedge rst) begin
		if (rst)
			oem_addr_o <= 5'b0;
		else if (ch_addr)
			oem_addr_o <= oem_addr_o + 5'b1;
	end
	reg [7:0] data;
	always @(posedge clk or posedge rst) begin
		if (rst)
			data <= 8'b0;
		else if (cnt == 3'h7)
			data  <= {so_data_i, 7'b0};
		else
			data[cnt] <= so_data_i;
	end
	
	always @(posedge clk or posedge rst) begin
		if (rst)
			oem_dataout_o <= 8'b0;
		else if (data_rdy)
			oem_dataout_o <= data;
	end

	reg [7:0] oem_wr;
	assign o1_wr_o = oem_wr[7];
	assign o2_wr_o = oem_wr[6];
	assign o3_wr_o = oem_wr[5];
	assign o4_wr_o = oem_wr[4];
	assign e1_wr_o = oem_wr[3];
	assign e2_wr_o = oem_wr[2];
	assign e3_wr_o = oem_wr[1];
	assign e4_wr_o = oem_wr[0];

	always @(posedge clk) begin
		case (STATE)
			ODD1    : begin
				case (wr_sig)
					1'b0 : oem_wr <= 8'b0;
					1'b1 : oem_wr <= 8'b10000000; 
				endcase
			end
			EVEN1   : begin
				case (wr_sig)
					1'b0 : oem_wr <= 8'b0;
					1'b1 : oem_wr <= 8'b00001000; 
				endcase
			end
			ODD2    : begin
				case (wr_sig)
					1'b0 : oem_wr <= 8'b0;
					1'b1 : oem_wr <= 8'b01000000; 
				endcase
			end
			EVEN2   : begin
				case (wr_sig)
					1'b0 : oem_wr <= 8'b0;
					1'b1 : oem_wr <= 8'b00000100; 
				endcase
			end
			ODD3    : begin
				case (wr_sig)
					1'b0 : oem_wr <= 8'b0;
					1'b1 : oem_wr <= 8'b00100000; 
				endcase
			end
			EVEN3   : begin
				case (wr_sig)
					1'b0 : oem_wr <= 8'b0;
					1'b1 : oem_wr <= 8'b00000010; 
				endcase
			end
			ODD4    : begin
				case (wr_sig)
					1'b0 : oem_wr <= 8'b0;
					1'b1 : oem_wr <= 8'b00010000; 
				endcase
			end
			EVEN4   : begin
				case (wr_sig)
					1'b0 : oem_wr <= 8'b0;
					1'b1 : oem_wr <= 8'b1; 
				endcase
			end
			default : oem_wr <= 8'b0;
		endcase
	end
endmodule
// }}}
