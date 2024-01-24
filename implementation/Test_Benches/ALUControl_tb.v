module ALUControl_tb;

reg [1:0] In_Si;
reg [3:0] In_Inst;
wire [3:0] Out_ALUCtrl;
reg  CLK;

// Setting up CLK
parameter HALF_PERIOD = 50;

initial begin
CLK = 0;
forever begin
#(HALF_PERIOD);
CLK = ~CLK;
end
end

integer failures;

ALUControl uut (
        .In_Si(In_Si),
.In_Inst(In_Inst),
.Out_ALUCtrl(Out_ALUCtrl)
);

initial begin
failures = 0;

// Test Case 1: ADD
In_Inst = 4'b0000;
    In_Si = 2'b00;
#(2*HALF_PERIOD);
if (Out_ALUCtrl != 4'b0000) begin
        $display("Test Case 1 (ADD) Failed");
        failures = failures + 1;
    end

    // Test Case 2: SUB
    In_Inst = 4'b0001;
In_Si = 2'b00; // No shift for SUB
    #(2*HALF_PERIOD);
    if (Out_ALUCtrl != 4'b0001) begin
$display("Test Case 2 (SUB) Failed");
failures = failures + 1;
end

// Test Case 3: AND
In_Inst = 4'b0010;
    In_Si = 2'b00;
#(2*HALF_PERIOD);
if (Out_ALUCtrl != 4'b0010) begin
        $display("Test Case 3 (AND) Failed");
        failures = failures + 1;
    end

    // Test Case 4: OR
    In_Inst = 4'b0011;
In_Si = 2'b00;
    #(2*HALF_PERIOD);
    if (Out_ALUCtrl != 4'b0011) begin
$display("Test Case 4 (OR) Failed");
failures = failures + 1;
end

// Test Case 5: ADDI
In_Inst = 4'b0100;
    In_Si = 2'b00;
#(2*HALF_PERIOD);
if (Out_ALUCtrl != 4'b0000) begin
        $display("Test Case 5 (ADDI) Failed");
        failures = failures + 1;
    end

    // Test Case 6: LW
    In_Inst = 4'b0111;
In_Si = 2'b00;
    #(2*HALF_PERIOD);
    if (Out_ALUCtrl != 4'b0000) begin
$display("Test Case 6 (LW) Failed");
failures = failures + 1;
end

// Test Case 7: SW
In_Inst = 4'b1000;
    In_Si = 2'b00;
#(2*HALF_PERIOD);
if (Out_ALUCtrl != 4'b0000) begin
        $display("Test Case 7 (SW) Failed");
        failures = failures + 1;
    end

    // Test Case 8: BEQ
    In_Inst = 4'b1001;
In_Si = 2'b00;
    #(2*HALF_PERIOD);
    if (Out_ALUCtrl != 4'b0001) begin
$display("Test Case 8 (BEQ) Failed");
failures = failures + 1;
end

// Test Case 9: JAL
In_Inst = 4'b1100;
    In_Si = 2'b00;
#(2*HALF_PERIOD);
if (Out_ALUCtrl != 4'b0000) begin
        $display("Test Case 9 (JAL) Failed");
        failures = failures + 1;
    end

    // Test Case 10: LUI
    In_Inst = 4'b1110;
In_Si = 2'b00;
    #(2*HALF_PERIOD);
    if (Out_ALUCtrl != 4'b1110) begin
$display("Test Case 10 (LUI) Failed");
failures = failures + 1;
end

// Test Case 11: LBI
In_Inst = 4'b1111;
    In_Si = 2'b00;
#(2*HALF_PERIOD);
if (Out_ALUCtrl != 4'b0011) begin
        $display("Test Case 11 (LBI) Failed");
        failures = failures + 1;
    end

    // Test Case 12: SLL (Shift Left Logical)
    In_Inst = 4'b0101;
In_Si = 2'b00;
    #(2*HALF_PERIOD);
    if (Out_ALUCtrl != 4'b0101) begin
$display("Test Case 12 (SLL) Failed");
failures = failures + 1;
end

// Test Case 13: SRL (Shift Right Logical)
In_Inst = 4'b0101;
    In_Si = 2'b01;
#(2*HALF_PERIOD);
if (Out_ALUCtrl != 4'b0110) begin
        $display("Test Case 13 (SRL) Failed");
        failures = failures + 1;
    end

    // Test Case 14: SLA (Shift Left Arithmetic)
    In_Inst = 4'b0101;
In_Si = 2'b10;
    #(2*HALF_PERIOD);
    if (Out_ALUCtrl != 4'b1100) begin
$display("Test Case 14 (SLA) Failed");
failures = failures + 1;
end

// Test Case 15: SRA (Shift Right Arithmetic)
In_Inst = 4'b0101;
    In_Si = 2'b11;
#(2*HALF_PERIOD);
if (Out_ALUCtrl != 4'b1101) begin
        $display("Test Case 15 (SRA) Failed");
        failures = failures + 1;
    end

    // Print the total number of failures or success
    if (failures == 0)
        $display("All tests passed.");
    else
        $display("%d tests failed.", failures);

end

endmodule
