module Reg_file (clk,reset_n,addr_a,addr_b,Datain,Datain_addr,W,DATA_A,DATA_B,pcin);
//Ports
	input clk;
	input reset_n;
	input [2:0]addr_a;
	input [2:0]addr_b;
	input [15:0]Datain;
	input [2:0]Datain_addr;
	input W;
	output [15:0]DATA_A;
	output [15:0]DATA_B;
	input [15:0]pcin;
	
	reg [15:0] registers [0:7];
	
	
	assign DATA_A=registers[addr_a];
	assign DATA_B=registers[addr_b];
	
	integer i;
	always @(negedge(clk) ,negedge(reset_n))
		begin				
			if(reset_n==1'b0) for(i=0;i<8;i=i+1) registers[i]<=16'h0000;
			else if(W==1'b1 && Datain_addr!=3'b111)	
				begin
				registers[Datain_addr] <= Datain;
				end
				registers[7]<=pcin;
		
			//REGARDS FOR PCIN
			end	
endmodule
