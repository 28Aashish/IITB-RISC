module Datapath_IF_ID (clk,resetn,in_Validity_IF_ID,
			in_IW,in_pc,
			out_IW,out_pc,validity_out,
			stall_IF);
//ports
	input clk;
	input resetn;
	input in_Validity_IF_ID;
	
	input [15:0]in_IW;
	input [15:0] in_pc;
	input stall_IF;


	output reg [15:0] out_IW;
	output reg [15:0] out_pc;
	
	output reg validity_out;

		
	always @ (negedge(clk) or negedge(resetn))
	begin
		validity_out<=in_Validity_IF_ID;
		if (resetn==1'b0)
			begin
			out_pc<=16'h0000;
			out_IW<=16'hfffe;
			end
		else if(stall_IF==1'b0)
			begin
			if (in_Validity_IF_ID==1'b1 )
				begin
				out_pc<=in_pc;
				out_IW<=in_IW;
				end
			else if(in_Validity_IF_ID==1'b0)
				if(out_IW[15:14]==2'b10 || out_IW==16'hffff ) out_IW<=16'hfffe; 
			end
		end
endmodule