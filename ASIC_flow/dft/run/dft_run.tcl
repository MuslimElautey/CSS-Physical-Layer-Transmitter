#############################################################
# dft_run.tcl - Entry point for the DFT flow
#############################################################
# This script is meant to be run from inside dft/run/
# Usage:
#   dc_shell-t -f dft_run.tcl | tee ../log/dft_run.log
#############################################################

# Make sure output directories exist (in case they were deleted)
sh mkdir -p ../results
sh mkdir -p ../log

# Source the main DFT flow
source -echo -verbose ../script/dft.tcl