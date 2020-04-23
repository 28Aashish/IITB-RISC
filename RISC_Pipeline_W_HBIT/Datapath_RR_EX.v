module Datapath_RR_EX (clk,resetn,in_Validity_RR_EX,
			in_pc,in_LHI,in_M_addr,in_src0,in_src1,in_LMStart,in_Data_in,in_RDest,in_alu_op,in_mem_ans,in_W_mem,in_W_reg,
			in_Jump,
			out_pc,out_LHI,out_M_addr,out_src0,out_src1,out_LMStart,out_Data_in,out_RDest,out_alu_op,out_mem_ans,out_W_mem,out_W_reg,
			out_Jump,
			out_Validity_RR_EX,
			in_stop,out_stop,stall_RR,in_BPR,out_BPR);
//ports
	input clk;
	input resetn;
	input in_Validity_RR_EX;
	
	input [15:0] in_pc;
	input in_LHI;
	input [15:0] in_M_addr;
	input [15:0] in_src0;
	input [15:0] in_src1;
	input [1:0] in_LMStart;
	input [15:0] in_Data_in;
	input [2:0] in_RDest;
	input [2:0] in_alu_op;
	input in_mem_ans;
	input in_W_mem;
	input in_W_reg;
	input in_stop;
	input [1:0]in_Jump;
	input stall_RR;

	output reg [15:0] out_pc;
	output reg out_LHI;
	output reg [15:0] out_M_addr;
	output reg [15:0]  out_src0;
	output reg [15:0]  out_src1;
	output reg [1:0] out_LMStart;
	output reg [15:0] out_Data_in;
	output reg [2:0] out_RDest;
	output reg [2:0] out_alu_op;
	output reg out_mem_ans;
	output reg out_W_mem;
	output reg out_W_reg;
	output reg out_Validity_RR_EX;
	output reg out_stop;
	output reg [1:0]out_Jump;
	

	input in_BPR;
	output reg out_BPR;


	always @ (negedge(clk) or negedge(resetn))
	begin
		out_Validity_RR_EX<=in_Validity_RR_EX;
	if (resetn==1'b0)
			begin
			out_pc<=16'h0000;
			out_LHI<=1'b0;
			out_M_addr<=16'h0000;
			out_src0<=16'h0000;
			out_src1<=16'h0000;
			out_LMStart<=2'b00;
			out_Data_in<=16'h0000;
			out_RDest<=3'b000;
			out_alu_op<=3'b111;
			out_mem_ans<=1'b0;
			out_W_mem<=1'b0;
			out_W_reg<=1'b0;
			out_stop<=1'b0;
			out_Jump<=2'b00;
			out_BPR<=1'b0;
			end
	
		else if(stall_RR==1'b0)
			begin
				if (in_Validity_RR_EX==1'b1 )
				begin	
				out_pc<=in_pc;
				out_LHI<=in_LHI;
				out_M_addr<=in_M_addr;
				out_src0<=in_src0;
				out_src1<=in_src1;
				out_LMStart<=in_LMStart;
				out_Data_in<=in_Data_in;
				out_RDest<=in_RDest;
				out_alu_op<=in_alu_op;
				out_mem_ans<=in_mem_ans;
				out_W_mem<=in_W_mem;
				out_W_reg<=in_W_reg;
				out_stop<=in_stop;
				out_Jump<=in_Jump;
				out_BPR<=in_BPR;
				end	
			else if(in_Validity_RR_EX==1'b0)
				begin
				out_Jump<=2'b00;
				out_stop<=1'b0; 
				out_BPR<=1'b0;
				end
			end
	end

endmodule