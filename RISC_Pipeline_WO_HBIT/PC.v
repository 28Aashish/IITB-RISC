module PC  (clk,reset_n,in,x,out);
	
	input clk;
	input reset_n;
	input x;
	input [16-1:0] in;
	output reg [16-1:0] out;
	
	always @(negedge(clk) or negedge(reset_n))
		begin
			if(reset_n==1'b0) 		out=16'h0000;
			else if(x==1'b1) 	 	out<=in;
		end
endmodule