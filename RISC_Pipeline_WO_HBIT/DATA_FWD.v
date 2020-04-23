module DATA_FWD (
				LMStart,JUMPER_RR,
				W_REG_RR,W_REG_EX,W_REG_MEM,W_REG_WB,W_MEM_RR,
				RDest_EX,RDest_MEM,RDest_WB,
				RA_RR,RB_RR,
				FWD_RA_N_EX_MEM_WB,
				FWD_RB_N_EX_MEM_WB);
//Ports
	input [1:0]LMStart;
	input JUMPER_RR;
	input W_REG_EX,W_REG_RR,W_REG_MEM,W_REG_WB,W_MEM_RR;
	input [2:0]	RDest_EX,RDest_MEM,RDest_WB;
	input [2:0] RA_RR,RB_RR;
/*
FWD_RA_N_EX_MEM_WB	00	DATA from Register Bank RA
					01	DATA from Execution
					10	DATA from memory acces
					11	DATA from WB
					
FWD_RB_N_EX_MEM_WB	00	DATA from Register Bank RB
					01	DATA from Execution
					10	DATA from memory acces
					11	DATA from WB
*/
	output reg [1:0] FWD_RA_N_EX_MEM_WB;
	output reg [1:0] FWD_RB_N_EX_MEM_WB;
	
	always @(*)
		begin	
			if(W_REG_RR==1'b1 ||LMStart[1]==1'b1 ||W_MEM_RR==1'b1 || JUMPER_RR==1'b1)
				begin
					if(RA_RR==RDest_WB &&	W_REG_WB==1'b1) 				FWD_RA_N_EX_MEM_WB=2'b11;
					else if(RA_RR==RDest_MEM &&	W_REG_MEM==1'b1) 		FWD_RA_N_EX_MEM_WB=2'b10;
					else if(RA_RR==RDest_EX &&	W_REG_EX==1'b1) 			FWD_RA_N_EX_MEM_WB=2'b01;
					else												FWD_RA_N_EX_MEM_WB=2'b00;
					
					if(RB_RR==RDest_WB &&	W_REG_WB==1'b1) 			FWD_RB_N_EX_MEM_WB=2'b11;
					else if(RB_RR==RDest_MEM &&	W_REG_MEM==1'b1) 		FWD_RB_N_EX_MEM_WB=2'b10;
					else if(RB_RR==RDest_EX &&	W_REG_EX==1'b1) 			FWD_RB_N_EX_MEM_WB=2'b01;
					else												FWD_RB_N_EX_MEM_WB=2'b00;
	
				end
			else
				begin
				FWD_RA_N_EX_MEM_WB<=2'b00;
				FWD_RB_N_EX_MEM_WB<=2'b00;
				end
		end	
		
endmodule