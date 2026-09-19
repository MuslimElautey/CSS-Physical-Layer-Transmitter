#############################################################
# routing.tcl
#############################################################

set design         "zigbee_phy_tx"
set prev_stage     "cts"
set current_stage  "routing"

open_lib ../../2_design_lib/results/${design}.dlib
open_block ${design}_${prev_stage}

# Create a new working copy for floorplan work 
copy_block -from_block ${design}_${prev_stage} -to_block ${design}_${current_stage}.design
current_block ${design}_${current_stage}.design
start_gui 

# Files handling
sh rm    -r ../results/reports
sh rm    -r ../results/outputs
sh mkdir -p ../results/reports
sh mkdir -p ../results/outputs


# ###################################### #
# ============= Tool Setup ============= #
# ###################################### #

set_host_option -max_cores 12

# ###################################### #
# ============= Pre-Route ============== #
# ###################################### #

# check for any issues that might cause problems during routing
check_routability
check_design -checks pre_route_stage
set_ignored_layers -max M9 -min M2

# ###################################### #
# ====================================== #
# ###################################### #

# --- Enable Timing Driven        # ===== Timing ===== #
#set_app_options -name route.global.timing_driven       -value true
#set_app_options -name route.track.timing_driven        -value true
#set_app_options -name route.detail.timing_driven       -value true

# --- Enable crosstalk-aware routing    # ===== Cross Talk ===== #
#set_app_options -name route.global.crosstalk_driven    -value true
#set_app_options -name route.track.crosstalk_driven     -value true
# --- Timing Analysis
#set_app_options -name time.si_enable_analysis          -value true
#set_app_options -name time.all_clocks_propagated       -value true

# --- Complex Design high advanced TEchnology >> DRCs = 0


# --- Simple design low Technology
                          # ===== DRC ===== #
# --- Improve DRC convergence
set_app_options -name route.detail.eco_max_number_of_iterations  -value 20 
#set_app_options -name route.detail.drc_convergence_effort_level  -value high

# --- drc spacing by metal patching
#set_app_options -name route.detail.enable_drc_from_fixed_shapes -value true

# ===== CCD ===== #
# --- Enable concurrent clock and data optimization helps setup timing closure
#set_app_options -name route_opt.flow.enable_ccd                        -value true
# --- fix clock transition and capacitance violations already on
#set_app_options -name route_opt.flow.enable_ccd_clock_drc_fixing       -value auto
#set_app_options -name refine_opt.hold.effort -value "high"

#set_app_options -list {route_opt.flow.enable_cto {true}}
#set_app_options -list {route_opt.flow.enable_targeted_ccd_wns_optimization {true}}
#set_app_options -list {route_opt.flow.enable_ccd {true}}

# ===== Naming ===== #
# --- Disabling the advanced legalization engine
set_app_options -name place.legalize.enable_advanced_legalizer   -value false

# ===== Naming ===== #
# --- Prefix-Routing
set_app_options -name opt.common.user_instance_name_prefix              -value "ROUTE_"

# ###################################### #
# ============= Optimized Route ======== #
# ###################################### #
route_opt
# --- Check number of Cells inserted through Route step
sizeof_collection [get_cells "ROUTE_*"]

# # Hierarchical (top level module + sub modules)
connect_pg_net -net VDD [get_pins -hierarchical */VDD]
connect_pg_net -net VSS [get_pins -hierarchical */VSS]

# ###################################### #
# ============= Important Checks ======= #
# ###################################### #
# --- Physical DRC
check_routes 			> ../results/reports/routes.rpt
# --- Open or Short nets
check_lvs -max_errors 0 	> ../results/reports/lvs_errors.rpt
# --- PG_DRC
check_pg_drc 			> ../results/reports/pg_drc.rpt
check_pg_connectivity 		> ../results/reports/pg_connectivity.rpt
# ---
check_legality 			> ../results/reports/legality.rpt

# ###################################### #
# ============= DECAP Cell ============= #
# ###################################### #
set dcap_fillers       [get_lib_cell */DCAP*]
create_stdcell_fillers -lib_cells $dcap_fillers \
                       -utilization 30          \
                       -prefix "DECAP_"         \
                       -post_eco

connect_pg_net -net "VDD" [get_pins -hierarchical "*/VDD*"]
connect_pg_net -net "VSS" [get_pins -hierarchical "*/VSS*"]

connect_pg_net -automatic
remove_stdcell_fillers_with_violation

# --- Verify updates
check_lvs -max_errors 0
check_routes
check_legality
check_pg_drc

# ###################################### #
# ============= Filler Cell ============ #
# ###################################### #
set std_fillers [get_lib_cell */SHFILL*]
set_attribute [get_lib_cells */SHFILL*] dont_touch false
set_attribute [get_lib_cells */SHFILL*] dont_use false

set std_fillers_128 "saed90nm_max/SHFILL128"
set std_fillers_64  "saed90nm_max/SHFILL64"
set std_fillers_3   "saed90nm_max/SHFILL3"
set std_fillers_2   "saed90nm_max/SHFILL2"
set std_fillers_1   "saed90nm_max/SHFILL1"

# --- insert non-metal fillers
create_stdcell_fillers -lib_cells $std_fillers_128 \
                       -prefix "FILLER128_"        \
                       -post_eco                   \
                       -continue_on_error

create_stdcell_fillers -lib_cells $std_fillers_64 \
                       -prefix "FILLER64_"       \
                       -post_eco                 \
                       -continue_on_error

create_stdcell_fillers -lib_cells $std_fillers_3 \
                       -prefix "FILLER3_"        \
                       -post_eco                 \
                       -continue_on_error

create_stdcell_fillers -lib_cells $std_fillers_2 \
                       -utilization 100          \
                       -prefix "FILLER2_"        \
                       -post_eco                 \
                       -continue_on_error        \
                       -rules no_1x

create_stdcell_fillers -lib_cells $std_fillers_1 \
                       -prefix "FILLER1_"        \
                       -post_eco                 \
                       -continue_on_error        \
                       -rules no_1x

connect_pg_net -net "VSS" [get_pins -hierarchical "*/VSS"]
connect_pg_net -net "VDD" [get_pins -hierarchical "*/VDD*"]

remove_stdcell_fillers_with_violation



#######################################################################
	# --------------- Important Checks and reports ------------- #
#######################################################################
check_pg_drc 				> ../results/reports/pg_drc.rpt 
check_pg_connectivity                   > ../results/reports/pg_connectivity.rpt
check_pg_missing_vias                   > ../results/reports/missing_via.rpt
check_routes -drc true 			> ../results/reports/physical_drc.rpt
report_timing                           > ../results/reports/timing.rpt
report_constraint -all_violators 	> ../results/reports/routing_violations.rpt
report_qor -summary 			> ../results/reports/qor.rpt

check_routes 				> ../results/reports/routes.rpt
check_lvs -max_errors 0 		> ../results/reports/lvs_errors.rpt
check_legality 				> ../results/reports/legality.rpt



#######################################################################
	# --------------- Save Block & outputs ------------- #
#######################################################################

write_parasitics -output 	../results/outputs/${design}.spef
write_def                	../results/outputs/${design}.def
write_verilog -include {all}   	../results/outputs/${design}.v
write_sdc -output 		../results/outputs/${design}.sdc
write_gds 			../results/outputs/${design}.gds

save_block
