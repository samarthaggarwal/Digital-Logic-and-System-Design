library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity lab5_gcd is

	port(
		clk		:	in std_logic;
		a_i		:	in std_logic_vector(7 downto 0);
		b_i		:	in std_logic_vector(7 downto 0);
		push_i		:	in std_logic;
		pushbutton	:	in std_logic;

		load		:	out std_logic;
		sub		:	out std_logic;
		op_valid	:	out std_logic;
		cathode		:	out std_logic_vector(6 downto 0);
		anode		:	out std_logic_vector(6 downto 0);
		);

end lab5_gcd;

architecture behavioral of lab5_gcd is

	signal cnt: integer :=0;
	signal cnt_display: integer :=0;
	signal slow_clk: std_logic :='0';
	signal slow_clk_d: std_logic :='0';
	signal clock_update: std_logic;
	signal clock_display: std_logic;

	signal temp_a		:	std_logic_vector(7 downto 0) :='00000000';
	signal temp_b		:	std_logic_vector(7 downto 0) :='00000000';
	signal temp_d		:	std_logic_vector(7 downto 0) :='00000000';
	signal valid		:	std_logic;

--	signal a1		:	integer;
--	signal a0		:	integer;
--	signal b1		:	integer;
--	signal b0		:	integer;

begin

	process(clk)
	begin
		if clk'EVENT and clk='1' then
			if (cnt > 200000000) then
				cnt <= 0;
				slow_clk <= NOT slow_clk;
			end if;
				cnt <= cnt+1;
		end if;
	end process;

	process(clk)
	begin
		if clk'EVENT and clk='1' then
			if (cnt_display > 100000) then
				cnt_display <= 0;
				slow_clk_d <= NOT slow_clk_d;
			end if;
				cnt_display <= cnt_display+1;
		end if;
	end process;

	clock_update <= ( pushbutton and clk ) or ( ( NOT pushbutton ) and slow_clk );
	clock_display <= ( pushbutton and clk ) or ( ( NOT pushbutton ) and slow_clk_d );


	process(a_i,b_i)
	begin
		if NOT (a_i = '00000000' or b_i = '00000000' or ( a_i(7) and (a_i(6) or a_i(5)) ) or ( b_i(7) and (b_i(6) or b_i(5)) )   )
			valid <= '1';
		else
			valid <= '0';
		end if
		op_valid <= valid;
	end process;


	process(push_i)
	begin
		if ( push_i ='1' and valid='1' )  then
			load <= '1';
			sub <= '0' ;
		elsif ( push_i ='1' and valid='0' )  then
			load <= '0';
			sub <= '0' ;
		end if;
	end process;

	process(load)
	begin
		if(load = '1') then
			temp_a <= a_i;
			temp_b <= b_i;
			sub <= '1';
			load <= '0';

	end process;

	process(clock_update)
	begin
		if sub='1' then
			if temp_a /= temp_b then
				if( to_integer(unsigned(temp_a(7 downto 4))) > to_integer(unsigned(temp_b(7 downto 4))) ) or ( ( to_integer(unsigned(temp_a(7 downto 4))) = to_integer(unsigned(temp_b(7 downto 4))) ) and ( to_integer(unsigned(temp_a(3 downto 0))) > to_integer(unsigned(temp_b(3 downto 0))) ) ) then
					
					if( to_integer(unsigned(temp_a(3 downto 0))) >= to_integer(unsigned(temp_b(3 downto 0))) ) then
						temp_a(7 downto 4) <= std_logic_vector( unsigned(temp_a(7 downto 4)) - unsigned(temp_b(7 downto 4)) );
						temp_a(3 downto 0) <= std_logic_vector( unsigned(temp_a(3 downto 0)) - unsigned(temp_b(3 downto 0)) );
						
					else
						temp_a(7 downto 4) <= std_logic_vector( unsigned(temp_a(7 downto 4)) - unsigned(temp_b(7 downto 4)) - 1 );
						temp_a(3 downto 0) <= std_logic_vector( unsigned(temp_a(3 downto 0)) - unsigned(temp_b(3 downto 0)) + 10);
					end if
					
				elsif( to_integer(unsigned(temp_b(7 downto 4))) > to_integer(unsigned(temp_a(7 downto 4))) ) or ( ( to_integer(unsigned(temp_b(7 downto 4))) = to_integer(unsigned(temp_a(7 downto 4))) ) and ( to_integer(unsigned(temp_b(3 downto 0))) > to_integer(unsigned(temp_a(3 downto 0))) ) )  then
					if( to_integer(unsigned(temp_b(3 downto 0))) >= to_integer(unsigned(temp_a(3 downto 0))) ) then
						temp_b(7 downto 4) <= std_logic_vector( unsigned(temp_b(7 downto 4)) - unsigned(temp_a(7 downto 4)) );
						temp_b(3 downto 0) <= std_logic_vector( unsigned(temp_b(3 downto 0)) - unsigned(temp_a(3 downto 0)) );
						
					else
						temp_b(7 downto 4) <= std_logic_vector( unsigned(temp_b(7 downto 4)) - unsigned(temp_a(7 downto 4)) - 1 );
						temp_b(3 downto 0) <= std_logic_vector( unsigned(temp_b(3 downto 0)) - unsigned(temp_a(3 downto 0)) + 10);
					end if
					
				end if;
			else
				sub <='0';
			end if;
		end if;
	end process;

	

end behavioral;


