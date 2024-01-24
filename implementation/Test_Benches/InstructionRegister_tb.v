`timescale 1 ns/1 ps

module InstructionRegister_tb();

//Inputs

reg[15:0] in_instruction;
wire[3:0] out_opcode, out_Reg1, out_Reg2, out_RegRd;
reg CLK, IRWrite;

parameter HALF_PERIOD = 50;
integer failures = 0;

initial begin
		CLK = 0;
		forever begin
			#(HALF_PERIOD);
			CLK = ~CLK;
		end
	end
	
	
InstructionRegister instructionRegisteruut
(
	.CLK(CLK) ,	// input  CLK_sig
	.IRWrite(IRWrite) ,	// input  IRWrite_sig
	.in_instruction(in_instruction) ,	// input [15:0] in_instruction_sig
	.out_opcode(out_opcode) ,	// output [3:0] out_opcode_sig
	.out_Reg1(out_Reg1) ,	// output [3:0] out_Reg1_sig
	.out_Reg2(out_Reg2) ,	// output [3:0] out_Reg2_sig
	.out_RegRd(out_RegRd) 	// output [3:0] out_RegRd_sig
);

initial begin

	CLK = 0;

//Test add x11, x0, x12
	in_instruction = 16'b1011000011000000;
	IRWrite = 1;
	
	 #(100*HALF_PERIOD);
	 if(out_RegRd != 11 || out_Reg1 != 0 || out_Reg2 != 12) begin	
			failures = failures + 1;
			$display("Failed input instruction \n");
	 end
	 #(100*HALF_PERIOD);
	 
//Test no writing, sub sp, sp, t0
	in_instruction = 16'b0010001010110001;
	IRWrite = 0;
	 
	 #(100*HALF_PERIOD);
	 if(out_RegRd != 11 || out_Reg1 != 0 || out_Reg2 != 12) begin	
			failures = failures + 1;
			$display("Failed IRWrite = 0 test \n");
	 end
	 #(100*HALF_PERIOD);
	 
	 
	if(failures == 0) begin
			$display("Passed all Instruction Register tests.");

	end
	else begin
			$display("Failed %d tests", failures);

	end
	$stop;
end

endmodule
