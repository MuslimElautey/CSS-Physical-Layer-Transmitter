
set worst_case "saed90nm_max.db"
#################################################################
set_app_var search_path "/home/ICer/Downloads/Lib/synopsys/models"
set_app_var target_library "$worst_case"
set_app_var link_library "* $target_library"
#################################################################
sh rm -rf work
sh mkdir -p work
define_design_lib work -path ./work
#################################################################
set design zigbee_phy_tx
#################################################################
set_svf ${design}.svf
#################################################################
analyze -library work -format verilog [glob ../rtl/*.v]
#################################################################
elaborate $design -lib work
#################################################################
current_design $design
#################################################################
check_design
#################################################################
source -e -v ../scripts/synthesis_cons.tcl
#################################################################
#set compile_prefer_mux true
#set hdlin_infer_mux all
compile -map_effort high 
compile -map_effort high  -incremental_mapping
compile -map_effort high  -incremental_mapping
compile -map_effort high  -incremental_mapping
compile -map_effort high  -incremental_mapping
#################################################################
sh rm -rf ../results/*
sh mkdir -p ../results/reports ../results/outputs
#############################################
write -format verilog -hierarchy -output ../results/outputs/${design}.v
write -format ddc -hierarchy -output ../results/outputs/${design}.ddc
write_sdc ../results/outputs/${design}.sdc
write_sdf ../results/outputs/${design}.sdf
#################################################################
report_timing -delay_type max -capacitance -transition_time -max_paths 10 > ../results/reports/setup.rpt
report_constraint -all_violators                                           > ../results/reports/all_violators.rpt
report_timing -delay_type min  -max_paths 10  > ../results/reports/hold.rpt
report_area > ../results/reports/area.rpt
report_power > ../results/reports/power.rpt
report_clock -attributes > ../results/reports/clocks.rpt
report_constraint -all_violators > ../results/reports/constraints.rpt
##################################################################
set_svf -off

