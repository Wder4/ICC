module String (clk, rst, isstr, scnt, slen, data, str);
	input  clk, rst, isstr;
	input  [5:0] scnt;
	input  [7:0] data;
	output reg [5:0] slen;
	output reg [7:0] str [39:0];

	integer i;
	always @(posedge clk) begin
		if (rst) begin
            str[0] <= 8'h20;
			for (i = 1; i < 40; i = i + 1)
				str[i] <= 8'b1;
		end
		else begin
			if (isstr) begin
				str[scnt] <= data;
				slen <= scnt + 5'b1;
			end
			else 
				str[slen] <= 8'h20;
		end
	end
endmodule