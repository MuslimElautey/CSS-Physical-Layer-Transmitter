################################################################################
#
# Design name:  zigbee_phy_tx_cts
#
# Created by icc2 write_sdc on Thu Sep 17 22:50:18 2026
#
################################################################################

set sdc_version 2.1
set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA

################################################################################
#
# Units
# time_unit               : 1e-09
# resistance_unit         : 1000000
# capacitive_load_unit    : 1e-15
# voltage_unit            : 1
# current_unit            : 1e-06
# power_unit              : 1e-12
################################################################################


# Mode: default
# Corner: default
# Scenario: default

# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 60
create_clock -name clk -period 31.25 -waveform {0 15.625} [get_ports {clk}]
set_propagated_clock [get_clocks {clk}]
set_load -pin_load 5 [get_ports {done_Tx}]
set_load -pin_load 5 [get_ports {Tx_real[7]}]
set_load -pin_load 5 [get_ports {Tx_real[6]}]
set_load -pin_load 5 [get_ports {Tx_real[5]}]
set_load -pin_load 5 [get_ports {Tx_real[4]}]
set_load -pin_load 5 [get_ports {Tx_real[3]}]
set_load -pin_load 5 [get_ports {Tx_real[2]}]
set_load -pin_load 5 [get_ports {Tx_real[1]}]
set_load -pin_load 5 [get_ports {Tx_real[0]}]
set_load -pin_load 5 [get_ports {Tx_imag[7]}]
set_load -pin_load 5 [get_ports {Tx_imag[6]}]
set_load -pin_load 5 [get_ports {Tx_imag[5]}]
set_load -pin_load 5 [get_ports {Tx_imag[4]}]
set_load -pin_load 5 [get_ports {Tx_imag[3]}]
set_load -pin_load 5 [get_ports {Tx_imag[2]}]
set_load -pin_load 5 [get_ports {Tx_imag[1]}]
set_load -pin_load 5 [get_ports {Tx_imag[0]}]
set_load -pin_load 5 [get_ports {sample_valid}]
# Set latency for io paths.
# -origin user
set_clock_latency -min 2.5003 [get_clocks {clk}]
# -origin user
set_clock_latency -max 2.6313 [get_clocks {clk}]
# Set propagated on clock sources to avoid removing latency for IO paths.
set_propagated_clock  [get_ports {clk}]
set_clock_uncertainty -setup 1.25 [get_clocks {clk}]
set_clock_uncertainty -hold 0.7 [get_clocks {clk}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 13
set_driving_cell -lib_cell IBUFFX2 [get_ports {reset}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 14
set_driving_cell -lib_cell IBUFFX2 [get_ports {start_Tx}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 15
set_driving_cell -lib_cell IBUFFX2 [get_ports {payloadLength[7]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 16
set_driving_cell -lib_cell IBUFFX2 [get_ports {payloadLength[6]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 17
set_driving_cell -lib_cell IBUFFX2 [get_ports {payloadLength[5]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 18
set_driving_cell -lib_cell IBUFFX2 [get_ports {payloadLength[4]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 19
set_driving_cell -lib_cell IBUFFX2 [get_ports {payloadLength[3]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 20
set_driving_cell -lib_cell IBUFFX2 [get_ports {payloadLength[2]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 21
set_driving_cell -lib_cell IBUFFX2 [get_ports {payloadLength[1]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 22
set_driving_cell -lib_cell IBUFFX2 [get_ports {payloadLength[0]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 23
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_din[7]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 24
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_din[6]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 25
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_din[5]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 26
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_din[4]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 27
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_din[3]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 28
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_din[2]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 29
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_din[1]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 30
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_din[0]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 31
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_addr[7]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 32
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_addr[6]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 33
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_addr[5]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 34
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_addr[4]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 35
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_addr[3]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 36
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_addr[2]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 37
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_addr[1]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 38
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_addr[0]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 39
set_driving_cell -lib_cell IBUFFX2 [get_ports {payload_wr_en}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 63
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {reset}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 64
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {start_Tx}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 65
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payloadLength[7]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 66
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payloadLength[6]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 67
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payloadLength[5]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 68
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payloadLength[4]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 69
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payloadLength[3]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 70
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payloadLength[2]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 71
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payloadLength[1]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 72
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payloadLength[0]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 73
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_din[7]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 74
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_din[6]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 75
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_din[5]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 76
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_din[4]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 77
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_din[3]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 78
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_din[2]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 79
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_din[1]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 80
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_din[0]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 81
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_addr[7]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 82
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_addr[6]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 83
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_addr[5]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 84
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_addr[4]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 85
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_addr[3]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 86
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_addr[2]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 87
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_addr[1]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 88
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_addr[0]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 89
set_input_delay -clock [get_clocks {clk}] -max 2 [get_ports {payload_wr_en}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 90
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {done_Tx}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 91
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_real[7]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 92
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_real[6]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 93
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_real[5]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 94
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_real[4]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 95
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_real[3]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 96
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_real[2]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 97
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_real[1]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 98
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_real[0]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 99
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_imag[7]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 100
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_imag[6]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 101
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_imag[5]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 102
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_imag[4]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 103
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_imag[3]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 104
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_imag[2]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 105
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_imag[1]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 106
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {Tx_imag[0]}]
# /mnt/hgfs/VM_Shared/Projects/Assignments/zigbee_phy_tx/syn/outputs/zigbee_phy_tx.sdc, \
#   line 107
set_output_delay -clock [get_clocks {clk}] -max 2 [get_ports {sample_valid}]
set_max_transition 1 [current_design]
set_max_transition 1 [get_clocks {clk}] -clock_path
set_max_capacitance 50 [current_design]
