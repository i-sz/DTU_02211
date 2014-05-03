onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/top_i/uart_adapter_i/MIPS_SIZE
add wave -noupdate /top_tb/top_i/uart_adapter_i/ADDR_SIZE
add wave -noupdate /top_tb/top_i/uart_adapter_i/clk
add wave -noupdate /top_tb/top_i/uart_adapter_i/rst
add wave -noupdate /top_tb/top_i/uart_adapter_i/mem_wr_ena
add wave -noupdate /top_tb/top_i/uart_adapter_i/mem_data_in
add wave -noupdate /top_tb/top_i/uart_adapter_i/to_proc_data_in
add wave -noupdate /top_tb/top_i/uart_adapter_i/to_proc_rd_ena
add wave -noupdate /top_tb/top_i/uart_adapter_i/mem_address
add wave -noupdate /top_tb/top_i/uart_adapter_i/uart_wr_ena
add wave -noupdate /top_tb/top_i/uart_adapter_i/uart_rd_ena
add wave -noupdate /top_tb/top_i/uart_adapter_i/uart_addr
add wave -noupdate /top_tb/top_i/uart_adapter_i/uart_wr_data
add wave -noupdate /top_tb/top_i/uart_adapter_i/uart_rd_data
add wave -noupdate /top_tb/top_i/uart_adapter_i/uart_rdy_cnt
add wave -noupdate -divider UART
add wave -noupdate /top_tb/top_i/uart_inst/address
add wave -noupdate /top_tb/top_i/uart_inst/wr_data
add wave -noupdate /top_tb/top_i/uart_inst/rd
add wave -noupdate /top_tb/top_i/uart_inst/wr
add wave -noupdate /top_tb/top_i/uart_inst/rd_data
add wave -noupdate /top_tb/top_i/uart_inst/rdy_cnt
add wave -noupdate /top_tb/top_i/uart_inst/txd
add wave -noupdate /top_tb/top_i/uart_inst/rxd
add wave -noupdate /top_tb/top_i/uart_inst/ncts
add wave -noupdate /top_tb/top_i/uart_inst/nrts
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {139394 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 311
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
WaveRestoreZoom {0 ps} {315 ns}
