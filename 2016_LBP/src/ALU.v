module ALU (
	input             clk,
	input             rst,
	input      [7:0]  graydata_i,
	input      [3:0]  cnt_i,
	input             white_i,
	input      [13:0] addr_i,
	output reg [13:0] waddr_o,
	output reg [7:0]  wdata_o
	);
	
	reg white;
	always @(posedge clk or posedge rst) begin
		white <= rst ? 1'b0 : white_i;
	end


	always @(posedge clk or posedge rst) begin
		waddr_o <= rst ? 14'b0 : addr_i;
	end

	reg [7:0] gc;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			wdata_o <= 8'b0;
			gc      <= 8'b0;
		end
		else if (white) begin
			wdata_o <= 8'b0;
			gc      <= graydata_i;
		end
		else begin
			if (~|cnt_i) begin
				gc      <= graydata_i;
				wdata_o <= 8'b0;
			end
			else 
				wdata_o[cnt_i - 4'b1] <= graydata_i >= gc;
		end
	end
endmodule
