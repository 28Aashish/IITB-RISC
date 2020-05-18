`timescale 1ns/100ps
module tb_RIsC ();
	
	reg clk;
	reg reset_n;
	
	RISC uut (clk,reset_n);

	parameter period=20;
	
	always 
		begin
		clk=1'b1;
		#period;
		clk=1'b0;
		#period;
		end
	initial
		begin
		reset_n=1'b0;
		#period;
		#period;
		#period;
		reset_n=1'b1;
		end
endmodule