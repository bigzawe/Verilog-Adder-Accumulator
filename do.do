vlib work

vlog	addaccu_beh_comb_test.v addaccu.v

vsim -voptargs=+acc work.addaccu_beh_comb_test

add wave * 

run -all