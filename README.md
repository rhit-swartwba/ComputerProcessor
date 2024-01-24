Designed and creating my own multicycle processor with a unique instruction set architecture

I worked with 3 other teammates in the design of this computer architecture. We created a load-store multicycle architecture with a 16 bit instruction size. There were 3 different 
instruction types. There were 16 different instructions, leading to a 4-bit opcode, and 16 available registers, leading to 4-bit registers.

The processor was designed to run Euclids algorithm to find the greatest common divisor (GCD) of two numbers. Using our instruction set, we wrote assembly for Euclid's algorithm
and ran it using Quartus and ModelSim. We also created an assembler that could take pseudoinstruction tempates so pseudoinstructions could be written in the code. 

My focus in the processor creation was designing and implementing the ALU, ALUControl, and ImmediateGenerator. I created an integration test for these components, as well as individual
tests to confirm the components functioned correctly. I also wrote the assembly code for RelPrime, and was the primary debugger when implementing the entire processor together. I coded the
with pseudoinstruction by myself as well, which was vital to our testing purposes.

