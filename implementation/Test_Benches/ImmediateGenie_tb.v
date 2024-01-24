`timescale 1 ns/1 ps

module ImmediateGenie_tb();

//Inputs
reg [15:0] instr;

//output
wire signed [15:0] dout;
wire [1:0] siVal;

integer correctImmediate;
integer failures = 0;

//instantiate
ImmediateGenie UUT(
	.In_Inst(instr),
	.Out_Imm(dout),
	.Out_Si(siVal)
);

//initial begin and end

	initial begin
	
	//Test add
	instr = 16'b0000000100100000;
	correctImmediate = 0;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed Add \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 
	 //Test positive addi (3)
	instr = 16'b0000000100110100;
	correctImmediate = 3;
	
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed Positive AddI \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	//Test negative addi (-1)
	instr = 16'b0010001111110100;
	correctImmediate = -1;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed Negative AddI \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	//Test positive lw 
	instr = 16'b0010000101000111;
	correctImmediate = 4;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed positive lw \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 	//Test negative lw 
	instr = 16'b0011001010100111;
	correctImmediate = -6;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed negative lw \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 	//Test positive sw
	instr = 16'b0001100100101000;
	correctImmediate = 2;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed positive sw \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 	//Test negative sw
	instr = 16'b1001011011101000;
	correctImmediate = -2;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed negative sw \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 	//Test positive beq
	instr = 16'b1000000010001001;
	correctImmediate = 8;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed positive beq \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 	//Test negative beq 
	instr = 16'b1001111111001001;
	correctImmediate = -4;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed negative beq \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 	//Test positive jal 
	instr = 16'b0010000001101100;
	correctImmediate = 6;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed positive jal \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 	//Test negative jal (-1)
	instr = 16'b1011111101101100;
	correctImmediate = -10;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed jal \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 	//Test jalr
	instr = 16'b0001001000000111;
	correctImmediate = 0;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed jalr \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 	//Test positive lui 
	instr = 16'b1101000011011110;
	correctImmediate = 16'b00001101_00000000;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed positive lui  \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 	 	//Test negative lui 
	instr = 16'b1110111010111110;
	correctImmediate = 16'b11101011_0000_0000;
	 #10;
	 if(dout != 16'b11101011_0000_0000) begin	
			failures = failures + 1;
			$display("Failed Negative lui \n Expected: %d \n Got: %d", 16'b11101011_0000_0000, dout);
	 end
	 #10;
	 
	 	 	//Test positive lbi
	instr = 16'b1100010010101111;
	correctImmediate = 16'b00000000_01001010;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed negative lui  \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;
	 
	 	 	//Test negative lbi
	instr = 16'b1101101011101111;
	correctImmediate = 16'b00000000_10101110;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed negative lbi \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 #10;

	//Test si
	instr = 16'b0011001101010101;
	correctImmediate = 5;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed si1 immediate \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	 if(siVal != 3) begin	
			failures = failures + 1;
			$display("Failed si1 bits \n Expected: %d \n Got: %d", 3, siVal);
	 end
	 #10;
	 
	 
	//Test si again
	instr = 16'b0010000111110101;
	correctImmediate = 15;
	 #10;
	 if(dout != correctImmediate) begin	
			failures = failures + 1;
			$display("Failed si2 immediate \n Expected: %d \n Got: %d", correctImmediate, dout);
	 end
	if(siVal != 1) begin
			failures = failures + 1;
			$display("Failed si2 bits \n Expected: %d \n Got: %d", 1, siVal);
	end
	 #10;


	if(failures == 0) begin
			$display("Passed all immediate genie tests.");

	end
	else begin
			$display("Failed %d tests", failures);

	end
	 

	
	end



endmodule