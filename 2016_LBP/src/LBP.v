`include "../src/ReadGray.v"
`include "../src/ALU.v"
// `include "../src/WriteLBP.v"

`timescale 1ns/10ps
module LBP ( clk, reset, gray_addr, gray_req, gray_ready, gray_data, lbp_addr, lbp_valid, lbp_data, finish);
input   		clk;
input   		reset;
output  [13:0] 	gray_addr;
output         	gray_req;
input   		gray_ready;
input   [7:0] 	gray_data;
output  [13:0] 	lbp_addr;
output  		lbp_valid;
output  [7:0] 	lbp_data;
output  		finish;
//====================================================================

	wire [3:0] cnt;
	wire white;
	wire [13:0] addr;
	ReadGray RdG (.clk          (clk       ),
				  .rst          (reset     ),
				  .gray_ready_i (gray_ready),
				  .gray_req_o   (gray_req  ),
				  .gray_addr_o  (gray_addr ),
				  .cnt_o        (cnt       ),
				  .white_o      (white     ),
				  .addr_o       (addr      ));
	wire [13:0] waddr;
	wire [7:0]  wdata;
	ALU      Alu (.clk          (clk       ),
				  .rst     		(reset     ),
				  .graydata_i   (gray_data ),
				  .cnt_i        (cnt       ),
				  .white_i      (white     ),
				  .addr_i       (addr      ),
				  .waddr_o      (waddr     ),
				  .wdata_o      (wdata     ));
	
	// Write 5689
	assign lbp_valid = gray_req;
	assign lbp_data  = wdata;
	assign lbp_addr  = waddr;
	assign finish    = lbp_addr == 14'd16383;

/* 6499
	WriteLBP WrL (.clk          (clk       ),
				  .rst          (reset     ),
				  .gray_req_i   (gray_req  ),
				  .wdata_i      (wdata     ),
				  .waddr_i      (waddr     ),
				  .lbp_valid_o  (lbp_valid ),
				  .lbp_data_o   (lbp_data  ),
				  .lbp_addr_o   (lbp_addr  ),
				  .finish_o     (finish    ));
*/
//====================================================================
endmodule



