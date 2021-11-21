module SendIdx (clk, rst, match_v, m_done, m_idx, head20, head2e, mstar_v, star_done, stride, o_idx, valid, match);
	input  clk, rst;
	input  match_v, m_done;
	input  head20, head2e;
	input  mstar_v, star_done;
	
	input  [4:0] m_idx;
	input  [4:0] stride;

	output reg valid, match;
	output reg [4:0] o_idx;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			match   <= 0;
			valid   <= 0;
		end
		else begin
			match   <= match_v | mstar_v;
			valid   <= m_done  | star_done| match_v | mstar_v;;
		end
	end

	wire idx1head20, idx0head2e;
	assign idx1head20 = m_idx == 5'b1 & head20;
	assign idx0head2e = m_idx == 5'b0 & head2e;

	always @(posedge clk or posedge rst) begin 
		if (rst) 
			o_idx <= 5'b0;
		else begin
			case({match_v, mstar_v})
				4'b10 : o_idx <= (idx1head20 | idx0head2e) ? 5'b0 : (m_idx - 5'b1 + {4'b0, head20});
				4'b01 : o_idx <= stride;	
				default : o_idx <= 5'b0;
			endcase 
		end	
	end	
endmodule