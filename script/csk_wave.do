onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /csk_mod_tb/addr
add wave -noupdate /csk_mod_tb/S_r
add wave -noupdate /csk_mod_tb/S_i
add wave -noupdate /csk_mod_tb/chirp_r
add wave -noupdate /csk_mod_tb/chirp_i
add wave -noupdate -color Gold -radix binary /csk_mod_tb/csk_dut/ext_chirp_r
add wave -noupdate -color Gold -radix binary /csk_mod_tb/csk_dut/ext_chirp_i
add wave -noupdate -radix decimal /csk_mod_tb/csk_dut/Sr_Cr
add wave -noupdate -radix decimal /csk_mod_tb/csk_dut/Si_Ci
add wave -noupdate -radix decimal /csk_mod_tb/csk_dut/Sr_Ci
add wave -noupdate -radix decimal /csk_mod_tb/csk_dut/Si_Cr
add wave -noupdate -color Cyan -radix decimal /csk_mod_tb/tx_r
add wave -noupdate -color Cyan -radix decimal /csk_mod_tb/tx_i
add wave -noupdate /csk_mod_tb/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {754 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {747 ps} {953 ps}
