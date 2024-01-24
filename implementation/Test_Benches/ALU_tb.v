module ALU_tb;

reg signed [15:0] In_A, In_B;
reg [3:0] In_ALUCtrl;
wire signed [15:0] Out_ALUResult;
wire Out_Zero;

integer failures;
integer expected_result;

ALU uut (
    .In_A(In_A),
.In_B(In_B),
.In_ALUCtrl(In_ALUCtrl),
.Out_ALUResult(Out_ALUResult),
.Out_Zero(Out_Zero)
);

initial begin
failures = 0; // Initialize the failure counter

// Test ADD operation
In_A = 16'b0110;
    In_B = 16'b1111_1111_1111_1000; // -8 in two's complement
In_ALUCtrl = 4'b0000;
    expected_result = -2; // 6 + (-8) = -2
    #10;
    if (Out_ALUResult !== expected_result) begin
        $display("Test ADD failed: Expected %d, Got %d", expected_result, Out_ALUResult);
        failures = failures + 1;
    end

    // Test SUB operation 
    In_A = 16'b0011_0000_0000_0000; // 12288
In_B = 16'b0000_0000_0000_1000; // 8
    In_ALUCtrl = 4'b0001;
expected_result = 12280; // 12288 - 8 = 12280
#10;
if (Out_ALUResult !== expected_result) begin
$display("Test SUB failed: Expected %d, Got %d", expected_result, Out_ALUResult);
failures = failures + 1;
end

// Test AND operation
In_A = 16'b1111_1111_1111_1111; // -1 
    In_B = 16'b1111_1111_1111_1000; // -8 
In_ALUCtrl = 4'b0010;
    expected_result = -8; // (-1) & (-8) = -8
    #10;
    if (Out_ALUResult !== expected_result) begin
        $display("Test AND failed: Expected %d, Got %d", expected_result, Out_ALUResult);
        failures = failures + 1;
    end

    // Test OR operation 
    In_A = 16'b0000_0000_0000_0110; // 6
In_B = 16'b1111_1111_1111_1000; // -8 
    In_ALUCtrl = 4'b0011;
expected_result = -2; // 6 | (-8) = -2
#10;
if (Out_ALUResult !== expected_result) begin
$display("Test OR failed: Expected %d, Got %d", expected_result, Out_ALUResult);
failures = failures + 1;
end

// Test XOR operation
In_A = 16'b0000_0000_0000_0010; // 8,074
    In_B = 16'b0000_0000_0000_0100; // 12,200
In_ALUCtrl = 4'b0100;
    expected_result = 6; 
    #10;
    if (Out_ALUResult !== expected_result) begin
        $display("Test XOR failed: Expected %d, Got %d", expected_result, Out_ALUResult);
        failures = failures + 1;
    end

    // Test Left Shift Logical operation 
    In_A = 16'b0000_0000_0000_0011; // 3
In_B = 16'b0000_0000_0000_0010; // 2
    In_ALUCtrl = 4'b0101;
expected_result = 12; // 3 << 2 = 12
#10;
if (Out_ALUResult !== expected_result) begin
$display("Test Left Shift failed: Expected %d, Got %d", expected_result, Out_ALUResult);
failures = failures + 1;
end

// Test Right Shift Logical operation
In_A = 16'b0000_0000_0011_0000; // 48
    In_B = 16'b0000_0000_0000_0010; // 2
In_ALUCtrl = 4'b0110;
    expected_result = 12; // 48 >> 2 = 12
    #10;
    if (Out_ALUResult !== expected_result) begin
        $display("Test Right Shift failed: Expected %d, Got %d", expected_result, Out_ALUResult);
        failures = failures + 1;
    end

    // Test NOT operation 
    In_A = 16'b1111_1111_1111_1000; // -8 
In_B = 16'b0000_0000_0000_0000; // 0
    In_ALUCtrl = 4'b0111;
expected_result = 7; // ~(-8) = 7
#10;
if (Out_ALUResult !== expected_result) begin
$display("Test NOT failed: Expected %d, Got %d", expected_result, Out_ALUResult);
failures = failures + 1;
end

// Test Multiply operation with mixed inputs
In_A = 16'b0000_0000_0000_1010; // 10
    In_B = 16'b1111_1111_1111_1000; // -8 in two's complement
In_ALUCtrl = 4'b1000;
    expected_result = -80; // 
    #10;
    if (Out_ALUResult !== expected_result) begin
        $display("Test Multiply failed: Expected %d, Got %d", expected_result, Out_ALUResult);
        failures = failures + 1;
    end

 // Test Divide operation
    In_A = 16'b0000_0000_0000_1010; // 10
In_B = 16'b0000_0000_0000_0010; // 2
    In_ALUCtrl = 4'b1001;
expected_result = 5; //
#10;
if (Out_ALUResult !== expected_result) begin
$display("Test Divide failed: Expected %d, Got %d", expected_result, Out_ALUResult);
failures = failures + 1;
end

// Test Increment operation
In_A = 16'b1111_1111_1111_1000; // -8 
    In_B = 16'b0000_0000_0000_0000; // 0
In_ALUCtrl = 4'b1010;
    expected_result = -7; // (-8) + 1 = -7
    #10;
    if (Out_ALUResult !== expected_result) begin
        $display("Test Increment failed: Expected %d, Got %d", expected_result, Out_ALUResult);
        failures = failures + 1;
    end

    // Test Decrement operation
    In_A = 16'b0000_0000_0000_0010; // 2
In_B = 16'b0000_0000_0000_0010; // 2
    In_ALUCtrl = 4'b1011;
expected_result = 1; // 2 - 1 = 1
#10;
if (Out_ALUResult !== expected_result) begin
$display("Test Decrement failed: Expected %d, Got %d", expected_result, Out_ALUResult);
failures = failures + 1;
end

// Test Left Shift Arithmetic operation
In_A = 16'b0000_0000_0000_0010; // 2
In_B = 16'b0000_0000_0000_0010; // 2
In_ALUCtrl = 4'b1100;
expected_result = 8;
#10;
if (Out_ALUResult !== expected_result) begin
$display("Test Left Shift Arithmetic failed: Expected %d, Got %d", expected_result, Out_ALUResult);
failures = failures + 1;
end

// Test Right Shift Arithmetic operation
In_A = 16'b1111_1111_1110_0000;
In_B = 16'b0000_0000_0000_0011; 
In_ALUCtrl = 4'b1101;
expected_result = -4;
#10;
if (Out_ALUResult !== expected_result) begin
$display("Test Right Shift Arithmetic failed: Expected %d, Got %d", expected_result, Out_ALUResult);
failures = failures + 1;
end

// Test pass through immediate operation
In_A = 16'b1111_1111_1110_0000; 
In_B = 16'b0000_0000_0000_0111;
In_ALUCtrl = 4'b1110;
expected_result = 7;
#10;
if (Out_ALUResult !== expected_result) begin
$display("Test Pass immediate through failed: Expected %d, Got %d", expected_result, Out_ALUResult);
failures = failures + 1;
end

// Display the total number of failures
if (failures !== 0) begin
$display("Total Failures: %d", failures);
end else begin
$display("All tests passed!");
end

end

endmodule