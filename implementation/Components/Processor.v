

module Processor(

	input CLK , // Clock
	input RST , // Reset
	input [15:0] in_data  , // Input Data
	output [15:0] out_result // Result

);

wire [15:0] PCAddress;
wire [15:0] ALUOutput;
wire [15:0] MemoryAddress;
wire [15:0] BData;
wire [15:0] AData;
wire [15:0] MDROut;
wire [15:0] WriteDataMuxOut;
wire [3:0] Opcode;
wire [3:0] RS1;
wire [3:0] RS2;
wire [3:0] SelectRS1Wire;
reg [3:0] SelectRS2Wire;
wire [3:0] RD;
wire [15:0] RegFileOutA;
wire [15:0] RegFileOutB;
wire [15:0] ASelectionMuxOutput;
wire [15:0] ALUResult;
wire [15:0] PCValue;
wire [15:0] PCValue2;
wire [15:0] OutData;
wire [15:0] MemoryData;
wire [15:0] Instruction;
//
//
//reg [15:0] OutValue;




//Instruction
wire [15:0] MemoryOut;
wire [15:0] ImmGenieInstruction;

//Control Signals
wire IorD;
wire MemWrite;
wire IRWrite;
wire [1:0] MemtoReg;
wire RegWrite;
wire ALUSrcA;
wire [1:0] ALUSrcB;
wire Zero;
wire [1:0] PCSrc;
wire PCWriteCond;
wire PCWrite;
wire PCMuxSig = ((Zero && PCWriteCond) || PCWrite) ? 1 : 0;
wire OutputSig;
wire Shift;
wire PerformAddition;
wire ReadRd;
wire OutputBr;

//Output
//assign out_result = OutData;

//Get rid of
wire RegDst;
wire MemRead;

PCRegister PC
(
	.CLK(CLK) ,	// input  CLK_sig
	.RST(RST) ,	// input  RST_sig,
	.in_write(PCMuxSig),
	.in_data(PCValue2) ,	// input [15:0] in_data_sig
	.out_result(PCAddress) 	// output [15:0] out_result_sig
);

Mux IorDMux
(
	.in_0(PCAddress) ,	// input [15:0] in_0_sig
	.in_1(ALUOutput) ,	// input [15:0] in_1_sig
	.sel(IorD) ,	// input  sel_sig
	.out_result(MemoryAddress) 	// output [15:0] out_result_sig
);


