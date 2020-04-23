module HM (reset_n,M_inst,RD_WB,W_REG_WB,Jump_ID,Jump_RR,
			Beq,
			Validity_IF_ID,Validity_ID_REG,Validity_REG_EX,
			Validity_EX_MEM,Validity_MEM_WB,
			SEL_PC,stop_ID,stop_MEM,stop_WB,
			stall,except_LW_RR,HB,except_R7_HM,except_JAL_HM,except_JLR_HM,except_BEQ_HM);
//ports
	input reset_n;
	input M_inst;
	input [2:0]RD_WB;
	input W_REG_WB;
	input [1:0]Jump_ID;
	input [1:0]Jump_RR;
	input Beq;
	input stop_ID;
	input stop_MEM;
	input stop_WB;
	input [5:0]HB;
	
	input except_LW_RR;
	
	output reg Validity_IF_ID;
	output reg Validity_ID_REG;
	output reg Validity_REG_EX;
	output reg Validity_EX_MEM;
	output reg Validity_MEM_WB;
	output reg [1:0] SEL_PC;
	output reg [5:0]stall;
	//USed to debug once only
	reg [3:0] debug;
	
	input except_R7_HM;
	input except_JAL_HM;
	input except_JLR_HM;
	input except_BEQ_HM;
	always @ (*)
	begin
		//Reset_n
		if(reset_n==1'b0)
			begin	
			Validity_IF_ID=1'b1;
			Validity_ID_REG=1'b0;
			Validity_REG_EX=1'b0;
			Validity_EX_MEM=1'b0;
			Validity_MEM_WB=1'b0;
			SEL_PC=2'b00;
			debug=3'b000;
			stall=6'b000_000;
			end/*
		//OVER ST IF
		else if (HB[4]==1'b1)
			begin
			Validity_IF_ID=1'b1;
			Validity_ID_REG=1'b1;
			Validity_REG_EX=1'b1;
			Validity_EX_MEM=1'b1;
			Validity_MEM_WB=1'b1;
			SEL_PC=2'b00;
			debug=3'b111;
			stall=6'b000_000;
			end*/
		//Upadate over R7 Data
		else if (W_REG_WB==1'b1 && RD_WB==3'b111  )
			begin
			if(HB[0]==1'b1 && except_R7_HM==1'b1)
				begin
				Validity_IF_ID=1'b1;
				Validity_ID_REG=1'b1;
				Validity_REG_EX=1'b1;
				Validity_EX_MEM=1'b1;
				Validity_MEM_WB=1'b1;
				SEL_PC=2'b00;
				debug=3'b111;
				end
			else
				begin
				Validity_IF_ID=1'b0;
				Validity_ID_REG=1'b0;
				Validity_REG_EX=1'b0;
				Validity_EX_MEM=1'b0;
				Validity_MEM_WB=1'b0;
				SEL_PC=2'b11;
				debug=3'b001;
				end
			end
		//BEQ check
		else if (Jump_RR==2'b01 && Beq!=1'b1 && HB[3]==1'b1)
				begin
				Validity_IF_ID=1'b0;
				Validity_ID_REG=1'b0;
				Validity_REG_EX=1'b0;
				Validity_EX_MEM=1'b1;
				Validity_MEM_WB=1'b1;
				SEL_PC=2'b01;	
				debug=3'b010;
				end
		else if (Jump_RR==2'b01 && Beq==1'b1 )
			begin
			if(HB[3]==1'b0 || HB[3]==1'b1 && except_BEQ_HM==1'b0)
				begin
				Validity_IF_ID=1'b0;
				Validity_ID_REG=1'b0;
				Validity_REG_EX=1'b0;
				Validity_EX_MEM=1'b1;
				Validity_MEM_WB=1'b1;
				SEL_PC=2'b01;	
				debug=3'b010;
				end
			else
				begin
				Validity_IF_ID=1'b1;
				Validity_ID_REG=1'b1;
				Validity_REG_EX=1'b1;
				Validity_EX_MEM=1'b1;
				Validity_MEM_WB=1'b1;
				SEL_PC=2'b00;
				debug=3'b111;
				end
			end
			//JLR
		else if (Jump_RR==2'b11 )
			begin
			if(HB[3]==1'b0 || HB[3]==1'b1 &&except_JLR_HM==1'b0 )
				begin
				Validity_IF_ID=1'b0;
				Validity_ID_REG=1'b0;
				Validity_REG_EX=1'b1;
				Validity_EX_MEM=1'b1;
				Validity_MEM_WB=1'b1;
				SEL_PC=2'b10;		
				debug=3'b011;
				end
			else
				begin
				Validity_IF_ID=1'b1;
				Validity_ID_REG=1'b1;
				Validity_REG_EX=1'b1;
				Validity_EX_MEM=1'b1;
				Validity_MEM_WB=1'b1;
				SEL_PC=2'b00;
				debug=3'b111;
				end
			end
		//JAL
		else if (Jump_ID==2'b10 )
			begin
			if(HB[4]==1'b0 ||HB[4]==1'b1 &&except_JAL_HM==1'b0 )
				begin
				Validity_IF_ID=1'b0;
				Validity_ID_REG=1'b1;
				Validity_REG_EX=1'b1;
				Validity_EX_MEM=1'b1;
				Validity_MEM_WB=1'b1;
				SEL_PC=2'b01;	
				debug=3'b100;
				end
			else
				begin
				Validity_IF_ID=1'b1;
				Validity_ID_REG=1'b1;
				Validity_REG_EX=1'b1;
				Validity_EX_MEM=1'b1;
				Validity_MEM_WB=1'b1;
				SEL_PC=2'b00;
				debug=3'b111;
				end
			end			
		//Multiple type instruction
		else if (M_inst==1'b1)
			begin
			Validity_IF_ID=1'b0;
			Validity_ID_REG=1'b1;
			Validity_REG_EX=1'b1;
			Validity_EX_MEM=1'b1;
			Validity_MEM_WB=1'b1;
			SEL_PC=2'b00;		
			debug=3'b101;
		end
		//5	PC
		//4	IF
		//3	ID
		//2	RR
		//1	EX
		//0	MM
		//-	WB
		
		else if (except_LW_RR==1'b1)
			begin
			Validity_IF_ID=1'b1;
			Validity_ID_REG=1'b1;
			Validity_REG_EX=1'b0;
			Validity_EX_MEM=1'b1;
			Validity_MEM_WB=1'b1;
			stall=6'b111_000;
			end
		//NONE condition
		else
			begin
			if(stop_WB!=1'b0)	
						begin
						Validity_IF_ID=1'b0;
						Validity_ID_REG=1'b0;
						Validity_REG_EX=1'b0;
						Validity_EX_MEM=1'b0;
						Validity_MEM_WB=1'b0;
						end
			else	
						begin
						Validity_IF_ID=1'b1;
						Validity_ID_REG=1'b1;
						Validity_REG_EX=1'b1;
						Validity_EX_MEM=1'b1;
						Validity_MEM_WB=1'b1;
						end
			SEL_PC=2'b00;
			debug=3'b110;
			if(stop_WB==1'b1) 	
				begin
				stall=6'b110_001;
				end
			else 		
				stall=6'b000_000;
			end
		
	end

endmodule