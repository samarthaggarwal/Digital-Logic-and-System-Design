## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
##Bank = 34, Pin name = ,	Sch name = CLK100MHZ
#	set_property PACKAGE_PIN W5 [get_ports clk]
#	set_property IOSTANDARD LVCMOS33 [get_ports clk]
##	[Place 30-574] Poor placement for routing between an IO pin and BUFG. If this sub optimal condition is acceptable for this design, you may use the CLOCK_DEDICATED_ROUTE constraint in the .xdc file to demote this message to a WARNING. However, the use of this override is highly discouraged. These examples can be used directly in the .xdc file to override this clock rule.
#    set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets load_inputs_IBUF]
    
##        load_inputs_IBUF_inst (IBUF.O) is locked to IOB_X0Y17
##         and load_inputs_IBUF_BUFG_inst (BUFG.I) is provisionally placed by clockplacer on BUFGCTRL_X0Y0

#	create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

# Clock signal
#Bank = 34, Pin name = ,	Sch name = CLK100MHZ
	set_property PACKAGE_PIN W5 [get_ports clk]
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets down_request_IBUF[0]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets down_request_IBUF[1]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets down_request_IBUF[2]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets down_request_IBUF[3]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets up_request_IBUF[0]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets up_request_IBUF[1]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets up_request_IBUF[2]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets up_request_IBUF[3]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets lift1_floor_IBUF[0]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets lift1_floor_IBUF[1]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets lift1_floor_IBUF[2]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets lift1_floor_IBUF[3]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets lift2_floor_IBUF[0]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets lift2_floor_IBUF[1]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets lift2_floor_IBUF[2]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets lift2_floor_IBUF[3]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE
#    set_property ALLOW_COMBINATORIAL_LOOPS TRUE [net_nets <myHier/myNet>]
# Switches
set_property PACKAGE_PIN R2 [get_ports lift1_floor[3]]
set_property IOSTANDARD LVCMOS33 [get_ports lift1_floor[3]]

set_property PACKAGE_PIN T1 [get_ports lift1_floor[2]]
set_property IOSTANDARD LVCMOS33 [get_ports lift1_floor[2]]

set_property PACKAGE_PIN U1 [get_ports lift1_floor[1]]
set_property IOSTANDARD LVCMOS33 [get_ports lift1_floor[1]]

set_property PACKAGE_PIN W2 [get_ports lift1_floor[0]]
set_property IOSTANDARD LVCMOS33 [get_ports lift1_floor[0]]

set_property PACKAGE_PIN R3 [get_ports lift2_floor[3]]
set_property IOSTANDARD LVCMOS33 [get_ports lift2_floor[3]]

set_property PACKAGE_PIN T2 [get_ports lift2_floor[2]]
set_property IOSTANDARD LVCMOS33 [get_ports lift2_floor[2]]

set_property PACKAGE_PIN T3 [get_ports lift2_floor[1]]
set_property IOSTANDARD LVCMOS33 [get_ports lift2_floor[1]]

set_property PACKAGE_PIN V2 [get_ports lift2_floor[0]]
set_property IOSTANDARD LVCMOS33 [get_ports lift2_floor[0]]

set_property PACKAGE_PIN W13 [get_ports down_request[3]]
set_property IOSTANDARD LVCMOS33 [get_ports down_request[3]]

set_property PACKAGE_PIN W14 [get_ports down_request[2]]
set_property IOSTANDARD LVCMOS33 [get_ports down_request[2]]

set_property PACKAGE_PIN V15 [get_ports down_request[1]]
set_property IOSTANDARD LVCMOS33 [get_ports down_request[1]]

set_property PACKAGE_PIN W15 [get_ports down_request[0]]
set_property IOSTANDARD LVCMOS33 [get_ports down_request[0]]

set_property PACKAGE_PIN W17 [get_ports up_request[3]]
set_property IOSTANDARD LVCMOS33 [get_ports up_request[3]]

