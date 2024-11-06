module ALU( ALU_Out, A_in, B_in,zero_flag, ALUSel );
	
	input  [31:0] A_in;
	input  [31:0] B_in; 
	input  [3:0] ALUSel; 
	output zero_flag;
	output [31:0] ALU_Out; 
		   
	reg [31:0] ALU_Result; 


	
	assign ALU_Out = ALU_Result;
	
	always @(ALUSel , A_in , B_in) begin 
		
		case(ALUSel)
			4'b0000: //and
				ALU_Result = A_in & B_in;
			
			4'b0001: //or
				ALU_Result = A_in | B_in;
			
			4'b0010: begin 
				ALU_Result = A_in + B_in;
			end 
			
			4'b0011: begin //Signed Subtraction with Overflow checking
				ALU_Result = $signed(A_in) - $signed(B_in); 
			end
			
			4'b0100: //Signed less than or equal comparison
				ALU_Result = ($signed(A_in) < $signed(B_in))?32'd1:32'd0;
			
			4'b0101: //nor
				ALU_Result = ~(A_in | B_in);
			
			4'b0110: //Comparison
				ALU_Result = ( A_in == B_in )?32'd1:32'd0;
			4'b0111: //Shift left
			    ALU_Result = A_in << B_in;
			4'b1000: //Shift Right logic
			    ALU_Result = A_in >> B_in;
			4'b1001: //Shift Right Arithmetic
			    ALU_Result = A_in >>> B_in;
			4'b1010: //Xor
			    ALU_Result = A_in ^ B_in;
			4'b1011: //Lui: rd = imm << 12;
			    ALU_Result = B_in << 12;
			default: ALU_Result = A_in + B_in;
		endcase
	end
	assign zero_flag = (ALU_Result == 32'b0) ? 1 : 0;
endmodule	
			
