module M_inst_addr_GEN (clk,LMstart,Base_addr,mem_addr,reset_n,IW);
//ports
	input clk;
	input [1:0] LMstart;
	input [15:0] Base_addr;
	output reg [15:0] mem_addr;
	input reset_n;
	input [7:0]IW;
//necessay const and addition
	reg [15:0] BASE;
	reg [15:0] index;
	reg check;
	reg [7:0] Encoded;
	
//selection

	always @ (negedge(clk),negedge(reset_n))
		begin
		if(reset_n==1'b0)
			begin
			BASE=16'h0000;
			mem_addr=16'hzzzz;
			check=1'b0;
			index<=16'h0000;
			Encoded=8'h00;
			end
		else if(LMstart[1]==1'b1)
			begin
			if(check==1'b0)
				begin
				check=1'b1;
				BASE<=Base_addr;
				index<=16'h0000;	
				Encoded=IW[7:0];
				end
			if(Encoded[0]==1'b1)
				begin
				Encoded[0]<=1'b0;
			mem_addr=BASE + index;
			index<=index + 16'h0001;
				end
			else if(Encoded[1]==1'b1)
				begin
				Encoded[1]<=1'b0;
			mem_addr=BASE + index;
			index<=index + 16'h0001;
				end
			else if(Encoded[2]==1'b1)
				begin
				Encoded[2]<=1'b0;
			mem_addr=BASE + index;
			index<=index + 16'h0001;
				end
			else if(Encoded[3]==1'b1)
				begin
				Encoded[3]<=1'b0;
			mem_addr=BASE + index;
			index<=index + 16'h0001;
				end
			else if(Encoded[4]==1'b1)
				begin
				Encoded[4]<=1'b0;
			mem_addr=BASE + index;
			index<=index + 16'h0001;
				end
			else if(Encoded[5]==1'b1)
				begin
				Encoded[5]<=1'b0;
			mem_addr=BASE + index;
			index<=index + 16'h0001;
				end
			else if(Encoded[6]==1'b1)
				begin
				Encoded[6]<=1'b0;
			mem_addr=BASE + index;
			index<=index + 16'h0001;
				end
			else if(Encoded[7]==1'b1)
				begin
				Encoded[7]<=1'b0;
			mem_addr=BASE + index;
			index<=index + 16'h0001;
				end
			end
		else
			begin
			check=1'b0;
			index<=16'h0000;
			end
		end
	
endmodule