set_property PACKAGE_PIN W16 [get_ports up_request[2]]
set_property IOSTANDARD LVCMOS33 [get_ports up_request[2]]

set_property PACKAGE_PIN V16 [get_ports up_request[1]]
set_property IOSTANDARD LVCMOS33 [get_ports up_request[1]]

set_property PACKAGE_PIN V17 [get_ports up_request[0]]
set_property IOSTANDARD LVCMOS33 [get_ports up_request[0]]

#Push Buttons
set_property PACKAGE_PIN W19 [get_ports door_open[0]]
set_property IOSTANDARD LVCMOS33 [get_ports door_open[0]]

set_property PACKAGE_PIN T18 [get_ports door_open[1]]
set_property IOSTANDARD LVCMOS33 [get_ports door_open[1]]

set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

set_property PACKAGE_PIN T17 [get_ports door_closed[0]]
set_property IOSTANDARD LVCMOS33 [get_ports door_closed[0]]

set_property PACKAGE_PIN U17 [get_ports door_closed[1]]
set_property IOSTANDARD LVCMOS33 [get_ports door_closed[1]]


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


# LED's
set_property PACKAGE_PIN L1 [get_ports lift1_floor_indicator[3]]
set_property IOSTANDARD LVCMOS33 [get_ports lift1_floor_indicator[3]]

set_property PACKAGE_PIN P1 [get_ports lift1_floor_indicator[2]]
set_property IOSTANDARD LVCMOS33 [get_ports lift1_floor_indicator[2]]

set_property PACKAGE_PIN N3 [get_ports lift1_floor_indicator[1]]
set_property IOSTANDARD LVCMOS33 [get_ports lift1_floor_indicator[1]]

set_property PACKAGE_PIN P3 [get_ports lift1_floor_indicator[0]]
set_property IOSTANDARD LVCMOS33 [get_ports lift1_floor_indicator[0]]

set_property PACKAGE_PIN U3 [get_ports lift2_floor_indicator[3]]
set_property IOSTANDARD LVCMOS33 [get_ports lift2_floor_indicator[3]]

set_property PACKAGE_PIN W3 [get_ports lift2_floor_indicator[2]]
set_property IOSTANDARD LVCMOS33 [get_ports lift2_floor_indicator[2]]

set_property PACKAGE_PIN V3 [get_ports lift2_floor_indicator[1]]
set_property IOSTANDARD LVCMOS33 [get_ports lift2_floor_indicator[1]]

set_property PACKAGE_PIN V13 [get_ports lift2_floor_indicator[0]]
set_property IOSTANDARD LVCMOS33 [get_ports lift2_floor_indicator[0]]

set_property PACKAGE_PIN V14 [get_ports down_request_indicator[3]]
set_property IOSTANDARD LVCMOS33 [get_ports down_request_indicator[3]]

set_property PACKAGE_PIN U14 [get_ports down_request_indicator[2]]
set_property IOSTANDARD LVCMOS33 [get_ports down_request_indicator[2]]

set_property PACKAGE_PIN U15 [get_ports down_request_indicator[1]]
set_property IOSTANDARD LVCMOS33 [get_ports down_request_indicator[1]]

set_property PACKAGE_PIN W18 [get_ports down_request_indicator[0]]
set_property IOSTANDARD LVCMOS33 [get_ports down_request_indicator[0]]

set_property PACKAGE_PIN V19 [get_ports up_request_indicator[3]]
set_property IOSTANDARD LVCMOS33 [get_ports up_request_indicator[3]]

set_property PACKAGE_PIN U19 [get_ports up_request_indicator[2]]
set_property IOSTANDARD LVCMOS33 [get_ports up_request_indicator[2]]

set_property PACKAGE_PIN E18 [get_ports up_request_indicator[1]]
set_property IOSTANDARD LVCMOS33 [get_ports up_request_indicator[1]]

set_property PACKAGE_PIN U16 [get_ports up_request_indicator[0]]
set_property IOSTANDARD LVCMOS33 [get_ports up_request_indicator[0]]



# Others (BITSTREAM, CONFIG)
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

