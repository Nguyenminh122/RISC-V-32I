`timescale 1ns / 1ps


module data_memory
(
    input clk,       
    input mem_read,
    input mem_write,
    input [2:0] LoadStore_Sel,
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] data_out
);
    reg [31:0] memory [0:65536];

    integer i;
    initial begin
        for (i = 0; i < 65536; i = i + 1) begin
            memory[i] = 32'b0;
        end
    end

    always@(posedge clk)begin
        if (mem_write)
        begin
            case(LoadStore_Sel)
                3'b000: begin // Store Byte
                    memory[address][7:0] <= write_data[7:0];
                end
                3'b001: begin // Store half
                    memory[address][15:0] <= write_data[15:0];
                end
                3'b010: begin // Store word
                    memory[address][31:0] <= write_data[31:0];
                end
                default:;
            endcase
        end
    end
    
    always @ (negedge clk) begin
        if (mem_read)
        begin
            case(LoadStore_Sel)
                3'b000: begin // Load Byte
                    data_out <= { {24{memory[address][7]}}, memory[address][7:0] };
                end
                3'b001: begin // Load half
                    data_out <= { {16{memory[address][15]}}, memory[address][15:0] };
                end
                3'b010: begin // Load word
                    data_out <= memory[address][31:0];
                end
                3'b011: begin // Load byte unsign
                    data_out <= {{24'b0},{memory[address][7:0]}};
                end
                3'b100: begin // Load haft unsign
                    data_out <= {{16'b0},{memory[address][15:0]}};
                end
                default:;
            endcase
        
        end
    end
endmodule
