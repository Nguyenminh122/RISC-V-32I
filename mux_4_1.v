`timescale 1ns / 1ps

module mux_4_1
(
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [1:0] sel,
    output reg [31:0] out
);
    always@(in1, in2, in3, in4, sel)
    begin
        case(sel)
            2'b00: out = in1;
            2'b01: out = in2;
            2'b10: out = in3;
            2'b11: out = in4;
        endcase
    end
endmodule
