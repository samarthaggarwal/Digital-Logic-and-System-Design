

library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity adder is

    port( 
        a : in std_logic :='0';
        b : in std_logic :='0';
        c0 : in std_logic :='0';
        s : out std_logic;
        c1: out std_logic);

end adder;

architecture simple of adder is

begin

    s <= a xor b xor c0;
    c1 <= ( ( a or b ) and c0 ) or ( a and b);

end simple;



library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity adder_4 is

    port(
            i : in std_logic_vector(7 downto 0):="00000000";
            j : in std_logic_vector(7 downto 0):="00000000";
            o : out std_logic_vector(8 downto 0));

end adder_4;

architecture simple of adder_4 is

    signal c : std_logic_vector(6 downto 0) :="0000000";

begin
    

	u0:entity work.adder(simple) 
        port map( a =>  i(0),
                  b =>  j(00),
                  c0 => '0' ,
                  s =>  o(0),
                  c1 => c(0));
                  
    xx:for h in 1 to 6 generate
    
    	uh:entity work.adder(simple) 
                      port map( a =>  i(h),
                                b =>  j(h),
                                c0 => c(h-1) ,
                                s =>  o(h),
                                c1 => c(h));
    
    end generate;
                  
	u7:entity work.adder(simple) 
                      port map( a =>  i(7),
                                b =>  j(7),
                                c0 => c(6) ,
                                s =>  o(7),
                                c1 => o(8));
                                

end simple;





library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity adder_4_2 is

    port(
            i : in std_logic_vector(7 downto 0):="00000000";
            j : in std_logic_vector(7 downto 0):="00000000";
            k : in std_logic_vector(7 downto 0):="00000000";
            o : out std_logic_vector(7 downto 0);
            c : out std_logic_vector(7 downto 0));

end adder_4_2;

architecture simple of adder_4_2 is

begin
    

	u0:entity work.adder(simple) 
        port map( a =>  i(0),
                  b =>  j(0),
                  c0 => k(0),
                  s =>  o(0),
                  c1 => c(0));
                  
    xx:for h in 1 to 6 generate
    
    	uh:entity work.adder(simple) 
                      port map( a =>  i(h),
                                b =>  j(h),
                                c0 => k(h) ,
                                s =>  o(h),
                                c1 => c(h));
    
    end generate;
                  
	u7:entity work.adder(simple) 
                      port map( a =>  i(7),
                                b =>  j(7),
                                c0 => k(7) ,
                                s =>  o(7),
                                c1 => c(7));
                                

end simple;



--library ieee;
--use ieee.std_logic_1164.all;
--library UNISIM;
--use UNISIM.Vcomponents.ALL;

--entity comparator is
--    port(
--            in1 : in std_logic_vector(7 downto 0) :=(others=>'0');
--            in2 : in std_logic_vector(7 downto 0) :=(others=>'0');
--            result : out boolean);
            
--end comparator;

--architecture simple of comparator is
--begin

--end simple;






--library ieee;
--use ieee.std_logic_1164.all;
--library UNISIM;
--use UNISIM.Vcomponents.ALL;

--entity subtract is
--    port(
--            a : in std_logic;
--            b : in std_logic;
--            c : out std_logic;
--            s : out std_logic);

            
--end subtract;

--architecture simple of subtract is
--begin

--end simple;




library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity subtract_8 is
    port(
            in1 : in std_logic_vector(7 downto 0) :=(others=>'0');
            in2 : in std_logic_vector(7 downto 0) :=(others=>'0');
            clk : in std_logic;
            result : out std_logic_vector(7 downto 0) :=(others=>'0'));
            
end subtract_8;

architecture simple of subtract_8 is
    
    signal c : std_logic :='0';
    
begin

    process(clk)
    begin
    
        c <= '0';
        for i in 0 to 7 loop
            result(i) <= in1(i) xor in2(i) xor c;
            c <= ( ( not in1(i) ) and in2(i)) or ( ( not in1(i) ) and c) or ( in2(i) and c);
        end loop;
    
    end process;
        

end simple;
    
    




library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity mul_1 is

    port(   
            in1 : in std_logic_vector(7 downto 0) :=(others=>'0');
            in2 : in std_logic_vector(7 downto 0) :=(others=>'0');
            result : out std_logic_vector(15 downto 0));

end mul_1;

architecture simple of mul_1 is

    signal p : std_logic_vector(77 downto 0) :=(others=>'0');
    signal carry : std_logic_vector(77 downto 0) :=(others=>'0');
begin

    xx:for i in 0 to 7 generate
    
        yy:for j in 0 to 7 generate
        
            p(10*i+j) <= in1(i) and in2(j);
        
        end generate;
    
    end generate;
    
    result(0) <= p(00);
    
    u0:entity work.adder_4(simple)
        port map(
                    i (6 downto 0) => p(07 downto 01),
                    i(7) => '0',
                    j (7 downto 0) => p(17 downto 10),
                    o (8 downto 0) => carry(08 downto 00));

    xy:for i in 1 to 5 generate
        ui:entity work.adder_4(simple)
            port map(
                    i (7 downto 0) => carry((10*(i-1)+8) downto (10*(i-1)+1)),
                    j (7 downto 0) => p((10*(i+1)+7) downto (10*(i+1)+0)),
                    o (8 downto 0) => carry((10*i+8) downto (10*i+0)));

    end generate;
    
    u6:entity work.adder_4(simple)
        port map(
                    i (7 downto 0) => carry((58) downto (51)),
                    j (7 downto 0) => p((77) downto (70)),
                    o (8 downto 0) => result(15 downto 7));
    
    result(1) <= carry(00);
    result(2) <= carry(10);
    result(3) <= carry(20);
    result(4) <= carry(30);
    result(5) <= carry(40);
    result(6) <= carry(50);
                  

                                

end simple;






library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity mul_3 is

    port(   
            in1 : in std_logic_vector(7 downto 0) :=(others=>'0');
            in2 : in std_logic_vector(7 downto 0) :=(others=>'0');
            result : out std_logic_vector(15 downto 0));

end mul_3;

architecture simple of mul_3 is

    signal p : std_logic_vector(77 downto 0) :=(others=>'0');
    signal carry : std_logic_vector(77 downto 0) :=(others=>'0');
    signal cla : std_logic_vector(7 downto 0) :=(others=>'0');
    signal pp : std_logic_vector(7 downto 0) :=(others=>'0');
    signal gg : std_logic_vector(7 downto 0) :=(others=>'0');
    signal output : std_logic_vector(77 downto 0) :=(others=>'0');
