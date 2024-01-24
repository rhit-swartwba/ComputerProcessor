/*
Design: Register
File Name: Register.v
Function: Stores values based on clock edge
Author: Spencer Halsey
*/

module Register(

	CLK , // Clock
	RST , // Reset
	in_data  , // Input Data
	out_result // Result

);

input RST, CLK;
input [15:0] in_data;

output signed out_result;

reg signed [15:0] out_result;

always @(posedge CLK, posedge RST) begin
    if (RST == 1) begin
        out_result = 16'b0000000000000000;
    end
    else begin
        out_result = in_data;
    end
end
endmodule
 