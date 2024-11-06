//////////////////// Verilog code for instruction memory////////////////////
module instruction_memory
(
    input [11:0] address,
    output [31:0] instruction
);

reg [31:0] codeMemory [0:1023];

initial begin
	codeMemory[0] = 32'h06000493; 
	codeMemory[1] = 32'h02000513; 
	codeMemory[2] = 32'h04400913; 
	codeMemory[3] = 32'h00400c93; 
	codeMemory[4] = 32'h02400993; 
	codeMemory[5] = 32'h01400f13; 
	codeMemory[6] = 32'h05c00413; 
	codeMemory[7] = 32'h05000b13; 
	codeMemory[8] = 32'h05800c13; 
	codeMemory[9] = 32'h00000a93; 
	codeMemory[10] = 32'h05000613; 
	codeMemory[11] = 32'h02800113; 
	codeMemory[12] = 32'h00c00693; 
	codeMemory[13] = 32'h00400093; 
	codeMemory[14] = 32'h00c00193; 
	codeMemory[15] = 32'h04c00313; 
	codeMemory[16] = 32'h00000593; 
	codeMemory[17] = 32'h04800293; 
	codeMemory[18] = 32'h7ff00713; 
	codeMemory[19] = 32'h59c00213; 
	codeMemory[20] = 32'h06000393; 
	codeMemory[21] = 32'h15f00713; 
	codeMemory[22] = 32'h87200793; 
	codeMemory[23] = 32'hb3800813; 
	codeMemory[24] = 32'h85400893; 
	codeMemory[25] = 32'h86700a13; 
	codeMemory[26] = 32'haec00b93; 
	codeMemory[27] = 32'h05000d13; 
	codeMemory[28] = 32'h9c000d93; 
	codeMemory[29] = 32'hf4c00e13; 
	codeMemory[30] = 32'hd0200e93; 
	codeMemory[31] = 32'hcfe00f93; 
	codeMemory[32] = 32'h00193bb7; 
	codeMemory[33] = 32'h02d52623; 
	codeMemory[34] = 32'h416bdd33; 
	codeMemory[35] = 32'h030c2c03; 
	codeMemory[36] = 32'h034b2403; 
	codeMemory[37] = 32'h002127b7; 
	codeMemory[38] = 32'h03850a83; 
	codeMemory[39] = 32'h004774b7; 
	codeMemory[40] = 32'h00148f37; 
	codeMemory[41] = 32'h002f1417; 
	codeMemory[42] = 32'h029cae23; 
	codeMemory[43] = 32'h040f2f03; 
	codeMemory[44] = 32'h003f9437; 
	codeMemory[45] = 32'h0494a223; 
	codeMemory[46] = 32'h0032fa37; 
	codeMemory[47] = 32'h048ca303; 
	codeMemory[48] = 32'h00446a17; 
	codeMemory[49] = 32'h0240016f; 
	codeMemory[50] = 32'h00100c97; 
	codeMemory[51] = 32'h0074e437; 
	codeMemory[52] = 32'h0509a903; 
	codeMemory[53] = 32'h04192a23; 
	codeMemory[54] = 32'h00f8e863; 
	codeMemory[55] = 32'h00e25c63; 
	codeMemory[56] = 32'h058aaa83; 
	codeMemory[57] = 32'h05c12583; 
	codeMemory[58] = 32'h40115e33; 
	codeMemory[59] = 32'h0e800093; 
	codeMemory[60] = 32'h00c08267; 
	codeMemory[61] = 32'h064aa983; 
end

assign instruction = codeMemory[address];

endmodule
///////////////////////////////////////////////////////////////////////////
