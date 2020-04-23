module M_inst_Controller (clk,LMstart,IW,M_inst,R_dest,reset_n);
//ports
	input clk;
	input [1:0] LMstart;
	input [7:0] IW;
	output M_inst;
	output reg [2:0] R_dest;
	input reset_n;
//necessay const and addition
	reg [8:0] Encoded;
	reg check;
//selection

	assign M_inst = check!=1'b1 ? LMstart[1] : |Encoded;
	
	always @ (negedge(clk) or negedge(reset_n))
		begin
		if(reset_n==1'b0)
			begin
			check=1'b0;
			Encoded=8'h00;
			R_dest=3'bzzz;
			end
		else if(LMstart[1]==1'b1)
			begin
			if(check==1'b0)
				begin
				Encoded={1'b1,IW[7:0]};			
				check=1'b1;
				end
			if(Encoded[0]==1'b1)
				begin
				Encoded[0]<=1'b0;
				R_dest<=3'b000;
				end
			else if(Encoded[1]==1'b1)
				begin
				Encoded[1]<=1'b0;
				R_dest<=3'b001;
				end
			else if(Encoded[2]==1'b1)
				begin
				Encoded[2]<=1'b0;
				R_dest<=3'b010;
				end
			else if(Encoded[3]==1'b1)
				begin
				Encoded[3]<=1'b0;
				R_dest<=3'b011;
				end
			else if(Encoded[4]==1'b1)
				begin
				Encoded[4]<=1'b0;
				R_dest<=3'b100;
				end
			else if(Encoded[5]==1'b1)
				begin
				Encoded[5]<=1'b0;
				R_dest<=3'b101;
				end
			else if(Encoded[6]==1'b1)
				begin
				Encoded[6]<=1'b0;
				R_dest<=3'b110;
				end
			else if(Encoded[7]==1'b1)
				begin
				Encoded[7]<=1'b0;
				R_dest<=3'b111;
				end
			else if(Encoded[8]==1'b1)
				begin
				Encoded[8]<=1'b0;
				end
			else
				check=1'b0;
			end
		end
	
endmodule