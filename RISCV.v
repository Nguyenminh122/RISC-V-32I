
//////////////////////////////////////////////RISC-V_MODULE///////////////////////////////////////////////////
module RISC_V
(
    input clk,
    input rst,
    output [31:0] pc_reg
);

  //////////////////////////////////////////IF signals////////////////////////////////////////////////////////
    wire [31:0] PC_IF_EX, PC_4_IF_EX, INSTRUCTION_IF_ID;
    
///////////////////////////////////////////Ctrol_Path signal and ID signals////////////////////////////////////////////////////////
    wire [2:0] FUNCT3_ID_EX,LoadStore_Sel;
    wire [6:0] FUNCT7_ID_EX, OPCODE_ID_Ctrl;
    wire MemRead_Ctrl_Mem, MemWrite_Ctrl_Mem, RegWrite_Ctrl_ID;
    
    wire [31:0] IMM_ID_EX, ALU_DATA_WB_ID,
                REG_DATA1_ID_EX, REG_DATA2_ID_EX;
        
        
 ////////////////////////////////////////EX signals////////////////////////////////////////////////////////        
    wire [31:0] ALU_OUT_EX_Mem;

 ////////////////////////////////////////MEM signals////////////////////////////////////////////////////////    
    wire [31:0] Read_data_Mem_Mux;   
    


    


/////////////////////////////////////IF Module/////////////////////////////////////
    wire PC_Sel;
    IF instruction_fetch(
                        .clk(clk), 
                        .rst(rst), 
                        .PC_Sel(PC_Sel),
                        .ALU_Src(ALU_OUT_EX_Mem), 
                        .PC_IF(PC_IF_EX),
                        .PC_4_IF(PC_4_IF_EX),
                        .INSTRUCTION_IF(INSTRUCTION_IF_ID)
                      );
                      
 ////////////////////////////////////////ID Module//////////////////////////////////
    wire BSel,ASel,BrUn,BrLT,BrEq;
    wire [1:0] WB_Sel;
    wire [2:0] ImmSel;
    wire [3:0] AluSel;
    Controller C1( 
                    .BSel(BSel), 
                    .WBSel(WB_Sel), 
                    .RegWrite(RegWrite_Ctrl_ID), 
                    .MemRead(MemRead_Ctrl_Mem), 
                    .MemWrite(MemWrite_Ctrl_Mem), 
                    .ALUSel(AluSel), 
                    .ImmSel(ImmSel), 
                    .ASel(ASel), 
                    .PCSel(PC_Sel), 
                    .BrUn(BrUn), 
                    .Opcode(OPCODE_ID_Ctrl), 
                    .Funct7(FUNCT7_ID_EX), 
                    .Funct3(FUNCT3_ID_EX), 
                    .BrEq(BrEq), 
                    .BrLT(BrLT),
                    .LoadStore_Sel(LoadStore_Sel)
                     );
                     
    ID instruction_decode(
                            .clk(clk),
                            .INSTRUCTION_ID(INSTRUCTION_IF_ID),
                            .RegWrite(RegWrite_Ctrl_ID), 
                            .Imm_Sel(ImmSel),
                            .ALU_DATA_WB(ALU_DATA_WB_ID),
                            .IMM_ID(IMM_ID_EX),
                            .REG_DATA1_ID(REG_DATA1_ID_EX),
                            .REG_DATA2_ID(REG_DATA2_ID_EX),
                            .FUNCT3_ID(FUNCT3_ID_EX),
                            .FUNCT7_ID(FUNCT7_ID_EX),
                            .OPCODE_ID(OPCODE_ID_Ctrl)
                            );




/////////////////////////// EX Module //////////////////////////////////////////////////////
    EX ex_unit(
                        .IMM_EX(IMM_ID_EX),         
                        .REG_DATA1_EX(REG_DATA1_ID_EX),
                        .REG_DATA2_EX(REG_DATA2_ID_EX),
                        .PC_EX(PC_IF_EX),
                        .ALU_Sel(AluSel),
                        .BrUn(BrUn),
                        .ASel(ASel),
                        .BSel(BSel),
                        .BrEq(BrEq),
                        .BrLT(BrLT),
                        .ALU_OUT_EX(ALU_OUT_EX_Mem)

    );



////////////////////////// MEM Module ////////////////////////////////////////////////////////
    data_memory Mem (
                        .clk(clk),     
                        .mem_read(MemRead_Ctrl_Mem),
                        .mem_write(MemWrite_Ctrl_Mem),
                        .LoadStore_Sel(LoadStore_Sel),
                        .address(ALU_OUT_EX_Mem),
                        .write_data(REG_DATA2_ID_EX),
                        .data_out(Read_data_Mem_Mux)
    );

    
/////////////////////////// WB Module ////////////////////////////////////////////////////////
   mux_4_1 WB(
       .in1(Read_data_Mem_Mux),
       .in2(ALU_OUT_EX_Mem),
       .in3(PC_4_IF_EX),
       .in4(32'b0),
       .sel(WB_Sel),
       .out(ALU_DATA_WB_ID)
   );
   assign pc_reg = PC_IF_EX;
   /*
   initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, RISC_V);
    end */
    
endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
