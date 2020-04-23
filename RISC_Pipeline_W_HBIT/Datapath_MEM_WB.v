module Datapath_MEM_WB (clk,resetn,in_Validity_MEM_WB,
			in_Result,in_RDest,in_W_reg,in_pc,
			out_Result,out_RDest,out_W_reg,out_pc,
			out_Validity_MEM_WB,
			in_stop,out_stop,stall_MEM,in_BPR,out_BPR);
//ports
	input clk;
	input resetn;
	input in_Validity_MEM_WB;
	input stall_MEM;
	
	input [15:0] in_Result;
	input [2:0] in_RDest;
	input in_W_reg;
	input in_stop;
	input [15:0] in_pc;
	

	
	output reg [15:0] out_Result;
	output reg [2:0] out_RDest;
	output reg out_W_reg;
	output reg out_Validity_MEM_WB;
	output reg out_stop;
	output reg [15:0] out_pc;
	
	
	input in_BPR;
	output reg out_BPR;

	
	always @ (negedge(clk))
	begin
		out_Validity_MEM_WB<=in_Validity_MEM_WB;
		if (resetn==1'b0)
			begin
			out_Result<=16'h0000;
			out_RDest<=3'b000;
			out_W_reg<=1'b0;
			out_stop<=1'b0;
			out_pc<=16'h0000;
			out_BPR<=1'b0;
			end
		else if(stall_MEM==1'b0)
			begin
				if (in_Validity_MEM_WB==1'b1)
				begin
				out_Result<=in_Result;
				out_RDest<=in_RDest;
				out_W_reg<=in_W_reg;
				out_stop<=in_stop;
				out_pc<=in_pc;
				out_BPR<=in_BPR;
				end
				else if(in_Validity_MEM_WB==1'b0)
				begin
				out_RDest<=3'b000;
				out_W_reg<=1'b0;
				out_stop<=1'b0;
				out_BPR<=1'b0;
				end
			end
	end

endmodule