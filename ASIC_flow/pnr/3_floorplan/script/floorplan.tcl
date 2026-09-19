
#############################################################
# floorplan.tcl
#############################################################

set design         "zigbee_phy_tx"
set prev_stage     "dlib"
set current_stage "floorplan"

open_lib ../../2_design_lib/results/${design}.dlib
open_block ${design}_${prev_stage}

# Create a new working copy for floorplan work 
copy_block -from_block ${design}_${prev_stage} -to_block ${design}_${current_stage}.design
current_block ${design}_${current_stage}.design
start_gui 


set_attribute [get_layers {M1 M3 M5 M7 M9 } ] routing_direction horizontal
set_attribute [get_layers {M2 M4 M6 M8 MRDL} ] routing_direction vertical
set Name_unit [get_site_defs]

set_attribute $Name_unit is_default true
set_attribute $Name_unit symmetry y 


initialize_floorplan \
    -control_type core \
    -core_utilization 0.5 \
    -shap R \
    -core_offset {10} \
    -flip_first_row true \
    -side_ratio {1 1} 


place_pins -ports [get_ports *]

sh rm -rf ../results/reports
sh mkdir -p ../results/reports


report_utilization        > ../results/reports/utilization.rpt
report_qor                > ../results/reports/qor.rpt
get_placement_blockages   > ../results/reports/blockages.rpt

save_block -as ${design}_${current_stage}  ${design}.dlib:${design}_${current_stage}.design
