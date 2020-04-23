module adder (src0,src1,out);
//ports
	input [15:0] src0;
	input [15:0] src1;
	output[15:0] out;
	assign out=src0+src1;
endmodule