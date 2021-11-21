module LenCounter (clk, rst, ctrlsig, pcnt_clr, isstr, ispat, scnt, plen);
	input clk, rst, ctrlsig, isstr, ispat, pcnt_clr;
	output reg [5:0] scnt;
	output reg [3:0] plen;

	always @(posedge clk) begin
		if (rst) begin
			scnt <= 6'b1;
		end
		else begin
			if (isstr) 
				scnt <= scnt[5] ? 6'b0 : (scnt + 6'b1);
			else
				scnt <= 6'b1;
		end
	end
	always @(posedge clk) begin
		if (rst | ~ctrlsig | pcnt_clr) 
			plen <= 4'b0;
		else begin
			if (ispat)
				plen <= plen[3] ? 4'b0 : (plen + 4'b1);
		end
	end
endmodule