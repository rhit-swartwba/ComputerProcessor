/*
Design: Instruction Register
File Name: InstructionRegister.v
Function: Stores values based on clock edge
Author: Spencer Halsey
*/

module InstructionRegister(

	input CLK , // Clock
	input IRWrite, //Write Instruction
	input Store,
	input[15:0] in_instruction  , // Input Instruction
	output reg [15:0] out_instruction,
	output reg [15:0] previousInstruction,
	output reg [3:0] out_opcode , // OPcode
	output reg [3:0] out_Reg1, out_Reg2, out_RegRd
);

reg[15:0] temp;

always @(posedge CLK) begin

if (IRWrite == 1) begin
        temp <= in_instruction;
		  out_opcode <= in_instruction[3:0];
		  out_RegRd <= in_instruction[15:12];
		  
		  if(in_instruction[3:0] == 4'b1001)begin
		  out_Reg1 <= in_instruction[15:12];
		  out_Reg2 <= 4'b1110;
		  end
		  else begin
		  out_Reg1 <= in_instruction[11:8];
		  out_Reg2 <= in_instruction[7:4];
		  end
		  
		  out_instruction <= in_instruction;
    end
	 else begin
	 out_opcode <= temp[3:0];
	 out_RegRd <= temp[15:12];
	 out_Reg1 <= temp[11:8];
	 out_Reg2 <= temp[7:4];
	 out_instruction <= temp;
	 end
	 
	 
end
endmodule
 