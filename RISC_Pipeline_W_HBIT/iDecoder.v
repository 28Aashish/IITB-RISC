//module iDecoder (IW,R_type,RD,W_reg,W_mem,sel69,LHi,alu_op,LMstart,LW_SR,MEM_ANS,Jump,JL_JR,J_B,v,stop);
module iDecoder (IW,R_type,RD,W_reg,W_mem,sel69,LHi,alu_op,LMstart,LW_SR,MEM_ANS,Jump,stop);
//	input v;
	

	//Instuction Word
	input [15:0] IW;
		/*
		R_type		0	I or J type
					1	R Type
		*/
	output reg R_type;
		/*
		RD	00 	RA
				01	RB
				10	RC
				11	Load/Store Multiple R
		*/
	output reg [1:0] RD;
		/*
		W_reg 		0	No_write_to_reg
					1	write_to_reg
		*/
	output reg W_reg;
		/*
		W_mem 		0	No_write_to_memory
					1	write_to_memory
		*/
	output reg W_mem;
		/*
		Sel69 		0	Select 6
					1	Select 9
		*/
	output reg sel69;
		/*
		LHi 9->16 	0	Not executing Lhi 
					1 	executing Lhi
		*/
	output reg LHi;
		/*
		alu_op		000	No_FLAGCHANGE Addition
				
					001	FLAG_CHANGE_ADDITION NO COND
					010	FLAG_CHANGE_ADDITION C COND
					011	FLAG_CHANGE_ADDITION 0 COND
		
					100	FLAG_CHANGE_NAND NO COND
					101	FLAG_CHANGE_NAND C COND
					110	FLAG_CHANGE_NAND 0 COND
		
					111	Not USed
		*/
	output reg [2:0] alu_op;
		/*
		LMstart     	0x	NO Multiple operation
						10	Register to memory
						11	Memory to register
		//10 & 11 is used to Data in for FROM RD_RR or IW
		*/
	output reg [1:0]LMstart;
		/*
		LW_SR		0	other
					1	Load or Store
		*/
	output reg LW_SR;
		/*
		MEM_ANS		0	MEM_Data
					1	ANS_Data
		*/
	output reg MEM_ANS;
		/*
		Jump		00	No Jump
					01	Conditional Jump
					10	Uncondtional Jump
					11	Not_Used
		*/
	output reg [1:0]Jump;
	output reg stop;
	always @(*)
		begin
//////////////////////////////////////////////////////////////start R type
	//	if(v!=1'b0)
	//	begin
			//ADD
			if(IW[15:12]==4'b0000 && IW[1:0]==2'b00)
				begin
				R_type=1'b0;
				RD=2'b10;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b001;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b1;
				Jump=2'b00;
				end
			//ADC
			else if(IW[15:12]==4'b0000 && IW[1:0]==2'b10)
				begin
				R_type=1'b0;
				RD=2'b10;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b010;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b1;
				Jump=2'b00;
				end		
			//AD0
			else if(IW[15:12]==4'b0000 && IW[1:0]==2'b01)
				begin
				R_type=1'b0;
				RD=2'b10;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b011;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b1;
				Jump=2'b00;
				end		
			//NAND
			else if(IW[15:12]==4'b0010 && IW[1:0]==2'b00)
				begin
				R_type=1'b0;
				RD=2'b10;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b100;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b1;
				Jump=2'b00;
				end
			//NDC
			else if(IW[15:12]==4'b0010 && IW[1:0]==2'b10)
				begin
				R_type=1'b0;
				RD=2'b10;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b101;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b1;
				Jump=2'b00;
				end		
			//ND0
			else if(IW[15:12]==4'b0010 && IW[1:0]==2'b01)
				begin
				R_type=1'b0;
				RD=2'b10;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b110;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b1;
				Jump=2'b00;
				end		
////////////////////////////////////////////////////////////////END R type
////////////////////////////////////////////////////////////////START I type
			////START ADI last 6bit
			else if(IW[15:12]==4'b0001)
				begin
				R_type=1'b1;
				RD=2'b01;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b001;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b1;
				Jump=2'b00;
				end
			////START LW last 6bit
			else if(IW[15:12]==4'b0100)
				begin		
				R_type=1'b1;
				RD=2'b00;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b000;
				LMstart=2'b00;
				LW_SR=1'b1;
				MEM_ANS=1'b0;
				Jump=2'b00;
				end
			////START SW last 6bit
			else if(IW[15:12]==4'b0101)
				begin
				R_type=1'b1;
				RD=2'b00;
				W_reg=1'b0;
				W_mem=1'b1;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b000;
				LMstart=2'b00;
				LW_SR=1'b1;
				MEM_ANS=1'b0;
				Jump=2'b00;
				end
			////START BEQ last 6bit
			else if(IW[15:12]==4'b1100)
				begin
				R_type=1'b0;
				RD=2'b00;
				W_reg=1'b0;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b111;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b1;
				Jump=2'b01;
				end
			////START JAL last 9bit
			else if(IW[15:12]==4'b1000)
				begin
				R_type=1'b1;
				RD=2'b00;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b1;
				LHi=1'b0;
				alu_op=3'b111;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b1;
				Jump=2'b10;
				end
			////START JLR last 6bit (fixed) wasted
			else if(IW[15:12]==4'b1001)
				begin
				R_type=1'b0;
				RD=2'b00;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b111;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b1;
				Jump=2'b11;
				end
////////////////////////////////////////////////////////////////END I type		
////////////////////////////////////////////////////////////////START J type		
			////START LHI last 9bit
			else if(IW[15:12]==4'b0011)
				begin
				R_type=1'b1;
				RD=2'b00;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b1;
				LHi=1'b1;
				alu_op=3'b111;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b1;
				Jump=2'b00;
				end
			////START LM last 9bit 0 + 8 bit addr
			else if(IW[15:12]==4'b0110)
				begin
				R_type=1'b0;
				RD=2'b11;
				W_reg=1'b1;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b1;
				alu_op=3'b111;
				LMstart=2'b11;
				LW_SR=1'b0;
				MEM_ANS=1'b0;
				Jump=2'b00;
				end
			////START SM last 9bit 0 + 8 bit addr
			else if(IW[15:12]==4'b0111)
				begin
				R_type=1'b0;
				RD=2'b11;
				W_reg=1'b0;
				W_mem=1'b1;
				sel69=1'b0;
				LHi=1'b1;
				alu_op=3'b111;
				LMstart=2'b10;
				LW_SR=1'b0;
				MEM_ANS=1'b0;
				Jump=2'b00;
				end
			//////HALT instruction
			else if(IW==16'hffff)
				begin
					stop=1'b1;
					R_type=1'b0;
					RD=2'b00;
					W_reg=1'b0;
					W_mem=1'b0;
					sel69=1'b0;
					LHi=1'b1;
					alu_op=3'b111;
					LMstart=2'b00;
					LW_SR=1'b0;
					MEM_ANS=1'b1;
					Jump=2'b00;
				end
			// UNDEFINED_STATE or NOP
			else
				begin
				R_type=1'b0;
				RD=2'b00;
				W_reg=1'b0;
				W_mem=1'b0;
				sel69=1'b0;
				LHi=1'b0;
				alu_op=3'b000;
				LMstart=2'b00;
				LW_SR=1'b0;
				MEM_ANS=1'b0;
				Jump=2'b00;
				stop=1'b0;
				end
		end
//		end
endmodule