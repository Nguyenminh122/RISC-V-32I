module IF
(
    input clk, rst,
    input PC_Sel, 
    input [31:0] ALU_Src,
    output [31:0] PC_IF, PC_4_IF, INSTRUCTION_IF
);

  //wire [31:0] instruction_address
  wire [31:0] PC_MUX;
  //wire [31:0] PC_4_IF;
  wire [31:0] PC_Out;
  
  wire [11:0] instruction_address = PC_Out[14:2];

  mux2_1 PC_ALU_Src(
                       .ina(PC_4_IF),            
                       .inb(ALU_Src),          
                       .sel(PC_Sel),              
                       .out(PC_MUX)
);
  
  PC PC_MODULE(
                      .clk(clk),
                      .res(rst),
                      //.write(PC_write),
                      .in(PC_MUX),
                      .out(PC_Out)
);
  
  instruction_memory INSTRUCTION_MEMORY_MODULE(
                      .address(instruction_address),
                      .instruction(INSTRUCTION_IF)
);
  adder ADDER_PC_4_IF(
                      .ina(PC_Out),
                      .inb(32'b0100),
                      .out(PC_4_IF)
  );
  assign PC_IF = PC_Out;
endmodule