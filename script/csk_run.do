vlog ../rtl/*.v ../tb/*.v

vsim -voptargs=+acc work.csk_mod_tb

do csk_wave.do
#add wave *
run -all

#quit
