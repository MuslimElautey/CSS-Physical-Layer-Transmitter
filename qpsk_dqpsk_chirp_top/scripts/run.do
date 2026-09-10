vlib work 
vlog ../rtl/*v ../tb/*v 

vsim -voptargs=+acc qpsk_dqpsk_chirp_top_tb

add wave *

run -all 

#do ../scripts/run.do