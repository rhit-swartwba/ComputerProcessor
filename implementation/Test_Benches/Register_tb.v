`timescale 1 ns/1 ps

module Register_tb();

//Inputs
reg CLK, RST;

reg[15:0] in_data;
reg[15:0] expectedReset = 16'b0000000000000000;

wire[15:0] out_result;

parameter HALF_PERIOD = 50;
integer failures = 0;

initial begin
		CLK = 0;
		forever begin
			#(HALF_PERIOD);
			CLK = ~CLK;
		end
	end

	
	
Register registeruut(
	.CLK(CLK),
	.RST(RST),
	.in_data(in_data),
	.out_result(out_result)
);

initial begin

	CLK = 0;
	RST = 0;

//Test input value
	in_data = 16'b0000000000000001;
	
	 #(100*HALF_PERIOD);
	 if(out_result != in_data) begin	
			failures = failures + 1;
			$display("Failed input value 1 \n Expected: %d \n Got: %d", in_data, out_result);
	 end
	 #(100*HALF_PERIOD);
	 
//Test negative input value
	in_data = 16'b1000000000000001;
	 
	 #(100*HALF_PERIOD);
	 if(out_result != in_data) begin	
			failures = failures + 1;
			$display("Failed input value -32767 \n Expected: %d \n Got: %d", in_data, out_result);
	 end
	 #(100*HALF_PERIOD);

//Test reset

	 in_data = 16'b1000000000000001;
	 
	 #(100*HALF_PERIOD);
	 
	 
	 RST = 1;
	 
	 #(100*HALF_PERIOD);
	 if(out_result != expectedReset) begin	
			failures = failures + 1;
			$display("Failed test reset \n Expected: %d \n Got: %d", expectedReset, out_result);
	 end
	 #(100*HALF_PERIOD);
	 
	 
	if(failures == 0) begin
			$display("Passed all Register tests.");

	end
	else begin
			$display("Failed %d tests", failures);

	end
	$stop;
end

endmodule