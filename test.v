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
    
    initial begin
    $readmemh("/home/minh/Documents/RISCV-32I_Sinngcycle/RISC-V-32I/data_mem.mem", instruction_memory.codeMemory);
                clk = 0; rst = 1;
            #20 rst = 0;
            #1000 $finish;
    end
    always #5 clk = ~clk;    
endmodule
