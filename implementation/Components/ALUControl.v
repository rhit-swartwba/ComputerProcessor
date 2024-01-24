module ALUControl (
input wire CLK,               // Clock signal
input wire [1:0] In_Si,
input wire PerformAddition,
input wire [3:0] In_Inst,
output reg [3:0] Out_ALUCtrl
);

always @(*) begin

if (PerformAddition == 1) begin
	Out_ALUCtrl = 4'b0000;
end 

else begin
case (In_Inst)
4'b0000: Out_ALUCtrl = 4'b0000;    // ADD
4'b0001: Out_ALUCtrl = 4'b0001;    // SUB
4'b0010: Out_ALUCtrl = 4'b0010;    // AND
4'b0011: Out_ALUCtrl = 4'b0011;    // OR
4'b0100: Out_ALUCtrl = 4'b0000;    // ADDI
4'b0111: Out_ALUCtrl = 4'b0000;    // LW
4'b1000: Out_ALUCtrl = 4'b0000;    // SW
4'b1001: Out_ALUCtrl = 4'b0001;    // BEQ
4'b1100: Out_ALUCtrl = 4'b0000;    // JAL
4'b1101: Out_ALUCtrl = 4'b0000;    // JALR (Not here)
4'b1110: Out_ALUCtrl = 4'b1110;    // LUI
4'b1111: Out_ALUCtrl = 4'b0011;    // LBI
4'b0101:                       // Shift
                if (In_Si == 0) begin
                    Out_ALUCtrl = 4'b0101; // Shift left logical
end
else if (In_Si == 1) begin
Out_ALUCtrl = 4'b0110; // Shift right logical
                end
                else if (In_Si == 2) begin
                    Out_ALUCtrl = 4'b1100; // Shift left arithmetic
end
else begin
Out_ALUCtrl = 4'b1101; // Shift right arithmetic
                end
            default: Out_ALUCtrl = 4'b0000;
endcase
end

end

endmodule
