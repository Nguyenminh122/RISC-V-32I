module instruction_memory
(
    input [11:0] address,
    output [31:0] instruction
);

reg [31:0] codeMemory [0:1023];

assign instruction = codeMemory[address];

endmodule
///////////////////////////////////////////////////////////////////////////
