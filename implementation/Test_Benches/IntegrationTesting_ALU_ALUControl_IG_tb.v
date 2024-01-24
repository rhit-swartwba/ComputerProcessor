`timescale 1 ns/1 ps

module IntegrationTesting_ALU_ALUControl_IG_tb();

// Testbench inputs and outputs
reg [15:0] In_Inst;
reg signed [15:0] In_A;
reg signed [15:0] In_B;
reg CLK;
reg [1:0] ALUSrcB;
wire signed [15:0] Out_ALUResult;
wire [0:0] Out_Zero;

//setting up CLK
parameter HALF_PERIOD = 50;

initial begin
CLK = 0;
forever begin
#(HALF_PERIOD);
CLK = ~CLK;
end
end

integer failures = 0;
integer correctValue;

// Instantiate the IntegrationTesting_ALU_ALUControl_IG module
IntegrationTesting_ALU_ALUControl_IG uut (
	.In_Inst(In_Inst),
.In_A(In_A),
.In_B(In_B),
.CLK(CLK),
.ALUSrcB(ALUSrcB),
.Out_ALUResult(Out_ALUResult),
.Out_Zero(Out_Zero)
);

initial begin 

//Testing R TYPE add r3, r5, r7
	correctValue = 4;
	In_Inst = 16'b0011010101110000;
	In_A = 16'b1111_1111_1111_1100; //-4
	In_B = 16'b0000_0000_0000_1000; //8
	ALUSrcB = 2'b00;
	#(2*HALF_PERIOD);
	if(Out_ALUResult != correctValue || Out_Zero != 0) begin
	failures = failures + 1;
	$display("Failed sub \n Expected: %d \n Got: %d", correctValue, Out_ALUResult);
	end
	#(2*HALF_PERIOD);

//Testing I TYPE addi sp, sp, -6
	correctValue = 8;
	In_Inst = 16'b0010001010100100;
	In_A = 16'b0000_0000_0000_1110; //14
	In_B = 16'b0000_0000_0001_1110;
	ALUSrcB = 2'b10;
	#(2*HALF_PERIOD);
	if(Out_ALUResult != correctValue || Out_Zero != 0) begin
		failures = failures + 1;
		$display("Failed Addi \n Expected: %d \n Got: %d", correctValue, Out_ALUResult);
	end
	#(2*HALF_PERIOD);


//Testing I TYPE lw s1, 4 (sp)
	correctValue = 34;
	In_Inst = 16'b1001001001000111;
	In_A = 16'b0000_0000_0001_1110; //30
	In_B = 16'b0000_0000_0000_1110;
	ALUSrcB = 2'b10;
#(2*HALF_PERIOD); //Letting ALU calculate correct values
	if(Out_ALUResult != correctValue || Out_Zero != 0) begin
	failures = failures + 1;
	$display("Failed lw \n Expected: %d \n Got: %d", correctValue, Out_ALUResult);
	end
	#(2*HALF_PERIOD);
	 
// //Testing U Type beq a0, END1
// 	In_Inst = 16'b0011111100101001;
// 	In_A = 16'b0010_0000_0101_0100;
// 	In_B = 16'b0010_0000_0101_0100;
// 	ALUSrcB = 2'b10;
// 	#(2*HALF_PERIOD);
// 	//Need to do a PC + imm value comparison here and make usre it works
//
//
// 	#(2*HALF_PERIOD);
// 	correctValue = 0;
// 	ALUSrcB = 2'b00;
//
// if(Out_ALUResult != correctValue || Out_Zero != 1) begin
// 	failures = failures + 1;
// 	$display("Failed beq A,B part \n Expected: %d \n Got: %d", correctValue, Out_ALUResult);
// 	end
// 	#(2*HALF_PERIOD);
//
//Testing U Type lui r2, 112
	correctValue = 16'b11110010_00000000;
	In_Inst = 16'b0011111100101110;
		In_A = 16'b0000_0000_0000_0100;
		In_B = 16'b0000_0000_0000_0010;
		ALUSrcB = 2'b10;
	#(2*HALF_PERIOD);

	if(Out_ALUResult != 16'b11110010_00000000 || Out_Zero != 0) begin
		failures = failures + 1;
			$display("Failed lui part \n Expected: %d \n Got: %d", 16'b11110010_00000000, Out_ALUResult);
		end
	#(2*HALF_PERIOD);

//Testing U Type si t2, 00111111
	correctValue = -1;
	In_Inst = 16'b1101001111110101; //imm 15
	In_A = 16'b1100_0010_0001_0000;
	In_B = 16'b0010_0000_0101_0100;
	ALUSrcB = 2'b10;
	#(2*HALF_PERIOD);
	if(Out_ALUResult != correctValue || Out_Zero != 0) begin
		failures = failures + 1;
			$display("Failed si neg \n Expected: %d \n Got: %d", correctValue, Out_ALUResult);
		end
	#(2*HALF_PERIOD);

//Testing U Type si t2, 00111111
	correctValue = 0;
	In_Inst = 16'b1101001111110101; //imm 15
	In_A = 16'b0100_0010_0001_0000;
	In_B = 16'b0010_0000_0101_0100;
	ALUSrcB = 2'b10;
	#(2*HALF_PERIOD);
	if(Out_ALUResult != correctValue || Out_Zero != 1) begin
		failures = failures + 1;
			$display("Failed si pos \n Expected: %d \n Got: %d", correctValue, Out_ALUResult);
		end
	#(2*HALF_PERIOD);

//END
// 
	if(failures == 0) begin
			$display("Passed all ALU_ALU_Control_IG tests.");

	end
	else begin
			$display("Failed %d tests", failures);
	end

end

endmodule
