module Memory_Wrapper
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=16)
(

	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] memAddr,
	input we, clk,
	output [(DATA_WIDTH-1):0] q

);

	// Variable to hold the registered read address
	wire [15:0] shiftedWire = memAddr >> 1;
	wire [9:0] newAddr = (memAddr > 'h3FF) ? 'h3FF : shiftedWire[9:0];
	
Memory Memory_inst
(
	.data(data) ,	// input [DATA_WIDTH-1:0] data
	.addr(newAddr) ,	// input [ADDR_WIDTH-1:0] addr
	.we(we) ,	// input  we
	.clk(clk) ,	// input  clk
	.q(q) 	// output [DATA_WIDTH-1:0] q
);


endmodule 

