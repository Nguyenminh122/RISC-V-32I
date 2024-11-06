module ID
(
    input clk,
    input [31:0] INSTRUCTION_ID,
    input RegWrite,
    input [31:0] ALU_DATA_WB,
    input [2:0] Imm_Sel,
    output [31:0] IMM_ID,
    output [31:0] REG_DATA1_ID,REG_DATA2_ID,
    output [2:0] FUNCT3_ID,
    output [6:0] FUNCT7_ID,
    output [6:0] OPCODE_ID
 );

    wire [4:0]RS1_ID,RS2_ID,RD_ID;

    assign FUNCT3_ID = INSTRUCTION_ID[14:12];
    assign FUNCT7_ID = INSTRUCTION_ID[31:25];
    assign OPCODE_ID = INSTRUCTION_ID[6:0];
    assign RD_ID = INSTRUCTION_ID[11:7];
    assign RS1_ID = INSTRUCTION_ID[19:15];
    assign RS2_ID = INSTRUCTION_ID[24:20];

  registers REGISTER_FILE_MODULE(
                                .clk(clk),
                                .reg_write(RegWrite), 
                                .read_reg1(RS1_ID),    
                                .read_reg2(RS2_ID),    
                                .write_reg(RD_ID),     
                                .write_data(ALU_DATA_WB),
                                .read_data1(REG_DATA1_ID),
                                .read_data2(REG_DATA2_ID)
                                 );
  
  ImmGen IMM_GEN_MODULE(    .Inst(INSTRUCTION_ID), 
                            .ImmOut(IMM_ID), 
                            .ImmSel(Imm_Sel)
                            );
endmodule
