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
            clk = 0; rst = 1;
            #20 rst = 0;
            #10000 $finish;
    end
    always #10 clk = ~clk;    
endmodule