begin

    xx:for i in 0 to 7 generate
    
        yy:for j in 0 to 7 generate
        
            p(10*i+j) <= in1(i) and in2(j);
        
        end generate;
    
    end generate;
    
    result(0) <= p(00);
    
    u0:entity work.adder_4_2(simple)
        port map(
                    i (7 downto 0) => p(08 downto 01),
                    j (7 downto 0) => p(17 downto 10),
                    k (7 downto 0) => p(26 downto 19),
                    c (7 downto 0) => carry(07 downto 00),
                    o (7 downto 0) => output(07 downto 00));

    xy:for i in 1 to 5 generate
        ui:entity work.adder_4_2(simple)
            port map(
                    i (7 downto 0) => carry((10*(i-1)+7) downto (10*(i-1)+0)),
                    j (6 downto 0) => output((10*(i-1)+7) downto (10*(i-1)+1)),
                    j(7) => p(10*(i+1)+(i+2)),
                    k (7 downto 0) => p((10*(i+2)+6) downto (10*(i+1)+9)),
                    c (7 downto 0) => carry((10*i+7) downto (10*i+0)),
                    o (7 downto 0) => output((10*i+7) downto (10*i+0)));

    end generate;
    
            uu0:entity work.adder(simple)
    port map(
            a => carry(77),
            b => p(77),
            c0 => cla(7),
            s => result(14),
            c1 => result(15));
            
        
        cla(0) <= '0';
        zz:for i in 0 to 6 generate
        
            pp(i) <= carry(70+i) or output(71+i);
            gg(i) <= carry(70+i) and output(71+i);
        
        end generate;
        
            pp(7) <= carry(77) or p(77);
            gg(7) <= carry(77) and p(77);
            

            cla(1) <= (pp(0) and cla(0)) or gg(0);
            cla(2) <= (pp(1) and pp(0) and cla(0)) or (pp(1) and gg(0)) or gg(1);
            cla(3) <= (pp(2) and pp(1) and pp(0) and cla(0)) or (pp(2) and pp(1) and gg(0)) or (pp(2) and gg(1)) or gg(2);
            cla(4) <= (pp(3) and pp(2) and pp(1) and pp(0) and cla(0)) or (pp(3) and pp(2) and pp(1) and gg(0)) or (pp(3) and pp(2) and gg(1)) or (pp(3) and gg(2)) or gg(3);
            
            cla(5) <= (pp(0) and cla(4)) or gg(0);
            cla(6) <= (pp(1) and pp(0) and cla(4)) or (pp(1) and gg(0)) or gg(1);
            cla(7) <= (pp(2) and pp(1) and pp(0) and cla(4)) or (pp(2) and pp(1) and gg(0)) or (pp(2) and gg(1)) or gg(2);

            
        xyz:for i in 0 to 6 generate
            uui:entity work.adder(simple)
                port map(
                        a => carry(70+i),
                        b => output(70+(i+1)),
                        c0 => cla(i),
                        s => result(7+i)
--                        c1 => 
                        );
    
        end generate;
            uu7:entity work.adder(simple)
            port map(
                    a => carry(77),
                    b => p(77),
                    c0 => cla(7),
                    s => result(14),
                    c1 => result(15));

    
    result(1) <= output(00);
    result(2) <= output(10);
    result(3) <= output(20);
    result(4) <= output(30);
    result(5) <= output(40);
    result(6) <= output(50);
                  

                                

end simple;









library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity mul_2 is

    port(   
            in1 : in std_logic_vector(7 downto 0) :=(others=>'0');
            in2 : in std_logic_vector(7 downto 0) :=(others=>'0');
            result : out std_logic_vector(15 downto 0));

end mul_2;

architecture simple of mul_2 is

    signal p : std_logic_vector(77 downto 0) :=(others=>'0');
    signal carry : std_logic_vector(77 downto 0) :=(others=>'0');
    signal output : std_logic_vector(77 downto 0) :=(others=>'0');
begin

    xx:for i in 0 to 7 generate
    
        yy:for j in 0 to 7 generate
        
            p(10*i+j) <= in1(i) and in2(j);
        
        end generate;
    
    end generate;
    
    result(0) <= p(00);
    
    u0:entity work.adder_4_2(simple)
        port map(
                    i (7 downto 0) => p(08 downto 01),
                    j (7 downto 0) => p(17 downto 10),
                    k (7 downto 0) => p(26 downto 19),
                    c (7 downto 0) => carry(07 downto 00),
                    o (7 downto 0) => output(07 downto 00));

    xy:for i in 1 to 5 generate
        ui:entity work.adder_4_2(simple)
            port map(
                    i (7 downto 0) => carry((10*(i-1)+7) downto (10*(i-1)+0)),
                    j (6 downto 0) => output((10*(i-1)+7) downto (10*(i-1)+1)),
                    j(7) => p(10*(i+1)+(i+2)),
                    k (7 downto 0) => p((10*(i+2)+6) downto (10*(i+1)+9)),
                    c (7 downto 0) => carry((10*i+7) downto (10*i+0)),
                    o (7 downto 0) => output((10*i+7) downto (10*i+0)));

    end generate;
    
    u6:entity work.adder_4(simple)
        port map(
                    i (6 downto 0) => output((57) downto (51)),
                    i(7) => p(77),
                    j (7 downto 0) => carry((57) downto (50)),
                    o (8 downto 0) => result(15 downto 7));
    
    result(1) <= output(00);
    result(2) <= output(10);
    result(3) <= output(20);
    result(4) <= output(30);
    result(5) <= output(40);
    result(6) <= output(50);
                  

                                

end simple;



library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.ALL;
use ieee.numeric_std.all;

entity subtractor is
    port(   a : in std_logic_vector(15 downto 0) :=(others=>'0');
            b : in std_logic_vector(7 downto 0) :=(others=>'0');
            c : out std_logic_vector(15 downto 0) :=(others=>'0');
            d : out std_logic :='0');
            
end subtractor;

architecture simple of subtractor is
signal temp : std_logic_vector(15 downto 0) :=(others=>'0');
signal temp2 : std_logic_vector(7 downto 0) :=(others=>'0');
begin

    temp(15 downto 0) <= a(15 downto 0);
    d <= '1' when temp(15 downto 8) >= b(7 downto 0) else '0';
    temp2(7 downto 0) <= std_logic_vector(unsigned(temp(15 downto 8)) - unsigned(b(7 downto 0))) when temp(15 downto 8) >= b(7 downto 0) else temp(15 downto 8);
    c(15 downto 8) <= temp2(7 downto 0);
    c(7 downto 0) <= temp(7 downto 0);

end simple;


    


library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.ALL;
use ieee.numeric_std.all;

entity div_u is
    port(
            in1 : in std_logic_vector(7 downto 0) :=(others=>'0');
            in2 : in std_logic_vector(7 downto 0) :=(others=>'0');
--            quotient : out std_logic_vector(7 downto 0) :=(others=>'0');
--            remainder : out std_logic_vector(7 downto 0) :=(others=>'0');
            result : out std_logic_vector(15 downto 0) :=(others=>'0'));
            
end div_u;

architecture simple of div_u is
    
    type arraytype is array (0 to 8) of std_logic_vector(15 downto 0);
    signal temp : arraytype;
    signal temp2 : arraytype;
    signal c : std_logic_vector(7 downto 0) :=(others=>'0');    
begin

--    quotient(7 downto 0) <= temp2(8)(7 downto 0);
--    remainder(7 downto 0) <= temp2(8)(15 downto 8);
    result(15 downto 8) <= temp(8)(15 downto 8);
    result(7 downto 0) <= c(7 downto 0);
    temp(0)(7 downto 0) <= in1(7 downto 0);
    temp(0)(15 downto 8) <= "00000000";
    
    abc:for i in 0 to 7 generate
    
    temp2(i)(15 downto 1) <= temp(i)(14 downto 0);
    temp2(i)(0) <= '0';
    
        xyz:entity work.subtractor(simple)
            port map(   a => temp2(i),
                        b => in2,
                        c => temp(i+1),
                        d => c(7-i));
    
    end generate;
        
    
    

end simple;






    


--library ieee;
--use ieee.std_logic_1164.all;
--library UNISIM;
--use UNISIM.Vcomponents.ALL;
--use ieee.numeric_std.all;

--entity div_u is
--    port(
--            in1 : in std_logic_vector(7 downto 0) :=(others=>'0');
--            in2 : in std_logic_vector(7 downto 0) :=(others=>'0');
--            clk : in std_logic;
--            result : out std_logic_vector(15 downto 0) :=(others=>'0'));
            
--end div_u;

--architecture simple of div_u is
    
--    signal c : std_logic :='0';
--    signal temp : std_logic_vector(15 downto 0) :=(others=>'0');
--    signal temp2 : std_logic_vector(15 downto 0) :=(others=>'0');
--    signal temp3 : std_logic_vector(15 downto 0) :=(others=>'0');
--    signal quo : std_logic_vector(7 downto 0) :=(others=>'0');
    
--begin

--    process(clk)
--    begin
    
--        temp(7 downto 0) <= in1(7 downto 0);
--        temp(15 downto 8) <= "00000000";
        
--        for j in 0 to 7 loop
        
--            temp2(15 downto 0) <= temp(15 downto 0);
--            temp(15 downto 1) <= temp2(14 downto 0);
--            temp(0) <= '0';
--            if ( (temp((15) downto 8) > in2(7 downto 0) ) or (temp(15 downto 8) = in2(7 downto 0) ) ) then
            
