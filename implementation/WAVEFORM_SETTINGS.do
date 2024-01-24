onerror {resume}
quietly set dataset_list [list sim vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate sim:/Processor_tb/CLK
add wave -noupdate sim:/Processor_tb/DUTY_CYCLE
add wave -noupdate sim:/Processor_tb/PERIOD
add wave -noupdate sim:/Processor_tb/RST
add wave -noupdate sim:/Processor_tb/failures
add wave -noupdate sim:/Processor_tb/in_data
add wave -noupdate sim:/Processor_tb/out_result
add wave -noupdate -expand -group {Register Data Mux} sim:/Processor_tb/Processor_inst/WriteDataMux/s
add wave -noupdate -expand -group {Register Data Mux} sim:/Processor_tb/Processor_inst/WriteDataMux/a
add wave -noupdate -expand -group {Register Data Mux} sim:/Processor_tb/Processor_inst/WriteDataMux/b
add wave -noupdate -expand -group {Register Data Mux} sim:/Processor_tb/Processor_inst/WriteDataMux/c
add wave -noupdate -expand -group {Register Data Mux} sim:/Processor_tb/Processor_inst/WriteDataMux/d
add wave -noupdate -expand -group {Register Data Mux} sim:/Processor_tb/Processor_inst/WriteDataMux/r
add wave -noupdate -group {Out Value Mux} sim:/Processor_tb/Processor_inst/OutValueMux/in_0
add wave -noupdate -group {Out Value Mux} sim:/Processor_tb/Processor_inst/OutValueMux/in_1
add wave -noupdate -group {Out Value Mux} sim:/Processor_tb/Processor_inst/OutValueMux/sel
add wave -noupdate -group {Out Value Mux} sim:/Processor_tb/Processor_inst/OutValueMux/out_result
add wave -noupdate -expand -group PC sim:/Processor_tb/Processor_inst/PC/RST
add wave -noupdate -expand -group PC sim:/Processor_tb/Processor_inst/PC/CLK
add wave -noupdate -expand -group PC sim:/Processor_tb/Processor_inst/PC/in_data
add wave -noupdate -expand -group PC sim:/Processor_tb/Processor_inst/PC/out_result
add wave -noupdate -group {IorD Mux} sim:/Processor_tb/Processor_inst/IorDMux/in_0
add wave -noupdate -group {IorD Mux} sim:/Processor_tb/Processor_inst/IorDMux/in_1
add wave -noupdate -group {IorD Mux} sim:/Processor_tb/Processor_inst/IorDMux/sel
add wave -noupdate -group {IorD Mux} sim:/Processor_tb/Processor_inst/IorDMux/out_result
add wave -noupdate -expand -group Memory sim:/Processor_tb/Processor_inst/memWrapper/data
add wave -noupdate -expand -group Memory sim:/Processor_tb/Processor_inst/memWrapper/memAddr
add wave -noupdate -expand -group Memory sim:/Processor_tb/Processor_inst/memWrapper/we
add wave -noupdate -expand -group Memory sim:/Processor_tb/Processor_inst/memWrapper/clk
add wave -noupdate -expand -group Memory sim:/Processor_tb/Processor_inst/memWrapper/q
add wave -noupdate -expand -group Memory sim:/Processor_tb/Processor_inst/memWrapper/shiftedWire
add wave -noupdate -expand -group Memory sim:/Processor_tb/Processor_inst/memWrapper/newAddr
add wave -noupdate -expand -group {Instruction Register} sim:/Processor_tb/Processor_inst/IR/CLK
add wave -noupdate -expand -group {Instruction Register} sim:/Processor_tb/Processor_inst/IR/IRWrite
add wave -noupdate -expand -group {Instruction Register} sim:/Processor_tb/Processor_inst/IR/in_instruction
add wave -noupdate -expand -group {Instruction Register} sim:/Processor_tb/Processor_inst/IR/out_instruction
add wave -noupdate -expand -group {Instruction Register} sim:/Processor_tb/Processor_inst/IR/out_opcode
add wave -noupdate -expand -group {Instruction Register} sim:/Processor_tb/Processor_inst/IR/out_Reg1
add wave -noupdate -expand -group {Instruction Register} sim:/Processor_tb/Processor_inst/IR/out_Reg2
add wave -noupdate -expand -group {Instruction Register} sim:/Processor_tb/Processor_inst/IR/out_RegRd
add wave -noupdate -expand -group {Instruction Register} sim:/Processor_tb/Processor_inst/IR/temp
add wave -noupdate -expand -group {Register File} sim:/Processor_tb/Processor_inst/RegFile/RST
add wave -noupdate -expand -group {Register File} sim:/Processor_tb/Processor_inst/RegFile/CLK
add wave -noupdate -expand -group {Register File} sim:/Processor_tb/Processor_inst/RegFile/in_RegWrite
add wave -noupdate -expand -group {Register File} sim:/Processor_tb/Processor_inst/RegFile/in_Data
add wave -noupdate -expand -group {Register File} sim:/Processor_tb/Processor_inst/RegFile/in_ReadReg1
add wave -noupdate -expand -group {Register File} sim:/Processor_tb/Processor_inst/RegFile/in_ReadReg2
add wave -noupdate -expand -group {Register File} sim:/Processor_tb/Processor_inst/RegFile/in_WriteAddr
add wave -noupdate -expand -group {Register File} sim:/Processor_tb/Processor_inst/RegFile/out_ReadData1
add wave -noupdate -expand -group {Register File} sim:/Processor_tb/Processor_inst/RegFile/out_ReadData2
add wave -noupdate -expand -group {Register File} sim:/Processor_tb/Processor_inst/RegFile/j
add wave -noupdate -expand -group {Register File} sim:/Processor_tb/Processor_inst/RegFile/i
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/PCSource
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/ALUSrcB
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/ALUSrcA
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/MemtoReg
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/RegDst
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/RegWrite
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/MemRead
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/MemWrite
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/IorD
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/IRWrite
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/PCWrite
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/PCWriteCond
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/OutputSig
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/Opcode
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/Clk
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/Reset
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/current_state
add wave -noupdate -expand -group Control sim:/Processor_tb/Processor_inst/control/next_state
add wave -noupdate -expand -group {Immediate Genie} sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ImmGenie/In_Inst
add wave -noupdate -expand -group {Immediate Genie} sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ImmGenie/Out_Imm
add wave -noupdate -expand -group {Immediate Genie} sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ImmGenie/Out_Si
add wave -noupdate -expand -group {ALU Control} sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ALUControl/CLK
add wave -noupdate -expand -group {ALU Control} sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ALUControl/In_Si
add wave -noupdate -expand -group {ALU Control} sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ALUControl/In_Inst
add wave -noupdate -expand -group {ALU Control} sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ALUControl/Out_ALUCtrl
add wave -noupdate -expand -group A sim:/Processor_tb/Processor_inst/A/RST
add wave -noupdate -expand -group A sim:/Processor_tb/Processor_inst/A/CLK
add wave -noupdate -expand -group A sim:/Processor_tb/Processor_inst/A/in_data
add wave -noupdate -expand -group A sim:/Processor_tb/Processor_inst/A/out_result
add wave -noupdate -expand -group B sim:/Processor_tb/Processor_inst/B/RST
add wave -noupdate -expand -group B sim:/Processor_tb/Processor_inst/B/CLK
add wave -noupdate -expand -group B sim:/Processor_tb/Processor_inst/B/in_data
add wave -noupdate -expand -group B sim:/Processor_tb/Processor_inst/B/out_result
add wave -noupdate -expand -group ALU sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ALU/In_A
add wave -noupdate -expand -group ALU sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ALU/In_B
add wave -noupdate -expand -group ALU sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ALU/In_ALUCtrl
add wave -noupdate -expand -group ALU sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ALU/Out_ALUResult
add wave -noupdate -expand -group ALU sim:/Processor_tb/Processor_inst/ALUOperations/UUT_ALU/Out_Zero
add wave -noupdate -expand -group {ALU Register} sim:/Processor_tb/Processor_inst/ALUOut/RST
add wave -noupdate -expand -group {ALU Register} sim:/Processor_tb/Processor_inst/ALUOut/CLK
add wave -noupdate -expand -group {ALU Register} sim:/Processor_tb/Processor_inst/ALUOut/in_data
add wave -noupdate -expand -group {ALU Register} sim:/Processor_tb/Processor_inst/ALUOut/out_result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {290 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {374 ps}
