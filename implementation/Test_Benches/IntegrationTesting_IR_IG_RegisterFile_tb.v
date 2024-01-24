`timescale 1 ns/1 ps

module IntegrationTesting_IR_IG_RegisterFile_tb();

// Testbench inputs and outputs
reg [15:0] in_Inst;
reg [15:0] in_Data;
reg CLK, in_RegWrite, in_IRWrite;
wire [15:0] Out_Imm;
wire [15:0] out_RegData1, out_RegData2;

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

// Instantiate the IntegrationTesting_IR_IG_RegisterFile module
IntegrationTesting_IR_IG_RegisterFile IntegrationTesting_IR_IG_RegisterFile_inst
(
	.in_Inst(in_Inst) ,	// input [15:0] in_Inst_sig
	.in_Data(in_Data) ,	// input [15:0] in_Data_sig
	.CLK(CLK) ,	// input  CLK_sig
	.in_RegWrite(in_RegWrite) ,	// input  in_RegWrite_sig
	.in_IRWrite(in_IRWrite) ,	// input  in_IRWrite_sig
	.Out_Imm(Out_Imm) ,	// output [15:0] Out_Imm_sig
	.out_RegData1(out_RegData1) ,	// output [15:0] out_RegData1_sig
	.out_RegData2(out_RegData2) 	// output [15:0] out_RegData2_sig
);

initial begin 

//Testing write instruction and read reg (add r3, r3, r7)
	in_Inst = 16'b0011001101110000;
	in_Data = 16'b0000000000000001;
	in_RegWrite = 1;
	in_IRWrite = 1;

	#(2*HALF_PERIOD);
	
	in_RegWrite = 0;
	
	#(2*HALF_PERIOD);
	
	if(out_RegData1 != in_Data) begin
	failures = failures + 1;
	$display("Failed decode instruction and check data \n Expected: %d \n Got: %d", in_Data, out_RegData1);
	end
	#(2*HALF_PERIOD);



//END
// 
	if(failures == 0) begin
			$display("Passed all IR_IG_RegisterFie tests.");

	end
	else begin
			$display("Failed %d tests", failures);
	end

end

endmodule
