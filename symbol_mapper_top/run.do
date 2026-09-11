vlib work
vlog *.v
vsim -voptargs=+acc work.tb_symbol_mapper_top
add wave *
run -all
#quit -sim