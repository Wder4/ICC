module DT(
	input 			clk, 
	input			reset,
	output	   		done ,
	output    		sti_rd ,
	output	    	[9:0]	sti_addr ,
	input		    [15:0]	sti_di,
	output	   		res_wr ,
	output	   		res_rd ,
	output	    	[13:0]	res_addr ,
	output	    	[7:0]	res_do,
	input		    [7:0]	res_di
	);

// ==========================================================
	wire fw_start, bw_start;
	wire fw_fin, bw_fin;
	wire iswhite1, iswhite2;
	wire [ 1:0] iswhite;
	wire bw_wr;
	wire [13:0] fw_addr, bw_addr;
	wire cnt4_v;
	
	assign iswhite = {iswhite2, iswhite1};

// {{{ FW
	Forward FW (.clk 		(clk     ),
				.rst 		(reset   ),
				.sti_di_i 	(sti_di  ),
				.cnt4_v_i   (cnt4_v  ),
				.start      (fw_start),
				.sti_rd_o   (sti_rd  ),
				.sti_addr_o (sti_addr),
				.iswhite_o  (iswhite1),
				.fw_addr_o  (fw_addr ),
				.fw_fin_o   (fw_fin  ));
// }}}
// {{{ BW
	Backward BW (.clk        (clk     ),
				 .rst        (reset   ),
				 .bw_start_i (bw_start), 
				 .cnt4_v_i   (cnt4_v  ),
				 .res_di_i   (res_di  ),
				 .iswhite_o  (iswhite2),
				 .bw_addr_o  (bw_addr ),
				 .bw_wr_o    (bw_wr   ),
				 .bw_fin_o   (bw_fin  ));
// }}}
// {{{ RES
	RES res (.clk		 (clk     ),
			 .rst		 (reset   ),
			 .iswhite_i  (iswhite ),
			 .fw_start_i (fw_start),
			 .fw_fin_i   (fw_fin  ),
			 .fw_addr_i  (fw_addr ),
			 .bw_fin_i   (bw_fin  ),
			 .bw_wr_i    (bw_wr   ),
			 .bw_addr_i  (bw_addr ),
			 .res_di_i   (res_di  ),
			 .bw_start_o (bw_start),
			 .cnt4_v_o   (cnt4_v  ),
			 .res_wr_o   (res_wr  ),
			 .res_rd_o   (res_rd  ),
			 .res_do_o   (res_do  ),
			 .res_addr_o (res_addr),
			 .done_o     (done    ));
// }}}


endmodule
// ==========================================================


