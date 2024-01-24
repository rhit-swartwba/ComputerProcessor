/*
Design: Mux
File Name: Mux.v
Function: 2:1 Mux
Author: Spencer Halsey
*/

module Mux(

	input [15:0] in_0 , // Mux first input
	input [15:0] in_1 , // Mux second input
	input sel, // Select Bit
	output reg [15:0] out_result
);


//Code

always @ (sel or in_0 or in_1)
begin: MUX

case(sel) 
     1'b0 : out_result = in_0;
     1'b1 : out_result = in_1;
  endcase
 end
 
 endmodule
 