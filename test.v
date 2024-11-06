`timescale 1ns / 1ns
module test_riscv();
    reg clk;
    reg rst;
    wire pc_reg;
    
    
    RISC_V risc_v_instance(
        .clk(clk),
        .rst(rst),
        .pc_reg(pc_reg)
    );
    
    // integer i, j;
    initial begin
            //$readmemb("F:\NCKH\NCKH_2022\Process_1\Output_Assembler\binary_out.txt", TOP_module.instruction_fetch.INSTRUCTION_MEMORY_MODULE.codeMemory);
            //$readmemh("binary_1.txt", risc_v_instance.instruction_fetch.INSTRUCTION_MEMORY_MODULE.codeMemory);
            clk = 0; rst = 1;
            #20 rst = 0;
            #10000 $finish;
    end
    always #10 clk = ~clk;    
endmodule


