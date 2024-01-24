	
module Control 			(
                          ALUSrcA,
                          ALUSrcB,
                          MemtoReg,
                          RegDst,
                          RegWrite, 
                          MemRead,
                          MemWrite,
                          IorD,
                          IRWrite, 
                          PCWrite,
                          PCWriteCond,
                          PCSource,
                          Opcode,
                          Clk,
                          Shift,
								  OutputSig,
                          PerformAddition,
								  ReadRd,
								  OutputBr,
                          RST
                          );

   output [1:0] PCSource;
   output [1:0] ALUSrcB;
   output       ALUSrcA;
   output [1:0] MemtoReg;
   output       RegDst;
   output       RegWrite;
   output       MemRead;
   output       MemWrite;
   output       IorD;
   output       IRWrite;
   output       PCWrite;
   output       PCWriteCond;
	output		 OutputSig;
   output       Shift;
   output PerformAddition;
	output ReadRd;
	output OutputBr;

   input [3:0]  Opcode;
   input        Clk;
   input        RST;

   reg [1:0]    PCSource;
   reg [1:0]    ALUSrcB;
   reg          ALUSrcA;
   reg [1:0]    MemtoReg;
   reg          RegDst;
   reg          RegWrite;
   reg          MemRead;
   reg          MemWrite;
   reg          IorD;
   reg          IRWrite;
   reg          PCWrite;
   reg          PCWriteCond;
	reg			 OutputSig;
   reg          Shift;
   reg PerformAddition;
	reg ReadRd;
	reg OutputBr;

   //state flip-flops
   reg [4:0]    current_state;
   reg [4:0]    next_state;

   //state definitions
	parameter	 Reset = 17;
   parameter    Fetch = 0;
   parameter    Decode = 1;
   parameter    Memory = 2;
   parameter    SW = 3;
	parameter    LW = 4;
   parameter    Execution = 5;
   parameter    Write = 6;
	parameter    Immediate = 7;
   parameter    Branch = 8;
   parameter    Jump = 9;
	parameter	 MemoryRead = 10;
	parameter	 Jalr = 11;
	parameter	 Input = 12;
	parameter 	 Output = 13;
   parameter    Shifting = 14;
	parameter    Prebranch = 15;
	parameter	 Postbranch = 16;

   //register calculation
   always @ (posedge Clk, posedge RST)
     begin
        if (RST)
          current_state = Reset;
        else 
          current_state = next_state;
     end


   //OUTPUT signals for each state (depends on current state)
   always @ (current_state)
     begin
        //Reset all signals that cannot be don't cares
				PCSource = 0;
				ALUSrcB = 0;
				ALUSrcA = 0;
				MemtoReg = 0;
            RegDst = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            IorD = 0;
            IRWrite = 0;
            PCWrite = 0;
            PCWriteCond = 0;
				OutputSig = 0;
            Shift = 0;
            PerformAddition = 0;
	         ReadRd = 0;
	         OutputBr = 0;
        
        case (current_state)
			 Reset:
				begin
				PCSource = 0;
				ALUSrcB = 0;
				ALUSrcA = 0;
				MemtoReg = 0;
            RegDst = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            IorD = 0;
            IRWrite = 0;
            PCWrite = 0;
            PCWriteCond = 0;
				OutputSig = 0;
            Shift = 0;
            PerformAddition = 0;
	         ReadRd = 0;
	         OutputBr = 0;	
				end
			 
          Fetch:
            begin
               MemRead = 1;
               ALUSrcA = 0;
               IorD = 0;
               IRWrite =  1;
               ALUSrcB = 1;
               PCWrite = 1;
               PCSource = 0;
               PerformAddition = 1;
					OutputSig = 0;
            end

        Shifting:
            begin
                Shift = 1;
            end
                         
          Decode:
            begin
               ALUSrcA = 0;
               ALUSrcB = 2;
					PerformAddition = 1;
            end
        
          Execution:
            begin
               ALUSrcA = 1;
               ALUSrcB = 0;
            end
        
          Write:
            begin
               RegDst = 1;
               RegWrite = 1;
               MemtoReg = 0;
            end
			 Immediate:
            begin
               ALUSrcA = 1;
               ALUSrcB = 2;
            end
			 
			 //Make the immediate 2 less than what you need
          Branch:
            begin
					OutputBr = 1;
					Shift = 1;
               ALUSrcA = 1;
               ALUSrcB = 0;
               PCWriteCond = 1;
               PCSource = 1;
            end
        
          Jump:
            begin
               PCWrite = 1;
               PCSource = 1;
					MemtoReg = 2;
					RegWrite = 1;
            end
				
			 Jalr:
            begin
               PCWrite = 1;
               PCSource = 2;
					MemtoReg = 2;
					RegWrite = 1;
            end
          
          Memory:
            begin
               ALUSrcA = 1;
					ALUSrcB = 2;
					ReadRd = 1;
            end
				
			 LW:
            begin
               MemRead = 1;
					IorD = 1;
            end
				
			 SW:
            begin
               MemWrite = 1;
					IorD = 1;
            end
				
			 MemoryRead:
            begin
               RegDst = 0;
					RegWrite = 1;
					MemtoReg = 1;
					//IorD = 0;
            end
         Input:
            begin
					MemtoReg = 3;
					RegWrite = 1;
            end
			Output:
				begin
					OutputSig = 1;
				end
			Prebranch:
				begin
				OutputBr = 1;
				Shift = 1;
				end
			Postbranch:
				begin
				PCSource = 0;
				ALUSrcB = 0;
				ALUSrcA = 0;
				MemtoReg = 0;
            RegDst = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            IorD = 0;
            IRWrite = 0;
            PCWrite = 0;
            PCWriteCond = 0;
				OutputSig = 0;
            Shift = 0;
            PerformAddition = 0;
	         ReadRd = 0;
	         OutputBr = 0;	
				end
        
          default:
            begin $display ("not implemented"); end
          
        endcase
     end
                
   //NEXT STATE calculation (depends on current state and opcode)       
   always @ (current_state, next_state, Opcode)
     begin           
        case (current_state)
		  
			 Reset:
				begin
					next_state = Fetch;
				end
          
          Fetch:
            begin
               next_state = Decode;
            end
          
          Decode: 
            begin       
