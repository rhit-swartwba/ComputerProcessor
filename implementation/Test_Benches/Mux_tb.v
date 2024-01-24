`timescale 1 ns/1 ps

module Mux_tb();

//Inputs

reg[15:0] in_A;
reg[15:0] in_B;
reg[0:0] in_select;

wire [15:0] out_mux;

integer failures = 0;
	
	
Mux muxuut(
	.in_0(in_A),
	.in_1(in_B),
	.sel(in_select),
	.out_result(out_mux)
);

initial begin

//Test select A
	in_A = 16'b0000000000000001;
	in_B = 16'b0000000000000000;
	in_select = 1'b0;
	
	 #10;
	 if(out_mux != in_A) begin	
			failures = failures + 1;
			$display("Failed Select 0 \n Expected: %d \n Got: %d", A, out_result);
	 end
	 #10;
	 
//Test select B
	in_A = 16'b0000000000000001;
	in_B = 16'b0000000000000000;
	in_select = 1'b1;
	
	 #10;
	 if(out_mux != in_B) begin	
			failures = failures + 1;
			$display("Failed Select 1 \n Expected: %d \n Got: %d", B, out_result);
	 end
	 #10;
	 
	if(failures == 0) begin
			$display("Passed all mux tests.");

	end
	else begin
			$display("Failed %d tests", failures);

	end

end

endmodule
