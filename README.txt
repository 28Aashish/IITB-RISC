Introduction:-

Their are 2 Different Pipeline Processor:-

	1.RISC_Pipepline_WO_HBIT:
		It is a simple 6 stage pipeline Processor
		Processor_Pipeline_Arch_WO_H.pdf has the Circuit Connection diagram
	2.RISC_Pipepline_W_HBIT:
		It includes use of HistoryBit for Faster(more efficient)
		Processor_Pipeline_Arch_W_H.pdf has the Circuit Connection diagram
		
The Pipeline Processor have following stage:-
	1.Instruction Fetch
	2.Instruction Decode
	3.Register Read
	4.Execution
	5.Memory Access
	6.Write Back

This Processor is written using verilog language and I have used "ModelSim - Intel FPGA Starter Edition 10.5b (Quartus Prime 18.1)" for Simulation Purpose.

The pdf include the Circuital arrangement of the Pipeline Architecture of their respective kind.

Decoder pdf/excell sheet include the Decoding logic of Instruction Decoder

Steps to run(for ModelSim only):-
	1.Open ModelSim
	2.Change Directory to respective folder(RISC_Pipepline_WO_HBIT or RISC_Pipepline_W_HBIT)
	3.The "script.tcl" is in the respective folder.Execute it using command line as writing "do ./script.tcl" or going through Tools->Tcl->Execute Macro and selecting script.tcl
	
The Simulation Contains Major observations:-
	1.The Program Counter (Current and Next)
	2.Register Files(Only Registers )
	3.Instruction Decode Generated Signal
	
Following are the points to be noted:-
	1.The Instruction is in "instruction_mem.v" .Which has some mixed instruction execution
	2.The Size of Memory(Data,Instruction & History) is cut down to 200 for the implementable purpose.
	3.The "RISC.v" is the Top Module and "tb_RISC.v" is the Testbench for clock and Reset of Processor.
	4.script.tcl has details of everything,Although to see in Simulation one need to comment out the Signal.


-Made By
Aashish Tamrakar
193079034