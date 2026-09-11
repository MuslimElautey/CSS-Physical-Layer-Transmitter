vlog ../rtl/*.v ../tb/*.v

vsim -voptargs=+acc work.qpsk_mapper_tb

add wave *
run -all

#quit
