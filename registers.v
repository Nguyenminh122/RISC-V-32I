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
  
  
//  always@(posedge clk) begin
//    if(reg_write)  // reg 0 luon = 0
//      Registers[write_reg] <= write_data;
//  end
  
  
//  assign read_data1 = (read_reg1 != 5'b0) ? //ko xai reg x0 = 0,
//                      (((reg_write == 1'b1)&&(read_reg1 == write_reg)) ? // neu doc va ghi cung 1 reg thi g/tri doc = g/tri ghi
//                      write_data : Registers[read_reg1]) : 32'b0;
                      
//  assign read_data2 = (read_reg2 != 5'b0) ? //ko xai reg x0 = 0
//                      (((reg_write == 1'b1)&&(read_reg2 == write_reg)) ? 
//                      write_data : Registers[read_reg2]) : 32'b0;

    always@(posedge clk) begin
            if(reg_write)
                Registers[write_reg] <= write_data;
    end
    // Read the desire register
    assign read_data1 = Registers[read_reg1];
    assign read_data2 = Registers[read_reg2];

endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
