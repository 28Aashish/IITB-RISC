module mux2  (in0,in1,sel,out);
		
	input [16-1:0] in0;
	input [16-1:0] in1;
	input sel;
	output reg [15:0]out;
	
	always @(*)
		begin
			if(sel==1'b0) 		out<=in0;
			else if(sel==1'b1)  out<=in1;
			else				out<=16'hzzzz;
		end
endmodule