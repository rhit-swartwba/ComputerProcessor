module IntegrationTesting_ALU_ALUControl_IG (
input [15:0] In_Inst,
input signed [15:0] In_A,
input signed [15:0] In_B,
input CLK,
    input PerformAddition,
input [1:0] ALUSrcB,
output wire signed [15:0] Out_ALUResult,
output wire [0:0] Out_Zero
);

// ALU CONTROL INS AND OUTS
wire [3:0] Out_ALUCtrl;

// IMM GENIE INS AND OUTS
wire signed [15:0] Out_Imm;
wire [1:0] Out_Si;

// Output from Mux to give input to ALU
wire signed [15:0] Out_Mux_ValB;

// Instantiate ImmediateGenie module
ImmediateGenie UUT_ImmGenie (
    .In_Inst(In_Inst),
.Out_Imm(Out_Imm),
.Out_Si(Out_Si)
);

// Instantiate ALUControl module
ALUControl UUT_ALUControl (
    .CLK(CLK),
.In_Si(Out_Si),
.PerformAddition(PerformAddition),    
.In_Inst(In_Inst[3:0]),
.Out_ALUCtrl(Out_ALUCtrl)
);

// Instantiate Mux module
Mux42 UUT_Mux (
.a(In_B),
.b(16'b0000_0000_0000_0010),
.c(Out_Imm),
.d(16'b0000_0000_0000_0000), //this should never be chosen
.s(ALUSrcB),
.r(Out_Mux_ValB)
);

// Instantiate ALU module
ALU UUT_ALU (
    .In_A(In_A),
.In_B(Out_Mux_ValB),
.In_ALUCtrl(Out_ALUCtrl),
.Out_ALUResult(Out_ALUResult),
.Out_Zero(Out_Zero)
);

endmodule





