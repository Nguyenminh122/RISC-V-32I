//////////////////////////////////////////IMM_GEN_MODULE/////////////////////////////////////////////////////
module ImmGen( Inst, ImmOut, ImmSel);

    // Initialize input, output, register
    input [31:0] Inst;
    input [2:0]  ImmSel;
    output [31:0] ImmOut;
    
    reg [31:0] ImmOut_tmp;
    
    assign ImmOut = ImmOut_tmp;
    
    
    // always occur on InstCode
    always@(*) begin
        // Case statement that will generate the immidiate value based on the intruction code
        case(ImmSel)
            // I-format 
            3'b000 :  ImmOut_tmp = {Inst[31] ? {20{1'b1}} : 20'b0, Inst[31:20]};            
            // S-format 
            3'b001 :  ImmOut_tmp = {Inst[31] ? {20{1'b1}} : 20'b0, Inst[31:25], Inst[11:7]};
            // B-format
            3'b010 :  ImmOut_tmp = {Inst[31] ? {20{1'b1}} : 19'b0, Inst[31],Inst[7], Inst[30:25], Inst[11:8], 1'b0};
            // U-format:LUI
            3'b011 :  ImmOut_tmp = {12'b0, Inst[31:12]};
            // U-format:Auip
            3'b101 :  ImmOut_tmp = {Inst[31:12], 12'b0};
            // J-format
            3'b100 :  ImmOut_tmp = {Inst[31] ? {11{1'b1}} : 11'b0, Inst[31], Inst[19:12], Inst[20], Inst[30:21], 1'b0};
            default :  ImmOut_tmp = 32'b0;
        endcase
    end 
    
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
