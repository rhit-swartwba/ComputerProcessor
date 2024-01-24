module ALU(
    input signed [15:0] In_A,                // 16-bit Operand A
    input signed [15:0] In_B,                // 16-bit Operand B
    input [3:0] In_ALUCtrl,           // 4-bit ALU control inputs
    output reg signed [15:0] Out_ALUResult,  // 16-bit ALU result
    output reg [0:0] Out_Zero        // Zero flag output
);

always @(*) begin
    case (In_ALUCtrl)
        4'b0000: Out_ALUResult = In_A + In_B;         // ADD
        4'b0001: Out_ALUResult = In_A - In_B;         // SUB
        4'b0010: Out_ALUResult = In_A & In_B;         // AND
        4'b0011: Out_ALUResult = In_A | In_B;         // OR
        4'b0100: Out_ALUResult = In_A ^ In_B;         // XOR
        4'b0101: Out_ALUResult = In_A << In_B;        // Left Shift Logical
        4'b0110: Out_ALUResult = In_A >> In_B;        // Right Shift Logical
        4'b0111: Out_ALUResult = ~In_A;               // NOT
        4'b1000: Out_ALUResult = In_A * In_B;         // Multiply
        4'b1001: Out_ALUResult = In_A / In_B;         // Divide
        4'b1010: Out_ALUResult = In_A + 16'b0000000000000001;  // Increment
        4'b1011: Out_ALUResult = In_A - 16'b0000000000000001;  // Decrement
        4'b1100: Out_ALUResult = In_A <<< In_B;        // Left Shift Arithmetic
        4'b1101: Out_ALUResult = In_A >>> In_B;        // Right Shift Arithemtic
        4'b1110: Out_ALUResult = In_B;                  //pass through immediate value
        default: Out_ALUResult = 16'b0;                     
    endcase
    Out_Zero = (Out_ALUResult == 16'b0);
end

endmodule