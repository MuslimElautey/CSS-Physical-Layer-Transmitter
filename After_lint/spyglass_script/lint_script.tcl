read_file -type verilog {../rtl/chirp_modulation.v ../rtl/demux.v ../rtl/dqpsk_encoder.v ../rtl/form_ppdu.v ../rtl/master_ctrl_fsm.v ../rtl/mux2x1.v ../rtl/payload_ram.v ../rtl/piso.v ../rtl/preamble_sfd_rom.v ../rtl/qpsk_dqpsk_chirp_top.v ../rtl/qpsk_mapper.v ../rtl/symbol_mapper.v ../rtl/symbol_mapper_RAM.v ../rtl/zero_padder.v ../rtl/zigbee_phy_tx.v}
set_option top zigbee_phy_tx
current_goal Design_Read -top zigbee_phy_tx
current_goal lint/lint_rtl -top zigbee_phy_tx
run_goal