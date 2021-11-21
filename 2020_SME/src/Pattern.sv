module Pattern (clk, ctrlsig, ispat, plen, data, pat, patmask, starsig, staridx, pcnt_clr);
	input  clk, ispat, pcnt_clr;
	input  ctrlsig;
	input  [3:0] plen;
	input  [7:0] data;
	output reg [7:0] pat [7:0]; 
	output reg [7:0] patmask;
    output reg starsig;
    output reg [3:0] staridx;

	wire pat_rst;
	assign pat_rst = ~ctrlsig | pcnt_clr;

	integer i;

	always @(posedge clk) begin
		if (pat_rst) begin
			patmask <= 8'b0;
			for (i = 0; i < 8; i = i + 1)
				pat[i] <= 8'b0;
		end
		else begin
			if (ispat) begin
				patmask[plen] <= 1;
				pat[plen]     <= ((data == 8'h5E) || (data == 8'h24)) ? 8'h20 : data;
			end
			else ;
		end
	end
    
    always @(posedge clk) begin
        if (pat_rst) begin
            starsig <= 0;
            staridx <= 4'b0;
        end
        else begin
            if (data == 8'h2a) begin
                starsig <= 1;
                staridx <= plen;
            end
            else ;
        end             
    end

endmodule