module sign_6_16 (in6,out16);
	input [5:0] in6;
	output reg [15:0] out16;
	
	always @(in6)
			out16 <= { {10{in6[5]}} , in6 };

endmodule