
`timescale 1 ns/1 ps

module RegisterFile_tb();

//Inputs
reg CLK, RST, regWrite;

reg [15:0] in_data;
reg [3:0] readReg1, readReg2, writeAddr;

wire [15:0] out_readData1, out_readData2;
reg [15:0] expectedReset = 16'b0000000000000000;

parameter HALF_PERIOD = 50;
integer failures = 0; 

initial begin
		CLK = 0;
		forever begin
			#(HALF_PERIOD);
			CLK = ~CLK;
		end
	end

	
	
RegisterFile registerFileuut
(
	.CLK(CLK) ,								// input  CLK_sig
	.RST(RST) ,								// input  RST_sig
	.in_RegWrite(regWrite) ,			// input  regWrite
	.in_ReadReg1(readReg1) ,			// input [3:0] readReg1
	.in_ReadReg2(readReg2) ,			// input [3:0] readReg2
	.in_WriteAddr(writeAddr) ,			// input [3:0] writeAddr
	.in_Data(in_data) ,					// input [15:0] in_data
	.out_ReadData1(out_readData1) ,	// output [15:0] out_readData1
	.out_ReadData2(out_readData2) 	// output [15:0] out_readData2
);

initial begin

	CLK = 0;
	RST = 0;

//Test set positive value
	 in_data = 16'b0000000000000001;
	 regWrite = 1;
	 writeAddr = 4'b0001;
	
	 #(100*HALF_PERIOD);
	 
	 //Read set value
	 readReg1 = 4'b0001;
	 regWrite = 0;
	
	 #(100*HALF_PERIOD);
	
	 if(out_readData1 != in_data) begin	
			failures = failures + 1;
			$display("Failed input value 1 \n Expected: %d \n Got: %d", in_data, out_readData1);
	 end
	 #(100*HALF_PERIOD);
	 
//Test set negative value
	 in_data = 16'b1000000000000001;
	 regWrite = 1;
	 writeAddr = 4'b0010;
	
	 #(100*HALF_PERIOD);
	 
	 //Read set value
	 readReg2 = 4'b0010;
	 regWrite = 0;
	
	 #(100*HALF_PERIOD);
	
	 if(out_readData2 != in_data) begin	
			failures = failures + 1;
			$display("Failed input value -32767 \n Expected: %d \n Got: %d", in_data, out_readData2);
	 end
	 #(100*HALF_PERIOD);

//Test reset
	 
	 RST = 1;
	 readReg1 = 4'b0001;
	 readReg2 = 4'b0010;
	 
	 #(100*HALF_PERIOD);
	 
	 if(out_readData1 != expectedReset && out_readData1 != expectedReset) begin	
			failures = failures + 1;
			$display("Failed test reset \n Expected: %d \n Got: %d and %d", expectedReset, out_readData1, out_readData2);
	 end
	 #(100*HALF_PERIOD);
	 
//Test try to set x0
	 in_data = 16'b0000000000000001;
	 regWrite = 1;
	 writeAddr = 4'b0000;
	
	 #(100*HALF_PERIOD);
	 
	 //Read set value
	 readReg1 = 4'b0000;
	 regWrite = 0;
	
	 #(100*HALF_PERIOD);
	
	 if(out_readData1 != expectedReset) begin	
			failures = failures + 1;
			$display("Failed set x0 \n Expected: %d \n Got: %d", expectedReset, out_readData1);
	 end
	 #(100*HALF_PERIOD);

	 
	 
	if(failures == 0) begin
			$display("Passed all RegisterFile tests.");

	end
	else begin
			$display("Failed %d tests", failures);

	end
	$stop;
end

endmodule