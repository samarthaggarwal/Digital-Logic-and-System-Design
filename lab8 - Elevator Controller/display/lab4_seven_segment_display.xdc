## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
Bank = 34, Pin name = ,	Sch name = CLK100MHZ
	set_property PACKAGE_PIN W5 [get_ports clk]
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

# Switches
set_property PACKAGE_PIN R2 [get_ports b[15]]
set_property IOSTANDARD LVCMOS33 [get_ports b[15]]

set_property PACKAGE_PIN T1 [get_ports b[14]]
set_property IOSTANDARD LVCMOS33 [get_ports b[14]]

set_property PACKAGE_PIN U1 [get_ports b[13]]
set_property IOSTANDARD LVCMOS33 [get_ports b[13]]

set_property PACKAGE_PIN W2 [get_ports b[12]]
set_property IOSTANDARD LVCMOS33 [get_ports b[12]]

set_property PACKAGE_PIN R3 [get_ports b[11]]
set_property IOSTANDARD LVCMOS33 [get_ports b[11]]

set_property PACKAGE_PIN T2 [get_ports b[10]]
set_property IOSTANDARD LVCMOS33 [get_ports b[10]]

set_property PACKAGE_PIN T3 [get_ports b[9]]
set_property IOSTANDARD LVCMOS33 [get_ports b[9]]

set_property PACKAGE_PIN V2 [get_ports b[8]]
set_property IOSTANDARD LVCMOS33 [get_ports b[8]]

set_property PACKAGE_PIN W13 [get_ports b[7]]
set_property IOSTANDARD LVCMOS33 [get_ports b[7]]

set_property PACKAGE_PIN W14 [get_ports b[6]]
set_property IOSTANDARD LVCMOS33 [get_ports b[6]]

set_property PACKAGE_PIN V15 [get_ports b[5]]
set_property IOSTANDARD LVCMOS33 [get_ports b[5]]

set_property PACKAGE_PIN W15 [get_ports b[4]]
set_property IOSTANDARD LVCMOS33 [get_ports b[4]]

set_property PACKAGE_PIN W17 [get_ports b[3]]
set_property IOSTANDARD LVCMOS33 [get_ports b[3]]

set_property PACKAGE_PIN W16 [get_ports b[2]]
set_property IOSTANDARD LVCMOS33 [get_ports b[2]]

set_property PACKAGE_PIN V16 [get_ports b[1]]
set_property IOSTANDARD LVCMOS33 [get_ports b[1]]

set_property PACKAGE_PIN V17 [get_ports b[0]]
set_property IOSTANDARD LVCMOS33 [get_ports b[0]]

#Push Button
set_property PACKAGE_PIN U18 [get_ports pushbutton]
set_property IOSTANDARD LVCMOS33 [get_ports pushbutton]

# Cathodes
set_property PACKAGE_PIN W7 [get_ports cathode[0]]
set_property IOSTANDARD LVCMOS33 [get_ports cathode[0]]

set_property PACKAGE_PIN W6 [get_ports cathode[1]]
set_property IOSTANDARD LVCMOS33 [get_ports cathode[1]]

set_property PACKAGE_PIN U8 [get_ports cathode[2]]
set_property IOSTANDARD LVCMOS33 [get_ports cathode[2]]

set_property PACKAGE_PIN V8 [get_ports cathode[3]]
set_property IOSTANDARD LVCMOS33 [get_ports cathode[3]]

set_property PACKAGE_PIN U5 [get_ports cathode[4]]
set_property IOSTANDARD LVCMOS33 [get_ports cathode[4]]

set_property PACKAGE_PIN V5 [get_ports cathode[5]]
set_property IOSTANDARD LVCMOS33 [get_ports cathode[5]]

set_property PACKAGE_PIN U7 [get_ports cathode[6]]
set_property IOSTANDARD LVCMOS33 [get_ports cathode[6]]

#Anodes
set_property PACKAGE_PIN U2 [get_ports anode[0]]
set_property IOSTANDARD LVCMOS33 [get_ports anode[0]]

set_property PACKAGE_PIN U4 [get_ports anode[1]]
set_property IOSTANDARD LVCMOS33 [get_ports anode[1]]

set_property PACKAGE_PIN V4 [get_ports anode[2]]
set_property IOSTANDARD LVCMOS33 [get_ports anode[2]]

set_property PACKAGE_PIN W4 [get_ports anode[3]]
set_property IOSTANDARD LVCMOS33 [get_ports anode[3]]

# Others (BITSTREAM, CONFIG)
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]


