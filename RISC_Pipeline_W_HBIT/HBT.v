module HBT (clk,reset_n,addr,datain,dataout,w,HBin,HBout);
//Ports
	parameter size = 200;

	input clk;
	input reset_n;
	input [15:0] addr;
	input [15:0] datain;
	output[15:0] dataout;
	input w;

	input  HBin;
	output HBout;
//Necesary Cell
	reg [15:0] ROM_PC[0:size-1];
	reg HBV[0:size-1];
	
	integer i;
	initial
		begin
		for(i=0 ; i<size ; i= i+1)
			begin
				HBV[i]<=1'b0;
				ROM_PC[i]<=16'h0000;
			end
		end
		
		
	always @(negedge(clk))
		begin
			if(reset_n==1'b0)
				begin
					for(i=0 ; i<size ; i= i+1)
						begin
							HBV[i]<=1'b0;
							ROM_PC[i]<=16'h0000;
						end
				end
			else if(w==1'b1)
			begin
				ROM_PC[addr] <= datain;
				HBV[addr]<=HBin;
			end
		end
	/*		always @(negedge(clk))
		begin	
			if(reset_n==1'b0)	for(i=0;i<size-1;i=i+1)	ram[i]<=16'b0000;
			else if(w==1'b1 )	ram[addr] <= datain;
		end	
	*/	
	assign dataout = ROM_PC[addr] ;
	assign HBout   = HBV[addr];
	
endmodule