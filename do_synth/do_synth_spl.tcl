read_file -format vhdl {../rtl/my_adder.vhd}
create_clock [get_ports clk]  -period 8.0  -waveform {0 4} -name clk

set_clock_uncertainty 0.025  -setup [get_clocks clk]
set_clock_uncertainty 0.025  -hold [get_clocks clk]
set_clock_transition -fall 0.04 [get_clocks clk]
set_clock_transition -rise 0.04 [get_clocks clk]

set_dont_touch clk
set_dont_touch rstn

set_clock_latency -max -source 0.1 [get_clocks clk] 

set_input_delay -max -clock clk  0.05 [get_ports {dta dtb}]
set_output_delay -max -clock clk  0.05 [all_outputs]

set_false_path -from [get_ports rstn]

check_timing
compile
report_area > reports/my_adder-spl_synth.area
report_power > reports/my_adder-spl_synth.power
change_names -hier -rules vhdl 
change_names -hier -rules verilog
write_file -hierarchy -f vhdl    -output "./results/my_adder.vhd"
write_file -hierarchy -f verilog -output "./results/my_adder.v"
write_sdf  "./results/my_adder.sdf"
write -hierarchy -f ddc -output  "./results/my_adder.ddc"
