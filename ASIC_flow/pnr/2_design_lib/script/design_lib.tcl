#############################################################
# design_lib.tcl - ICC2 Design Setup
#############################################################

# ===========================================================
# 1. Design Configuration
# ===========================================================

# Technology file
set TECH_FILE "/home/ICer/Downloads/Lib/process/astro/tech/astroTechFile.tf"

# StarRC parasitic technology files
set Tech "/home/ICer/Downloads/Lib/Technology_Kit/starrcxt"

# Reference NDM library
set reference_library "../../1_ndm/ndm/saed90nm_max_1.ndm"

# Top-level design name
set design "zigbee_phy_tx"

sh rm -rf ../results
sh mkdir -p ../results

# ===========================================================
# 2. Create Design Library
# ===========================================================

# Create the ICC2 design library and link it
# to the reference NDM library.
create_lib -technology $TECH_FILE -ref_libs $reference_library ../results/${design}.dlib


# ===========================================================
# 3. Read Synthesized Netlist
# ===========================================================

# Read the synthesized gate-level Verilog netlist
# and define the top-level design.
read_verilog -top $design ../../../syn/outputs/${design}.v


# ===========================================================
# 4. Read Timing Constraints
# ===========================================================

# Read the Synopsys Design Constraints generated
# during the synthesis stage.
 read_sdc ../../../syn/outputs/${design}.sdc


# ===========================================================
# 5. Read Parasitic Technology
# ===========================================================

# Read maximum capacitance parasitic technology
# for the late timing analysis.
read_parasitic_tech \
    -layermap ${Tech}/tech2itf.map \
    -tlup ${Tech}/tluplus/saed90nm_1p9m_1t_Cmax.tluplus \
    -name maxTLU


# Read minimum capacitance parasitic technology
# for the early timing analysis.
read_parasitic_tech \
    -layermap ${Tech}/tech2itf.map \
    -tlup ${Tech}/tluplus/saed90nm_1p9m_1t_Cmin.tluplus \
    -name minTLU


# ===========================================================
# 6. Set Parasitic Parameters
# ===========================================================

# Use maxTLU for late timing analysis
# and minTLU for early timing analysis.
set_parasitic_parameters \
    -late_spec maxTLU \
    -early_spec minTLU

# ===========================================================
# 8. Save Design Setup
# ===========================================================
# Save the current design block as a setup block.
save_block -as ${design}_dlib ../results/${design}.dlib:${design}.design




# ===========================================================
# 9. Start GUI
# ===========================================================
start_gui
