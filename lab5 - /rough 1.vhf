library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity clock_update is

	port(	clk		:	in 	std_logic;
		pushbutton	:	in 	std_logic;
		output		: 	out	std_logic
		);

end clock_update;

architecture BEHAVIORAL of clock_update is

	component TFF

end BEHAVIORAL
