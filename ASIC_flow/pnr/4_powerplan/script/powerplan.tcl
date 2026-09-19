
#############################################################
# powerplan.tcl
#############################################################

set design         "zigbee_phy_tx"
set prev_stage     "floorplan"
set current_stage  "powerplan"

open_lib ../../2_design_lib/results/${design}.dlib
open_block ${design}_${prev_stage}

# Create a new working copy for floorplan work 
copy_block -from_block ${design}_${prev_stage} -to_block ${design}_${current_stage}.design
current_block ${design}_${current_stage}.design
start_gui 

remove_pg_via_master_rules -all
remove_pg_patterns -all
remove_pg_strategies  -all
remove_pg_strategy_via_rules  -all
remove_pg_regions -all



set ring_width 3
set ring_spacing  2
set hm_top M9
set vm_top M8

create_net -power  VDD
create_net -ground VSS

set_attribute [get_nets VDD] net_type power
set_attribute [get_nets VSS] net_type ground

get_attribute [get_nets VDD] net_type
get_attribute [get_nets VSS] net_type

create_pg_ring_pattern ring_pattern \
  -horizontal_layer $hm_top  -vertical_layer $vm_top \
  -horizontal_width $ring_width   -vertical_width $ring_width \
  -horizontal_spacing $ring_spacing -vertical_spacing $ring_spacing
  
 set_pg_strategy core_ring   -core -pattern {{name:ring_pattern} {nets : "VSS VDD"}}
 #set_pg_strategy core_ring   -design_boundary -pattern {{name:ring_pattern} {nets : "VSS VDD"}}

#  set_pg_strategy core_ring \
#     -polygon {{10 10} {649.3600 10} {649.3600 649.3600} {10 649.3600}} \
#     -pattern {{name:ring_pattern} {nets : "VSS VDD"}}

 compile_pg -strategies core_ring



create_pg_mesh_pattern straps_vddvss\
  -layers { \
               {{horizontal_layer: M9}{width: 2} \
                   {spacing: interleaving} {pitch: 20} {offset:0.856} {trim:true}} \
               {{vertical_layer: M8}{width: 2} \
                   {spacing: interleaving}{pitch: 20} {offset: 0.856} {trim:true}} \
            } 
set_pg_strategy mesh_vddvss -core \
 -pattern {{ pattern:straps_vddvss}{nets : VSS VDD }} \
 -extension {{stop: design_boundary_and_generate_pin}}

 compile_pg -strategies mesh_vddvss


# ##################################################
# ============= Rails VDD/VSS ======================
# ##################################################
# --- Variables
set rail_startegie rails_M1;
set rail_pattern   std_cell_rail;
set rail_layer     M1;
set rail_width     0.16;

# ---- Create rails {Layer , Width}
create_pg_std_cell_conn_pattern $rail_pattern -layers $rail_layer -rail_width $rail_width

# ---- Define Strategie
set_pg_strategy $rail_startegie -core -pattern {{pattern: std_cell_rail} {nets: {VDD VSS}}}
# --- Connect pins of cells and submodules to rails
# hierarchical [include top module + sub modules]
connect_pg_net -net VDD [get_pins -hierarchical */VDD]
connect_pg_net -net VSS [get_pins -hierarchical */VSS]
# --- compile stratege
compile_pg -strategies $rail_startegie


# --- Verify routing of PG nets satisfies technology design rules
check_pg_drc
# --- Connectivity check for PG networks, standard cell PG pins, PG pads, and...
check_pg_connectivity
check_pg_missing_vias



sh rm -rf ../results/reports
sh mkdir -p ../results/reports


check_pg_drc                    > ../results/reports/pg_drc.rpt
check_pg_connectivity           > ../results/reports/pg_connectivity.rpt
check_pg_missing_vias           > ../results/reports/missing_via.rpt






save_block -as ${design}_${current_stage}  ${design}.dlib:${design}_${current_stage}.design





