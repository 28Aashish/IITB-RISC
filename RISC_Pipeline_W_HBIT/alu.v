module alu (opc_id,src1,src0,out,reset_n,allow);
//ports
	input reset_n;
	input [2:0] opc_id;
	input [15:0] src0;
	input [15:0] src1;
	output reg [15:0] out;
	output reg allow;
//necessay const and addition
	reg [16:0] add;
	reg [1:0]flag;
			//	flag[1] = Carry 1 if carry generated
			//	flag[0]	= Zero 0 if all zero
//selection
	always @ (*)
	begin
		//reset_state					
		if(reset_n==1'b0)	
			begin
			allow=1'b0;
			out=16'h0000;
			add=17'b00000000000000000;
			flag=2'b00;
			end
		//No_FLAGCHANGE Addition	
		else if(opc_id==3'b000)
			begin
				allow=1'b1;
				out=src1+src0;
			end
		//FLAG_CHANGE_ADDITION NO COND
		else if(opc_id==3'b001)
			begin
				allow=1'b1;
				out=src1+src0;
				add=src1+src0;
				flag[1]=add[16];
				flag[0]=|out;
			end
		//FLAG_CHANGE_ADDITION C COND
		else if(opc_id==3'b010 && flag[1]==1'b1)
			begin			
				allow=1'b1;
				out=src1+src0;
				add=src1+src0;
				flag[1]=add[16];
				flag[0]=|out;
			end
		//FLAG_CHANGE_ADDITION Z COND
		else if(opc_id==3'b011 && flag[0]==1'b0)
			begin
				allow=1'b1;			
				out=src1+src0;
				add=src1+src0;
				flag[0]=|out;
			end
		//FLAG_CHANGE_NAND NO COND
		else if(opc_id==3'b100)
			begin
				allow=1'b1;
				out=~(src1&src0);
				flag[0]=|out;
			end
		//FLAG_CHANGE_ADDITION C COND
		else if(opc_id==3'b101 && flag[1]==1'b1)
			begin
				allow=1'b1;
				out=~(src1&src0);
				flag[0]=|out;
			end
		//FLAG_CHANGE_ADDITION Z COND
		else if(opc_id==3'b110 && flag[0]==1'b0)
			begin
				allow=1'b1;			
				out=~(src1&src0);
				flag[0]=|out;
			end
		//NOTA
		else
			begin
			if(opc_id==3'b110 || opc_id==3'b011 || opc_id==3'b010 || opc_id==3'b101  )	allow=1'b0;
			else allow=1'b1;
			end
	end

endmodule