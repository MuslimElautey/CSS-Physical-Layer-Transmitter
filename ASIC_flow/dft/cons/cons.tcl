
#############################################################
# DFT Constraints - i2c
#############################################################
# clock definitions
create_clock -name dft_clk_i -period 100 -waveform {0 50} [get_ports dft_clk_i]

set_clock_groups -asynchronous \
    -group [get_clocks wb_clk_i] \
    -group [get_clocks dft_clk_i]
    
#############################################################
# 1. Scan Configuration
#############################################################
# Defines HOW the scan chains will be built:
#   -style multiplexed_flip_flop : each flip-flop gets a 2:1 mux in front
#                                   of its D input (functional data vs. scan data)
#   -replace true                : allow the tool to replace existing flip-flops
#                                   with scan-capable equivalents
#   -clock_mixing no_mix         : don't mix flip-flops clocked by different
#                                   clocks into the same scan chain
#   -chain_count 1               : build a single scan chain (fine for a small
#                                   design like this; larger designs use more
#                                   chains in parallel to reduce test time)
set_scan_configuration -style multiplexed_flip_flop \
                        -replace true \
                        -clock_mixing no_mix \
                        -chain_count 1
#############################################################
# 2. Create New Top-Level Scan Ports
#############################################################
create_port -direction in  Scan_Data_In    ;# where test patterns are shifted IN
create_port -direction out Scan_Data_Out   ;# where captured results are shifted OUT
create_port -direction in  Scan_En         ;# selects functional mode vs. scan-shift mode
# Treat Scan_En as a zero-delay/ideal net for now (no real clock tree yet,
# same reasoning as set_ideal_network on fun_clk/dft_clk_i earlier)
set_ideal_network [get_ports Scan_En]

#############################################################
# 3. Case Analysis
#############################################################
# Fix test_mode = 1 for this compile pass, so the tool analyzes/optimizes
# assuming test/scan mode is active (as opposed to the functional-mode
# compile, which instead fixes test_mode = 0).
set_case_analysis 1 [get_ports test_mode]


#############################################################
# 4. DFT Signal Definitions - Existing Ports (already in the RTL)
#############################################################
# ScanClock: the clock used while shifting data through the scan chain.
# -timing {45 55} = the clock edge is expected around the 45-55% mark
#                    of the scan clock period (roughly centered).
set_dft_signal -view existing_dft -type ScanClock -port [get_ports dft_clk_i] -timing {45 55}

# Reset: dft_rst_i acts as a reset specific to test mode (NOT scan enable).
# -active 1 means the reset is active-HIGH.
set_dft_signal -view existing_dft -type Reset -port [get_ports dft_rst_i] -active 0

# TestMode: the top-level mode selector (functional vs. test).
# -active 1 means test_mode = 1 selects test mode.
set_dft_signal -view existing_dft -type TestMode -port [get_ports test_mode] -active 1

#############################################################
# 5. DFT Signal Definitions - New Ports (to be created by the tool)
#############################################################
# -view spec (vs. existing_dft above) tells the tool these ports don't
# exist yet in the netlist - it should create/wire them during scan
# insertion, using the ports we declared in section 2.
set_dft_signal -view spec -type ScanDataIn  -port [get_ports Scan_Data_In]
set_dft_signal -view spec -type ScanDataOut -port [get_ports Scan_Data_Out]
set_dft_signal -view spec -type ScanEnable -port [get_ports Scan_En] -active 1 -usage scan
#############################################################
# 6. Critical Range (optional - optimization tuning)
#############################################################
# Uncomment and set a value if you want the tool to treat paths within
# <value> ns of the critical path as "critical" too during optimization.
# set_critical_range <value> [current_design]
