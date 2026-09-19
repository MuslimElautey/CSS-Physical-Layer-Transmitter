#############################################################
# ndm.tcl - NDM Library Creation
#############################################################

# -----------------------------------------------------------
# Library Name
# -----------------------------------------------------------
set lib_name "saed90nm_max"


# -----------------------------------------------------------
# Library Paths
# -----------------------------------------------------------
set tech_file "/home/ICer/Downloads/Lib/process/astro/tech/astroTechFile.tf"

set db_file "/home/ICer/Downloads/Lib/synopsys/models/saed90nm_max.db"

set lef_file "/home/ICer/Downloads/Lib/lef/saed90nmEditted.lef"


# -----------------------------------------------------------
# Create Workspace
# -----------------------------------------------------------
create_workspace \
    -flow exploration \
    -technology $tech_file \
    $lib_name


# -----------------------------------------------------------
# Workspace Options
# -----------------------------------------------------------
set_app_options -list {
    lib.workspace.save_design_views {true}
}

set_app_options -list {
    lib.workspace.keep_all_physical_cells {true}
}

set_app_options -list {
    lib.workspace.save_layout_views {true}
}


# -----------------------------------------------------------
# Read Library Files
# -----------------------------------------------------------
read_db $db_file

read_lef \
    -merge_action Add \
    $lef_file


# -----------------------------------------------------------
# Group Libraries
# -----------------------------------------------------------
group_libs


# -----------------------------------------------------------
# Process Workspace and Generate NDM
# -----------------------------------------------------------
process_workspaces \
    -force \
    -directory ../ndm/


# -----------------------------------------------------------
# Start GUI
# -----------------------------------------------------------
start_gui