// {{{ Forward
module Forward (
	input 			  clk,
	input 			  rst,
	input 	   [15:0] sti_di_i,
	input             cnt4_v_i,
	output reg        start,
	output reg        sti_rd_o,
	output reg [ 9:0] sti_addr_o,
	output reg  	  iswhite_o,
	output reg [13:0] fw_addr_o,
	output reg        fw_fin_o      
	);

	wire        fw_data;
	wire        iswhite;
	reg  [ 3:0] cnt16;
	wire        cnt_rst;
	wire 		fin;

	assign fin = fw_addr_o == 14'd16382;
	always @(posedge clk or negedge rst) begin
		if (~rst) begin
			sti_rd_o <= 1'b0; 
			start    <= 1'b0;
			fw_fin_o <= 1'b0;
		end
		else begin
			sti_rd_o <= ~fw_fin_o;
			start    <= sti_rd_o;
			fw_fin_o <= fin ? 1'b1 : fw_fin_o;
		end
	end

	always @(posedge clk) begin
		if (~start) 
			sti_addr_o <= 10'b0;
		else begin
			case({iswhite, cnt_rst})
				2'b11 : sti_addr_o <= sti_addr_o + 10'b1;
				2'b01 : sti_addr_o <= cnt4_v_i ? (sti_addr_o + 10'b1) : sti_addr_o;
			endcase
		end
	end
	assign fw_data = sti_di_i[4'd15 - cnt16];
	assign iswhite = start ? ~fw_data : 1'b0; 
	always @(posedge clk) begin
		if (~start) begin
			iswhite_o <= 1'b0;
			fw_addr_o <= 14'b0;
		end
		else begin
			iswhite_o <= iswhite;
			fw_addr_o <= fw_fin_o ? fw_addr_o : ({sti_addr_o, 4'b0} + {10'b0, cnt16});
		end
	end
	assign cnt_rst = cnt16 == 4'hf;
	always @(posedge clk) begin
		if (~start)
			cnt16 <= 4'b0;
		else if (fw_fin_o)
			cnt16 <= 4'b0;
		else begin
			case({iswhite, cnt4_v_i})
				2'b10   : cnt16 <= cnt16 + 4'b1;
				2'b01   : cnt16 <= cnt16 + 4'b1;
				default : cnt16 <= cnt16;
			endcase
		end
	end

endmodule
// }}}
// {{{ Backward
module Backward (
	input			  clk,
	input             rst,
	input             bw_start_i,
	input             cnt4_v_i,
	input      [ 7:0] res_di_i,
	output reg        iswhite_o,
	output reg [13:0] bw_addr_o,
	output            bw_wr_o,
	output reg        bw_fin_o
	);

	reg [1:0] cnt;
	assign bw_wr_o = cnt == 2'h2;
	always @(posedge clk or negedge rst) begin
		if (~rst) bw_fin_o   <= 1'b0;
		else      bw_fin_o   <= (bw_addr_o == 14'b0) ? 1'b1 : bw_fin_o;
	end

	always @(posedge clk) begin
		if (~bw_start_i)
			cnt <= 2'b0;
		else begin
			case({iswhite_o, cnt[1], cnt4_v_i})
				3'b000  : cnt <= cnt + 2'b1;
				3'b011  : cnt <= 2'b0;
				3'b100  : cnt <= cnt + 2'b1;
				3'b110  : cnt <= 2'b0;
				default : cnt <= cnt;
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (~bw_start_i)
			bw_addr_o <= 14'd16383;
		else if (bw_fin_o)
			bw_addr_o <= bw_addr_o;
		else begin
			case({iswhite_o, cnt[1], cnt4_v_i})
				3'b011 : bw_addr_o <= bw_addr_o - 14'd1;
				3'b110 : bw_addr_o <= bw_addr_o - 14'd1;
			endcase
		end
	end

	always @(posedge clk) begin
		if (~bw_start_i)
			iswhite_o <= 1'b0;
		else if (~cnt[1])
			iswhite_o <= res_di_i == 8'b0;
	end

endmodule
// }}}
// {{{ RES
module RES (
	input			  clk,
	input 			  rst,
	input      [ 1:0] iswhite_i,  // {iswhite2, iswhite1}
	input             fw_start_i,
	input             fw_fin_i,
	input      [13:0] fw_addr_i,
	input             bw_fin_i,
	input             bw_wr_i,
	input      [13:0] bw_addr_i,
	input      [ 7:0] res_di_i,
	output            bw_start_o,
	output reg     	  cnt4_v_o,
	output reg        res_wr_o,
	output reg        res_rd_o,
	output reg [ 7:0] res_do_o,
	output reg [13:0] res_addr_o,
	output reg        done_o
	);
	reg  [ 2:0] cnt4;
	reg         cnt4_rst;
	reg  [13:0] pos;
	reg         fw_fin;
	reg         bw_fin;
	reg  [ 1:0] STATE, NEXT;
	parameter	IDLE = 2'h0,
				FW   = 2'h1,
				BW   = 2'h2,
				DONE = 2'h3;

	assign bw_start_o = STATE == BW; 
	always @(posedge clk or negedge rst) begin
		STATE <= ~rst ? IDLE : NEXT;
	end
	always @(*) begin
		case(STATE)
			IDLE : NEXT = fw_start_i ? FW   : IDLE;
			FW   : NEXT = fw_fin     ? BW   : FW;
			BW   : NEXT = bw_fin     ? DONE : BW;
			default : NEXT = DONE;
		endcase
	end

	always @(posedge clk or negedge rst) begin
		if (~rst) begin
			fw_fin <= 1'b0;
			bw_fin <= 1'b0;
		end
		else begin
			fw_fin <= fw_fin_i;
			bw_fin <= bw_fin_i;
		end
	end
	always @(*) begin
		case(STATE)
			DONE    : done_o = 1'b1;
			default : done_o = 1'b0;
		endcase
	end

	always @(*) begin
		case (STATE)
			FW      : begin 
				cnt4_v_o = cnt4 == 3'h4;
				cnt4_rst = cnt4 == 3'h5;
			end
			BW      : begin
				cnt4_v_o = cnt4 == 3'h5;
				cnt4_rst = cnt4 == 3'h6;
			end
			default : begin
				cnt4_v_o = 1'b0;
				cnt4_rst = 1'b0;
			end
		endcase
	end


	always @(posedge clk) begin
		if (STATE == IDLE) 
			cnt4 <= 3'b0;
		else if (cnt4_rst)
			cnt4 <= 3'b0;
		else begin
			case (STATE)
				FW : cnt4 <= ~iswhite_i[0] ? (cnt4 + 3'b1) : cnt4;
				BW : cnt4 <= (~iswhite_i[1] & bw_wr_i) ? (cnt4 + 3'b1) : cnt4; 
			endcase
		end
	end

	always @(posedge clk) begin
		case (STATE)
			FW : begin
				case (iswhite_i[0])
					1'b0 : res_addr_o <= fw_addr_i - pos;
					1'b1 : res_addr_o <= fw_addr_i;
				endcase
			end
			BW : begin
				case (iswhite_i[1])
					1'b0 : res_addr_o <= bw_addr_i + pos;
					1'b1 : res_addr_o <= bw_addr_i;
				endcase
			end
			default : res_addr_o <= 14'b0;
		endcase
	end

	always @(*) begin
		case (STATE)
			FW : begin
				case ({iswhite_i[0], cnt4})
					4'b0000 : pos = 14'd127;
					4'b0001 : pos = 14'd127;
					4'b0010 : pos = 14'd128;
					4'b0011 : pos = 14'd129;
					4'b0100 : pos = 14'd1;
					default : pos = 14'd0;
				endcase
			end
			BW : begin
				case({iswhite_i[1], cnt4})
					4'b0001 : pos = 14'd127;
					4'b0010 : pos = 14'd128;
					4'b0011 : pos = 14'd129;
					4'b0100 : pos = 14'd1;
					default : pos = 14'd0;
				endcase
			end
			default : pos = 14'd0;
		endcase
	end


	always @(posedge clk) begin
		if (STATE == IDLE) begin
			res_wr_o <= 1'b0;
			res_rd_o <= 1'b0;
		end
		else begin
			case (STATE)
				FW : begin
					case ({iswhite_i[0], cnt4_rst})
						2'b00 : {res_wr_o, res_rd_o} <= 2'b01;
						2'b01 : {res_wr_o, res_rd_o} <= 2'b11;
						2'b10 : {res_wr_o, res_rd_o} <= 2'b10;
						2'b11 : {res_wr_o, res_rd_o} <= 2'b01;
					endcase
				end
				BW : begin
					case ({iswhite_i[1], bw_wr_i, cnt4_v_o})
						3'b011  : {res_wr_o, res_rd_o} <= 2'b10;
						3'b110  : {res_wr_o, res_rd_o} <= 2'b10;
						default : {res_wr_o, res_rd_o} <= 2'b01;	
					endcase
				end
			endcase
		end
	end
	wire [7:0] bw_cp;
	reg  [7:0] cp_data;
	reg  [7:0] bw_init;
	assign bw_cp = res_di_i + 8'b1;
	always @(*) begin
		case (STATE)
			FW : cp_data = (res_di_i < res_do_o) ? res_di_i : res_do_o;
			BW : cp_data = (   bw_cp < res_do_o) ? bw_cp : res_do_o;
			default : cp_data = 8'b0;
		endcase
	end
	always @(posedge clk) begin
		case (STATE)
			BW      : bw_init <= (cnt4 == 3'b0) ? res_di_i : bw_init;
			default : bw_init <= 8'b0;
		endcase
	end
	always @(posedge clk) begin
		if (STATE == IDLE)
			res_do_o <= 8'b0;
		else begin 
			case(STATE)
				FW : begin
					case({iswhite_i[0], cnt4})
						4'b0000 : res_do_o <= res_di_i;
						4'b0001 : res_do_o <= res_di_i;
						4'b0010 : res_do_o <= cp_data;
						4'b0011 : res_do_o <= cp_data;
						4'b0100 : res_do_o <= cp_data;
						4'b0101 : res_do_o <= cp_data + 8'b1;
						default : res_do_o <= 8'b0;
					endcase
				end
				BW : begin
					case({iswhite_i[1], cnt4})
						4'b0000 : res_do_o <= res_di_i;
						4'b0001 : res_do_o <= bw_cp;
						4'b0010 : res_do_o <= cp_data;
						4'b0011 : res_do_o <= cp_data;
						4'b0100 : res_do_o <= cp_data;
						4'b0101 : res_do_o <= (cp_data < bw_init) ? cp_data : bw_init;
						4'b0110 : res_do_o <= res_do_o;
						default : res_do_o <= 8'b0;
					endcase
				end
			endcase
		end
	end
endmodule
// }}}
