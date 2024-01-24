`timescale 1 ns/1 ps

module Control_tb();

//Input
reg [3:0] Opcode;
reg		 Clk;
reg       Reset;


//Outputs
wire ALUSrcA;
wire [1:0] ALUSrcB;
wire [1:0] MemtoReg;
wire RegDst;
wire RegWrite;
wire MemRead;
wire MemWrite;
wire IorD;
wire IRWrite;
wire PCWrite;
wire PCWriteCond;
wire [1:0] PCSource;

integer cycle_counter = 0;
integer failures = 0;

parameter HALF_PERIOD = 50;

//instantiate
Control UUT(
	.Opcode(Opcode),
	.Reset(Reset),
	.ALUSrcA(ALUSrcA),
	.ALUSrcB(ALUSrcB),
	.MemtoReg(MemtoReg),
	.RegDst(RegDst),
	.RegWrite(RegWrite),
	.MemRead(MemRead),
	.MemWrite(MemWrite),
	.IorD(IorD),
	.IRWrite(IRWrite),
	.PCWrite(PCWrite),
	.PCWriteCond(PCWriteCond),
	.PCSource(PCSource),
	.Clk(Clk)
);

//initial begin and end



always #HALF_PERIOD Clk = ~Clk;


initial begin
	Clk = 0;
	
$display("Testing add operation.");
	//Test add
	Reset = 1;
	Opcode = 4'B0000;
	#(2*HALF_PERIOD);
	Reset = 0;
	        
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 ||IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed add: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	Reset = 0;
	#(2*HALF_PERIOD);
	Reset = 0;
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed add: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 1 || ALUSrcB != 0) begin
		failures = failures + 1;
		$display("Failed add: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD); 
		if (RegDst != 1 || RegWrite != 1 || MemtoReg != 0) begin
		failures = failures + 1;
		$display("Failed add: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	//Test sub
	Opcode = 4'B0001;
	#(2*HALF_PERIOD);
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed sub: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed sub: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 1 || ALUSrcB != 0) begin
		failures = failures + 1;
		$display("Failed sub: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (RegDst != 1 || RegWrite != 1 || MemtoReg != 0) begin
		failures = failures + 1;
		$display("Failed sub: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//Test and
	Opcode = 4'B0010;
	#(2*HALF_PERIOD);
	
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed and: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed and: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 1 || ALUSrcB != 0) begin
		failures = failures + 1;
		$display("Failed and: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (RegDst != 1 || RegWrite != 1 || MemtoReg != 0) begin
		failures = failures + 1;
		$display("Failed and: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//Test or
	Opcode = 4'B0011;
	#(2*HALF_PERIOD);
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed or: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed or: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 1 || ALUSrcB != 0) begin
		failures = failures + 1;
		$display("Failed or: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (RegDst != 1 || RegWrite != 1 || MemtoReg != 0) begin
		failures = failures + 1;
		$display("Failed or: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Test addi
	Opcode = 4'B0100;
	#(2*HALF_PERIOD);
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed addi: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed addi: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 1 || ALUSrcB != 3) begin
		failures = failures + 1;
		$display("Failed addi: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (RegDst != 1 || RegWrite != 1 || MemtoReg != 0) begin
		failures = failures + 1;
		$display("Failed addi: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Test lw
	Opcode = 4'B0111;
	#(2*HALF_PERIOD);
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed fetch lw: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed decode lw: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 1 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed memory lw: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (MemRead != 1 || IorD != 1) begin
		failures = failures + 1;
		$display("Failed LW lw: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (RegDst != 0 || RegWrite != 1 || MemtoReg != 1) begin
		failures = failures + 1;
		$display("Failed MemoryRead lw: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//Test sw
	Opcode = 4'B1000;
	#(2*HALF_PERIOD);
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed sw: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed sw: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 1 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed sw: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (IorD != 1 || MemWrite != 1) begin
		failures = failures + 1;
		$display("Failed sw: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Test beq
	Opcode = 4'B1001;
	#(2*HALF_PERIOD);
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed beq: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed beq: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 1 || ALUSrcB != 0 || PCWriteCond != 1 || PCSource != 1) begin
		failures = failures + 1;
		$display("Failed beq: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//Test jal
	Opcode = 4'B1100;
	#(2*HALF_PERIOD);
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed fetch jal: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed decode jal: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (PCWrite != 1 || PCSource != 1 || MemtoReg != 2 || RegWrite != 1) begin
		failures = failures + 1;
		$display("Failed jump jal: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Test jalr
	Opcode = 4'B1101;
	#(2*HALF_PERIOD);
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed fetch jalr: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed decode jalr: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (PCWrite != 1 || PCSource != 2 || MemtoReg != 2 || RegWrite != 1) begin
		failures = failures + 1;
		$display("Failed jalr jalr: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//Test lui
	Opcode = 4'B1110;
	#(2*HALF_PERIOD);
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed lui: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed lui: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 1 || ALUSrcB != 3) begin
		failures = failures + 1;
		$display("Failed lui: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (RegDst != 1 || RegWrite != 1 || MemtoReg != 0) begin
		failures = failures + 1;
		$display("Failed lui: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//Test lbi
	Opcode = 4'B1111;
	#(2*HALF_PERIOD);
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed lbi: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed lbi: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 1 || ALUSrcB != 3) begin
		failures = failures + 1;
		$display("Failed lbi: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (RegDst != 1 || RegWrite != 1 || MemtoReg != 0) begin
		failures = failures + 1;
		$display("Failed lbi: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	//Test si
	Opcode = 4'B1010;
	#(2*HALF_PERIOD);
		if (MemRead != 1 || ALUSrcA != 0 || IorD != 0 || IRWrite != 1 || ALUSrcB != 1 || PCWrite != 1 || PCSource != 0) begin
		failures = failures + 1;
		$display("Failed fetch si: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 0 || ALUSrcB != 2) begin
		failures = failures + 1;
		$display("Failed decode si: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (ALUSrcA != 1 || ALUSrcB != 3) begin
		failures = failures + 1;
		$display("Failed immdediate si: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end
	#(2*HALF_PERIOD);
		if (RegDst != 1 || RegWrite != 1 || MemtoReg != 0) begin
		failures = failures + 1;
		$display("Failed write si: wrong signals");
		$display("Displaying Signals  ALUSrcA: %d  ALUSrcB: %d  MemtoReg: %d  RegDst: %d  RegWrite: %d  MemRead: %d  MemWrite: %d  IorD: %d  IRWrite: %d  PCWrite: %d  PCWriteCond: %d  PCSource: %d ", ALUSrcA, ALUSrcB, MemtoReg, RegDst, RegWrite, MemRead, MemWrite, IorD, IRWrite, PCWrite, PCWriteCond, PCSource);
	end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	 
	 if(failures == 0) begin
			$display("Passed all control tests.");

	end
	else begin
			$display("Failed %d tests", failures);

	end
	$stop;
	
	end



endmodule