//Might not need
Mux memData
(
	.in_0(16'b0000_0000_0000_0000) ,	// input [15:0] in_0_sig
	.in_1(BData) ,	// input [15:0] in_1_sig
	.sel(MemWrite) ,	// input  sel_sig
	.out_result(MemoryData) 	// output [15:0] out_result_sig
);

Memory_Wrapper memWrapper
(
	.data(MemoryData) ,	// input [DATA_WIDTH-1:0] data_sig
	.memAddr(MemoryAddress) ,	// input [ADDR_WIDTH-1:0] addr_sig
	.we(MemWrite) ,	// input  we_sig
	.clk(CLK) ,	// input  clk_sig
	.q(MemoryOut) 	// output [DATA_WIDTH-1:0] q_sig
);

Mux42 WriteDataMux
(
	.s(MemtoReg) ,	// input [1:0] s_sig
	.a(ALUOutput) ,	// input [15:0] a_sig
	.b(MemoryOut) ,	// input [15:0] b_sig
	.c(PCAddress) ,	// input [15:0] c_sig
	.d(in_data) ,	// input [15:0] d_sig
	.r(WriteDataMuxOut) 	// output [15:0] r_sig
);

InstructionRegister IR
(
	.CLK(CLK) ,	// input  CLK_sig
	.IRWrite(IRWrite) ,	// input  IRWrite_sig
	.Store(IorD),
	.in_instruction(MemoryOut) ,	// input [15:0] in_instruction_sig
	.out_instruction(ImmGenieInstruction),
	.previousInstruction(Instruction),
	.out_opcode(Opcode) ,	// output [3:0] out_opcode_sig **GIVEN TO CONTROL**
	.out_Reg1(RS1) ,	// output [3:0] out_Reg1_sig
	.out_Reg2(RS2) ,	// output [3:0] out_Reg2_sig
	.out_RegRd(RD) 	// output [3:0] out_RegRd_sig
);

Control control
(
	.ALUSrcA(ALUSrcA) ,	// output  ALUSrcA_sig
	.ALUSrcB(ALUSrcB) ,	// output [1:0] ALUSrcB_sig
	.MemtoReg(MemtoReg) ,	// output [1:0] MemtoReg_sig
	.RegDst(RegDst) ,	// output  RegDst_sig
	.RegWrite(RegWrite) ,	// output  RegWrite_sig
	.MemRead(MemRead) ,	// output  MemRead_sig
	.MemWrite(MemWrite) ,	// output  MemWrite_sig
	.IorD(IorD) ,	// output  IorD_sig
	.IRWrite(IRWrite) ,	// output  IRWrite_sig
	.PCWrite(PCWrite) ,	// output  PCWrite_sig
	.PCWriteCond(PCWriteCond) ,	// output  PCWriteCond_sig
	.PCSource(PCSrc) ,	// output [1:0] PCSource_sig
	.Opcode(Opcode) ,	// input [3:0] Opcode_sig
	.Clk(CLK) ,	// input  Clk_sig
	.Shift(Shift) ,	// output  Shift_sig
	.OutputSig(OutputSig) ,	// output  OutputSig_sig
	.PerformAddition(PerformAddition) ,	// output  PerformAddition_sig
	.ReadRd(ReadRd) ,
	.OutputBr(OutputBr) ,
	.RST(RST) 	// input  Reset_sig
);

FourBitMux RS1Value
(
	.in_0(RS1) ,	// input [15:0] in_0_sig
	.in_1(RD) ,	// input [15:0] in_1_sig
	.sel(Shift) ,	// input  sel_sig
	.out_result(SelectRS1Wire) 	// output [15:0] out_result_sig
);

//always @* begin
//	if (Shift == 0) begin
//		SelectRS1Wire = RS1; // When sel is 0, output y is connected to data0
//	end
//else begin
//		SelectRS1Wire = RD; // When sel is 1, output y is connected to data1
//	end
//end

always @* begin
	if (ReadRd == 0) begin
		SelectRS2Wire = RS2; // When sel is 0, output y is connected to data0
	end
else begin
		SelectRS2Wire = RD; // When sel is 1, output y is connected to data1
	end
end

RegisterFile RegFile
(
	.CLK(~CLK) ,	// input  CLK_sig
	.RST(RST) ,	// input  RST_sig
	.in_RegWrite(RegWrite) ,	// input  in_RegWrite_sig
	.in_BrSig(OutputBr) ,
	.in_ReadReg1(SelectRS1Wire) ,	// input [3:0] in_ReadReg1_sig
	.in_ReadReg2(SelectRS2Wire) ,	// input [3:0] in_ReadReg2_sig
	.in_WriteAddr(RD) ,	// input [3:0] in_WriteAddr_sig
	.in_Data(WriteDataMuxOut) ,	// input [15:0] in_Data_sig
	.out_ReadData1(RegFileOutA) ,	// output [15:0] out_ReadData1_sig
	.out_ReadData2(RegFileOutB) 	// output [15:0] out_ReadData2_sig
);

Register A
(
	.CLK(CLK) ,	// input  CLK_sig
	.RST(RST) ,	// input  RST_sig
	.in_data(RegFileOutA) ,	// input [15:0] in_data_sig
	.out_result(AData) 	// output [15:0] out_result_sig
);

Register B
(
	.CLK(CLK) ,	// input  CLK_sig
	.RST(RST) ,	// input  RST_sig
	.in_data(RegFileOutB) ,	// input [15:0] in_data_sig
	.out_result(BData) 	// output [15:0] out_result_sig
);

Mux ADataMux
(
	.in_0(PCAddress) ,	// input [15:0] in_0_sig
	.in_1(AData) ,	// input [15:0] in_1_sig
	.sel(ALUSrcA) ,	// input  sel_sig
	.out_result(ASelectionMuxOutput) 	// output [15:0] out_result_sig
);

IntegrationTesting_ALU_ALUControl_IG ALUOperations
(
	.In_Inst(ImmGenieInstruction) ,	// input [15:0] In_Inst_sig
	.In_A(ASelectionMuxOutput) ,	// input [15:0] In_A_sig
	.In_B(BData) ,	// input [15:0] In_B_sig
	.PerformAddition(PerformAddition),
	.CLK(~CLK) ,	// input  CLK_sig
	.ALUSrcB(ALUSrcB) ,	// input [1:0] ALUSrcB_sig
	.Out_ALUResult(ALUResult) ,	// output [15:0] Out_ALUResult_sig
	.Out_Zero(Zero) 	// output [0:0] Out_Zero_sig
);

Register ALUOut
(
	.CLK(CLK) ,	// input  CLK_sig
	.RST(RST) ,	// input  RST_sig
	.in_data(ALUResult) ,	// input [15:0] in_data_sig
	.out_result(ALUOutput) 	// output [15:0] out_result_sig
);

Mux42 PCValueMux
(
	.s(PCSrc) ,	// input [1:0] s_sig
	.a(ALUResult) ,	// input [15:0] a_sig
	.b(ALUOutput) ,	// input [15:0] b_sig
	.c(AData) ,	// input [15:0] c_sig
	.d(16'b0000_0000_0000_0000) ,	// input [15:0] d_sig
	.r(PCValue2) 	// output [15:0] r_sig
);


//Output

PCRegister OutValue
(
	.CLK(CLK) ,	// input  CLK_sig
	.RST(RST) ,	// input  RST_sig
	.in_write(OutputSig) , 
	.in_data(RegFileOutA) ,	// input [15:0] in_data_sig
	.out_result(OutData) 	// output [15:0] out_result_sig
);

assign out_result = OutData;
//wire PCMuxSig = ((Zero && PCWriteCond) || PCWrite) ? 1 : 0;
//assign out_result = (OutputSig) ? RegFileOutA : OutData;



//always @(*)begin

//out_result = (OutputSig) ? RegFileOutA : OutData;

//end
endmodule
 