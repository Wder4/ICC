module ReadGray (
	input      		  clk, 
	input			  rst,
	input      		  gray_ready_i,
	output reg        gray_req_o,
  	output reg [13:0] gray_addr_o,
	output reg [3:0]  cnt_o,
	output            white_o,
	output reg [13:0] addr_o
	);
	
	wire x, y;
	assign x       = &addr_o[13:7] | ~|addr_o[13:7];
	assign y       = &addr_o[6:0]  | ~|addr_o[6:0];
	assign white_o = x | y;


	always @(posedge clk or posedge rst) begin
		gray_req_o <= rst ? 1'b0 : gray_ready_i; 
	end

	wire cnt_fin;
	assign cnt_fin = cnt_o[3];
	always @(posedge clk or posedge rst) begin
		if (rst)
			cnt_o <= 4'b0;
		else if (~white_o)
			cnt_o <= cnt_fin ? 4'h0 : (cnt_o + 4'h1);
	end


	always @(posedge clk or posedge rst) begin
		if (rst)
			addr_o <= 14'b0;
		else if (white_o)
			addr_o <= addr_o + 14'b1;
		else if (cnt_fin)
			addr_o <= addr_o + 14'b1;
	end
	
	always @(*) begin
		case(cnt_o)
			4'h1 : gray_addr_o = addr_o - 14'd129;
			4'h2 : gray_addr_o = addr_o - 14'd128;
			4'h3 : gray_addr_o = addr_o - 14'd127;
			4'h4 : gray_addr_o = addr_o - 14'd1;
			4'h5 : gray_addr_o = addr_o + 14'd1;
			4'h6 : gray_addr_o = addr_o + 14'd127;
			4'h7 : gray_addr_o = addr_o + 14'd128;
			4'h8 : gray_addr_o = addr_o + 14'd129;
			default : gray_addr_o = addr_o;
		endcase
	end

endmodule
