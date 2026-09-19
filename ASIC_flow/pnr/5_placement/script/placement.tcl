
#############################################################
# placement.tcl
#############################################################

set design         "zigbee_phy_tx"
set prev_stage     "powerplan"
set current_stage  "placement"

open_lib ../../2_design_lib/results/${design}.dlib
open_block ${design}_${prev_stage}

# Create a new working copy for floorplan work 
copy_block -from_block ${design}_${prev_stage} -to_block ${design}_${current_stage}.design
current_block ${design}_${current_stage}.design
start_gui 



check_pg_connectivity -check_std_cell_pin none 

check_pg_drc -ignore_std_cells 

check_pg_missing_vias 

check_design -checks pre_placement_stage

#set_app_options -list {clock_opt.place.effort {high}}
 
 #set_app_options -list {place.coarse.congestion_driven_max_util {0.4}}
 set_app_options -list {place.coarse.max_density {0.3}}
 set_app_options -list {place.coarse.continue_on_missing_scandef {true}}
 set_app_options -list {place.coarse.detect_detours {true}}
 set_app_options -list {place.coarse.legalizer_driven_placement {true}}

 set_app_options -list {place.legalize.enable_vertical_abutment_rules {true}}
 set_app_options -list {place.legalize.enable_advanced_legalizer {true}}

set_app_options -list {opt.common.max_fanout {10}}
set_app_options -list {opt.tie_cell.max_fanout {2}}
set_app_options -list {opt.common.user_instance_name_prefix {PLACE_}}
set_app_options -name opt.common.user_instance_name_prefix -value "PLACE_" 


report_ideal_network 
remove_ideal_network {reset}
report_ideal_network 

report_net_fanout -threshold 20


#set_placement_mode -mode auto

create_placement -effort high -timing_driven  -congestion -incremental -congestion_effort high 

legalize_placement -incremental 

report_net_fanout -threshold 20 

report_attribute -application -nosplit [get_lib_cells */*TIE*] > TIE_attribute.rpt

place_opt 

sizeof_collection [get_cells "PLACE_*"]


#############################################################
# Spare Cells and Tie Cells
#############################################################

# Allow TIE cells to be used
set_attribute [get_lib_cells */*TIE*] dont_touch false
set_attribute [get_lib_cells */*TIE*] dont_use false


#############################################################
# Check available spare-cell libraries
#############################################################

get_lib_cells */NAND2X1
get_lib_cells */NOR2X1
get_lib_cells */INVX1
get_lib_cells */OR2X1
get_lib_cells */SDFFX1


#############################################################
# Add Spare Cells
#############################################################

add_spare_cells \
    -num_cells {
        NAND2X1 4
        NOR2X1  4
        INVX1   4
        OR2X1   4
        SDFFX1  4
    } \
    -cell_name SpareCell \
    -random_distribution \
    -input_pin_connect_type tie_low


#############################################################
# Get Spare Cells
#############################################################

set spare_cells [get_cells *SpareCell*]

puts "Number of spare cells = [sizeof_collection $spare_cells]"


#############################################################
# Spread and Legalize Spare Cells
#############################################################

spread_spare_cells -cells $spare_cells

place_eco_cells \
    -cells $spare_cells \
    -legalize_only

legalize_placement -incremental

connect_pg_net -net VDD [get_pins -hierarchical */VDD]
connect_pg_net -net VSS [get_pins -hierarchical */VSS]
#############################################################
# Protect Spare Cells
#############################################################

set_dont_touch $spare_cells


#############################################################
# Find TIE Cells
#############################################################

set tie_cells_low  [get_lib_cells */*TIEL*]
set tie_cells_high [get_lib_cells */*TIEH*]

puts "TIE LOW cells  = [sizeof_collection $tie_cells_low]"
puts "TIE HIGH cells = [sizeof_collection $tie_cells_high]"


#############################################################
# Connect Spare Cells to TIE cells
#############################################################

add_tie_cells \
    -objects $spare_cells \
    -tie_low_lib_cells $tie_cells_low \
    -tie_high_lib_cells $tie_cells_high

  legalize_placement -incremental


connect_pg_net -net VDD [get_pins -hierarchical */VDD]
connect_pg_net -net VSS [get_pins -hierarchical */VSS]
### 

sh rm -rf ../results/reports
sh mkdir -p ../results/reports

report_cell  > ../results/reports/cell_placement.rpt
report_nets > ../results/reports/net_placement.rpt
report_qor > ../results/reports/qor_placement.rpt
report_timing > ../results/reports/timing_placement.rpt
report_timing -delay max -max_paths 5  > ../results/reports/timing_placement_max.rpt
report_utilization > ../results/reports/utilization_placement.rpt
get_placement_blockages > ../results/reports/blockages_placement.rpt
check_pg_drc                    > ../results/reports/pg_drc.rpt
check_pg_connectivity           > ../results/reports/pg_connectivity.rpt
check_pg_missing_vias           > ../results/reports/missing_via.rpt


write_def  ../results/${design}.def 
write_verilog -include {all}  ../results/${design}.v
write_sdc -output ../results/${design}.sdc

save_block -as ${design}_${current_stage}  ${design}.dlib:${design}_${current_stage}.design



