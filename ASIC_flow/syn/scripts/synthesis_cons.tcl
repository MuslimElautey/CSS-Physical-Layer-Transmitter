create_clock -name clk -period 31.25 -waveform {0 15.625} [get_ports clk]
set_clock_uncertainty -setup 1.25 [get_clocks clk]
set_clock_uncertainty -hold 0.7 [get_clocks clk]
############################ 4% clock uncertainty##################################
set_ideal_network [get_ports clk]
set_ideal_network [get_ports reset]
#set_ideal_network [get_ports payload_din]
#set_ideal_network [get_ports payload_addr]
#set_ideal_network [get_ports u_sm_ram_Q/wr_addr]
#set_ideal_network [get_ports u_sm_ram_Q/rd_addr]
#set_ideal_network [get_ports u_sm_ram_I/wr_addr]
#set_ideal_network [get_ports u_sm_ram_I/rd_addr]
#set_ideal_network [get_ports u_sm_ram_I/data_in]
#set_ideal_network [get_ports u_sm_ram_Q/data_in]

#set_dont_touch_network [get_clocks clk]
####################################################################################
set_input_delay -clock clk -max 2.00 [remove_from_collection [all_inputs] [get_ports {clk}]]

set_output_delay -clock clk -max 2.00 [all_outputs]
#################################################################################
set_max_fanout 3 $design
##################################################################################
set_max_capacitance 50 [current_design]
##################################################################################
set_max_transition 1.00 [current_design]
#################################################################################
set_driving_cell -lib_cell IBUFFX2 [remove_from_collection [all_inputs] [get_ports {clk}]]

set_load 5 [all_outputs]
####################################################################################
set_dont_use [get_lib_cells */*AND3*]

set_wire_load_model -name ForQA -library saed90nm_max [current_design]
