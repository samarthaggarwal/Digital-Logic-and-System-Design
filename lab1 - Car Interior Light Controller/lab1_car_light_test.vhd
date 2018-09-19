-- Vhdl test bench created from schematic /home/asobti/Xilinx_projects/lab1_car_light/lab1_car_light.sch - Fri Jul 21 15:05:17 2017
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
library std;
use std.textio.all;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY lab1_car_light_tb IS
END lab1_car_light_tb;
ARCHITECTURE behavioral OF lab1_car_light_tb IS 

   COMPONENT lab1_car_light
   PORT( D1	:	IN	STD_LOGIC; 
          D2	:	IN	STD_LOGIC; 
          D3	:	IN	STD_LOGIC; 
          D4	:	IN	STD_LOGIC; 
          SW_DOOR	:	IN	STD_LOGIC; 
          SW_ON	:	IN	STD_LOGIC; 
          SW_OFF	:	IN	STD_LOGIC;
          INVALID	:	OUT	STD_LOGIC; 
          LIGHT	:	OUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL D1	:	STD_LOGIC;
   SIGNAL D2	:	STD_LOGIC;
   SIGNAL D3	:	STD_LOGIC;
   SIGNAL D4	:	STD_LOGIC;
   SIGNAL SW_DOOR	:	STD_LOGIC;
   SIGNAL SW_ON	:	STD_LOGIC;
   SIGNAL SW_OFF	:	STD_LOGIC;
   SIGNAL INVALID	:	STD_LOGIC;
   SIGNAL LIGHT	:	STD_LOGIC;
   signal err_cnt_signal : integer;

BEGIN

   UUT: lab1_car_light PORT MAP(
		D1 => D1, 
		D2 => D2, 
		D3 => D3, 
		D4 => D4, 
		SW_DOOR => SW_DOOR, 
		SW_ON => SW_ON, 
		SW_OFF => SW_OFF, 
		INVALID => INVALID, 
		LIGHT => LIGHT
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
	variable err_cnt : integer := 0;
        variable s : line;
	constant LogicalGND : STD_LOGIC := '0';
	constant LogicalSUPPLY : STD_LOGIC := '1';	

   BEGIN
		
		-- case 0
		wait for 10 ns;	
		SW_OFF <= LogicalSUPPLY;
		SW_DOOR <= LogicalGND;
		SW_ON <= LogicalGND;
		D1 <= LogicalSUPPLY;
		D2 <= LogicalSUPPLY;
		D3 <= LogicalSUPPLY;
		D4 <= LogicalSUPPLY;
		wait for 1 ns;
		assert (LIGHT=LogicalGND) report "Error LIGHT, case 0";
		assert (INVALID=LogicalGND) report "Error INVALID, case 0";
		if (LIGHT/=LogicalGND or INVALID/=LogicalGND) then 
			 err_cnt := err_cnt + 1;
		end if;
		
		-- case 1
		wait for 10 ns;	
		SW_OFF <= LogicalGND;
		SW_DOOR <= LogicalSUPPLY;
		SW_ON <= LogicalSUPPLY;
		D1 <= LogicalSUPPLY;
		D2 <= LogicalGND;
		D3 <= LogicalGND;
		D4 <= LogicalGND;
		wait for 1 ns;
		assert (LIGHT=LogicalGND) report "Error LIGHT, case 1";
		assert (INVALID=LogicalSUPPLY) report "Error INVALID, case 1";
		if (LIGHT/=LogicalGND or INVALID/=LogicalSUPPLY) then 
			 err_cnt := err_cnt + 1;
		end if;
			
		
		-- case "2"
		wait for 10 ns;	
		SW_OFF <= LogicalSUPPLY;
		SW_DOOR <= LogicalSUPPLY;
		SW_ON <= LogicalSUPPLY;
		D1 <= LogicalGND;
		D2 <= LogicalGND;
		D3 <= LogicalGND;
		D4 <= LogicalGND;
		wait for 1 ns;
		assert (LIGHT=LogicalGND) report "Error LIGHT, case 2";
		assert (INVALID=LogicalSUPPLY) report "Error INVALID, case 2";
		if (LIGHT/=LogicalGND or INVALID/=LogicalSUPPLY) then 
			 err_cnt := err_cnt + 1;
		end if;
			

		-- case "3"
		wait for 10 ns;	
		SW_OFF <= LogicalGND;
		SW_DOOR <= LogicalGND;
		SW_ON <= LogicalSUPPLY;
		D1 <= LogicalSUPPLY;
		D2 <= LogicalSUPPLY;
		D3 <= LogicalSUPPLY;
		D4 <= LogicalSUPPLY;
		wait for 1 ns;
		assert (LIGHT=LogicalSUPPLY) report "Error LIGHT, case 3";
		assert (INVALID=LogicalGND) report "Error INVALID, case 3";
		if (LIGHT/=LogicalSUPPLY or INVALID/=LogicalGND) then 
			 err_cnt := err_cnt + 1;
		end if;

		-- case "4"
		wait for 10 ns;	
		SW_OFF <= LogicalGND;
		SW_DOOR <= LogicalGND;
		SW_ON <= LogicalSUPPLY;
		D1 <= LogicalGND;
		D2 <= LogicalGND;
		D3 <= LogicalGND;
		D4 <= LogicalGND;
		wait for 1 ns;
		assert (LIGHT=LogicalSUPPLY) report "Error LIGHT, case 4";
		assert (INVALID=LogicalGND) report "Error INVALID, case 4";
		if (LIGHT/=LogicalSUPPLY or INVALID/=LogicalGND) then 
			 err_cnt := err_cnt + 1;
		end if;
						

		-- case "5"
		wait for 10 ns;	
		SW_OFF <= LogicalGND;
		SW_DOOR <= LogicalGND;
		SW_ON <= LogicalGND;
		D1 <= LogicalSUPPLY;
		D2 <= LogicalGND;
		D3 <= LogicalSUPPLY;
		D4 <= LogicalGND;
		wait for 1 ns;
		assert (LIGHT=LogicalGND) report "Error LIGHT, case 5";
		assert (INVALID=LogicalSUPPLY) report "Error INVALID, case 5";
		if (LIGHT/=LogicalGND or INVALID/=LogicalSUPPLY) then 
			 err_cnt := err_cnt + 1;
		end if;

		-- case "6"
		wait for 10 ns;	
		SW_OFF <= LogicalGND;
		SW_DOOR <= LogicalSUPPLY;
		SW_ON <= LogicalGND;
		D1 <= LogicalGND;
		D2 <= LogicalGND;
		D3 <= LogicalGND;
		D4 <= LogicalGND;
		wait for 1 ns;
		assert (LIGHT=LogicalGND) report "Error LIGHT, case 6";
		assert (INVALID=LogicalGND) report "Error INVALID, case 6";
		if (LIGHT/=LogicalGND or INVALID/=LogicalGND) then 
			 err_cnt := err_cnt + 1;
		end if;

		-- case "7"
		wait for 10 ns;	
		SW_OFF <= LogicalGND;
		SW_DOOR <= LogicalSUPPLY;
		SW_ON <= LogicalGND;
		D1 <= LogicalSUPPLY;
		D2 <= LogicalGND;
		D3 <= LogicalGND;
		D4 <= LogicalSUPPLY;
		wait for 1 ns;
		assert (LIGHT=LogicalSUPPLY) report "Error LIGHT, case 7";
		assert (INVALID=LogicalGND) report "Error INVALID, case 7";
		if (LIGHT/=LogicalSUPPLY or INVALID/=LogicalGND) then 
			 err_cnt := err_cnt + 1;
		end if;

		-- case "8"
		wait for 10 ns;	
		SW_OFF <= LogicalGND;
		SW_DOOR <= LogicalSUPPLY;
		SW_ON <= LogicalGND;
		D1 <= LogicalGND;
		D2 <= LogicalGND;
		D3 <= LogicalSUPPLY;
		D4 <= LogicalGND;
		wait for 1 ns;
		assert (LIGHT=LogicalSUPPLY) report "Error LIGHT, case 8";
		assert (INVALID=LogicalGND) report "Error INVALID, case 8";
		if (LIGHT/=LogicalSUPPLY or INVALID/=LogicalGND) then 
			 err_cnt := err_cnt + 1;
		end if;

		-- case "9"
		wait for 10 ns;	
		SW_OFF <= LogicalGND;
		SW_DOOR <= LogicalSUPPLY;
		SW_ON <= LogicalGND;
		D1 <= LogicalSUPPLY;
		D2 <= LogicalSUPPLY;
		D3 <= LogicalGND;
		D4 <= LogicalGND;
		wait for 1 ns;
		assert (LIGHT=LogicalSUPPLY) report "Error LIGHT, case 9";
		assert (INVALID=LogicalGND) report "Error INVALID, case 9";
		if (LIGHT/=LogicalSUPPLY or INVALID/=LogicalGND) then 
			 err_cnt := err_cnt + 1;
		end if;

		-- case ""
		wait for 10 ns;

		-- summary of all the tests
                 write(s,string'("Error counter:"));
                 write(s,err_cnt);
                 writeline(output,s);
		if (err_cnt=0) then 			
			 assert false 
			 report "Testbench of Lab 1 completed successfully!" 
			 severity note; 
		else 
			 assert true 
			 report "Something wrong, try again" 
			 severity error; 
		end if; 
         err_cnt_signal <= err_cnt;        
			
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
