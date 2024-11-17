///////////////////////////////////REGISTER_FILE_MODULE///////////////////////////////////////////////////////
module registers
(
    input clk,reg_write,
    input [4:0] read_reg1,read_reg2,write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,read_data2
);
  
  reg [31:0] Registers [0:31] ;
  
  integer i;
  initial begin
      for (i = 0; i < 31; i = i + 1) begin
         Registers[i] = 32'b0;
      end
   end
    always@(posedge clk) begin
            if(reg_write)
                Registers[write_reg] <= write_data;
    end
    // Read the desire register
    assign read_data1 = Registers[read_reg1];
    assign read_data2 = Registers[read_reg2];

endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
