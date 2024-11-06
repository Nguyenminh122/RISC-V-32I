module Controller( BSel, WBSel, RegWrite, MemRead, MemWrite, 
                   ALUSel, ImmSel, ASel, PCSel, BrUn, Opcode, Funct7, Funct3, BrEq, BrLT,LoadStore_Sel );

    // define the input and output signals
    input [6:0] Opcode;
    input [6:0] Funct7;
    input [2:0] Funct3;
    input       BrEq, BrLT;
    output      BSel, RegWrite, MemRead, 
                MemWrite, ASel, PCSel, BrUn;
    output [1:0] WBSel;
    output [3:0] ALUSel;
    output [2:0] ImmSel,LoadStore_Sel;
    
    // define registers
    /*ALUSel 
        and:    0000
        or:     0001
        A+B:    0010
        A-B:    0011
        A<B:    0100
        AnorB:  1000
        A=B:    1001
        A<<B:   0111
        A>>B:   1000
        A>>>B:  1001
        AxorB:  1010
    */
    reg BSel, RegWrite, MemRead, 
              MemWrite, ASel, PCSel, BrUn;
    reg [1:0] WBSel;
    reg [3:0] ALUSel;
    reg [2:0] ImmSel;
    reg [2:0] LoadStore_Sel; // signal for slect mode for haft/byte/word value
    // Define the Controller modules behavior
    always@(*)
        case(Opcode)         // Setting all signals based on the OPcode
            7'b0000011 : begin                  // Opcode for Load Word
                             PCSel = 1'b0;
                             ImmSel = 3'b000;
                             RegWrite = 1'b1;
                             BrUn = 1'b0;
                             BSel = 1'b1;
                             ASel = 1'b0;
                             ALUSel = 4'b0010;
                             MemWrite = 1'b0;
                             MemRead = 1'b1; 
                             WBSel = 2'b00;
                             case(Funct3) 
                                3'b000: LoadStore_Sel = 3'b000; //Load Byte
                                3'b001: LoadStore_Sel = 3'b001; //Load Haft
                                3'b010: LoadStore_Sel = 3'b010; //Load Word
                                3'b011: LoadStore_Sel = 3'b011; //Load byte Unsign
                                3'b100: LoadStore_Sel = 3'b100; //Load Haft Unsign
                                default:  LoadStore_Sel = 3'b010;
                              endcase                                                       
                         end
            7'b0100011 : begin                  // Opcode for Store Word
                             PCSel = 1'b0;
                             ImmSel = 3'b001;
                             RegWrite = 1'b0;
                             BrUn = 1'b0;
                             BSel = 1'b1;
                             ASel = 1'b0;
                             ALUSel = 4'b0010;
                             MemWrite = 1'b1;
                             MemRead = 1'b0;
                             WBSel = 2'b00;     
                             case(Funct3) 
                                3'b000: LoadStore_Sel = 3'b000; //Store Byte
                                3'b001: LoadStore_Sel = 3'b001; //Store Haft
                                3'b010: LoadStore_Sel = 3'b010; //Store Word
                                default:  LoadStore_Sel = 3'b010;
                              endcase                                                    
                         end 
            7'b0010011 : begin                  // Opcode for I-type Operation
                             PCSel = 1'b0;
                             ImmSel = 3'b000;
                             RegWrite = 1'b1;
                             BrUn = 1'b0;
                             BSel = 1'b1;
                             ASel = 1'b0;
                             MemWrite = 1'b0;
                             MemRead = 1'b0;
                             WBSel = 2'b01;
                             //ALUSel
                             case(Funct3) 
                                3'b000: ALUSel = 4'b0010; //addi
                                3'b001: ALUSel = 4'b0111; //slli
                                3'b010: ALUSel = 4'b0100; //slti
                                3'b011: ALUSel = 4'b0111; //sltiu
                                3'b100: ALUSel = 4'b1010; //xori
                                3'b101: begin      //srli & srai
                                    if (Funct7 == 7'b0000000)
                                        ALUSel = 4'b1000;    //srli
                                    else
                                        ALUSel = 4'b1001;    //srai
                                end
                                3'b110: ALUSel = 4'b0001;     //ori 
                                3'b111: ALUSel = 4'b0000;     //andi
                              endcase
                         end
            7'b0110011 :begin                   // Opcode for R-type Operation
                             PCSel = 1'b0;
                             ImmSel = 3'b000;
                             RegWrite = 1'b1;
                             BrUn = 1'b0;
                             BSel = 1'b0;
                             ASel = 1'b0;
                             MemWrite = 1'b0;
                             MemRead = 1'b0;
                             WBSel = 2'b01;
                             //ALUSel
                             case(Funct3) 
                                3'b000: begin                   //add & sub
                                    if(Funct7 == 7'b0000000)
                                        ALUSel = 4'b0010;
                                    else
                                        ALUSel = 4'b0011;
                                end
                                3'b001: ALUSel = 4'b0111;       //sll
                                3'b010: ALUSel = 4'b0100;       //slt
                                3'b011: ALUSel = 4'b0100;       //sltu
                                3'b100: ALUSel = 4'b1010;       //xor
                                3'b101: begin                   //srl & sra
                                    if (Funct7 == 7'b0000000)
                                        ALUSel = 4'b1000;       //srl
                                    else
                                        ALUSel = 4'b1001;       //sra
                                end
                                3'b110: ALUSel = 4'b0001;       //or 
                                3'b111: ALUSel = 4'b0000;       //and
                              endcase
                         end
            7'b1100011 :begin                   // Opcode for B-type Operation
                             //PCSel
                             if(BrEq == 1'b1 | BrLT == 1'b1 | (BrEq == 1'b0 & BrLT == 1'b0))
                                PCSel = 1;
                             else
                                PCSel = 0; 
                             
                             ImmSel = 3'b010;
                             RegWrite = 1'b0;
                             
                             //BrUn 
                             if (Funct3 == 3'b110 | Funct3 == 3'b111)
                                BrUn = 1'b1;
                             else
                                BrUn = 1'b0;
                             
                             BSel = 1'b1;
                             ASel = 1'b1;
                             ALUSel = 4'b0010;
                             MemWrite = 1'b0;
                             MemRead = 1'b1;
                             WBSel = 2'b10;                             
                         end
            7'b1101111 :begin                   // Opcode for J-type Operation
                             PCSel = 1'b1;
                             ImmSel = 3'b100;
                             RegWrite = 1'b1;
                             BrUn = 1'b0;
                             BSel = 1'b1;
                             ASel = 1'b1;
                             ALUSel = 4'b0010;
                             MemWrite = 1'b0;
                             MemRead = 1'b0;
                             WBSel = 2'b10;                             
                        end
            7'b1100111 :begin                   // Opcode for Jalr Operation
                             PCSel = 1'b1;
                             ImmSel = 3'b000;
                             RegWrite = 1'b1;
                             BrUn = 1'b0;
                             BSel = 1'b1;
                             ASel = 1'b0;
                             ALUSel = 4'b0010;
                             MemWrite = 1'b0;
                             MemRead = 1'b1;
                             WBSel = 2'b10;                             
                        end
            7'b0110111  :begin                  // Opcode for lui Operation
                             PCSel = 1'b0;
                             ImmSel = 3'b011;
                             RegWrite = 1'b1;
                             BrUn = 1'b0;
                             BSel = 1'b1;
                             ASel = 1'b1;
                             ALUSel = 4'b1011;
                             MemWrite = 1'b0;
                             MemRead = 1'b0;
                             WBSel = 1'b01;
                        end
            7'b0010111  :begin                  // Opcode for auipc Operation
                             PCSel = 1'b0;
                             ImmSel = 3'b101;
                             RegWrite = 1'b1;
                             BrUn = 1'b0;
                             BSel = 1'b1;
                             ASel = 1'b1;
                             ALUSel = 4'b0010;
                             MemWrite = 1'b0;
                             MemRead = 1'b0;
                             WBSel = 1'b01;
                        end
            default    :begin                   // Set all signals to 0
                             WBSel = 1'b0;
                             MemWrite = 1'b0;
                             MemRead = 1'b0;
                             BSel = 1'b0;
                             RegWrite = 1'b0;
                             ALUSel = 4'b0010;
                             ImmSel = 3'b000;
                             ASel = 1'b0;
                             BrUn = 1'b0;
                             PCSel = 1'b0;
                         end     
        endcase
    
endmodule