----                c <= '0';
----                for i in 0 to 7 loop
----                    temp3(15 downto 0) <= temp(15 downto 0);
----                    temp(8+i) <= temp3(8+i) xor in2(i) xor c;
----                    c <= ( ( not temp3(8+i) ) and in2(i)) or ( ( not temp3(8+i) ) and c) or ( in2(i) and c);
----                end loop;
--                    temp3(15 downto 0) <= temp(15 downto 0);
--                    temp(15 downto 8 ) <= std_logic_vector ( unsigned(temp3(15 downto 8)) - unsigned(in2(7 downto 0)) );
--                quo(7-j) <= '1'; 
--            else
--                quo(7-j) <= '0';
            
--                end if;
            
--        end loop;
        
--        result(15 downto 8) <= quo(7 downto 0);
--        result(7 downto 0) <= temp(15 downto 8);
    
--    end process;
        

--end simple;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;


entity lab7_divider is

	port(
		clk		:	in std_logic;
		dividend		:	in std_logic_vector(7 downto 0);
		divisor		:	in std_logic_vector(7 downto 0);
		output_valid : out std_logic :='0';
		input_invalid : out std_logic :='0';
		load_inputs : in std_logic :='0';
		sim_mode : in std_logic :='0';
		cathode		:	out std_logic_vector(6 downto 0);
		anode		:	out std_logic_vector(3 downto 0));


end lab7_divider;

architecture behavioral of lab7_divider is


	component lab4_seven_segment_display is
	   port ( b     : in std_logic_vector(15 downto 0);
		  clk        : in    std_logic; 
		  pushbutton : in    std_logic; 
		  anode      : out   std_logic_vector (3 downto 0); 
		  cathode    : out   std_logic_vector (6 downto 0));
	end component;
	
	
	signal div : std_logic_vector(15 downto 0):="0000000000000000";
	signal quotient : std_logic_vector(7 downto 0):="00000000";
	signal remainder : std_logic_vector(7 downto 0):="00000000";
	signal quotient2 : std_logic_vector(7 downto 0):="00000000";
    signal remainder2 : std_logic_vector(7 downto 0):="00000000";
	signal quotient3 : std_logic_vector(7 downto 0):="00000000";
    signal remainder3 : std_logic_vector(7 downto 0):="00000000";
	signal pushbutton : std_logic :='0';
	signal sign1 : std_logic :='0';
	signal sign2 : std_logic :='0';
	signal inv1 : std_logic_vector(7 downto 0) :=(others=>'0');
	signal inv2 : std_logic_vector(7 downto 0) :=(others=>'0');
	signal in1 : std_logic_vector(7 downto 0) :=(others=>'0');
    signal in2 : std_logic_vector(7 downto 0) :=(others=>'0');
--	signal p : std_logic_vector (77 downto 0);
	
	
begin

--    input_invalid <= '0' when ( load_inputs='1' and not(divisor="00000000")) else '1' when ( load_inputs='1' and divisor="00000000");
--    output_valid <= '1' when ( load_inputs='0' and not(div="0000000000000000"));

 
    process(load_inputs)
    begin
    
    if (load_inputs='1') then
    
        if (divisor="00000000") then
            input_invalid <= '1';
            output_valid <= '0';
        else
            input_invalid <= '0';
            output_valid <= '1';
        end if;
    
    end if;
    
    end process;
       
    sign1 <= dividend(7);
    sign2 <= divisor(7);
    
    aaa:for i in 0 to 6 generate
    
        inv1(i) <= dividend(i) when sign1='0' else not(dividend(i));
        inv2(i) <= divisor(i) when sign2='0' else not(divisor(i));
    
    end generate; 
    
    in1(7 downto 0) <= inv1(7 downto 0) when sign1='0' else std_logic_vector( unsigned(inv1) + "1" );
    in2(7 downto 0) <= inv2(7 downto 0) when sign2='0' else std_logic_vector( unsigned(inv2) + "1" );
    
    div(15 downto 8) <= quotient3(7 downto 0);
    div(7 downto 0) <= remainder3(7 downto 0);
        
    bbb:for i in 0 to 7 generate
    
        quotient2(i) <= quotient(i) when sign1=sign2 else not(quotient(i));
        remainder2(i) <= remainder(i) when sign1='0' else not(remainder(i));
    
    end generate;

    quotient3(7 downto 0) <= quotient2(7 downto 0) when sign1=sign2 else std_logic_vector( unsigned(quotient2) + "1" );
    remainder3(7 downto 0) <= remainder2(7 downto 0) when sign1='0' else std_logic_vector( unsigned(remainder2) + "1" );
    
    xxx:entity work.div_u(simple)
        port map(   in1(7 downto 0) => in1(7 downto 0),
                    in2(7 downto 0) => in2(7 downto 0),
                    result(15 downto 8) => remainder(7 downto 0),
                    result(7 downto 0) => quotient(7 downto 0));
    
   
   


	display: lab4_seven_segment_display
	port map( b(15 downto 0) => div(15 downto 0), 
		  clk => clk,
		  pushbutton => pushbutton, 
		  anode(3 downto 0) => anode(3 downto 0), 
		  cathode(6 downto 0) => cathode(6 downto 0));

end behavioral;













--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

------ Uncomment the following library declaration if instantiating
------ any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--entity divisor is
--    Port ( anode      : out   std_logic_vector (3 downto 0); 
--           cathode    : out   std_logic_vector (6 downto 0);
--           Dividend : in  STD_LOGIC_VECTOR (7 downto 0);
--           Divis : in  STD_LOGIC_VECTOR (3 downto 0);
--           clk : in  STD_LOGIC;
--           Start : in  STD_LOGIC;
--           Remainder : out  STD_LOGIC_VECTOR (3 downto 0);
--	   Quotient : out  STD_LOGIC_VECTOR (3 downto 0);
--           Done : out  STD_LOGIC);
--end divisor;

--architecture Behavioral of divisor is

--	component lab4_seven_segment_display is
--	   port ( b     : in std_logic_vector(15 downto 0);
--		  clk        : in    std_logic; 
--		  pushbutton : in    std_logic; 
--		  anode      : out   std_logic_vector (3 downto 0); 
--		  cathode    : out   std_logic_vector (6 downto 0));
--	end component;
	
--signal DivBuf: STD_LOGIC_VECTOR (3 downto 0);
---- signal DivNeg: STD_LOGIC_VECTOR (3 downto 0);

--signal ACC: STD_LOGIC_VECTOR (7 downto 0);
--signal sum: STD_LOGIC_VECTOR (3 downto 0);
--signal Remaind :  STD_LOGIC_VECTOR (3 downto 0);

--type state is (S0, S1, S2, S3, S4);
--signal FSM_cur_state, FSM_nx_state: state;
--Signal Counter: STD_LOGIC_VECTOR (2 downto 0);
--signal INC_CNT: STD_LOGIC;
--signal LD_high: STD_LOGIC;
--signal AccShift_left0: STD_LOGIC;
--signal AccShift_left1: STD_LOGIC;
----signal addd: STD_LOGIC;
----signal subb: STD_LOGIC;
--signal FSM_Done: STD_LOGIC;
----signal sum: STD_LOGIC_VECTOR(3 downto 0);

--begin

--DivisorReg: process (clk, start)
--begin
--   if clk'event and clk = '1' then 
--	  if start = '1' then
--	  DivBuf <= Divis;
--	  end if;
--	 end if;
--end process;

--ComboSum: process(DivBuf, ACC)
--begin
--    	 sum <= ACC(7 downto 4) + (not(DivBuf) + 1);
--end process;

--ACCReg: process (clk, start, Dividend, sum,
--  AccShift_left0, AccShift_left1, LD_high)
--begin
--   if clk'event and clk = '1' then
--	  if start = '1' then
--	  ACC <= Dividend(6 downto 0)&'0';	
	  
--	  elsif  LD_high = '1' then 
--	     ACC(7 downto 4) <= sum;
--	  elsif AccShift_left0 = '1' then
--			ACC <= ACC(6 downto 0) & '0';
--	     elsif AccShift_left1 = '1' then
--	     ACC <= ACC(6 downto 0) & '1';
--	 end if;
--	 end if;	
--end process;

---- output the results
--Result: process(ACC)
--begin  
--	 Quotient  <= ACC(3 downto 0);	 
--	 Remainder <= '0'&ACC(7 downto 5);	 
--end process;

