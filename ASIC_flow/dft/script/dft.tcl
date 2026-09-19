
#dft.tcl
#############################################################
# 1. Library Setup
#############################################################
set_app_var search_path  [list . /home/ICer/Downloads/Lib/synopsys/models $search_path]
set_app_var target_library {saed90nm_max.db}
set_app_var link_library    "* $target_library"

#############################################################
# 2. Read Synthesized Design
#############################################################
sh rm -rf work
sh mkdir -p work
define_design_lib work -path ./work

set design i2c_master_top
set_svf ../results/${design}.svf
#netlist & wires
read_ddc ../../syn/results/${design}.ddc
current_design $design
link 
#const 
read_sdc ../../syn/results/${design}.sdc
current_design $design

set_fix_multiple_port_nets -all -buffer_constants

set_dp_smartgen_options -optimize_for speed

set_critical_range 1 $design

compile -scan -map_effort high 
#############################################################
# 4. Apply Constraints
#############################################################
source -echo -verbose ../cons/cons.tcl

create_test_protocol

dft_drc

insert_dft

dft_drc -coverage_estimate

compile -scan -map_effort high 
#############################################################
# Reports
#############################################################
report_scan_path                              > ../log/scan_path.rpt
report_dft_signal                             > ../log/dft_signal.rpt
dft_drc -coverage_estimate                    > ../log/dft_coverage.rpt
report_timing -delay_type max -transition_time -capacitance   > ../log/dft_timing.rpt
report_timing -max_paths 10 -delay_type max          > ../log/dft_setup.rpt
report_timing -max_paths 10 -delay_type min          > ../log/dft_hold.rpt
report_power   -hierarchy                            > ../log/dft_power.rpt
report_area                                   > ../log/dft_area.rpt
report_constraint -all_violators              > ../log/dft_violations.rpt


#############################################################
# Write Outputs
#############################################################
change_names -rules verilog -hierarchy

write -format verilog -hierarchy -output ../results/${design}_netlist.v
write_sdc  ../results/${design}.sdc
write -format ddc -hierarchy -output ../results/${design}.ddc
write_sdf  ../results/${design}.sdf

write_test_model    -output ../results/${design}.ctl
write_test_protocol -output ../results/${design}.spf
write_scan_def      -output ../results/${design}.def

set_svf -off 




