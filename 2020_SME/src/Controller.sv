module Controller (clk, rst, isstr, ispat, ctrlsig, valid);
	input  clk, rst, isstr, ispat, valid;
	output reg [1:0] ctrlsig;

	reg [1:0] STATE, NEXT;
	parameter	IDLE   = 0,
				READ   = 1,
				MATCH  = 2;

	always @(posedge clk or posedge rst) begin
		STATE = rst ? IDLE : NEXT;
	end
	always @(*) begin
		case(STATE)
			IDLE  : NEXT = READ;
			READ  : NEXT = (~isstr & ~ispat)  ? MATCH : READ;
			MATCH : NEXT = valid ? READ : MATCH;
			default : NEXT = IDLE;
		endcase
	end

	always @(*) begin
		case(STATE)
			IDLE  : ctrlsig = 2'b00;
			READ  : ctrlsig = 2'b01;
			MATCH : ctrlsig = 2'b11;
			default : ctrlsig = 2'b00;
		endcase
	end

endmodule