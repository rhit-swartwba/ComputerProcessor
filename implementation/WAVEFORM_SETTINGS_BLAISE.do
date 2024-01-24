onerror {resume}
quietly virtual function -install /Processor_tb/Processor_inst/PC -env /Processor_tb/Processor_inst/PC { &{/Processor_tb/Processor_inst/PC/RST, /Processor_tb/Processor_inst/PC/CLK, /Processor_tb/Processor_inst/PC/in_data, /Processor_tb/Processor_inst/PC/out_result }} PC
quietly WaveActivateNextPane {} 0
add wave -noupdate -group A -label A_in /Processor_tb/Processor_inst/A/in_data
add wave -noupdate -group A -label A_out /Processor_tb/Processor_inst/A/out_result
add wave -noupdate -group A /Processor_tb/CLK
add wave -noupdate -group B -label B_in /Processor_tb/Processor_inst/B/in_data
add wave -noupdate -group B -label B_out /Processor_tb/Processor_inst/B/out_result
add wave -noupdate -expand -group PC -label PC_in /Processor_tb/Processor_inst/PC/in_data
add wave -noupdate -expand -group PC -label PC_out /Processor_tb/Processor_inst/PC/out_result
add wave -noupdate -expand -group PC /Processor_tb/Processor_inst/PC/PC
add wave -noupdate -expand -group MemoryWrapper -label data /Processor_tb/Processor_inst/memWrapper/data
add wave -noupdate -expand -group MemoryWrapper -label memAddr /Processor_tb/Processor_inst/memWrapper/memAddr
add wave -noupdate -expand -group MemoryWrapper -label we /Processor_tb/Processor_inst/memWrapper/we
add wave -noupdate -expand -group MemoryWrapper -label q /Processor_tb/Processor_inst/memWrapper/q
add wave -noupdate -expand -group MemoryWrapper -label shiftedWire /Processor_tb/Processor_inst/memWrapper/shiftedWire
add wave -noupdate -expand -group MemoryWrapper -label newAddr /Processor_tb/Processor_inst/memWrapper/newAddr
add wave -noupdate -group MDR -label MDR_in /Processor_tb/Processor_inst/MDR/in_data
add wave -noupdate -group MDR -label MDR_out /Processor_tb/Processor_inst/MDR/out_result
add wave -noupdate -group IR -label IRWrite /Processor_tb/Processor_inst/IR/IRWrite
add wave -noupdate -group IR -label in /Processor_tb/Processor_inst/IR/in_instruction
add wave -noupdate -group IR -label out_full /Processor_tb/Processor_inst/IR/out_instruction
add wave -noupdate -group IR -label out_op /Processor_tb/Processor_inst/IR/out_opcode
add wave -noupdate -group IR -label out_rs1 /Processor_tb/Processor_inst/IR/out_Reg1
add wave -noupdate -group IR -label out_rs2 /Processor_tb/Processor_inst/IR/out_Reg2
add wave -noupdate -group IR -label out_rd /Processor_tb/Processor_inst/IR/out_RegRd
add wave -noupdate -group IR -label temp /Processor_tb/Processor_inst/IR/temp
add wave -noupdate -group RegFile -label RegWrite /Processor_tb/Processor_inst/RegFile/in_RegWrite
add wave -noupdate -group RegFile -label in_data /Processor_tb/Processor_inst/RegFile/in_Data
add wave -noupdate -group RegFile -label in_rs1 /Processor_tb/Processor_inst/RegFile/in_ReadReg1
add wave -noupdate -group RegFile -label in_rs2 /Processor_tb/Processor_inst/RegFile/in_ReadReg2
add wave -noupdate -group RegFile -label in_writeAddress /Processor_tb/Processor_inst/RegFile/in_WriteAddr
add wave -noupdate -group RegFile -label out_rs1 /Processor_tb/Processor_inst/RegFile/out_ReadData1
add wave -noupdate -group RegFile -label out_rs2 /Processor_tb/Processor_inst/RegFile/out_ReadData2
add wave -noupdate -group RegFile -label j /Processor_tb/Processor_inst/RegFile/j
add wave -noupdate -group RegFile -label i /Processor_tb/Processor_inst/RegFile/i
add wave -noupdate -group ImmediateGenie -label in_instr /Processor_tb/Processor_inst/ALUOperations/UUT_ImmGenie/In_Inst
add wave -noupdate -group ImmediateGenie -label out_imm /Processor_tb/Processor_inst/ALUOperations/UUT_ImmGenie/Out_Imm
add wave -noupdate -group ImmediateGenie -label out_si /Processor_tb/Processor_inst/ALUOperations/UUT_ImmGenie/Out_Si
add wave -noupdate -expand -group ALUControl -label in_si /Processor_tb/Processor_inst/ALUOperations/UUT_ALUControl/In_Si
add wave -noupdate -expand -group ALUControl -label in_opcode /Processor_tb/Processor_inst/ALUOperations/UUT_ALUControl/In_Inst
add wave -noupdate -expand -group ALUControl -label out_aluop /Processor_tb/Processor_inst/ALUOperations/UUT_ALUControl/Out_ALUCtrl
add wave -noupdate -expand -group ALU -label in_A /Processor_tb/Processor_inst/ALUOperations/UUT_ALU/In_A
add wave -noupdate -expand -group ALU -label in_B /Processor_tb/Processor_inst/ALUOperations/UUT_ALU/In_B
add wave -noupdate -expand -group ALU -label in_aluop /Processor_tb/Processor_inst/ALUOperations/UUT_ALU/In_ALUCtrl
add wave -noupdate -expand -group ALU -label out_aluresult /Processor_tb/Processor_inst/ALUOperations/UUT_ALU/Out_ALUResult
add wave -noupdate -expand -group ALU -label out_zero /Processor_tb/Processor_inst/ALUOperations/UUT_ALU/Out_Zero
add wave -noupdate -expand -group ALUOut -label in_data /Processor_tb/Processor_inst/ALUOut/in_data
add wave -noupdate -expand -group ALUOut -label out_data /Processor_tb/Processor_inst/ALUOut/out_result
add wave -noupdate -label CLK /Processor_tb/CLK
add wave -noupdate -label RST /Processor_tb/RST
add wave -noupdate -label In_data /Processor_tb/in_data
add wave -noupdate -label out_data /Processor_tb/out_result
add wave -noupdate -expand -group Control -group Control -label PCSource /Processor_tb/Processor_inst/control/PCSource
add wave -noupdate -expand -group Control -group Control -label ALUSrcB /Processor_tb/Processor_inst/control/ALUSrcB
add wave -noupdate -expand -group Control -group Control -label ALUSrcA /Processor_tb/Processor_inst/control/ALUSrcA
add wave -noupdate -expand -group Control -group Control -label MemtoReg /Processor_tb/Processor_inst/control/MemtoReg
add wave -noupdate -expand -group Control -group Control -label RegDst /Processor_tb/Processor_inst/control/RegDst
add wave -noupdate -expand -group Control -group Control -label RegWrite /Processor_tb/Processor_inst/control/RegWrite
add wave -noupdate -expand -group Control -group Control -label MemRead /Processor_tb/Processor_inst/control/MemRead
add wave -noupdate -expand -group Control -group Control -label MemWrite /Processor_tb/Processor_inst/control/MemWrite
add wave -noupdate -expand -group Control -group Control -label IorD /Processor_tb/Processor_inst/control/IorD
add wave -noupdate -expand -group Control -group Control -label IRWrite /Processor_tb/Processor_inst/control/IRWrite
add wave -noupdate -expand -group Control -group Control -label PCWrite /Processor_tb/Processor_inst/control/PCWrite
add wave -noupdate -expand -group Control -group Control -label PCWriteControl /Processor_tb/Processor_inst/control/PCWriteCond
add wave -noupdate -expand -group Control -group Control -label OutputSig /Processor_tb/Processor_inst/control/OutputSig
add wave -noupdate -expand -group Control -group Control -label in_opcode /Processor_tb/Processor_inst/control/Opcode
add wave -noupdate -expand -group Control -label CurrentState /Processor_tb/Processor_inst/control/current_state
add wave -noupdate -expand -group Control -label NextState /Processor_tb/Processor_inst/control/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {38 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {192 ps}
