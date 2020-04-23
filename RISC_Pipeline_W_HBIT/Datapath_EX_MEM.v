module Datapath_EX_MEM (clk,resetn,in_Validity_EX_MEM,
			in_M_addr,in_ANS_LHI_PC1,in_LMStart,in_Data_in,in_RDest,in_mem_ans,in_W_mem,in_W_reg,in_pc,
			out_M_addr,out_ANS_LHI_PC1,out_LMStart,out_Data_in,out_RDest,out_mem_ans,out_W_mem,out_W_reg,out_pc,
			out_Validity_EX_MEM,
			in_stop,out_stop,stall_EX,in_BPR,out_BPR);
//ports
	input clk;
	input resetn;
	input in_Validity_EX_MEM;
	
	input [15:0] in_M_addr;
	input [15:0] in_ANS_LHI_PC1;
	input [1:0] in_LMStart;
	input [15:0] in_Data_in;
	input [2:0] in_RDest;
	input in_mem_ans;
	input in_W_mem;
	input in_W_reg;
	input in_stop;
	input [15:0]in_pc;
	input stall_EX;
	
	output reg [15:0] out_M_addr;
	output reg [15:0] out_ANS_LHI_PC1;
	output reg [1:0] out_LMStart;
	output reg [15:0] out_Data_in;
	output reg [2:0] out_RDest;
	output reg out_mem_ans;
	output reg out_W_mem;
	output reg out_W_reg;
	output reg out_Validity_EX_MEM;
	output reg out_stop;
	output reg [15:0]out_pc;
	

	input in_BPR;
	output reg out_BPR;

	
	
	always @ (negedge(clk) or negedge (resetn))
	begin
		out_Validity_EX_MEM<=in_Validity_EX_MEM;
		if (resetn==1'b0)
			begin
			out_M_addr<=16'h0000;
			out_ANS_LHI_PC1<=16'h0000;
			out_LMStart<=2'b00;
			out_Data_in<=16'h0000;
			out_RDest<=3'b000;
			out_mem_ans<=1'b0;
			out_W_mem<=1'b0;
			out_W_reg<=1'b0;
			out_stop<=1'b0;
			out_pc<=16'h0000;
			out_BPR<=1'b0;
			end
		else if(stall_EX==1'b0)
			begin
				if (in_Validity_EX_MEM==1'b1)
				begin
				out_M_addr<=in_M_addr;
				out_ANS_LHI_PC1<=in_ANS_LHI_PC1;
				out_LMStart<=in_LMStart;
				out_Data_in<=in_Data_in;
				out_RDest<=in_RDest;
				out_mem_ans<=in_mem_ans;
				out_W_mem<=in_W_mem;
				out_W_reg<=in_W_reg;
				out_stop<=in_stop;
				out_pc<=in_pc;
				out_BPR<=in_BPR;
				end
			else if(in_Validity_EX_MEM==1'b0)
				begin
				out_RDest<=3'b000;
				out_W_reg<=1'b0;
				out_stop<=1'b0; 
				out_BPR<=1'b0;			
				end
		end
		
	end

endmodule