---- Combo Control Output
--ComboFSMoutput: process(FSM_cur_State, start, sum, FSM_done)
--begin
--   INC_CNT <= '0';
--   LD_high <= '0';
--   AccShift_left0 <= '0';
--   AccShift_left1 <= '0';
--	case FSM_cur_State is 
--	when S0 =>
--	          if start = '1' then 
--				 FSM_nx_State <= S0;
--				 elsif sum(3) = '0' then 
--				 FSM_nx_State <= S1;		 
--				 else 
--				 FSM_nx_State <= S2;
--				 end if;
				 
--	when S1 =>
--				 LD_high <= '1';
--				 FSM_nx_State <= S3;
	          	
--	when S2 =>
--	         AccShift_left0 <= '1';
--				INC_CNT <= '1';
--	         FSM_nx_State <= S4;
				
--	when S3 => 
--	         AccShift_left1 <= '1';
--				INC_CNT <= '1';
--				FSM_nx_State <= S4;
				
--	when S4 =>
--	         if FSM_done = '1' then 
--				FSM_nx_State <= S4;
--				else
--				FSM_nx_State <= S0;
--				end if;
--	end case;	
--end process;

---- FSM next state register	  
--RegFSM_State: process (clk, FSM_nx_State, start)
--begin
--    if (clk'event and clk = '1') then 
--	     if start ='1' then 
--		  FSM_Cur_State <= S0;
--		  else
--		  FSM_Cur_State <= FSM_nx_State;
--		  end if;
--	 end if;
--end process;

---- Counter to control the iteration
--RegCounter: process(clk, start)
--begin
--    if clk'event and clk = '1' then 
--	    if start = '1' then
--		 Counter <= (others => '0');
--		 elsif INC_CNT = '1' then
--		 Counter <= Counter + 1;
--		 end if;
--	 end if;
--end process;

---- update FSM_done
--ComboFSMdone: process(Counter)
--begin
--   FSM_done <= counter(2) and (not(counter(1)))  and (not(counter(0)));
--end process;

--process(FSM_done)
--begin 
--		done <= FSM_done;
--end process;

--	display: lab4_seven_segment_display
--	port map( b(15 downto 0) => ACC(15 downto 0), 
--		  clk => clk,
--		  pushbutton => Start, 
--		  anode(3 downto 0) => anode(3 downto 0), 
--		  cathode(6 downto 0) => cathode(6 downto 0));
		  
--end Behavioral;






--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

------ Uncomment the following library declaration if instantiating
------ any Xilinx primitives in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity divisor is
--    Port ( Dividend : in  STD_LOGIC_VECTOR (7 downto 0);
--           Divis : in  STD_LOGIC_VECTOR (3 downto 0);
--           clk : in  STD_LOGIC;
--           Start : in  STD_LOGIC;
--           Remainder : out  STD_LOGIC_VECTOR (3 downto 0);
--	   Quotient : out  STD_LOGIC_VECTOR (3 downto 0);
--           Done : out  STD_LOGIC);
--end divisor;

--architecture Behavioral of divisor is

--signal DivBuf: STD_LOGIC_VECTOR (3 downto 0);
---- signal DivNeg: STD_LOGIC_VECTOR (3 downto 0);

--signal ACC: STD_LOGIC_VECTOR (7 downto 0);
--signal sum: STD_LOGIC_VECTOR (3 downto 0);
--signal Remaind :  STD_LOGIC_VECTOR (3 downto 0);

--type state is (S0, S1, S2, S3, S4);
--signal FSM_cur_state, FSM_nx_state: state;
--Signal Counter: STD_LOGIC_VECTOR (2 downto 0);
--signal INC_CNT: STD_LOGIC;
--signal LD_high: STD_LOGIC;
--signal AccShift_left0: STD_LOGIC;
--signal AccShift_left1: STD_LOGIC;
----signal addd: STD_LOGIC;
----signal subb: STD_LOGIC;
--signal FSM_Done: STD_LOGIC;
----signal sum: STD_LOGIC_VECTOR(3 downto 0);

--begin

--DivisorReg: process (clk, start)
--begin
--   if clk'event and clk = '1' then 
--	  if start = '1' then
--	  DivBuf <= Divis;
--	  end if;
--	 end if;
--end process;

--ComboSum: process(DivBuf, ACC)
--begin
--    	 sum <= ACC(7 downto 4) + (not(DivBuf) + 1);
--end process;

--ACCReg: process (clk, start, Dividend, sum,
--  AccShift_left0, AccShift_left1, LD_high)
--begin
--   if clk'event and clk = '1' then
--	  if start = '1' then
--	  ACC <= Dividend(6 downto 0)&'0';	
	  
--	  elsif  LD_high = '1' then 
--	     ACC(7 downto 4) <= sum;
--	  elsif AccShift_left0 = '1' then
--			ACC <= ACC(6 downto 0) & '0';
--	     elsif AccShift_left1 = '1' then
--	     ACC <= ACC(6 downto 0) & '1';
--	 end if;
--	 end if;	
--end process;

---- output the results
--Result: process(ACC)
--begin  
--	 Quotient  <= ACC(3 downto 0);	 
--	 Remainder <= '0'&ACC(7 downto 5);	 
--end process;

---- Combo Control Output
--ComboFSMoutput: process(FSM_cur_State, start, sum, FSM_done)
--begin
--   INC_CNT <= '0';
--   LD_high <= '0';
--   AccShift_left0 <= '0';
--   AccShift_left1 <= '0';
--	case FSM_cur_State is 
--	when S0 =>
--	          if start = '1' then 
--				 FSM_nx_State <= S0;
--				 elsif sum(3) = '0' then 
--				 FSM_nx_State <= S1;		 
--				 else 
--				 FSM_nx_State <= S2;
--				 end if;
				 
--	when S1 =>
--				 LD_high <= '1';
--				 FSM_nx_State <= S3;
	          	
--	when S2 =>
--	         AccShift_left0 <= '1';
--				INC_CNT <= '1';
--	         FSM_nx_State <= S4;
				
--	when S3 => 
--	         AccShift_left1 <= '1';
--				INC_CNT <= '1';
--				FSM_nx_State <= S4;
				
--	when S4 =>
--	         if FSM_done = '1' then 
--				FSM_nx_State <= S4;
--				else
--				FSM_nx_State <= S0;
--				end if;
--	end case;	
--end process;

---- FSM next state register	  
--RegFSM_State: process (clk, FSM_nx_State, start)
--begin
--    if (clk'event and clk = '1') then 
--	     if start ='1' then 
--		  FSM_Cur_State <= S0;
--		  else
--		  FSM_Cur_State <= FSM_nx_State;
--		  end if;
--	 end if;
--end process;

---- Counter to control the iteration
--RegCounter: process(clk, start)
--begin
--    if clk'event and clk = '1' then 
--	    if start = '1' then
--		 Counter <= (others => '0');
--		 elsif INC_CNT = '1' then
--		 Counter <= Counter + 1;
--		 end if;
--	 end if;
--end process;

---- update FSM_done
--ComboFSMdone: process(Counter)
--begin
--   FSM_done <= counter(2) and (not(counter(1)))  and (not(counter(0)));
--end process;

--process(FSM_done)
--begin 
--		done <= FSM_done;
--end process;

--end Behavioral;







library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CB16CE_HXILINX_lab4_seven_segment_display is
port (
    CEO : out STD_LOGIC;
    Q   : out STD_LOGIC_VECTOR(15 downto 0);
    TC  : out STD_LOGIC;
    C   : in STD_LOGIC;
    CE  : in STD_LOGIC;
    CLR : in STD_LOGIC
    );
end CB16CE_HXILINX_lab4_seven_segment_display;

architecture Behavioral of CB16CE_HXILINX_lab4_seven_segment_display is

  signal COUNT : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
  constant TERMINAL_COUNT : STD_LOGIC_VECTOR(15 downto 0) := (others => '1');
  
begin

process(C, CLR)
begin
  if (CLR='1') then
    COUNT <= (others => '0');
  elsif (C'event and C = '1') then
    if (CE='1') then 
      COUNT <= COUNT+1;
    end if;
  end if;
end process;

TC  <= '1' when (COUNT = TERMINAL_COUNT) else '0';
CEO <= '1' when ((COUNT = TERMINAL_COUNT) and CE='1') else '0';
Q   <= COUNT;

end Behavioral;

----- CELL D2_4E_HXILINX_lab4_seven_segment_display -----
  
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity D2_4E_HXILINX_lab4_seven_segment_display is
  
port(
    D0  : out std_logic;
    D1  : out std_logic;
    D2  : out std_logic;
    D3  : out std_logic;

    A0  : in std_logic;
    A1  : in std_logic;
    E   : in std_logic
  );
end D2_4E_HXILINX_lab4_seven_segment_display;

architecture D2_4E_HXILINX_lab4_seven_segment_display_V of D2_4E_HXILINX_lab4_seven_segment_display is
  signal d_tmp : std_logic_vector(3 downto 0);
begin
  process (A0, A1, E)
  variable sel   : std_logic_vector(1 downto 0);
  begin
    sel := A1&A0;
    if( E = '0') then
    d_tmp <= "0000";
    else
      case sel is
      when "00" => d_tmp <= "0001";
      when "01" => d_tmp <= "0010";
      when "10" => d_tmp <= "0100";
      when "11" => d_tmp <= "1000";
      when others => NULL;
      end case;
    end if;
  end process; 

    D3 <= d_tmp(3);
    D2 <= d_tmp(2);
    D1 <= d_tmp(1);
    D0 <= d_tmp(0);

end D2_4E_HXILINX_lab4_seven_segment_display_V;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity T_Flip_Flop_MUSER_lab4_seven_segment_display is
   port ( CLOCK : in    std_logic; 
          T     : in    std_logic; 
          Q     : out   std_logic; 
          Q_BAR : out   std_logic);
end T_Flip_Flop_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of T_Flip_Flop_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_1      : std_logic;
   signal XLXN_2      : std_logic;
   signal XLXN_3      : std_logic;
   signal XLXN_8      : std_logic;
   signal Q_DUMMY     : std_logic;
   signal Q_BAR_DUMMY : std_logic;
   component FD
      generic( INIT : bit :=  '0');
      port ( C : in    std_logic; 
             D : in    std_logic; 
             Q : out   std_logic);
   end component;
   attribute BOX_TYPE of FD : component is "BLACK_BOX";
   
   component OR2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR2 : component is "BLACK_BOX";
   
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   Q <= Q_DUMMY;
   Q_BAR <= Q_BAR_DUMMY;
   XLXI_1 : FD
      port map (C=>CLOCK,
                D=>XLXN_1,
                Q=>Q_DUMMY);
   
   XLXI_2 : OR2
      port map (I0=>XLXN_3,
                I1=>XLXN_2,
                O=>XLXN_1);
   
   XLXI_3 : AND2
      port map (I0=>Q_BAR_DUMMY,
                I1=>T,
                O=>XLXN_2);
   
   XLXI_4 : AND2
      port map (I0=>Q_DUMMY,
                I1=>XLXN_8,
                O=>XLXN_3);
   
   XLXI_5 : INV
      port map (I=>Q_DUMMY,
                O=>Q_BAR_DUMMY);
   
   XLXI_6 : INV
      port map (I=>T,
                O=>XLXN_8);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity clocking_2_MUSER_lab4_seven_segment_display is
   port ( clk        : in    std_logic; 
          pushbutton : in    std_logic; 
          anode      : out   std_logic_vector (3 downto 0));
end clocking_2_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of clocking_2_MUSER_lab4_seven_segment_display is
   attribute HU_SET     : string ;
   attribute BOX_TYPE   : string ;
   signal count0     : std_logic;
   signal count1     : std_logic;
   signal q          : std_logic_vector (15 downto 0);
   signal XLXN_2     : std_logic;
   signal XLXN_3     : std_logic;
   signal XLXN_322   : std_logic;
   signal XLXN_331   : std_logic;
   signal XLXN_332   : std_logic;
   signal XLXN_333   : std_logic;
   signal XLXN_338   : std_logic;
   signal XLXN_341   : std_logic;
   component CB16CE_HXILINX_lab4_seven_segment_display
      port ( C   : in    std_logic; 
             CE  : in    std_logic; 
             CLR : in    std_logic; 
             CEO : out   std_logic; 
             Q   : out   std_logic_vector (15 downto 0); 
             TC  : out   std_logic);
   end component;
   
   component T_Flip_Flop_MUSER_lab4_seven_segment_display
      port ( CLOCK : in    std_logic; 
             Q     : out   std_logic; 
             Q_BAR : out   std_logic; 
             T     : in    std_logic);
   end component;
   
   component OR2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR2 : component is "BLACK_BOX";
   
   component D2_4E_HXILINX_lab4_seven_segment_display
      port ( A0 : in    std_logic; 
             A1 : in    std_logic; 
             E  : in    std_logic; 
             D0 : out   std_logic; 
             D1 : out   std_logic; 
             D2 : out   std_logic; 
             D3 : out   std_logic);
   end component;
   
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   attribute HU_SET of XLXI_1 : label is "XLXI_1_4";
   attribute HU_SET of XLXI_250 : label is "XLXI_250_5";
begin
   XLXN_2 <= '1';
   XLXN_3 <= '0';
   XLXN_322 <= '1';
   XLXN_341 <= '1';
   XLXI_1 : CB16CE_HXILINX_lab4_seven_segment_display
      port map (C=>clk,
                CE=>XLXN_2,
                CLR=>XLXN_3,
                CEO=>open,
                Q(15 downto 0)=>q(15 downto 0),
                TC=>open);
   
   XLXI_217 : T_Flip_Flop_MUSER_lab4_seven_segment_display
      port map (CLOCK=>XLXN_338,
                T=>XLXN_341,
                Q=>count0,
                Q_BAR=>open);
   
   XLXI_222 : T_Flip_Flop_MUSER_lab4_seven_segment_display
      port map (CLOCK=>XLXN_338,
                T=>count0,
                Q=>count1,
                Q_BAR=>open);
   
   XLXI_249 : OR2
      port map (I0=>XLXN_332,
                I1=>XLXN_331,
                O=>XLXN_338);
   
   XLXI_250 : D2_4E_HXILINX_lab4_seven_segment_display
      port map (A0=>count0,
                A1=>count1,
                E=>XLXN_322,
                D0=>anode(0),
                D1=>anode(1),
                D2=>anode(2),
                D3=>anode(3));
   
   XLXI_252 : AND2
      port map (I0=>clk,
                I1=>pushbutton,
                O=>XLXN_331);
   
   XLXI_253 : AND2
      port map (I0=>q(15),
                I1=>XLXN_333,
                O=>XLXN_332);
   
   XLXI_254 : INV
      port map (I=>pushbutton,
                O=>XLXN_333);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity segg_a_MUSER_lab4_seven_segment_display is
   port ( x : in    std_logic_vector (3 downto 0); 
          a : out   std_logic);
end segg_a_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of segg_a_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_1  : std_logic;
   signal XLXN_2  : std_logic;
   signal XLXN_3  : std_logic;
   signal XLXN_4  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_16 : std_logic;
   signal XLXN_17 : std_logic;
   signal XLXN_19 : std_logic;
   signal XLXN_20 : std_logic;
   signal XLXN_23 : std_logic;
   signal XLXN_24 : std_logic;
   signal XLXN_30 : std_logic;
   signal XLXN_34 : std_logic;
   signal XLXN_35 : std_logic;
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component AND3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
   component OR3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR3 : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2
      port map (I0=>x(1),
                I1=>XLXN_1,
                O=>XLXN_16);
   
   XLXI_2 : AND2
      port map (I0=>XLXN_2,
                I1=>x(3),
                O=>XLXN_20);
   
   XLXI_3 : AND3
      port map (I0=>XLXN_5,
                I1=>XLXN_4,
                I2=>XLXN_3,
                O=>XLXN_19);
   
   XLXI_4 : AND3
      port map (I0=>x(0),
                I1=>x(2),
                I2=>XLXN_6,
                O=>XLXN_17);
   
   XLXI_5 : INV
      port map (I=>x(3),
                O=>XLXN_1);
   
   XLXI_6 : INV
      port map (I=>x(0),
                O=>XLXN_2);
   
   XLXI_7 : INV
      port map (I=>x(2),
                O=>XLXN_3);
   
   XLXI_8 : INV
      port map (I=>x(1),
                O=>XLXN_4);
   
   XLXI_9 : INV
      port map (I=>x(0),
                O=>XLXN_5);
   
   XLXI_10 : INV
      port map (I=>x(3),
                O=>XLXN_6);
   
   XLXI_11 : OR4
      port map (I0=>XLXN_17,
                I1=>XLXN_19,
                I2=>XLXN_20,
                I3=>XLXN_16,
                O=>XLXN_30);
   
   XLXI_12 : AND2
      port map (I0=>x(2),
                I1=>x(1),
                O=>XLXN_34);
   
   XLXI_13 : AND3
      port map (I0=>XLXN_24,
                I1=>XLXN_23,
                I2=>x(3),
                O=>XLXN_35);
   
   XLXI_14 : INV
      port map (I=>x(2),
                O=>XLXN_23);
   
   XLXI_15 : INV
      port map (I=>x(1),
                O=>XLXN_24);
   
   XLXI_16 : OR3
      port map (I0=>XLXN_35,
                I1=>XLXN_34,
                I2=>XLXN_30,
                O=>a);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity segment_b_MUSER_lab4_seven_segment_display is
   port ( x : in    std_logic_vector (3 downto 0); 
          b : out   std_logic);
end segment_b_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of segment_b_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_2  : std_logic;
   signal XLXN_3  : std_logic;
   signal XLXN_4  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_7  : std_logic;
   signal XLXN_8  : std_logic;
   signal XLXN_9  : std_logic;
   signal XLXN_10 : std_logic;
   signal XLXN_11 : std_logic;
   signal XLXN_12 : std_logic;
   signal XLXN_13 : std_logic;
   signal XLXN_14 : std_logic;
   signal XLXN_15 : std_logic;
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component AND3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
   
   component OR5
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             I4 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR5 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2
      port map (I0=>XLXN_8,
                I1=>XLXN_7,
                O=>XLXN_2);
   
   XLXI_2 : AND2
      port map (I0=>XLXN_10,
                I1=>XLXN_9,
                O=>XLXN_3);
   
   XLXI_3 : AND3
      port map (I0=>XLXN_13,
                I1=>XLXN_12,
                I2=>XLXN_11,
                O=>XLXN_4);
   
   XLXI_4 : AND3
      port map (I0=>x(0),
                I1=>x(1),
                I2=>XLXN_14,
                O=>XLXN_5);
   
   XLXI_5 : AND3
      port map (I0=>x(0),
                I1=>XLXN_15,
                I2=>x(3),
                O=>XLXN_6);
   
   XLXI_6 : OR5
      port map (I0=>XLXN_6,
                I1=>XLXN_5,
                I2=>XLXN_4,
                I3=>XLXN_3,
                I4=>XLXN_2,
                O=>b);
   
   XLXI_7 : INV
      port map (I=>x(3),
                O=>XLXN_7);
   
   XLXI_8 : INV
      port map (I=>x(2),
                O=>XLXN_8);
   
   XLXI_9 : INV
      port map (I=>x(2),
                O=>XLXN_9);
   
   XLXI_10 : INV
      port map (I=>x(0),
                O=>XLXN_10);
   
   XLXI_11 : INV
      port map (I=>x(3),
                O=>XLXN_11);
   
   XLXI_12 : INV
      port map (I=>x(1),
                O=>XLXN_12);
   
   XLXI_13 : INV
      port map (I=>x(0),
                O=>XLXN_13);
   
   XLXI_14 : INV
      port map (I=>x(3),
                O=>XLXN_14);
   
   XLXI_15 : INV
      port map (I=>x(1),
                O=>XLXN_15);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity segment_c_MUSER_lab4_seven_segment_display is
   port ( x : in    std_logic_vector (3 downto 0); 
          c : out   std_logic);
end segment_c_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of segment_c_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_2  : std_logic;
   signal XLXN_3  : std_logic;
   signal XLXN_4  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_8  : std_logic;
   signal XLXN_9  : std_logic;
   signal XLXN_10 : std_logic;
   signal XLXN_11 : std_logic;
   signal XLXN_12 : std_logic;
   signal XLXN_13 : std_logic;
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component OR5
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             I4 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR5 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2
      port map (I0=>x(2),
                I1=>XLXN_8,
                O=>XLXN_2);
   
   XLXI_2 : AND2
      port map (I0=>XLXN_10,
                I1=>XLXN_9,
                O=>XLXN_3);
   
   XLXI_3 : AND2
      port map (I0=>x(3),
                I1=>XLXN_11,
                O=>XLXN_4);
   
   XLXI_4 : AND2
      port map (I0=>x(0),
                I1=>XLXN_12,
                O=>XLXN_5);
   
   XLXI_5 : AND2
      port map (I0=>x(0),
                I1=>XLXN_13,
                O=>XLXN_6);
   
   XLXI_6 : OR5
      port map (I0=>XLXN_6,
                I1=>XLXN_5,
                I2=>XLXN_4,
                I3=>XLXN_3,
                I4=>XLXN_2,
                O=>c);
   
   XLXI_7 : INV
      port map (I=>x(3),
                O=>XLXN_8);
   
   XLXI_8 : INV
      port map (I=>x(3),
                O=>XLXN_9);
   
   XLXI_9 : INV
      port map (I=>x(1),
                O=>XLXN_10);
   
   XLXI_10 : INV
      port map (I=>x(2),
                O=>XLXN_11);
   
   XLXI_11 : INV
      port map (I=>x(2),
                O=>XLXN_12);
   
   XLXI_12 : INV
      port map (I=>x(1),
                O=>XLXN_13);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity segment_d_MUSER_lab4_seven_segment_display is
   port ( x : in    std_logic_vector (3 downto 0); 
          d : out   std_logic);
end segment_d_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of segment_d_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_3  : std_logic;
   signal XLXN_4  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_7  : std_logic;
   signal XLXN_8  : std_logic;
   signal XLXN_9  : std_logic;
   signal XLXN_10 : std_logic;
   signal XLXN_11 : std_logic;
   signal XLXN_12 : std_logic;
   signal XLXN_13 : std_logic;
   signal XLXN_14 : std_logic;
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component AND3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
   
   component OR5
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             I4 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR5 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2
      port map (I0=>XLXN_8,
                I1=>x(3),
                O=>XLXN_3);
   
   XLXI_2 : AND3
      port map (I0=>x(0),
                I1=>XLXN_9,
                I2=>x(2),
                O=>XLXN_4);
   
   XLXI_3 : AND3
      port map (I0=>x(0),
                I1=>x(1),
                I2=>XLXN_10,
                O=>XLXN_5);
   
   XLXI_4 : AND3
      port map (I0=>XLXN_11,
                I1=>x(1),
                I2=>x(2),
                O=>XLXN_6);
   
   XLXI_5 : AND3
      port map (I0=>XLXN_14,
                I1=>XLXN_13,
                I2=>XLXN_12,
                O=>XLXN_7);
   
   XLXI_7 : OR5
      port map (I0=>XLXN_7,
                I1=>XLXN_6,
                I2=>XLXN_5,
                I3=>XLXN_4,
                I4=>XLXN_3,
                O=>d);
   
   XLXI_8 : INV
      port map (I=>x(1),
                O=>XLXN_8);
   
   XLXI_9 : INV
      port map (I=>x(1),
                O=>XLXN_9);
   
   XLXI_10 : INV
      port map (I=>x(2),
                O=>XLXN_10);
   
   XLXI_11 : INV
      port map (I=>x(0),
                O=>XLXN_11);
   
   XLXI_13 : INV
      port map (I=>x(3),
                O=>XLXN_12);
   
   XLXI_14 : INV
      port map (I=>x(2),
                O=>XLXN_13);
   
   XLXI_15 : INV
      port map (I=>x(0),
                O=>XLXN_14);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity segment_e_MUSER_lab4_seven_segment_display is
   port ( x : in    std_logic_vector (3 downto 0); 
          e : out   std_logic);
end segment_e_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of segment_e_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_2  : std_logic;
   signal XLXN_3  : std_logic;
   signal XLXN_4  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_7  : std_logic;
   signal XLXN_8  : std_logic;
   signal XLXN_9  : std_logic;
   signal XLXN_10 : std_logic;
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component AND3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2
      port map (I0=>x(2),
                I1=>x(3),
                O=>XLXN_2);
   
   XLXI_2 : AND2
      port map (I0=>XLXN_7,
                I1=>x(1),
                O=>XLXN_3);
   
   XLXI_3 : AND2
      port map (I0=>x(1),
                I1=>x(3),
                O=>XLXN_4);
   
   XLXI_4 : AND3
      port map (I0=>XLXN_8,
                I1=>XLXN_9,
                I2=>XLXN_10,
                O=>XLXN_5);
   
   XLXI_5 : OR4
      port map (I0=>XLXN_5,
                I1=>XLXN_4,
                I2=>XLXN_3,
                I3=>XLXN_2,
                O=>e);
   
   XLXI_6 : INV
      port map (I=>x(0),
                O=>XLXN_7);
   
   XLXI_7 : INV
      port map (I=>x(0),
                O=>XLXN_8);
   
   XLXI_8 : INV
      port map (I=>x(1),
                O=>XLXN_9);
   
   XLXI_9 : INV
      port map (I=>x(2),
                O=>XLXN_10);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity segment_f_MUSER_lab4_seven_segment_display is
   port ( x : in    std_logic_vector (3 downto 0); 
          f : out   std_logic);
end segment_f_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of segment_f_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_2  : std_logic;
   signal XLXN_3  : std_logic;
   signal XLXN_4  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_15 : std_logic;
   signal XLXN_16 : std_logic;
   signal XLXN_17 : std_logic;
   signal XLXN_18 : std_logic;
   signal XLXN_19 : std_logic;
   signal XLXN_20 : std_logic;
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component AND3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
   
   component OR5
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             I4 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR5 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2
      port map (I0=>XLXN_16,
                I1=>XLXN_15,
                O=>XLXN_2);
   
   XLXI_2 : AND2
      port map (I0=>XLXN_17,
                I1=>x(3),
                O=>XLXN_3);
   
   XLXI_3 : AND2
      port map (I0=>x(1),
                I1=>x(3),
                O=>XLXN_4);
   
   XLXI_4 : AND3
      port map (I0=>XLXN_19,
                I1=>x(2),
                I2=>XLXN_18,
                O=>XLXN_5);
   
   XLXI_5 : AND3
      port map (I0=>XLXN_20,
                I1=>x(1),
                I2=>x(2),
                O=>XLXN_6);
   
   XLXI_6 : OR5
      port map (I0=>XLXN_6,
                I1=>XLXN_5,
                I2=>XLXN_4,
                I3=>XLXN_3,
                I4=>XLXN_2,
                O=>f);
   
   XLXI_7 : INV
      port map (I=>x(1),
                O=>XLXN_15);
   
   XLXI_8 : INV
      port map (I=>x(0),
                O=>XLXN_16);
   
   XLXI_9 : INV
      port map (I=>x(2),
                O=>XLXN_17);
   
   XLXI_10 : INV
      port map (I=>x(3),
                O=>XLXN_18);
   
   XLXI_11 : INV
      port map (I=>x(1),
                O=>XLXN_19);
   
   XLXI_12 : INV
      port map (I=>x(0),
                O=>XLXN_20);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity segment_g_MUSER_lab4_seven_segment_display is
   port ( x : in    std_logic_vector (3 downto 0); 
          g : out   std_logic);
end segment_g_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of segment_g_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_2  : std_logic;
   signal XLXN_3  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_7  : std_logic;
   signal XLXN_9  : std_logic;
   signal XLXN_10 : std_logic;
   signal XLXN_11 : std_logic;
   signal XLXN_12 : std_logic;
   signal XLXN_13 : std_logic;
   signal XLXN_14 : std_logic;
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component AND3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND3 : component is "BLACK_BOX";
   
   component OR5
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             I4 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR5 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2
      port map (I0=>XLXN_9,
                I1=>x(1),
                O=>XLXN_2);
   
   XLXI_2 : AND2
      port map (I0=>XLXN_10,
                I1=>x(3),
                O=>XLXN_3);
   
   XLXI_3 : AND2
      port map (I0=>x(0),
                I1=>x(3),
                O=>XLXN_5);
   
   XLXI_4 : AND3
      port map (I0=>XLXN_12,
                I1=>x(2),
                I2=>XLXN_11,
                O=>XLXN_6);
   
   XLXI_5 : AND3
      port map (I0=>x(1),
                I1=>XLXN_14,
                I2=>XLXN_13,
                O=>XLXN_7);
   
   XLXI_6 : OR5
      port map (I0=>XLXN_7,
                I1=>XLXN_6,
                I2=>XLXN_5,
                I3=>XLXN_3,
                I4=>XLXN_2,
                O=>g);
   
   XLXI_7 : INV
      port map (I=>x(0),
                O=>XLXN_9);
   
   XLXI_8 : INV
      port map (I=>x(2),
                O=>XLXN_10);
   
   XLXI_9 : INV
      port map (I=>x(3),
                O=>XLXN_11);
   
   XLXI_10 : INV
      port map (I=>x(1),
                O=>XLXN_12);
   
   XLXI_11 : INV
      port map (I=>x(3),
                O=>XLXN_13);
   
   XLXI_12 : INV
      port map (I=>x(2),
                O=>XLXN_14);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity fake_mux_MUSER_lab4_seven_segment_display is
   port ( anode  : in    std_logic_vector (3 downto 0); 
          b      : in    std_logic_vector (15 downto 0); 
          binary : out   std_logic_vector (3 downto 0));
end fake_mux_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of fake_mux_MUSER_lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal XLXN_7  : std_logic;
   signal XLXN_16 : std_logic;
   signal XLXN_19 : std_logic;
   signal XLXN_28 : std_logic;
   signal XLXN_43 : std_logic;
   signal XLXN_52 : std_logic;
   signal XLXN_54 : std_logic;
   signal XLXN_55 : std_logic;
   signal XLXN_58 : std_logic;
   signal XLXN_59 : std_logic;
   signal XLXN_65 : std_logic;
   signal XLXN_66 : std_logic;
   signal XLXN_70 : std_logic;
   signal XLXN_77 : std_logic;
   signal XLXN_79 : std_logic;
   signal XLXN_80 : std_logic;
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component OR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR4 : component is "BLACK_BOX";
   
begin
   XLXI_1 : AND2
      port map (I0=>anode(3),
                I1=>b(15),
                O=>XLXN_7);
   
   XLXI_18 : AND2
      port map (I0=>anode(2),
                I1=>b(11),
                O=>XLXN_54);
   
   XLXI_19 : AND2
      port map (I0=>anode(1),
                I1=>b(7),
                O=>XLXN_55);
   
   XLXI_20 : AND2
      port map (I0=>anode(0),
                I1=>b(3),
                O=>XLXN_16);
   
   XLXI_21 : AND2
      port map (I0=>anode(3),
                I1=>b(14),
                O=>XLXN_19);
   
   XLXI_22 : AND2
      port map (I0=>anode(2),
                I1=>b(10),
                O=>XLXN_58);
   
   XLXI_23 : AND2
      port map (I0=>anode(1),
                I1=>b(6),
                O=>XLXN_59);
   
   XLXI_24 : AND2
      port map (I0=>anode(0),
                I1=>b(2),
                O=>XLXN_28);
   
   XLXI_29 : AND2
      port map (I0=>anode(3),
                I1=>b(12),
                O=>XLXN_43);
   
   XLXI_30 : AND2
      port map (I0=>anode(2),
                I1=>b(8),
                O=>XLXN_66);
   
   XLXI_31 : AND2
      port map (I0=>anode(1),
                I1=>b(4),
                O=>XLXN_65);
   
   XLXI_32 : AND2
      port map (I0=>anode(0),
                I1=>b(0),
                O=>XLXN_52);
   
   XLXI_33 : OR4
      port map (I0=>XLXN_16,
                I1=>XLXN_55,
                I2=>XLXN_54,
                I3=>XLXN_7,
                O=>binary(3));
   
   XLXI_35 : OR4
      port map (I0=>XLXN_28,
                I1=>XLXN_59,
                I2=>XLXN_58,
                I3=>XLXN_19,
                O=>binary(2));
   
   XLXI_36 : OR4
      port map (I0=>XLXN_52,
                I1=>XLXN_65,
                I2=>XLXN_66,
                I3=>XLXN_43,
                O=>binary(0));
   
   XLXI_37 : AND2
      port map (I0=>anode(3),
                I1=>b(13),
                O=>XLXN_70);
   
   XLXI_38 : AND2
      port map (I0=>anode(2),
                I1=>b(9),
                O=>XLXN_80);
   
   XLXI_39 : AND2
      port map (I0=>anode(1),
                I1=>b(5),
                O=>XLXN_79);
   
   XLXI_40 : AND2
      port map (I0=>anode(0),
                I1=>b(1),
                O=>XLXN_77);
   
   XLXI_41 : OR4
      port map (I0=>XLXN_77,
                I1=>XLXN_79,
                I2=>XLXN_80,
                I3=>XLXN_70,
                O=>binary(1));
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity bin_to_c_MUSER_lab4_seven_segment_display is
   port ( anode : in    std_logic_vector (3 downto 0); 
          bb    : in    std_logic_vector (15 downto 0); 
          a     : out   std_logic; 
          b     : out   std_logic; 
          c     : out   std_logic; 
          d     : out   std_logic; 
          e     : out   std_logic; 
          f     : out   std_logic; 
          g     : out   std_logic);
end bin_to_c_MUSER_lab4_seven_segment_display;

architecture BEHAVIORAL of bin_to_c_MUSER_lab4_seven_segment_display is
   signal XLXN_1 : std_logic_vector (3 downto 0);
   component fake_mux_MUSER_lab4_seven_segment_display
      port ( anode  : in    std_logic_vector (3 downto 0); 
             b      : in    std_logic_vector (15 downto 0); 
             binary : out   std_logic_vector (3 downto 0));
   end component;
   
   component segment_g_MUSER_lab4_seven_segment_display
      port ( g : out   std_logic; 
             x : in    std_logic_vector (3 downto 0));
   end component;
   
   component segment_f_MUSER_lab4_seven_segment_display
      port ( f : out   std_logic; 
             x : in    std_logic_vector (3 downto 0));
   end component;
   
   component segment_e_MUSER_lab4_seven_segment_display
      port ( e : out   std_logic; 
             x : in    std_logic_vector (3 downto 0));
   end component;
   
   component segment_d_MUSER_lab4_seven_segment_display
      port ( d : out   std_logic; 
             x : in    std_logic_vector (3 downto 0));
   end component;
   
   component segment_c_MUSER_lab4_seven_segment_display
      port ( c : out   std_logic; 
             x : in    std_logic_vector (3 downto 0));
   end component;
   
   component segment_b_MUSER_lab4_seven_segment_display
      port ( b : out   std_logic; 
             x : in    std_logic_vector (3 downto 0));
   end component;
   
   component segg_a_MUSER_lab4_seven_segment_display
      port ( a : out   std_logic; 
             x : in    std_logic_vector (3 downto 0));
   end component;
   
begin
   XLXI_10 : fake_mux_MUSER_lab4_seven_segment_display
      port map (anode(3 downto 0)=>anode(3 downto 0),
                b(15 downto 0)=>bb(15 downto 0),
                binary(3 downto 0)=>XLXN_1(3 downto 0));
   
   XLXI_11 : segment_g_MUSER_lab4_seven_segment_display
      port map (x(3 downto 0)=>XLXN_1(3 downto 0),
                g=>g);
   
   XLXI_12 : segment_f_MUSER_lab4_seven_segment_display
      port map (x(3 downto 0)=>XLXN_1(3 downto 0),
                f=>f);
   
   XLXI_13 : segment_e_MUSER_lab4_seven_segment_display
      port map (x(3 downto 0)=>XLXN_1(3 downto 0),
                e=>e);
   
   XLXI_14 : segment_d_MUSER_lab4_seven_segment_display
      port map (x(3 downto 0)=>XLXN_1(3 downto 0),
                d=>d);
   
   XLXI_15 : segment_c_MUSER_lab4_seven_segment_display
      port map (x(3 downto 0)=>XLXN_1(3 downto 0),
                c=>c);
   
   XLXI_16 : segment_b_MUSER_lab4_seven_segment_display
      port map (x(3 downto 0)=>XLXN_1(3 downto 0),
                b=>b);
   
   XLXI_21 : segg_a_MUSER_lab4_seven_segment_display
      port map (x(3 downto 0)=>XLXN_1(3 downto 0),
                a=>a);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity lab4_seven_segment_display is
   port ( b          : in    std_logic_vector (15 downto 0):="0000000000000000"; 
          clk        : in    std_logic; 
          pushbutton : in    std_logic; 
          anode      : out   std_logic_vector (3 downto 0); 
          cathode    : out   std_logic_vector (6 downto 0));
end lab4_seven_segment_display;

architecture BEHAVIORAL of lab4_seven_segment_display is
   attribute BOX_TYPE   : string ;
   signal an         : std_logic_vector (3 downto 0);
   signal XLXN_8     : std_logic;
   signal XLXN_9     : std_logic;
   signal XLXN_10    : std_logic;
   signal XLXN_11    : std_logic;
   signal XLXN_12    : std_logic;
   signal XLXN_13    : std_logic;
   signal XLXN_14    : std_logic;
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component bin_to_c_MUSER_lab4_seven_segment_display
      port ( a     : out   std_logic; 
             anode : in    std_logic_vector (3 downto 0); 
             b     : out   std_logic; 
             bb    : in    std_logic_vector (15 downto 0); 
             c     : out   std_logic; 
             d     : out   std_logic; 
             e     : out   std_logic; 
             f     : out   std_logic; 
             g     : out   std_logic);
   end component;
   
   component clocking_2_MUSER_lab4_seven_segment_display
      port ( anode      : out   std_logic_vector (3 downto 0); 
             clk        : in    std_logic; 
             pushbutton : in    std_logic);
   end component;
   
begin
   XLXI_9 : INV
      port map (I=>XLXN_8,
                O=>cathode(0));
   
   XLXI_10 : INV
      port map (I=>XLXN_9,
                O=>cathode(1));
   
   XLXI_11 : INV
      port map (I=>XLXN_10,
                O=>cathode(2));
   
   XLXI_12 : INV
      port map (I=>XLXN_11,
                O=>cathode(3));
   
   XLXI_13 : INV
      port map (I=>XLXN_12,
                O=>cathode(4));
   
   XLXI_14 : INV
      port map (I=>XLXN_13,
                O=>cathode(5));
   
   XLXI_15 : INV
      port map (I=>XLXN_14,
                O=>cathode(6));
   
   XLXI_17 : INV
      port map (I=>an(0),
                O=>anode(0));
   
   XLXI_18 : INV
      port map (I=>an(1),
                O=>anode(1));
   
   XLXI_19 : INV
      port map (I=>an(2),
                O=>anode(2));
   
   XLXI_20 : INV
      port map (I=>an(3),
                O=>anode(3));
   
   XLXI_24 : bin_to_c_MUSER_lab4_seven_segment_display
      port map (anode(3 downto 0)=>an(3 downto 0),
                bb(15 downto 0)=>b(15 downto 0),
                a=>XLXN_8,
                b=>XLXN_9,
                c=>XLXN_10,
                d=>XLXN_11,
                e=>XLXN_12,
                f=>XLXN_13,
                g=>XLXN_14);
   
   XLXI_27 : clocking_2_MUSER_lab4_seven_segment_display
      port map (clk=>clk,
                pushbutton=>pushbutton,
                anode(3 downto 0)=>an(3 downto 0));
   
end BEHAVIORAL;




