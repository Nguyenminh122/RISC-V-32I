`timescale 1ns / 1ps

module BranchComp(BrEq, BrLT, A_in, B_in, BrUn);
    
    input   [31:0]  A_in;
    input   [31:0]  B_in;
    input           BrUn;
    output          BrEq;
    output          BrLT;
    
    reg             BrEq;
    reg             BrLT;
    
    // BrUn = 1 selects unsigned comparison for BrLT, 0 = signed
    // BrEq = 1, if A = B
    // BrLT = 1, if A < B
    // BGE branch: A >= B if !(A<B)
    
    always@ (*) begin
        if (BrUn) begin
            if (A_in == B_in)
                BrEq = 1'b1;
            else if (A_in < B_in)
                BrLT = 1'b1;
                else begin
                    BrEq = 1'b0;
                    BrLT = 1'b0;
                end
        end
        else begin
            if ($signed(A_in) == $signed(B_in))
                BrEq = 1'b1;
            else
                if ($signed(A_in) < $signed(B_in))
                    BrLT = 1'b1;
                else begin
                    BrEq = 1'b0;
                    BrLT = 1'b0;
                end
        end
    end
    
endmodule
