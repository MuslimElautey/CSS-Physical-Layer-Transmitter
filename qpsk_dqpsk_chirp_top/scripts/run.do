vlib work
vlog ../rtl/*v ../tb/*v

vsim -voptargs=+acc dqpsk_encoder_tb

add wave *

run -all

#do ../scripts/run.do
