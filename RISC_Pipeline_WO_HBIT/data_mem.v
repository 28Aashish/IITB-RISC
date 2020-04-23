module data_mem (clk,addr,datain,dataout,w,reset_n);
//Ports
	parameter size = 100;
	input clk;
	input reset_n;
	input [15:0] addr;
	input [15:0] datain;
	output[15:0] dataout;
	input w;
//Necesary Cell
	reg [15:0] ram[0:size-1];
	integer i;
	
	always @(negedge(clk))
		begin	
			if(reset_n==1'b0)	for(i=0;i<size-1;i=i+1)	ram[i]<=16'b0000;
			else if(w==1'b1 )	ram[addr] <= datain;
		end	
		
	assign dataout = w ==1'b0 ? ram[addr] : 16'bzzzz;
	
endmodule