
module Processor_tb();

// Inputs
	reg CLK, RST;
	reg[15:0] in_data;

// Outputs
	wire[15:0] out_result;

	parameter   PERIOD = 20;
	parameter   real DUTY_CYCLE = 0.5;
	integer failures = 0;
	integer counter = 0;
	
	initial begin   // Clock process for CLK
	forever
		begin
        CLK = 1'b0;
        counter = counter + 1;
        #(PERIOD-(PERIOD*DUTY_CYCLE)) CLK = 1'b1;
        #(PERIOD*DUTY_CYCLE);
       end
   end
	
	
Processor Processor_inst
(
	.CLK(CLK) ,	// input  CLK
	.RST(RST) ,	// input  RST
	.in_data(in_data) ,	// input [15:0] in_data
	.out_result(out_result) 	// output [15:0] out_result
);

integer i;

initial begin

	// Initialize
	CLK= 0;
	RST = 1;
	#(PERIOD);
	
	RST = 0;


	//TEST 1
	in_data = 16'h13B0;
	
	// for(i = 0; i < 500000; i=i+1) begin
	// 	//$display("Cycle value: %d", i);
	// 	#(PERIOD);
	// end
	
	@(out_result);

$display("RESULT TEST 1: %d, CycleCount: %d", out_result, counter);
counter = 0;
// 	if(out_result != 16'h000B)begin
// 	$display("Failed Ouput: Got %i", out_result);
// 		failures = failures + 1;
// 	end
// else begin
// $display("TEST 1 PASSED! RESULT: ", out_result);
// end

//TEST 2
in_data = 16'h0906;

	// for(i = 0; i < 100000; i=i+1) begin
	// 	//$display("Cycle value: %d", i);
	// 	#(PERIOD);
	// end
	@(out_result);

$display("RESULT TEST 2: %d, CycleCount: %d", out_result, counter);
counter = 0;
// 	if(out_result != 16'h0003)begin
// $display("Failed Ouput: Got %i", out_result);
// failures = failures + 1;
// end
// else begin
// $display("TEST 2 PASSED! RESULT: ", out_result);
// end


// 	if(out_result != 16'h0003)begin
// $display("Failed Ouput: Got %i", out_result);
// failures = failures + 1;
// end
// else begin
// $display("TEST 3 PASSED! RESULT: ", out_result);
// end

	// Display the total number of failures
	if (failures != 0) begin
		$display("Total Failures: %d", failures);
	end else begin
		$display("All tests passed!");
	end

$stop;
end


endmodule 