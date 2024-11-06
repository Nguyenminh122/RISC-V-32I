`timescale 1ns / 1ps

module EX
(
    input [31:0] IMM_EX,         
    input [31:0] REG_DATA1_EX,
    input [31:0] REG_DATA2_EX,
    input [31:0] PC_EX,
    input [3:0]  ALU_Sel,
    input BrUn,ASel,BSel,
    output BrEq,BrLT,
    output [31:0] ALU_OUT_EX

);
    wire zero_flag;
    wire [31:0] value_1,value_2;
    
    BranchComp branch_compare(  
                                .BrEq(BrEq), 
                                .BrLT(BrLT), 
                                .A_in(REG_DATA1_EX), 
                                .B_in(REG_DATA2_EX), 
                                .BrUn(BrUn)
                                );
    mux2_1 Value_PC_RS1(
                       .ina(REG_DATA1_EX),            
                       .inb(PC_EX),          
                       .sel(ASel),              
                       .out(value_1)
);   
    mux2_1 Value_PC_RS2(
                       .ina(REG_DATA2_EX),            
                       .inb(IMM_EX),          
                       .sel(BSel),              
                       .out(value_2)
);   

    ALU     ALU_1(  
                       .ALU_Out(ALU_OUT_EX), 
                       .A_in(value_1), 
                       .B_in(value_2), 
                       .zero_flag(zero_flag),
                       .ALUSel(ALU_Sel)
                       );
    

endmodule