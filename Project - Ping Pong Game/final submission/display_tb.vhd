----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/17/2017 04:56:31 PM
-- Design Name: 
-- Module Name: ssd_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--USE ieee.numeric_std.ALL;
library std;
use std.textio.all;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display_tb is
--  Port ( );
end display_tb;

architecture Behavioral of display_tb is

component display
   port ( b : in  STD_LOGIC_VECTOR (15 downto 0);
				  pushbutton : in STD_LOGIC;
              cathode : out  STD_LOGIC_VECTOR (6 downto 0);
              anode : out  STD_LOGIC_VECTOR (3 downto 0);
              clk : in  STD_LOGIC);
   end component;
   
    signal b : STD_LOGIC_VECTOR (15 downto 0);
       signal pushbutton : STD_LOGIC;
      signal cathode : STD_LOGIC_VECTOR (6 downto 0);
      signal anode : STD_LOGIC_VECTOR (3 downto 0);
      signal clk : STD_LOGIC := '1';
  
      signal err_cnt_signal : INTEGER;
      signal second_input : STD_LOGIC := '0';
    
       type display_output is array (0 to 3) of STD_LOGIC_VECTOR (6 downto 0);
       type bin_type is array (0 to 3) of STD_LOGIC_VECTOR (15 downto 0);
       type error_type is array (0 to 3) of INTEGER;
		 type anodeSeen_type is array (0 to 3) OF STD_LOGIC_VECTOR (3 downto 0);

   
begin


   UUT: display port map(
		b => b, 
		pushbutton => pushbutton,
		cathode => cathode, 
		anode => anode, 
		clk => clk
   );

    clk_process :process
    begin
	   wait for 5 ns;
        clk <= not clk;
    end process;
    
-- *** Test Bench - User Defined Section ***
    tb : process (clk)
   	    variable b_input : bin_type := (others => (others=>'0'));

        variable err_cnt : INTEGER := 0;
        variable s : line;
        variable first_cycle : INTEGER := 0;
        variable input_index : INTEGER := 0;
        variable cathode0 : display_output := (others => (others=>'0'));
        variable cathode1 : display_output := (others => (others=>'0'));
        variable cathode2 : display_output := (others => (others=>'0'));
        variable cathode3 : display_output := (others => (others=>'0'));
        variable error_testcase : error_type := (others => 0);
        variable error_printed : INTEGER := 0;
		  variable cycle_number : INTEGER := 0;
		  variable verification_index : INTEGER := 0;
		  variable anodeSeen : anodeSeen_type := (others => (others=>'0'));
        
        begin
            b_input := ("0000000000000000","0001001000110100","0101011001111000","1001110011011111");
            cathode3 :=  ("1000000","1111001","0010010","0010000");
            cathode2 :=  ("1000000","0100100","0000010","1000111");
            cathode1 :=  ("1000000","0110000","1111000","0001001");
            cathode0 :=  ("1000000","0011001","0000000","1000000");
            
      
            if ((clk'event and clk = '1') and input_index <= 3) then
                pushbutton <= '1';
                b <= b_input(input_index);
                
						-- initial check
                if(first_cycle = 0) then	
                    first_cycle := 1;
                    report "Spending 1 cycle (10ns) idle";
                elsif(first_cycle = 1) then	
                        first_cycle := 2;
                        report "Spending 2 cycle (10ns) idle";
					 else	
							if(anode = "1110") then
									if(cathode /= cathode0(verification_index)) then
										 report "(1) Error in testcase .1 " & integer'image(input_index+1) & " : 0111 : " & integer'image(to_integer(unsigned(cathode)));
										 error_testcase(verification_index) := 1;
--									else
--										 report "Test case" & integer'image(input_index+1) & " : 1110 : " & integer'image(to_integer(unsigned(cathode)));
									end if;    
							 elsif(anode = "1101") then
									if(cathode /= cathode1(verification_index)) then
										 report "(2) Error in testcase .2 " & integer'image(input_index+1) & " : 0111 : " & integer'image(to_integer(unsigned(cathode)));
										 error_testcase(verification_index) := 1;
--									else
--                                              report "Test case" & integer'image(input_index+1) & " : 1101 : " & integer'image(to_integer(unsigned(cathode)));
									end if;
							 elsif(anode = "1011") then
									if(cathode /= cathode2(verification_index)) then
										 report "(3) Error in testcase .3 " & integer'image(input_index+1) & " : 0111 : " & integer'image(to_integer(unsigned(cathode)));
										 error_testcase(verification_index) := 1;
--									else
--                                              report "Test case" & integer'image(input_index+1) & " : 1011 : " & integer'image(to_integer(unsigned(cathode)));										 
									end if;    
							 elsif(anode = "0111") then
									if(cathode /= cathode3(verification_index)) then
										 report "(4) Error in testcase .4 " & integer'image(input_index+1) & " : 0111 : " & integer'image(to_integer(unsigned(cathode)));
										 error_testcase(verification_index) := 1;
--									else
--                                              report "Test case" & integer'image(input_index+1) & " : 0111 : " & integer'image(to_integer(unsigned(cathode)));
									end if;
							 else
									report "(5) Error in testcase .5 " & integer'image(input_index+1);
									error_testcase(verification_index) := 1;
							 end if;
							  anodeSeen(cycle_number mod 4) := anode;
							  if ( cycle_number > 0 and cycle_number mod 4 = 0 ) then
							         first_cycle :=0;

									if ( anodeSeen(0) = anodeSeen(1) or anodeSeen(0) = anodeSeen(2) or  anodeSeen(0) = anodeSeen(3)
											or anodeSeen(1) = anodeSeen(2) or anodeSeen(1) = anodeSeen(3) or anodeSeen(2) = anodeSeen(3) )
											then
											report "(6) not all anodes seen in testcase" & integer'image(input_index+1);
											error_testcase(verification_index) := 1;
									end if;											
								end if;
						end if;

            if(cycle_number = 15 and error_printed = 0) then
							report "printing errors";
                     for i in 0 to error_testcase'LENGTH-1 loop
								err_cnt := err_cnt + error_testcase(i);									
                     end loop;
                     report "err_cnt is " & integer'image(err_cnt);
                     err_cnt_signal <= err_cnt; 
                     -- summary of all the tests
                     if (err_cnt=0) then
								assert false
								report "Testbench of Display completed successfully!"
								severity note;
                     else
								assert false
                        report "Something wrong, try again"
                        severity error;
                     end if;
                     error_printed := 1;
            end if;
				cycle_number := cycle_number + 1;
				input_index := cycle_number / 4;
				verification_index := (cycle_number - 1) / 4;
        end if;      
    end process;        
end Behavioral;
