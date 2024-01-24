`timescale 1 ns/1 ps

module Memory_tb();

//Inputs
	reg [15:0] data;
	reg [15:0] addr;
	reg we, CLK;
	wire [15:0] q;

 parameter   PERIOD = 20;
 parameter   real DUTY_CYCLE = 0.5;
 integer failures = 0;

 initial    // Clock process for CLK
 begin
	forever
		begin
        CLK = 1'b0;
        #(PERIOD-(PERIOD*DUTY_CYCLE)) CLK = 1'b1;
        #(PERIOD*DUTY_CYCLE);
       end
   end
	
	
Memory Memory_inst
(
	.data(data) ,	// input [DATA_WIDTH-1:0] data_sig
	.addr(addr) ,	// input [ADDR_WIDTH-1:0] addr_sig
	.we(we) ,	// input  we_sig
	.clk(CLK) ,	// input  clk_sig
	.q(q) 	// output [DATA_WIDTH-1:0] q_sig
);

 initial begin
         CLK = 0;
			we = 0;
         addr = 16'b0000_0000_0000_0001;

         #(PERIOD);
		
		if (q != 16'b1011_0000_0010_0100) begin
        $display("failed reading from memory");
        failures = failures + 1;
    end
	 
	 we = 0;
    addr = 16'b0000_0000_0000_0010;
	 
	  #(PERIOD);
	  
	  if (q != 16'b1011_0000_1100_0011) begin
        $display("failed reading from memory 2");
        failures = failures + 1;
    end
	 
	  #(PERIOD);
	  we = 1;
     addr = 16'b0000_0000_0000_0011;
     data = 16'b1011_1100_0100_1000;
	  
	  #(PERIOD);
	 
	  if (q != 16'b1011_1100_0100_1000) begin
        $display("failed reading & writing from memory");
        failures = failures + 1;
    end
	 
	 we = 0;
	 
	 
// Display the total number of failures
 if (failures != 0) begin
	$display("Total Failures: %d", failures);
 end else begin
	$display("All tests passed!");
 end
			
			$stop;
     end

endmodule 
