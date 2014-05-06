onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/top_i/uart_inst/clk
add wave -noupdate /top_tb/top_i/uart_inst/reset
add wave -noupdate /top_tb/top_i/uart_inst/address
add wave -noupdate -radix ascii /top_tb/top_i/uart_inst/wr_data
add wave -noupdate /top_tb/top_i/uart_inst/rd
add wave -noupdate /top_tb/top_i/uart_inst/wr
add wave -noupdate /top_tb/top_i/uart_inst/rd_data
add wave -noupdate /top_tb/top_i/uart_inst/rdy_cnt
add wave -noupdate /top_tb/top_i/uart_inst/txd
add wave -noupdate /top_tb/top_i/uart_inst/rxd
add wave -noupdate /top_tb/top_i/uart_inst/ncts
add wave -noupdate /top_tb/top_i/uart_inst/nrts
add wave -noupdate /top_tb/top_i/uart_inst/ua_dout
add wave -noupdate /top_tb/top_i/uart_inst/ua_wr
add wave -noupdate /top_tb/top_i/uart_inst/tdre
add wave -noupdate /top_tb/top_i/uart_inst/ua_rd
add wave -noupdate /top_tb/top_i/uart_inst/rdrf
add wave -noupdate /top_tb/top_i/uart_inst/uart_tx_state
add wave -noupdate /top_tb/top_i/uart_inst/tf_dout
add wave -noupdate /top_tb/top_i/uart_inst/tf_rd
add wave -noupdate /top_tb/top_i/uart_inst/tf_empty
add wave -noupdate /top_tb/top_i/uart_inst/tf_full
add wave -noupdate /top_tb/top_i/uart_inst/tf_half
add wave -noupdate /top_tb/top_i/uart_inst/ncts_buf
add wave -noupdate /top_tb/top_i/uart_inst/tsr
add wave -noupdate /top_tb/top_i/uart_inst/tx_clk
add wave -noupdate /top_tb/top_i/uart_inst/uart_rx_state
add wave -noupdate /top_tb/top_i/uart_inst/rf_wr
add wave -noupdate /top_tb/top_i/uart_inst/rf_empty
add wave -noupdate /top_tb/top_i/uart_inst/rf_full
add wave -noupdate /top_tb/top_i/uart_inst/rf_half
add wave -noupdate /top_tb/top_i/uart_inst/rxd_reg
add wave -noupdate /top_tb/top_i/uart_inst/rx_buf
add wave -noupdate /top_tb/top_i/uart_inst/rx_d
add wave -noupdate /top_tb/top_i/uart_inst/rsr
add wave -noupdate /top_tb/top_i/uart_inst/rx_clk
add wave -noupdate /top_tb/top_i/uart_inst/rx_clk_ena
add wave -noupdate /top_tb/top_i/uart_inst/parity_mode
add wave -noupdate /top_tb/top_i/uart_inst/parity_error
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2463 ns} 0}
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
WaveRestoreZoom {6240 ns} {10440 ns}
