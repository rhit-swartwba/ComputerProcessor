/*
Design: Register File
File Name: RegisterFile.v
Function: Holds all of the registers and read/writes accordingly
Author: Spencer Halsey
*/

module RegisterFile(

CLK , // Clock
RST , // Reset
in_RegWrite, //Signal to determine if we need to write
in_BrSig,
in_ReadReg1, //First register address to read
in_ReadReg2, //Second register address to read
in_WriteAddr, //Register address to write to
in_Data, //Data to write to write register
out_ReadData1, // Data from ReadReg1
out_ReadData2 // Data from ReadReg2


);

input RST, CLK, in_RegWrite, in_BrSig;
input [15:0] in_Data;
input [3:0] in_ReadReg1, in_ReadReg2, in_WriteAddr;

output signed [15:0] out_ReadData1, out_ReadData2;

reg signed [15:0] out_ReadData1, out_ReadData2;

//0:15
reg signed [15:0] regfile [0:15];
integer j, i;
//Add start state, which sets everything to zero
initial begin
for (j = 0; j < 16; j = j + 1) begin
regfile[j] <= 0;
end
//Stack pointer
regfile[2] <= 'h03FF;
 end
 
 always @(posedge CLK) begin
     if (RST == 1) begin
         for (i = 0; i < 16; i = i + 1) begin
            regfile[i] <= 0;
                 end
			//Stack pointer
			regfile[2] <= 'h03FF;

end
if(in_RegWrite == 1) begin

if(in_WriteAddr != 4'b0000) begin
 
                //Writing
                regfile[in_WriteAddr] <= in_Data;
 
                end
 
         end
    // else begin
 
         //Reading
			
			$display("a0 Value: %d\n", regfile[4'b0011]);
		$display("a1 Value: %d\n", regfile[4'b0100]);
out_ReadData1 = regfile[in_ReadReg1];
//out_ReadData1 = regfile[4'b1001];
if(in_BrSig == 1)begin
out_ReadData2 = regfile[4'b1110];
			end
			else begin
         out_ReadData2 = regfile[in_ReadReg2];
			end
 
   //  end
 end
 
 
 endmodule