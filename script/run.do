vlog ../rtl/*.v ../tb/*.v

vsim -voptargs=+acc work.rom_tb

add wave *
run -all

#quit
