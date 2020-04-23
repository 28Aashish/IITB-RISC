module Datapath_ID_RR (clk,resetn,in_Validity_ID_RR,
			in_pc,in_LHI,in_imm,in_IW,in_LMStart,in_RDest,in_R_type,in_LW_SR,in_Jump,in_alu_op,in_mem_ans,in_W_mem,in_W_reg,
			out_pc,out_LHI,out_imm,out_IW,out_LMStart,out_RDest,out_R_type,out_LW_SR,out_Jump,out_alu_op,out_mem_ans,out_W_mem,out_W_reg,
			out_Validity_ID_RR,
			in_stop,out_stop,stall_ID,in_BPR,out_BPR);
//ports
	input clk;
	input resetn;
	input in_Validity_ID_RR;
	
	input [15:0] 	in_pc;
	input [15:0]	in_IW;
	input in_LHI;
	input [15:0] 	in_imm;
	input [1:0] in_LMStart;
	input [2:0] in_RDest;
	input in_R_type;
	input in_LW_SR;
	input [1:0] in_Jump;
	input [2:0] in_alu_op;
	input in_mem_ans;
	input in_W_mem;
	input in_W_reg;
	input in_stop;
	input stall_ID;
	
	output reg [15:0] 	out_pc;
	output reg [15:0]	out_IW;
	output reg out_LHI;
	output reg [15:0] 	out_imm;
	output reg [1:0] out_LMStart;
	output reg [2:0] out_RDest;
	output reg out_R_type;
	output reg out_LW_SR;
	output reg [1:0] out_Jump;
	output reg [2:0] out_alu_op;
	output reg out_mem_ans;
	output reg out_W_mem;
	output reg out_W_reg;
	output reg out_Validity_ID_RR;
	output reg out_stop;

	input in_BPR;
	output reg out_BPR;

	always @ (negedge(clk) or negedge(resetn) )
	begin
		out_Validity_ID_RR<=in_Validity_ID_RR;
		if (resetn==1'b0)
			begin
			out_pc<=16'h0000;
			out_IW<=16'h0000;
			out_LHI<=1'b0;
			out_imm<=16'h0000;
			out_LMStart<=2'b00;
			out_RDest<=3'b000;
			out_R_type<=1'b0;
			out_LW_SR<=1'b0;
			out_Jump<=2'b00;
			out_alu_op<=3'b000;
			out_mem_ans<=1'b0;
			out_W_mem<=1'b0;
			out_W_reg<=1'b0;
			out_stop<=1'b0;
			out_BPR<=1'b0;

			end
			
		else if(stall_ID==1'b0)
			begin
			if (in_Validity_ID_RR==1'b1)
			begin
				out_pc<=in_pc;
				out_IW<=in_IW;
				out_LHI<=in_LHI;
				out_imm<=in_imm;
				out_LMStart<=in_LMStart;
				out_RDest<=in_RDest;
				out_R_type<=in_R_type;
				out_LW_SR<=in_LW_SR;
				out_Jump<=in_Jump;
				out_alu_op<=in_alu_op;
				out_mem_ans<=in_mem_ans;
				out_W_mem<=in_W_mem;
				out_W_reg<=in_W_reg;
				out_stop<=in_stop;
				out_BPR<=in_BPR;
				end
			else if(in_Validity_ID_RR==1'b0)
				begin
				out_Jump<=2'b00;
				out_stop<=1'b0; 
				out_BPR<=1'b0;
				end
			end
	end

endmodule