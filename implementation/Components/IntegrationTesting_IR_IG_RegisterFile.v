module IntegrationTesting_IR_IG_RegisterFile (
input [15:0] in_Inst,
input [15:0] in_Data,
input CLK, in_RegWrite, in_IRWrite,
output [15:0] out_Imm,
output [3:0] out_opcode,
output [15:0] out_RegData1, out_RegData2
);


//IR I/O
wire [3:0] out_Reg1;
wire [3:0] out_Reg2;
wire [3:0] out_RegRd;

wire [1:0] out_Si;


//Instantiate InstructionRegister module
InstructionRegister UUT_InstRegister
(
	.CLK(CLK) ,	// input  CLK_sig
	.IRWrite(in_IRWrite) ,	// input  IRWrite_sig
	.in_instruction(in_Inst) ,	// input [15:0] in_instruction_sig
	.out_opcode(out_opcode) ,	// output [3:0] out_opcode_sig
	.out_Reg1(out_Reg1) ,	// output [3:0] out_Reg1_sig
	.out_Reg2(out_Reg2) ,	// output [3:0] out_Reg2_sig
	.out_RegRd(out_RegRd) 	// output [3:0] out_RegRd_sig
);

ImmediateGenie ImmediateGenie_inst
(
	.In_Inst(in_Inst) ,	// input [15:0] In_Inst_sig
	.Out_Imm(out_Imm) ,	// output [15:0] Out_Imm_sig
	.Out_Si(out_Si) 	// output [1:0] Out_Si_sig
);

// Instantiate RegisterFile module
RegisterFile UUT_RegFile
(
	.CLK(CLK) ,	// input  CLK_sig
	.RST(0) ,	// input  RST_sig
	.in_RegWrite(in_RegWrite) ,	// input  in_RegWrite_sig
	.in_ReadReg1(out_Reg1) ,	// input [3:0] in_ReadReg1_sig
	.in_ReadReg2(out_Reg2) ,	// input [3:0] in_ReadReg2_sig
	.in_WriteAddr(out_RegRd) ,	// input [3:0] in_WriteAddr_sig
	.in_Data(in_Data) ,	// input [15:0] in_Data_sig
	.out_ReadData1(out_RegData1) ,	// output [15:0] out_ReadData1_sig
	.out_ReadData2(out_RegData2) 	// output [15:0] out_ReadData2_sig
);



endmodule





