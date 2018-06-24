--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:29:01 08/20/2017
-- Design Name:   
-- Module Name:   /home/anupam/Xilinx_projects/lab4_gcd/lab4_gcd_tb.vhd
-- Project Name:  lab4_gcd
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: gcd_comp
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY lab7_divider_tb IS
END lab7_divider_tb;
 
ARCHITECTURE behavior OF lab7_divider_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lab7_divider
    Port ( divisor : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           dividend : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           clk : in  STD_LOGIC;
           load_inputs : in  STD_LOGIC;
           sim_mode : in  STD_LOGIC := '1';
           output_valid : out  STD_LOGIC;
           anode : out  STD_LOGIC_VECTOR(3 DOWNTO 0);
           cathode : out  STD_LOGIC_VECTOR(6 DOWNTO 0);
           input_invalid : out  STD_LOGIC);
    END COMPONENT;

	-- Custom Types
	type display_output is array (0 to 15) of std_logic_vector(6 downto 0);
	type anode_output_array is array(0 to 3) of std_logic_vector(3 downto 0);

   --Inputs
	   signal divisor : STD_LOGIC_VECTOR(7 DOWNTO 0);
		signal dividend : STD_LOGIC_VECTOR(7 DOWNTO 0);
		signal clk : STD_LOGIC;
		signal load_inputs : STD_LOGIC;
		signal sim_mode : STD_LOGIC := '1';
		
	--Outputs
		signal output_valid : STD_LOGIC;
		signal anode : STD_LOGIC_VECTOR(3 DOWNTO 0);
		signal cathode : STD_LOGIC_VECTOR(6 DOWNTO 0);
		signal input_invalid : STD_LOGIC;
		
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	-- Signals
	signal err_cnt_signal : integer range 0 to 50 := 0;
	constant intToCathodeValue : display_output := ("1000000","1111001","0100100","0110000","0011001","0010010","0000010","1111000","0000000","0010000","0001000","0000011","1000110","0100001","0000110","0001110");
	constant anodeValues : anode_output_array := ("0111","1011","1101","1110");
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lab7_divider PORT MAP (
			divisor => divisor,
			dividend => dividend,
			clk => clk,
			load_inputs => load_inputs,
			sim_mode => sim_mode,
			output_valid => output_valid,
			input_invalid => input_invalid,
			cathode => cathode,
			anode => anode
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
  end process;
 

   -- Stimulus process
   stim_proc: process

		type intArray is array(0 to 3) of integer;
		variable cathodeGroundTruth : intArray := (0,1,0,1);
		variable err_cnt : INTEGER RANGE 0 to 50 := 0;
		variable res_err_cnt : INTEGER := 0;
		variable final_err_cnt : INTEGER := 0;

   begin		
		------------------------------------------------------------
      --------------------- pre-case 0 ---------------------------
		------------------------------------------------------------
		sim_mode <= '1';
		-- Set inputs
		dividend <= "00000111";
		divisor <= "00000011";
		
		wait for 4*clk_period;
		
		load_inputs <= '1';

		wait for 10*clk_period;			-- ensures completion of division


		-------------------------------------------------------------
		---------------------  case 0 -------------------------------
		-------------------------------------------------------------
		err_cnt := 0;
		res_err_cnt := 0;
		
		assert (output_valid = '1') report "Error: output is not yet ready";
		
		if (output_valid /= '1' or input_invalid /= '0') then
			err_cnt := err_cnt + 1; report "Error count increased to " & integer'image(err_cnt);
		end if;
		
		cathodeGroundTruth := (0,2,0,1);
		
		for cycleNo in 0 to 3 loop	
			for anodeNumber in 0 to 3 loop
				if (anode = anodeValues(anodeNumber)) then
					assert (cathode = intToCathodeValue(cathodeGroundTruth(anodeNumber))) report "Incorrect cathode value";
					if (cathode /= intToCathodeValue(cathodeGroundTruth(anodeNumber))) then
						err_cnt := err_cnt + 1; 
--						report "Error count increased to " & integer'image(err_cnt);
					end if;
				else
						res_err_cnt := res_err_cnt + 1;
--						report "Res Error count increased to " & integer'image(res_err_cnt);
				end if;
			end loop;
			
			wait for clk_period;	
			
		end loop;
		load_inputs <= '0';
		
		if(err_cnt > 0 or (res_err_cnt-12) > 0) then
			final_err_cnt := final_err_cnt + 1;
			report "Final error count increased to " & integer'image(final_err_cnt);
		end if;
		
		------------------------------------------------------------
      --------------------- pre-case 1 ---------------------------
		------------------------------------------------------------

		sim_mode <= '1';
		-- Set inputs
		dividend <= "00001100";
		divisor <= "00000000";
		
		wait for 4*clk_period;
		
		load_inputs <= '1';

		wait for clk_period * 10;	-- ensures completion of division

		-------------------------------------------------------------
		---------------------  case 1 -------------------------------
		-------------------------------------------------------------

		err_cnt := 0;
		res_err_cnt := 0;
		
		if (input_invalid /= '1') then
			report "Error: This is an invalid case!!";
--			err_cnt := err_cnt + 1; report "Error count increased to " & integer'image(err_cnt);
		end if;
	
		cathodeGroundTruth := (15,15,15,15);		-- it can have any value
--		for cycleNo in 0 to 3 loop
			if (input_invalid /= '1') then
					err_cnt := err_cnt + 1; 
					report "input_invalid should be high. Error count increased to " & integer'image(err_cnt);
			end if;
--		end loop;
		wait for 4*clk_period;	
		load_inputs <= '0';
		
		if(err_cnt > 0 or (res_err_cnt-12) > 0) then
			final_err_cnt := final_err_cnt + 1;
			report "Final error count increased to " & integer'image(final_err_cnt);
		end if;
		
		
--		------------------------------------------------------------
--      --------------------- pre-case 2 ---------------------------
--		------------------------------------------------------------
		sim_mode <= '1';
		-- Set inputs
		dividend <= "01111111";
		divisor <= "00001010";
		
		wait for 4*clk_period;
		
		load_inputs <= '1';

		wait for 10*clk_period;			-- ensures completion of division


		-------------------------------------------------------------
		---------------------  case 2 -------------------------------
		-------------------------------------------------------------
		err_cnt := 0;
		res_err_cnt := 0;
		
		assert (output_valid = '1') report "Error: output is not yet ready";
		
		if (output_valid /= '1' or input_invalid /= '0') then
			err_cnt := err_cnt + 1; report "Error count increased to " & integer'image(err_cnt);
		end if;
		
		cathodeGroundTruth := (0,12,0,7);
		
		for cycleNo in 0 to 3 loop	
			for anodeNumber in 0 to 3 loop
				if (anode = anodeValues(anodeNumber)) then
					assert (cathode = intToCathodeValue(cathodeGroundTruth(anodeNumber))) report "Incorrect cathode value";
					if (cathode /= intToCathodeValue(cathodeGroundTruth(anodeNumber))) then
						err_cnt := err_cnt + 1; 
--						report "Error count increased to " & integer'image(err_cnt);
					end if;
				else
						res_err_cnt := res_err_cnt + 1;
--						report "Res Error count increased to " & integer'image(res_err_cnt);
				end if;
			end loop;
			
			wait for clk_period;	
			
		end loop;
		load_inputs <= '0';
		
		if(err_cnt > 0 or (res_err_cnt-12) > 0) then
			final_err_cnt := final_err_cnt + 1;
			report "Final error count increased to " & integer'image(final_err_cnt);
		end if;

		
		
--		------------------------------------------------------------
--      --------------------- pre-case 3 ---------------------------
--		------------------------------------------------------------
		sim_mode <= '1';
		-- Set inputs
		dividend <= "10000001";		-- -127
		divisor <= "00001010";
		
		wait for 4*clk_period;
		
		load_inputs <= '1';

		wait for 10*clk_period;			-- ensures completion of division


		-------------------------------------------------------------
		---------------------  case 3 -------------------------------
		-------------------------------------------------------------
		err_cnt := 0;
		res_err_cnt := 0;
		
		assert (output_valid = '1') report "Error: output is not yet ready";
		
		if (output_valid /= '1' or input_invalid /= '0') then
			err_cnt := err_cnt + 1; report "Error count increased to " & integer'image(err_cnt);
		end if;
		
		cathodeGroundTruth := (15,4,15,9);
		
		for cycleNo in 0 to 3 loop	
			for anodeNumber in 0 to 3 loop
				if (anode = anodeValues(anodeNumber)) then
					assert (cathode = intToCathodeValue(cathodeGroundTruth(anodeNumber))) report "Incorrect cathode value";
					if (cathode /= intToCathodeValue(cathodeGroundTruth(anodeNumber))) then
						err_cnt := err_cnt + 1; 
--						report "Error count increased to " & integer'image(err_cnt);
					end if;
				else
						res_err_cnt := res_err_cnt + 1;
--						report "Res Error count increased to " & integer'image(res_err_cnt);
				end if;
			end loop;
			
			wait for clk_period;	
			
		end loop;
		load_inputs <= '0';
		
		if(err_cnt > 0 or (res_err_cnt-12) > 0) then
			final_err_cnt := final_err_cnt + 1;
			report "Final error count increased to " & integer'image(final_err_cnt);
		end if;
		
		
		
		
--		------------------------------------------------------------
--      --------------------- pre-case 4 ---------------------------
--		------------------------------------------------------------
		sim_mode <= '1';
		-- Set inputs
		dividend <= "11100101";		-- -27
		divisor <= "00000101";
		
		wait for 4*clk_period;
		
		load_inputs <= '1';

		wait for 10*clk_period;			-- ensures completion of division


		-------------------------------------------------------------
		---------------------  case 4 -------------------------------
		-------------------------------------------------------------
		err_cnt := 0;
		res_err_cnt := 0;
		
		assert (output_valid = '1') report "Error: output is not yet ready";
		
		if (output_valid /= '1' or input_invalid /= '0') then
			err_cnt := err_cnt + 1; report "Error count increased to " & integer'image(err_cnt);
		end if;
		
		cathodeGroundTruth := (15,11,15,14);
		
		for cycleNo in 0 to 3 loop	
			for anodeNumber in 0 to 3 loop
				if (anode = anodeValues(anodeNumber)) then
					assert (cathode = intToCathodeValue(cathodeGroundTruth(anodeNumber))) report "Incorrect cathode value";
					if (cathode /= intToCathodeValue(cathodeGroundTruth(anodeNumber))) then
						err_cnt := err_cnt + 1; 
--						report "Error count increased to " & integer'image(err_cnt);
					end if;
				else
						res_err_cnt := res_err_cnt + 1;
--						report "Res Error count increased to " & integer'image(res_err_cnt);
				end if;
			end loop;
			
			wait for clk_period;	
			
		end loop;
		load_inputs <= '0';
		
		if(err_cnt > 0 or (res_err_cnt-12) > 0) then
			final_err_cnt := final_err_cnt + 1;
			report "Final error count increased to " & integer'image(final_err_cnt);
		end if;
		
		
		
		
--		------------------------------------------------------------
--      --------------------- pre-case 5 ---------------------------
--		------------------------------------------------------------
		sim_mode <= '1';
		-- Set inputs
		dividend <= "00001100";
		divisor <= "00000011";
		
		wait for 4*clk_period;
		
		load_inputs <= '1';

		wait for 10*clk_period;			-- ensures completion of division


		-------------------------------------------------------------
		---------------------  case 5 -------------------------------
		-------------------------------------------------------------
		err_cnt := 0;
		res_err_cnt := 0;
		
		assert (output_valid = '1') report "Error: output is not yet ready";
		
		if (output_valid /= '1' or input_invalid /= '0') then
			err_cnt := err_cnt + 1; report "Error count increased to " & integer'image(err_cnt);
		end if;
		
		cathodeGroundTruth := (0,4,0,0);
		
		for cycleNo in 0 to 3 loop	
			for anodeNumber in 0 to 3 loop
				if (anode = anodeValues(anodeNumber)) then
					assert (cathode = intToCathodeValue(cathodeGroundTruth(anodeNumber))) report "Incorrect cathode value";
					if (cathode /= intToCathodeValue(cathodeGroundTruth(anodeNumber))) then
						err_cnt := err_cnt + 1; 
--						report "Error count increased to " & integer'image(err_cnt);
					end if;
				else
						res_err_cnt := res_err_cnt + 1;
--						report "Res Error count increased to " & integer'image(res_err_cnt);
				end if;
			end loop;
			
			wait for clk_period;	
			
		end loop;
--		load_inputs <= '0';
		
		if(err_cnt > 0 or (res_err_cnt-12) > 0) then
			final_err_cnt := final_err_cnt + 1;
			report "Final error count increased to " & integer'image(final_err_cnt);
		end if;
		

--		err_cnt := err_cnt + (res_err_cnt-72);
		report "Total error count " & integer'image(final_err_cnt);
		err_cnt_signal <= final_err_cnt;		
		-- summary of all the tests
		if (final_err_cnt=0) then
			 assert false
			 report "Testbench of Lab 7 completed successfully!"
			 severity note;
		else
			 assert false
			 report "Something wrong, try again"
			 severity error;
		end if;

      -- end of tb 
		wait for clk_period*100;

      wait;
   end process;

END;

