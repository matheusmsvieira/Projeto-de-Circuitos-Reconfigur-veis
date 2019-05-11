
create_clock -period 20.000 -waveform {0.000 10.000} -name clkin [get_ports clk]

set_input_delay -clock clkin -max 4.000 [get_ports reset]
set_input_delay -clock clkin -min 1.000 [get_ports reset]

set_input_delay -clock clkin -max 4.000 [get_ports start]
set_input_delay -clock clkin -min 1.000 [get_ports start]

set_input_delay -clock clkin -max 4.000 [get_ports sw]
set_input_delay -clock clkin -min 1.000 [get_ports sw]

#assume que o -min é 2
set_output_delay -clock clkin 6.000 [get_ports led[0]]
set_output_delay -clock clkin 6.000 [get_ports led[1]]
set_output_delay -clock clkin 6.000 [get_ports led[2]]
set_output_delay -clock clkin 6.000 [get_ports led[3]]
set_output_delay -clock clkin 6.000 [get_ports led[4]]
set_output_delay -clock clkin 6.000 [get_ports led[5]]
set_output_delay -clock clkin 6.000 [get_ports led[6]]
set_output_delay -clock clkin 6.000 [get_ports led[7]]
set_output_delay -clock clkin 6.000 [get_ports led[8]]
set_output_delay -clock clkin 6.000 [get_ports led[9]]
set_output_delay -clock clkin 6.000 [get_ports led[10]]
set_output_delay -clock clkin 6.000 [get_ports led[11]]
set_output_delay -clock clkin 6.000 [get_ports led[12]]
set_output_delay -clock clkin 6.000 [get_ports led[13]]
set_output_delay -clock clkin 6.000 [get_ports led[14]]
set_output_delay -clock clkin 6.000 [get_ports led[15]]