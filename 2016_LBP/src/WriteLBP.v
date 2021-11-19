module WriteLBP (
	input             clk,
	input             rst,
	input             gray_req_i,
	input      [7:0]  wdata_i,
	input      [13:0] waddr_i,
	output reg        lbp_valid_o,
	output reg [7:0]  lbp_data_o,
	output reg [13:0] lbp_addr_o,
	output reg        finish_o
	);

	always @(posedge clk or posedge rst) begin
		lbp_valid_o <= rst ? 1'b0 : gray_req_i;
	end

	always @(posedge clk or posedge rst) begin
		if (rst)
			lbp_data_o <= 8'b0;
		else
			lbp_data_o <= wdata_i;
	end

	always @(posedge clk or posedge rst) begin
		if (rst) 
			lbp_addr_o <= 14'b0;
		else
			lbp_addr_o <= waddr_i;
	end

	always @(posedge clk or posedge rst) begin
		finish_o <= rst ? 1'b0 : lbp_addr_o == 14'd16382;
	end


endmodule