//               $display("The opcode is %d", Opcode);
               case (Opcode)
                 0:
                   begin
                      next_state = Execution;
                   end
					  1:
                   begin
                      next_state = Execution;
                   end
					  2:
                   begin
                      next_state = Execution;
                   end
					  3:
                   begin
                      next_state = Execution;
                   end
					  4:
                   begin
                      next_state = Immediate;
                   end
                 5:
                   begin
                      next_state = Shifting;
                   end
					  6:
                   begin
                      next_state = Input;
                   end
                 7:
                   begin
                      next_state = Memory;
                   end
                 8:
                   begin next_state = Memory;
                   end
					  9:
                   begin
                      next_state = Branch;
                   end
					  10:
                   begin
                      next_state = Output;
                   end
				 	  12:
                   begin
                      next_state = Jump;
                   end
					  13:
                   begin
                      next_state = Jalr;
                   end
					  14:
                   begin
                      next_state = Immediate;
                   end
					  15:
                   begin
                      next_state = Shifting;
                   end
                 default:
                   begin 
                      //$display(" Wrong Opcode %d ", Opcode);
                   end
               endcase  
               
            end
          
          Execution:
            begin
               next_state = Write;
            end
          
          Write:
            begin
               next_state = Fetch;
            end
			
			 Prebranch:
				begin
					next_state = Branch;
				end
          
          Branch:
            begin
               next_state = Postbranch;
            end
				
			 Postbranch:
				begin
					next_state = Fetch;
				end

          Memory:
            begin
				if (Opcode == 8) begin
               next_state = SW;
					end else begin
					next_state = LW;
					end
            end
          
          Jump:
            begin
               next_state = Postbranch;
            end
				
			 Immediate:
            begin
               next_state = Write;
            end
			 Jalr:
            begin
               next_state = Postbranch;
            end
			LW:
            begin
               next_state = MemoryRead;
            end
			SW:
            begin
               next_state = Fetch;
            end
			MemoryRead:
            begin
               next_state = Fetch;
            end
			Output:
            begin
               next_state = Fetch;
            end
			Input:
            begin
               next_state = Fetch;
            end

            Shifting:
            begin
                next_state = Immediate;
			end
          
          default:
            begin
               $display(" Not implemented!");
               next_state = Fetch;
            end
          
        endcase
        
                
     end

endmodule