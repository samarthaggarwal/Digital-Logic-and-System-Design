## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
#Bank = 34, Pin name = ,					Sch name = CLK100MHZ
#		set_property PACKAGE_PIN W5 [get_ports CLK]
#		set_property IOSTANDARD LVCMOS33 [get_ports CLK]
#		create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports CLK]

# Switches
set_property PACKAGE_PIN V17 [get_ports SW_ON]
set_property IOSTANDARD LVCMOS33 [get_ports SW_ON]

set_property PACKAGE_PIN V16 [get_ports SW_DOOR]
set_property IOSTANDARD LVCMOS33 [get_ports SW_DOOR]

set_property PACKAGE_PIN W16 [get_ports SW_OFF]
set_property IOSTANDARD LVCMOS33 [get_ports SW_OFF]

set_property PACKAGE_PIN W2 [get_ports D4]
set_property IOSTANDARD LVCMOS33 [get_ports D4]

set_property PACKAGE_PIN U1 [get_ports D3]
set_property IOSTANDARD LVCMOS33 [get_ports D3]

set_property PACKAGE_PIN T1 [get_ports D2]
set_property IOSTANDARD LVCMOS33 [get_ports D2]

set_property PACKAGE_PIN R2 [get_ports D1]
set_property IOSTANDARD LVCMOS33 [get_ports D1]

# LEDs
set_property PACKAGE_PIN U16 [get_ports INVALID]
set_property IOSTANDARD LVCMOS33 [get_ports INVALID]

set_property PACKAGE_PIN L1 [get_ports LIGHT]
set_property IOSTANDARD LVCMOS33 [get_ports LIGHT]

# Others (BITSTREAM, CONFIG)
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]


