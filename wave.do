onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider FETCH
add wave -noupdate /top_tb/top_i/mips_inst/instr_fetch_i/clk
add wave -noupdate /top_tb/top_i/mips_inst/instr_fetch_i/rst
add wave -noupdate /top_tb/top_i/mips_inst/instr_fetch_i/pc_sel
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/instr_fetch_i/pc_addr_in
add wave -noupdate /top_tb/top_i/mips_inst/instr_fetch_i/pc_addr_out
add wave -noupdate /top_tb/top_i/mips_inst/instr_fetch_i/instr
add wave -noupdate /top_tb/top_i/mips_inst/instr_fetch_i/PC_tmp1
add wave -noupdate /top_tb/top_i/mips_inst/instr_fetch_i/PC_tmp3
add wave -noupdate /top_tb/top_i/mips_inst/instr_fetch_i/Instr_tmp
add wave -noupdate /top_tb/top_i/mips_inst/instr_fetch_i/PC_tmp2
add wave -noupdate -divider DECODE
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/clk
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/rst
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/rw
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/r1_addr
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/r2_addr
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/r3_addr
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/wr_data
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/reg_1
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/reg_2
add wave -noupdate -radix unsigned -childformat {{/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(31) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(30) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(29) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(28) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(27) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(26) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(25) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(24) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(23) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(22) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(21) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(20) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(19) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(18) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(17) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(16) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(15) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(14) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(13) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(12) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(11) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(10) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(9) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(8) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(7) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(6) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(5) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(4) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(3) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(2) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(1) -radix unsigned} {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(0) -radix unsigned}} -expand -subitemconfig {/top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(31) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(30) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(29) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(28) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(27) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(26) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(25) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(24) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(23) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(22) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(21) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(20) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(19) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(18) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(17) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(16) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(15) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(14) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(13) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(12) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(11) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(10) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(9) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(8) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(7) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(6) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(5) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(4) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(3) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(2) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(1) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers(0) {-height 15 -radix unsigned}} /top_tb/top_i/mips_inst/instr_decode_i/register_file_i/registers
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/clk
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/rst
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/instr
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/reg_2_data
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/reg_3_data
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/wr_flag
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/reg1_wb_addr
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/reg1_wb_data
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/reg_1_addr
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/pc_addr_in
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/pc_addr_out
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/pc_sel_out
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/sign_extend
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/alu_ctrl
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/alu_src
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/wr_to_mem
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/rd_from_mem
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/branch
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/wb_reg_o
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/reg_1_p
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/reg_2_p
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/reg_3_p
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/reg_2data
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/reg_3data
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/alu_ctrl_p
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/sign_extend_p
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/alu_src_s
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/pc_sel_p
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/branch_s
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/wb_reg
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/wr_to_mem_s
add wave -noupdate /top_tb/top_i/mips_inst/instr_decode_i/rd_from_mem_s
add wave -noupdate -divider EXECUTE
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/clk
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/rst
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/execute_i/a
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/execute_i/b
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/reg3_addr_i
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/reg3_addr_o
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/sign_extend
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/alu_ctrl
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/alu_src
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/pc_addr_in
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/pc_sel_in
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/execute_i/alu_result
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/pc_sel_out
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/pc_address_out
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/b_out
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/wr_to_mem
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/rd_from_mem
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/memory_wr
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/branch_i
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/branch_o
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/wb_reg_i
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/wb_reg_o
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/execute_i/input_a
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/execute_i/input_b
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/execute_i/branch_address
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/execute_i/jump_or_branch_address
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/execute_i/alu_result_p
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/ctrl_p
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/ab_test
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/pc_sel_actual
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/execute_i/sign_extend_shifted
add wave -noupdate -divider MEMORYACC
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/clk
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/rst
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/ramdata_in
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/ram_write
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/addr
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/ram_read
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/ramdata_out
add wave -noupdate -radix unsigned -childformat {{/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(31) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(30) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(29) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(28) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(27) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(26) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(25) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(24) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(23) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(22) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(21) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(20) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(19) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(18) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(17) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(16) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(15) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(14) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(13) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(12) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(11) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(10) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(9) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(8) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(7) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(6) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(5) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(4) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(3) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(2) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(1) -radix unsigned} {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(0) -radix unsigned}} -expand -subitemconfig {/top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(31) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(30) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(29) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(28) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(27) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(26) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(25) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(24) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(23) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(22) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(21) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(20) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(19) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(18) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(17) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(16) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(15) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(14) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(13) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(12) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(11) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(10) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(9) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(8) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(7) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(6) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(5) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(4) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(3) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(2) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(1) {-height 15 -radix unsigned} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram(0) {-height 15 -radix unsigned}} /top_tb/top_i/mips_inst/memory_access_i/Data_Mem_RAM/block_ram
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/clk
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/rst
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/wr
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/rd
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/memory_access_i/reg3_addr_i
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/memory_access_i/reg3_addr_o
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/memory_access_i/addr_in
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/memory_access_i/addr_out
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/memory_access_i/wr_data
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/memory_access_i/rd_data
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/wr_to_mem
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/branch_i
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/branch_o
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/wb_reg_i
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/wb_reg_o
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/memory_access_i/rd_data_s
add wave -noupdate -divider WB
add wave -noupdate /top_tb/top_i/mips_inst/write_back_i/clk
add wave -noupdate /top_tb/top_i/mips_inst/write_back_i/rst
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/write_back_i/rd_data
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/write_back_i/alu_result
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/write_back_i/wr_reg_in
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/write_back_i/wr_reg_out
add wave -noupdate /top_tb/top_i/mips_inst/write_back_i/wr_flag
add wave -noupdate -radix unsigned /top_tb/top_i/mips_inst/write_back_i/wr_data
add wave -noupdate /top_tb/top_i/mips_inst/write_back_i/wr_mem_wb
add wave -noupdate /top_tb/top_i/mips_inst/execute_i/memory_rd
add wave -noupdate /top_tb/top_i/mips_inst/memory_access_i/rd_from_mem
add wave -noupdate /top_tb/top_i/mips_inst/write_back_i/rd_mem_wb
add wave -noupdate /top_tb/top_i/mips_inst/write_back_i/branch
add wave -noupdate /top_tb/top_i/mips_inst/write_back_i/wb_reg_i
add wave -noupdate -radix binary /top_tb/top_i/uart_inst/address
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7535 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 63
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
configure wave -timelineunits ns
update
WaveRestoreZoom {7274 ns} {7668 ns}
