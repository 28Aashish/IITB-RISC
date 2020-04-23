module sign_9_16 (LHI,in9,out16);
	input LHI;
	input [8:0] in9;
	output reg [15:0] out16;
	wire [6:0]tmp_n;
	wire [6:0]tmp_L;
	
	always @(in9,LHI)
		begin
		if(LHI==1'b0)	out16 <= { {7{in9[8]}} , in9 };
		else			out16 <= { in9 , {7{1'b0}} };
		end
endmodule