// `include "Controller.sv"
// `include "String.sv"
// `include "Pattern.sv"
// `include "LenCounter.sv"
// `include "SendIdx.sv"

module SME(clk,reset,chardata,isstring,ispattern,valid,match,match_index);
input clk;
input reset;
input [7:0] chardata;
input isstring;
input ispattern;
output match;
output [4:0] match_index;
output valid;

// =============================================
wire [1:0] ctrlsig; 
wire match_v, m_done, starsig;
wire mstar_v, star_done;
wire [5:0] slen, scnt;
wire [3:0] plen;
wire [7:0] str [39:0];
wire [7:0] pat [7:0];
wire [7:0] patmask;
wire [4:0] m_idx;
wire [3:0] staridx;
wire [4:0] stride;
wire head20, head2e;
wire pcnt_clr;
assign pcnt_clr = m_done | match_v | star_done | mstar_v; 

Controller ctrl1 ( .clk(clk), .rst(reset), 
                   .isstr(isstring), .ispat(ispattern), .ctrlsig(ctrlsig), 
				   .valid(valid) );

LenCounter lcnt1 (.clk(clk), .rst(reset), .ctrlsig(ctrlsig[0]), .pcnt_clr(pcnt_clr), 
				  .isstr(isstring), .ispat(ispattern), .scnt(scnt), .plen(plen) );
  
String str1 ( .clk(clk), .rst(reset), .isstr(isstring), .scnt(scnt), .slen(slen), .data(chardata), .str(str) );


Pattern pat1 ( .clk(clk), .ctrlsig(ctrlsig[0]), .pcnt_clr(pcnt_clr),
  			   .ispat(ispattern), .plen(plen), .data(chardata), .pat(pat), .patmask(patmask), 
			   .starsig(starsig), .staridx(staridx) );

Match mat1 ( .clk(clk), .ctrlsig(ctrlsig), .starsig(starsig), 
			 .m_done(m_done), .match_v(match_v), .m_idx(m_idx),
			 .str(str),  .pat(pat), .slen(slen),  .plen(plen),
			 .patmask(patmask), .head20(head20), .head2e(head2e) );

MatchStar mats1 ( .clk(clk), .ctrlsig(ctrlsig), .starsig(starsig), 
				  .mstar_v(mstar_v), .star_done(star_done), .staridx(staridx), 
				  .stride(stride), .pat(pat), .str(str), 
				  .slen(slen), .plen(plen) );

SendIdx si1 ( .clk(clk), .rst(reset), .match_v(match_v), .m_done(m_done), 
	          .m_idx(m_idx), .head20(head20), .head2e(head2e), .o_idx(match_index),
			  .stride(stride), .mstar_v(mstar_v), .star_done(star_done),
			  .valid(valid), .match(match) );

// =============================================
endmodule


module Match (clk, ctrlsig, starsig, str, pat, slen, plen, patmask, m_done, match_v, m_idx, head20, head2e); 
	input  clk, starsig;
	input  [1:0] ctrlsig;
	input  [5:0] slen;
	input  [3:0] plen;
	input  [7:0] str [39:0];
	input  [7:0] pat [7:0];
	input  [7:0] patmask;
	output head20, head2e, match_v;
	output reg   m_done;
	output reg   [4:0] m_idx;  // match_idx

	reg  [7:0] m_res;
	reg  [4:0] m_cnt;
	wire start;
	assign start = (ctrlsig == 2'b11) & ~starsig;
	assign head20 = ctrlsig[0] ? pat[0] == 8'h20 : 1'b0;
	assign head2e = ctrlsig[0] ? pat[0] == 8'h2e : 1'b0; 
	assign match_v = start ? (m_res == patmask) & |patmask  : 1'b0;

	wire mcnt_start;
	assign mcnt_start = (start & ~m_done) & ~match_v;
	always @(posedge clk) begin
		m_cnt  <= mcnt_start ? (m_cnt + 5'b1) : 5'b0;
		m_done <= start ? ((m_cnt == (slen[4:0] - {1'b0, plen} + 5'b1)) & ~match_v) : 1'b0;
	end

	integer i;
	always @(*) begin
		if (start) begin
			m_res = 8'b0;
			for (i = 0; i < 8; i = i + 1) 
				m_res[i] = (str[i + m_cnt] == pat[i]) | (pat[i] == 8'h2e) ? 1'b1 : 1'b0;
		end	
		else 
			m_res   = 8'b0;
	end

	always @(posedge clk) begin 
		if(start)
			m_idx <= ~(m_done | match_v) ? (m_cnt + 5'b1) : m_idx;
		else
			m_idx <= 5'b0;
	end
endmodule

module MatchStar(clk, starsig, ctrlsig, staridx, pat, str, slen, plen, stride, mstar_v, star_done);
	input  clk, starsig;
	input  [1:0] ctrlsig;
	input  [3:0] staridx;
	input  [7:0] str [39:0];
	input  [7:0] pat [7:0];
	input  [5:0] slen;
	input  [3:0] plen;
	output mstar_v, star_done;
	output reg  [4:0] stride;
	reg  [5:0] scnt;
	reg  [4:0] pcnt;
	wire start;


	reg match, nxt_match, isstar;
	
	assign start = (ctrlsig == 2'b11) & starsig;
	assign mstar_v    = (start & |pat[0]) ? (pcnt == (plen - 4'b1) & match) : 0;
	assign star_done  = starsig ? scnt == slen  : 0;

	wire headstar;
	assign headstar = pat[0] == 8'h2a;
	always @(posedge clk) begin
		if(start)
			isstar = (headstar | (pat[pcnt + 4'b1] == 8'h2a) & ~star_done & match) ? 1 : isstar;
		else 
			isstar = 0;
	end

	always @(posedge clk) begin
		if (start)
			stride <= (match | nxt_match | isstar) ? stride : scnt[4:0]; 	
		else 
			stride <= 5'b0;
	end

	always @(posedge clk) begin
		if (start) begin
			if (scnt == slen)
				scnt <= 6'b0;
			else
				scnt <= nxt_match ? scnt : (scnt + 6'b1);
		end
		else
			scnt <= 5'b0;
	end
	
	always @(posedge clk) begin
		if (~start | &pcnt[2:0])
			pcnt <= 4'b0;
		else begin
			if (~isstar) begin
				case({match, nxt_match})
					2'b00 : pcnt <= 4'b00;
					2'b01 : pcnt <= pcnt + 4'b10;
					2'b10 : pcnt <= pcnt + 4'b01;
				endcase
			end
			else 
				pcnt <= match ? (pcnt + 4'b1) : (staridx + 4'b1);
		end
	end

	always @(*) begin
		if (~start) begin
			match     = 0;
			nxt_match = 0;
		end
		else begin
			match     = (str[scnt] == pat[pcnt]) | (pat[pcnt] == 8'h2e & |scnt);
			nxt_match = (pat[pcnt] == 8'h2a) ? str[scnt] == pat[pcnt + 1] : 0;
		end
	end
endmodule









