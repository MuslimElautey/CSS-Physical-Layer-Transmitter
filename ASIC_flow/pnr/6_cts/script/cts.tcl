#############################################################
# cts.tcl
#############################################################

set design         "zigbee_phy_tx"
set prev_stage     "placement"
set current_stage  "cts"

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

#######################################################################
	# --------------- Tool setup ------------- #
#######################################################################
set_host_option -max_cores 12;            # multi threading is used to get the results faster (must be a high-end laptop)


#######################################################################
	# --------------- Pre-CTS Checks ------------- #
#######################################################################
report_qor -summary 			 > ../results/reports/qor_pre_cts.rpt

# Clock sources
report_clocks 				 > ../results/reports/clocks.rpt

# setting the routing resources for CTS to be only on the layers from M3 to M8 (using a stack of vias to route the clock pin "from M1" on M3)
set_ignored_layers -max_routing_layer M8 -min_routing_layer M3


#######################################################################
	# --------------- CTS Cells ------------- #
#######################################################################

# Excluding all cells in the library from CTS and hold (hold can be fixed later in routing)
set_lib_cell_purpose -exclude cts 		[get_lib_cells */*]
set_lib_cell_purpose -exclude hold 		[get_lib_cells */*]


# Preferred (High drive strength and INV cells)
# INV preferred to resistance of wire interconnect and transitions 
# CTS purpose 
set_lib_cell_purpose -include cts { saed90nm_max/IBUFFX2 saed90nm_max/IBUFFX4 saed90nm_max/IBUFFX8 saed90nm_max/IBUFFX16 saed90nm_max/IBUFFX32 } 
set_lib_cell_purpose -include cts { saed90nm_max/NBUFFX2 saed90nm_max/NBUFFX4 saed90nm_max/NBUFFX8 saed90nm_max/NBUFFX16 saed90nm_max/NBUFFX32 }
set_lib_cell_purpose -include cts { saed90nm_max/INVX2   saed90nm_max/INVX4   saed90nm_max/INVX8   saed90nm_max/INVX16   saed90nm_max/INVX32   }

