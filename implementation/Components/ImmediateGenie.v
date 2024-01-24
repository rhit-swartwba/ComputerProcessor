module ImmediateGenie (
  input [15:0] In_Inst,
  output reg signed [15:0] Out_Imm,
  output reg [1:0] Out_Si
);

always @* begin

  Out_Si = In_Inst[9:8];
  case (In_Inst[3:0])
    // addi
    4'b0100: Out_Imm = {{12{In_Inst[7]}}, In_Inst[7:4]};
    // lw
    4'b0111: Out_Imm = {{12{In_Inst[7]}}, In_Inst[7:4]};
    // sw
    4'b1000: Out_Imm = {{12{In_Inst[7]}}, In_Inst[7:4]};
    // beq
    4'b1001: Out_Imm = {{8{In_Inst[11]}}, In_Inst[11:4]}; 
    // jal
    4'b1100: Out_Imm = {{8{In_Inst[11]}}, In_Inst[11:4]}; 
	 // jalr
    4'b1101: Out_Imm = {{12{In_Inst[7]}}, In_Inst[7:4]};
	 // lui
    4'b1110: Out_Imm = {In_Inst[11:4], 8'b0};
	 // lbi
    4'b1111: Out_Imm = {8'b0, In_Inst[11:4]};
	 // si
    4'b0101: Out_Imm = {12'b0, In_Inst[7:4]};
    default: Out_Imm = 16'b0000000000000000; // Default value
  endcase

end

endmodule





