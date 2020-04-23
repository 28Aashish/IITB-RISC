module RIsC (clk,reset_n);


///////////////////////////////////////////////////////////////////////
/////////////////////////////Interface Stage///////////////////////////
///////////////////////////////////////////////////////////////////////	
	
	input clk;
	input reset_n;

///////////////////////////////////////////////////////////////////////
/////////////////////////////Instruction Fetch/////////////////////////
///////////////////////////////////////////////////////////////////////
	wire stop_WB;
	wire [5:0]stall;
	wire [15:0]Next_PC;
	wire [15:0]Current_PC;
	wire not_M_inst;
	PC ProgramCounter (clk,reset_n,Next_PC,not_M_inst & reset_n  & !stall[5] || stop_WB,Current_PC);
	wire [15:0]IW_IF;
	instr_mem IM (Current_PC,IW_IF);
	
	wire [15:0]pc_1;
	adder  add_IF (Current_PC,16'h0001,pc_1);

	wire X_Validity_IF_ID;
	wire [15:0] IW_ID;
	wire [15:0] PC_ID;
	wire Validity_ID;
	Datapath_IF_ID Datapath_IF_ID (clk,reset_n,X_Validity_IF_ID,
									IW_IF,Current_PC,
									IW_ID,PC_ID,Validity_ID,stall[4]);


///////////////////////////////////////////////////////////////////////
/////////////////////////////Instruction Decode////////////////////////
///////////////////////////////////////////////////////////////////////
	wire R_type_ID;
	wire [1:0] RD_ID;
	wire W_reg_ID;
	wire W_mem_ID;
	wire sel69_ID;
	wire LHI_ID;
	wire [2:0] alu_op_ID;
	wire [1:0] LMStart_ID;
	wire LW_SR_ID;
	wire MEM_ANS_ID;
	wire [1:0] Jump_ID;
	
	wire in_Validity_ID_RR;
	wire X_Validity_ID_RR;
	wire M_inst;
	wire stop_ID;
	
	assign in_Validity_ID_RR= M_inst | X_Validity_ID_RR & Validity_ID;

	iDecoder iDecoder (IW_ID,R_type_ID,RD_ID,W_reg_ID,W_mem_ID,sel69_ID,
						LHI_ID,alu_op_ID,LMStart_ID,LW_SR_ID,MEM_ANS_ID,
						Jump_ID,stop_ID);


	wire [2:0]RM_ID;
	M_inst_Controller MIC (clk,LMStart_ID,IW_ID[7:0],M_inst,RM_ID,reset_n);
	assign not_M_inst=!M_inst;
	
	wire [2:0]RA_ID;
	wire [2:0]RB_ID;
	wire [2:0]RC_ID;
	wire [2:0]RDest_ID;
	assign RA_ID=IW_ID[11:9];
	assign RB_ID=IW_ID[8:6];
	assign RC_ID=IW_ID[5:3];
	
	mux4_3 mux4_ID (RA_ID,RB_ID,RC_ID,RM_ID,RD_ID,RDest_ID);
	
	wire [15:0] out16_6;
	sign_6_16 sign_6_16 (IW_ID[5:0],out16_6);
	
	wire [15:0] out16_9;
	sign_9_16 sign_9_16 (LHI_ID,IW_ID[8:0],out16_9);
	
	wire [15:0] Imm_ID;
	mux2 mux2_ID (out16_6,out16_9,sel69_ID,Imm_ID);
	
//	wire in_Validity_ID_RR;
	wire [15:0]PC_RR;
	wire LHI_RR;
	wire [15:0]Imm_RR;
	wire [15:0]IW_RR;
	wire [1:0]LMStart_RR;
	wire [2:0]RDest_RR;
	wire R_type_RR;
	wire LW_SR_RR;
	wire [1:0] Jump_RR;
	wire [2:0] alu_op_RR;
	wire MEM_ANS_RR;
	wire W_reg_RR;
	wire W_mem_RR;
	wire Validity_RR;
	wire stop_RR;

	Datapath_ID_RR Datapath_ID_RR (clk,reset_n,in_Validity_ID_RR,
									PC_ID,LHI_ID,Imm_ID,IW_ID,LMStart_ID,RDest_ID
									,R_type_ID,LW_SR_ID,Jump_ID,alu_op_ID,MEM_ANS_ID
									,W_mem_ID,W_reg_ID,
									PC_RR,LHI_RR,Imm_RR,IW_RR,LMStart_RR,RDest_RR
									,R_type_RR,LW_SR_RR,Jump_RR,alu_op_RR,MEM_ANS_RR
									,W_mem_RR,W_reg_RR,
									Validity_RR,
									stop_ID,stop_RR,stall[3]);
///////////////////////////////////////////////////////////////////////
/////////////////////////////Register Read/////////////////////////////
///////////////////////////////////////////////////////////////////////
	
	wire [15:0] PC_WB;
	wire [2:0]RB_RR;
	mux2_3 mux2_RR_0 (IW_RR[8:6],RDest_RR,LMStart_RR[1],RB_RR);
	
	wire [2:0]RA_RR;
	wire [2:0]RDest_WB;
	wire W_reg_WB;
	wire [15:0] R_DATA_IN;
	wire [15:0] NData_A;
	wire [15:0] NData_B;
	wire [15:0] NData_A_tmp;
	wire [15:0] NData_B_tmp;
	
	wire [15:0] DATA_A;
	wire [15:0] DATA_B;
	wire [15:0] R7DATA;

	assign RA_RR=IW_RR[11:9];
	
	Reg_file RBank (clk,reset_n,
					RA_RR,RB_RR,
					R_DATA_IN,RDest_WB,W_reg_WB,
					NData_A_tmp,NData_B_tmp,
					R7DATA);
	
	mux2 mux2_RR_R7_RA (NData_A_tmp,PC_RR,&RA_RR,NData_A);
	
	mux2 mux2_RR_R7_RB (NData_B_tmp,PC_RR,&RB_RR,NData_B);
	
	
	wire in_Validity_RR_EX;
	wire X_Validity_RR_EX;
	wire [15:0] in_src0,in_src1;

	
	wire [15:0] M_ADDR_RR;
	M_inst_addr_GEN MIAG (clk,LMStart_RR,
							DATA_A,M_ADDR_RR,
							reset_n,IW_RR[7:0]);
	wire [15:0] MData_in_RR;
	mux2 mux2_RR_1 (DATA_A,DATA_B,LMStart_RR[1],MData_in_RR);
	
	mux2 mux2_RR_2 (DATA_A,DATA_B,LW_SR_RR,in_src0);
	
	mux2 mux2_RR_3 (DATA_B,Imm_RR,R_type_RR,in_src1);


// 			Loose Ends of The FWD Technique
/*
	wire in_Validity_RR_EX;
	wire X_Validity_RR_EX;
	wire [15:0] in_src0,in_src1;
*/
	wire [15:0] PC_EX;
	wire LHI_EX;
	wire [15:0] M_ADDR_EX;
	wire [15:0] out_src0,out_src1;
	wire [1:0] LMStart_EX;
	wire [15:0] MData_in_EX;
	wire [2:0]alu_op_EX;
	wire MEM_ANS_EX;
	wire [2:0] RDest_EX;
	wire W_mem_EX;
	wire W_reg_EX_tmp;
	
	wire [1:0] Jump_EX;
	assign in_Validity_RR_EX = Validity_RR & X_Validity_RR_EX;
	
	wire stop_EX;

	wire Validity_EX;
	Datapath_RR_EX Datapath_RR_EX (clk,reset_n,in_Validity_RR_EX,
									PC_RR,LHI_RR,M_ADDR_RR,in_src0,in_src1,LMStart_RR,MData_in_RR,
									RDest_RR,alu_op_RR,MEM_ANS_RR,W_mem_RR,W_reg_RR,Jump_RR,
									PC_EX,LHI_EX,M_ADDR_EX,out_src0,out_src1,LMStart_EX,
									MData_in_EX,RDest_EX,alu_op_EX,MEM_ANS_EX,W_mem_EX,
									W_reg_EX_tmp,Jump_EX,
			
									Validity_EX,
									stop_RR,stop_EX,stall[2]);


//////////////////////////////////////////////////////////////////
/////////////////////////////EXEUCUTE/////////////////////////////
//////////////////////////////////////////////////////////////////

	wire [15:0]ans;
	wire allow;
	
	alu ALU (alu_op_EX,out_src0,out_src1,ans,reset_n,allow);
	
	wire [15:0] ans_src1;
	mux2 EX0 (ans,out_src1,LHI_EX,ans_src1);

	wire [15:0]PC_EX_1;
	wire [15:0] ans_LHI_PC_1;
	adder PC_ADDER_EX (PC_EX,16'h0001,PC_EX_1);
	
	mux2 EX1 (ans_src1,PC_EX_1,Jump_EX[1],ans_LHI_PC_1);
	
	wire W_reg_EX;
	assign W_reg_EX=W_reg_EX_tmp & allow;
	
	wire in_Validity_EX_MEM;
	wire X_Validity_EX_MEM;
	
	wire [15:0] M_ADDR_MEM;
	wire [15:0] ans_LHI_PC_1_MEM;
	wire [1:0] LMStart_MEM;
	wire [15:0] MData_in_MEM;
	wire [2:0]RDest_MEM;
	wire MEM_ANS_MEM;
	wire W_reg_MEM;
	wire W_mem_MEM;
	wire [15:0] PC_MEM;
	
	
	assign	in_Validity_EX_MEM = Validity_EX & X_Validity_EX_MEM;
	
	wire stop_MEM;

	wire Validity_MEM;
	Datapath_EX_MEM Datapath_EX_MEM (clk,reset_n,in_Validity_EX_MEM,
										M_ADDR_EX,ans_LHI_PC_1,LMStart_EX,MData_in_EX,RDest_EX,
										MEM_ANS_EX,W_mem_EX,W_reg_EX,PC_EX,
										M_ADDR_MEM,ans_LHI_PC_1_MEM,LMStart_MEM,MData_in_MEM,
										RDest_MEM,MEM_ANS_MEM,W_mem_MEM,W_reg_MEM,PC_MEM,
										Validity_MEM,
										stop_EX,stop_MEM,stall[1]);

///////////////////////////////////////////////////////////////////////
/////////////////////////////MEMORY ACCESS/////////////////////////////
///////////////////////////////////////////////////////////////////////

	wire [15:0] ADDR;
	mux2 MEM0 (ans_LHI_PC_1_MEM,M_ADDR_MEM,LMStart_MEM[1],ADDR);

	wire [15:0]DATA_out;
	data_mem DATA_MEMORY (clk,ADDR,MData_in_MEM,DATA_out,W_mem_MEM,reset_n);
	
	wire [15:0]in_Result;
	mux2 MEM1 (DATA_out,ans_LHI_PC_1_MEM,MEM_ANS_MEM,in_Result);
	
	
	wire in_Validity_MEM_WB;
	wire X_Validity_MEM_WB;

	wire [15:0]out_Result;
//	wire [2:0] RDest_WB;
//	wire W_reg_WB;
	assign in_Validity_MEM_WB= Validity_MEM & X_Validity_MEM_WB ;
	
	wire Validity_WB;
	Datapath_MEM_WB Datapath_MEM_WB (clk,reset_n,in_Validity_MEM_WB,
									in_Result,RDest_MEM,W_reg_MEM,PC_MEM,
									out_Result,RDest_WB,W_reg_WB,PC_WB,
									Validity_WB,
									stop_MEM,stop_WB,stall[0]);

///////////////////////////////////////////////////////////////////////
//////////////////////////// WRITE BACK  //////////////////////////////
///////////////////////////////////////////////////////////////////////
	
	assign R_DATA_IN=out_Result;
	wire [1:0]FWD_RA_N_EX_MEM_WB;
	wire [1:0]FWD_RB_N_EX_MEM_WB;

	DATA_FWD DATA_FWD (LMStart_RR,|Jump_RR,W_reg_RR,W_reg_EX,W_reg_MEM,W_reg_WB,W_mem_RR,
				RDest_EX,RDest_MEM,RDest_WB,
				RA_RR,RB_RR,
				FWD_RA_N_EX_MEM_WB,
				FWD_RB_N_EX_MEM_WB);
	//when load in exe and RR need that loaded Value
	wire except_LW_RR;
	assign except_LW_RR = W_reg_RR==1'b1 && alu_op_EX==3'b000 && MEM_ANS_EX==1'b0 && (FWD_RA_N_EX_MEM_WB==2'b01 || FWD_RB_N_EX_MEM_WB==2'b01 ) ? 1'b1 :1'b0;
	wire Beq;
	assign Beq = DATA_A==DATA_B ? 1'b1 : 1'b0;
	wire [1:0] SEL_PC;

	HM HM (reset_n,M_inst,RDest_MEM,W_reg_MEM,Jump_ID,Jump_RR,
			Beq,
			X_Validity_IF_ID,X_Validity_ID_RR,X_Validity_RR_EX,
			X_Validity_EX_MEM,X_Validity_MEM_WB,
			SEL_PC,stop_ID,stop_MEM,stop_WB,
			stall,except_LW_RR);		

	
	wire imm_sel;
	//assign imm_sel= reset_n&(Beq&! | &!);
	//*********************************************************************************************need assign
	assign imm_sel= Beq&&!Jump_RR[1]&&Jump_RR[0];
	wire [15:0] mux_PC_IMM0_ans;
	wire [15:0] mux_PC_IMM1_ans;
	wire [15:0] Next_PC_tmp;
	mux2 mux_PC_IMM0 (PC_ID,PC_RR,imm_sel,mux_PC_IMM0_ans);
	mux2 mux_PC_IMM1 (Imm_ID,Imm_RR,imm_sel,mux_PC_IMM1_ans);
/*	mux2 mux_PC_IMM0 (PC_RR,PC_ID,imm_sel,mux_PC_IMM0_ans);
	mux2 mux_PC_IMM1 (Imm_RR,Imm_ID,imm_sel,mux_PC_IMM1_ans);*/
	wire [15:0] PC_IMM;
	adder add_imm (mux_PC_IMM0_ans,mux_PC_IMM1_ans,PC_IMM);
	mux4  mux4_RR0 (NData_A,ans_LHI_PC_1,in_Result,out_Result,FWD_RA_N_EX_MEM_WB,DATA_A);
	mux4  mux4_RR1 (NData_B,ans_LHI_PC_1,in_Result,out_Result,FWD_RB_N_EX_MEM_WB,DATA_B);

	mux4 PC_SELECTION (pc_1,PC_IMM,DATA_B,in_Result,SEL_PC,Next_PC_tmp);
	
	
	mux2 HLT_SYNC (Next_PC_tmp,PC_WB,stall[0],Next_PC);
	
	mux2 R7D (PC_WB,out_Result,&RDest_WB && W_reg_WB,R7DATA);
	
 endmodule