# Hold Purpose (delay cells)
set_lib_cell_purpose -include hold 	[get_lib_cells */*DELLN* ]



#######################################################################
	# --------------- NDR ------------- #
#######################################################################

# Defines non-default routing rules in the design
create_routing_rule clk_network_NDR_root 	-multiplier_spacing 2 -multiplier_width 2
create_routing_rule clk_network_NDR_internal 	-multiplier_spacing 2 -multiplier_width 2


# root: from port to first buffer
set_clock_routing_rules -net_type root 				\
			-clocks {clk} 			\
			-rules clk_network_NDR_root 		\
			-max_routing_layer M8 			\
			-min_routing_layer M6 			

# internal: from first buffer to last buffer before sink
set_clock_routing_rules -net_type internal 				\
			-clocks {clk} 				\
			-rules clk_network_NDR_internal 		\
			-max_routing_layer M6 				\
			-min_routing_layer M3

# Sink: from last buffer to sink (leaf) without NDR (minimum width and min spacing)
set_clock_routing_rules -net_type sink \
			-clocks {clk} \
			-default_rule \
			-max_routing_layer M3 \
			-min_routing_layer M1


#######################################################################
	# --------------- Constraints ------------- #
#######################################################################
# Clock Ideal Network
remove_ideal_network -all

# Latency and skew applied
remove_clock_latency 	[all_clocks]
remove_propagated_clock [all_clocks]
remove_clock_tree_options -all -target_skew -target_latency


#######################################################################
	# --------------- Clock Net DRC ------------- #
#######################################################################

# Clock tree Design rule constraints (Reported Violated)
set_max_transition 1.0 -clock_path [get_clocks clk]

# Specifies all pins that are in the network
set_max_capacitance 100.0 -clock_path [get_clocks clk]


#######################################################################
	# --------------- Clock Tree Target (CTO) ------------- #
#######################################################################
# Target global skew we need tight to 0
set_clock_tree_options -target_skew 0.1 -clocks {clk}
set_clock_tree_options -target_latency 0.0 -clocks {clk}


# Reported 
report_clock_settings 			> ../results/reports/clock_settings.rpt
report_clock_tree_options 		> ../results/reports/clock_tree_options.rpt



#######################################################################
	# --------------- CTS APP Options ------------- #
#######################################################################


# Signal Integrity
set_app_options -list {time.enable_si_timing_windows {true}}
set_app_options -list {time.si_enable_analysis {true}}



		# ============================ Time Setup ============================ #
# --- Prevent tool check Reset path
set_app_options -name time.disable_recovery_removal_checks      -value false

# --- Enhanced Timing Check by adding CRPR for Timing path
set_app_options -name time.remove_clock_reconvergence_pessimism -value true

            	 # ============================ clock_reconvergence_pessimism Setup ============================ #
# --- Limit Fanout of clock network |
set_app_options -list {cts.common.max_fanout {10}}
# --- Aware with Congestion through Build CTS and using Global Route instead of Virtual route
set_app_options -list {cts.compile.enable_global_route true}
# --- Remove each buffer inserted in clock tree before cts
set_app_options -name cts.compile.remove_existing_clock_trees -value true
# --- CTS Engine Try solve Hold by usefuel Skew and data path
set_app_options -list {clock_opt.hold.effort           {high} }
# --- Through Optimize implement Apply NDR on long wire Length
set_app_options -name clock_opt.flow.optimize_ndr -value true
# --- Enable Area Recovery this take Higest Priority for timing and second Priority for area if availble
set_app_options -name clock_opt.flow.enable_clock_power_recovery -value area


		# ============================ CCD (Clock concurrent data) ============================ #
# --- Make CTS Engine work on CCD flow and Not used CTS Classic
set_app_options -list {clock_opt.flow.enable_ccd      {true} }
# --- More Optimization in Skew for solving Hold Violations
set_app_options -name ccd.hold_control_effort     -value high
# ---- limit length of wire
set_app_options -list {cts.common.max_net_length {100}}


           	# ============================ Prefix ============================ #
# --- Prefix for Optimization
set_app_options -name cts.common.user_instance_name_prefix -value "CTS_"
set_app_options -name opt.common.user_instance_name_prefix -value "OPT_"



#######################################################################
	# --------------- Clock Network ------------- #
#######################################################################

# Synthesis clock network
clock_opt -from build_clock -to build_clock

# Assign clock network
clock_opt -from route_clock -to route_clock

# Optimize clock network
clock_opt -from final_opto -to final_opto


# Check number of cells inserted through CTS step
sizeof_collection [get_cells "CTS_*"]
sizeof_collection [get_cells "OPT_*"]

# Reported 
report_qor -summary 			> ../results/reports/qor_summary.rpt



#######################################################################
	# --------------- Connect PG ------------- #
#######################################################################

# Hierarchical (include top module + sub modules)
connect_pg_net -net VDD [get_pins -hierarchical */VDD]
connect_pg_net -net VSS [get_pins -hierarchical */VSS]

#######################################################################
	# --------------- Important Checks ------------- #
#######################################################################
check_pg_drc 				> ../results/reports/pg_drc.rpt 
check_pg_connectivity                   > ../results/reports/pg_connectivity.rpt
check_pg_missing_vias                   > ../results/reports/missing_via.rpt
check_routes -drc true 			> ../results/reports/physical_drc.rpt
report_timing                           > ../results/reports/timing.rpt
report_constraint -all_violators 	> ../results/reports/cts_violations.rpt



#######################################################################
	# --------------- Save Block ------------- #
#######################################################################

write_def                    ../results/outputs/${design}.def
write_verilog -include {all} ../results/outputs/${design}.v
write_sdc -output            ../results/outputs/${design}.sdc

save_block
