module instr_mem (addr,data);
	parameter size = 200;
	input [15:0] addr;
	output[15:0] data;
	
	reg [15:0] ROM[0:size-1];
	
	initial 
		begin
		/*
		ROM[0]<=16'b10_00_001_001_000_001;	//JaL R1 ,001_000_001 i.e pc +65 and r0<=0001;
		ROM[1]<=16'b00_01_000_000_011_000;	//adi r0,r0,011_000	r0<=r0+18			SHOULD BE NEGLECTED

		ROM[65]<=16'b00_01_000_011_011_000;	//adi r3,r0,011_000	r3<=r0+18 i.e r3=0018
		ROM[66]<=16'b00_01_000_010_011_011;	//adi r2,r0,011_011 r2<=r0+1b i.e r2=001b
		ROM[67]<=16'b00_00_010_011_100_0_00;//add r4,r3,r2 r4<=r3+r2 i.e r4=0033
		ROM[68]<=16'b00_00_010_100_101_0_00;//add r5,r3,r2 r5<=r4+r2 i.e r5=004e
		ROM[69]<=16'b00_11_001_001_001_000; // LHI R1,h48			put h2400	i.e r1=2400
		ROM[70]<=16'b00_00_010_011_000_0_01;//adz a2,a3,a0 a0<=a1+a2 if z=0;	no addition	
		ROM[71]<=16'b00_10_011_010_110_0_00;//ndu r3,r2,r6 r6<=!(r2 & r3) i.e r6=ffe7
		ROM[72]<=16'b01_01_011_000_001_010;	//Save r3 in 000a			[000a]=r3=0018
		ROM[73]<=16'b01_00_101_000_001_010;	//load r5 from 000a			r5=0018=[000a]
		ROM[74]<=16'b01_11_000_0_0100_1101;	//SM 0,2,3,6 from 0000 to 0003 from Ref to mem
											//[0000]=0000
											//[0001]=001b
											//[0002]=0018
											//[0003]=ffe7
		ROM[75]<=16'b00_01_001_010_011_011;	//adi r2,r1,011_011 r2<=r1+1b i.e r2 =241b
		ROM[76]<=16'b01_10_000_0_0111_1111;	//LM All other than r7 from 0000 to 0005 from Ref to mem
												//r0=0000	
												//r1=001b
												//r2=0018	
												//r3=ffe7
												//r4=0000
												//r5=0000
												//r6=0000	
		ROM[77]<=16'b10_01_011_001_000_000;	//JLR R3 ,r1 i.e pc<=r1=001b &	r3=<004e
		ROM[78]<=16'b00_01_000_000_011_000;	//adi r0,r0,011_000	r0<=r0+18			SHOULD BE NEGLECTED
		
		ROM[26]<=16'b00_01_000_000_011_000;	//adi r0,r0,011_000	r0<=r0+18			SHOULD BE NEGLECTED
		
	  //ROM[65]<=16'b00_01_000_011_011_000;	//adi r3,r0,011_000	r3<=r0+18 i.e r3=0018
		ROM[27]<=16'b00_01_000_011_011_011;	//adi r3,r0,111_011	r3<=r0+1b i.e r3=001b
		ROM[28]<=16'b11_00_010_101_010_010;	//beq r2,r5 01_00_11							FALSE BRANCH
		ROM[29]<=16'b11_00_100_101_010_010;	//beq r4,r5 01_00_11 PC<=29d+12h=47d			TRUE BRANCH
	
		ROM[30]<=16'b00_01_000_000_011_000;	//adi r0,r0,011_000	r0<=r0+18			SHOULD BE NEGLECTED
		ROM[46]<=16'b00_01_000_000_011_000;	//adi r0,r0,011_000	r0<=r0+18			SHOULD BE NEGLECTED
		
		ROM[47]<=16'b00_01_000_101_000_001;	//adi r3,r0,011_000	r5<=r0+01	r5=0001
		ROM[48]<=16'b00_01_000_111_011_111;	//adi r7,r0,011_000	r7<=r0+18   r7=0018
		ROM[49]<=16'hffff;
		
		ROM[31]<=16'b00_01_000_110_111_000;	//adi r0,r0,111_000	r6<=r0+18	r6=fff8
		ROM[32]<=16'b01_00_101_000_001_010;	//load r5 from 000a			r5=0018=[000a]
		ROM[33]<=16'b00_00_101_101_100_0_00;//adc r4,r5,r5 r4<=r5+r5 i.e r4=0030
		ROM[34]<=16'hffff;
		*/
		
		
		ROM[0]<=16'b00_01_000_011_011_100;	//adi r3,r0,011_000	r3<=r0+18 i.e r3=0018
		ROM[1]<=16'b00_01_000_010_000_111;	//adi r2,r0,011_011 r2<=r0+1b i.e r2=001b
		ROM[2]<=16'b11_00_011_000_000_100;	//beq r4,r0 00_00_100 looper	end 
		ROM[3]<=16'b00_00_100_010_100_0_00;//add r4,r2,r2 r4<=r2+r2 i.e looper
		ROM[4]<=16'b00_01_011_011_111_111;	//add r4,r2,r2 r4<=r2+r2 i.e
		ROM[5]<=16'b00_01_000_111_000_010;	//adi r7,r0,011_000	r7<=r0+2   r7=0002
		ROM[6]<=16'hffff;
		/*
		ROM[0]<=16'b10_00_001_001_000_001;	//JaL R1 ,001_000_001 i.e pc +65 and r0<=0001;
		ROM[65]<=16'b00_01_000_011_011_000;	//adi r3,r0,011_000	r3<=r0+18 i.e r3=0018
		*/
		end
	
	assign	data = ROM[addr];
	
	
endmodule



//		IF		ID		RR		EX 		MM 		WB	