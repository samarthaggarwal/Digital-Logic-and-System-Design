-- Testbench : /ayush@ayush-Aspire-E5-573G/home

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ping_pong_tb is
end;

architecture bench of ping_pong_tb is

  component ping_pong
      Port ( return1 : in STD_LOGIC;
             return2 : in STD_LOGIC;
             speed1 : in STD_LOGIC;
             speed2 : in STD_LOGIC;
             reset : in STD_LOGIC;
             clk : in STD_LOGIC;
             sw1 : in STD_LOGIC;
             sw2 : in STD_LOGIC;
             anode : out STD_LOGIC_VECTOR (3 downto 0);
             cathode : out STD_LOGIC_VECTOR (6 downto 0);
             led : out STD_LOGIC_VECTOR (15 downto 0));
  end component;
  
-- Custom Types
      type display_output is array (0 to 12) of std_logic_vector(6 downto 0);
      type anode_output_array is array(0 to 3) of std_logic_vector(3 downto 0);

--Input
  signal return1: STD_LOGIC;
  signal return2: STD_LOGIC;
  signal speed1: STD_LOGIC;
  signal speed2: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal clk: STD_LOGIC;
  signal sw1: STD_LOGIC;
  signal sw2: STD_LOGIC;

 	--Outputs
   signal anode : std_logic_vector(3 downto 0);
   signal cathode : std_logic_vector(6 downto 0);
   signal led: STD_LOGIC_VECTOR (15 downto 0);

    constant clk_period : time := 500 ms;
	signal err_cnt_signal : integer := 0;
	constant intToCathodeValue : display_output := ("1000000","1111001","0100100","0110000","0011001","0010010","0000010","1111000","0000000","0010000","1000111","0001001","0111111");
	constant anodeValues : anode_output_array := ("0111","1011","1101","1110");
	
	
begin

  uut: ping_pong port map ( return1 => return1,
                            return2 => return2,
                            speed1  => speed1,
                            speed2  => speed2,
                            reset   => reset,
                            clk     => clk,
                            sw1     => sw1,
                            sw2     => sw2,
                            anode   => anode,
                            cathode => cathode,
                            led     => led );

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
		variable cathodeGroundTruth : intArray := (0,0,10,10);
		variable err_cnt : INTEGER := 0;
   begin		
     
		------------------------------------------------------------
      --------------------- checking reset---------------------------
		------------------------------------------------------------
		
		reset <= '1';
		return1 <= '0';
		return2 <= '0';
		speed1 <= '0';
		speed2 <= '0';
		sw1 <= '0';
		sw2 <= '0';
		-- Set inputs

		wait for 15 ns;
		
      -------------------------------------------------------------
		---------------------  checking led for off state -------------------------------
		-------------------------------------------------------------
		
		report   "LED 0 : " & integer'image(to_integer(unsigned(led)));
		assert (led = "0000000000000000") report "Error: LED not reset";
		if (led /= "0000000000000000") then
			err_cnt := err_cnt + 1;
		end if;
      cathodeGroundTruth := (0,0,10,10);
		
		---------------- checking all the ssd values --------------------------
		
			for anodeNumber in 0 to 3 loop
				if (anode = anodeValues(anodeNumber)) then
				    report integer'image(to_integer(unsigned(anode))) & " " &integer'image(to_integer(unsigned(intToCathodeValue(cathodeGroundTruth(anodeNumber))))) & " " & integer'image(to_integer(unsigned(cathode)));
					assert (cathode = intToCathodeValue(cathodeGroundTruth(anodeNumber))) report "Incorrect cathode value for reset";
					if (cathode /= intToCathodeValue(cathodeGroundTruth(anodeNumber))) then
						err_cnt := err_cnt + 1;
					end if;
				end if;
			end loop;
		
			wait for 500 ms;	
			
		--------------- checking movement of led towards left -------------------
		
		report  "LED just after reset : " & integer'image(to_integer(unsigned(led)));
        assert (led = "0000000010000000") report "Error: LED not moving after reset";
        if (led /= "0000000010000000") then
            err_cnt := err_cnt + 1;
        end if;
	
	   reset <= '0';

		
		err_cnt_signal <= err_cnt;		
		-- summary of all the tests
        report "err_cnt is " & integer'image(err_cnt);
		if (err_cnt=0) then
			 assert false
			 report "Testbench of ping pong completed successfully!"
			 severity note;
		else
			 assert false
			 report "Something wrong, try again"
			 severity error;
		end if;

      -- end of tb 
		wait for 2 ns;
		
		

      wait;
   end process;



end bench;


