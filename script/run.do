vlog ../rtl/*.v ../tb/*.v

vsim -voptargs=+acc work.DQPSK_tb

add wave *
run -all

#quit
