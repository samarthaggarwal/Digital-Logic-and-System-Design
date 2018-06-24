----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.10.2017 15:20:43
-- Design Name: 
-- Module Name: ping_pong - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
    Port (  b : in STD_LOGIC_VECTOR (15 downto 0) :=(others => '0');
            clk : in STD_LOGIC :='0';
            pushbutton : in STD_LOGIC :='0';
            cathode : out STD_LOGIC_VECTOR (6 downto 0) :=(others => '0');
            anode : out STD_LOGIC_VECTOR (3 downto 0) :=(others => '0'));
end display;

architecture Behavioral of display is
    signal count : INTEGER :=0;
    signal count2 : INTEGER :=5;
    signal cat0 : STD_LOGIC_VECTOR (6 downto 0) :=(others => '1');
    signal cat : STD_LOGIC_VECTOR (6 downto 0) :=(others => '1');
    signal cat1 : STD_LOGIC_VECTOR (6 downto 0) :=(others => '1');
    signal cat2 : STD_LOGIC_VECTOR (6 downto 0) :=(others => '1');
    signal cat3 : STD_LOGIC_VECTOR (6 downto 0) :=(others => '1');
    signal an : STD_LOGIC_VECTOR (3 downto 0) :=(others => '1');
    signal pb : STD_LOGIC;

begin

pb <= pushbutton;
process(clk)
begin
    if (clk'event and clk='1') then
        case b(15 downto 12) is
            when "0000" => cat0(6 downto 0) <= "1000000";
            when "0001" => cat0(6 downto 0) <= "1111001";
            when "0010" => cat0(6 downto 0) <= "0100100";
            when "0011" => cat0(6 downto 0) <= "0110000";
            when "0100" => cat0(6 downto 0) <= "0011001";
            when "0101" => cat0(6 downto 0) <= "0010010";
            when "0110" => cat0(6 downto 0) <= "0000010";
            when "0111" => cat0(6 downto 0) <= "1111000";
            when "1000" => cat0(6 downto 0) <= "0000000";
            when "1001" => cat0(6 downto 0) <= "0010000";
            when "1100" => cat0(6 downto 0) <= "1000111";
            when "1101" => cat0(6 downto 0) <= "0001001";
            when others => cat0(6 downto 0) <= "1000000";
        end case;
        
        case b(11 downto 8) is
            when "0000" => cat1(6 downto 0) <= "1000000";
            when "0001" => cat1(6 downto 0) <= "1111001";
            when "0010" => cat1(6 downto 0) <= "0100100";
            when "0011" => cat1(6 downto 0) <= "0110000";
            when "0100" => cat1(6 downto 0) <= "0011001";
            when "0101" => cat1(6 downto 0) <= "0010010";
            when "0110" => cat1(6 downto 0) <= "0000010";
            when "0111" => cat1(6 downto 0) <= "1111000";
            when "1000" => cat1(6 downto 0) <= "0000000";
            when "1001" => cat1(6 downto 0) <= "0010000";
            when "1100" => cat1(6 downto 0) <= "1000111";
            when "1101" => cat1(6 downto 0) <= "0001001";
            when others => cat1(6 downto 0) <= "1000000";
        end case;
                
        case b(7 downto 4) is
            when "0000" => cat2(6 downto 0) <= "1000000";
            when "0001" => cat2(6 downto 0) <= "1111001";
            when "0010" => cat2(6 downto 0) <= "0100100";
            when "0011" => cat2(6 downto 0) <= "0110000";
            when "0100" => cat2(6 downto 0) <= "0011001";
            when "0101" => cat2(6 downto 0) <= "0010010";
            when "0110" => cat2(6 downto 0) <= "0000010";
            when "0111" => cat2(6 downto 0) <= "1111000";
            when "1000" => cat2(6 downto 0) <= "0000000";
            when "1001" => cat2(6 downto 0) <= "0010000";
            when "1100" => cat2(6 downto 0) <= "1000111";
            when "1101" => cat2(6 downto 0) <= "0001001";
            when others => cat2(6 downto 0) <= "0111111";
        end case;
                        
        case b(3 downto 0) is
            when "0000" => cat3(6 downto 0) <= "1000000";
            when "0001" => cat3(6 downto 0) <= "1111001";
            when "0010" => cat3(6 downto 0) <= "0100100";
            when "0011" => cat3(6 downto 0) <= "0110000";
            when "0100" => cat3(6 downto 0) <= "0011001";
            when "0101" => cat3(6 downto 0) <= "0010010";
            when "0110" => cat3(6 downto 0) <= "0000010";
            when "0111" => cat3(6 downto 0) <= "1111000";
            when "1000" => cat3(6 downto 0) <= "0000000";
            when "1001" => cat3(6 downto 0) <= "0010000";
            when "1100" => cat3(6 downto 0) <= "1000111";
            when "1101" => cat3(6 downto 0) <= "0001001";
            when others => cat3(6 downto 0) <= "0111111";
        end case;
        
        if( ( ((count mod (10**5)) = 0) and pb='0' ) or pb='1' ) then
            count2 <= (count2+1) mod 4;
            count <= 0;
        end if;
        
        count <= count+1;
        
        
            if(count2=1) then
                anode(3 downto 0) <= "1011";
                cathode(6 downto 0) <= cat1(6 downto 0);
            elsif(count2=2) then
                anode(3 downto 0) <= "1101";
                cathode(6 downto 0) <= cat2(6 downto 0);
            elsif(count2=3) then
                anode(3 downto 0) <= "1110";
                cathode(6 downto 0) <= cat3(6 downto 0);
            elsif(count2=0) then
                anode(3 downto 0) <= "0111";
                cathode(6 downto 0) <= cat0(6 downto 0);
            else
                anode(3 downto 0) <= "0111";
                cathode(6 downto 0) <= cat0(6 downto 0);
            end if;
                
        
    end if;
    
--    cathode(6 downto 0) <= cat(6 downto 0);
--    anode(3 downto 0) <= an(3 downto 0);
    

end process;

end Behavioral;



library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity debounce is
  Port (
    CLK : in  STD_LOGIC;
    x : in  STD_LOGIC;
    DBx : out  STD_LOGIC
  );
end debounce;

architecture Behavioral of debounce is
  type State_Type is (S0, S1);
  signal State : State_Type := S0;

  signal DPB, SPB : STD_LOGIC;
  signal DReg : STD_LOGIC_VECTOR (7 downto 0);
begin
  process (CLK, x)
    variable SDC : integer;
    constant Delay : integer := 50000;
  begin
    if CLK'Event and CLK = '1' then
      -- Double latch input signal
      DPB <= SPB;
      SPB <= x;

      case State is
        when S0 =>
          DReg <= DReg(6 downto 0) & DPB;

          SDC := Delay;

          State <= S1;
        when S1 =>
          SDC := SDC - 1;

          if SDC = 0 then
            State <= S0;
          end if;
        when others =>
          State <= S0;
      end case;

      if DReg = X"FF" then
        DBx <= '1';
      elsif DReg = X"00" then
        DBx <= '0';
      end if;
    end if;
  end process;
end Behavioral;



library ieee;
use ieee.std_logic_1164.all;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity ping_pong is
    Port ( return1 : in STD_LOGIC;
           return2 : in STD_LOGIC;
           speed1 : in STD_LOGIC;--return_speed
           speed2 : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           
           sw1 : in STD_LOGIC;
           sw2 : in STD_LOGIC;
           
           anode : out STD_LOGIC_VECTOR (3 downto 0);
           cathode : out STD_LOGIC_VECTOR (6 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end ping_pong;

architecture Behavioral of ping_pong is
    signal count : INTEGER :=0;
    signal led_temp : STD_LOGIC_VECTOR (15 downto 0) :=(others => '0');
    signal dir : INTEGER := 1;
    signal bspeed : STD_LOGIC := '0';
    signal bsp : INTEGER := 2*10**7;
    signal db1 : STD_LOGIC := '0';
    signal db2 : STD_LOGIC := '0';
    signal r1 : STD_LOGIC := '0';
    signal r2 : STD_LOGIC := '0';
        
    signal temp_speed1 : STD_LOGIC := '0';
    signal temp_speed2 : STD_LOGIC := '0';
                
--    signal movel : STD_LOGIC :='0';
--    signal mover : STD_LOGIC :='0';
    signal score1 : INTEGER :=0;
    signal score2 : INTEGER :=0;
    signal curpos : INTEGER :=7;
    signal button1 : STD_LOGIC := '0';
    signal button2 : STD_LOGIC := '0';
    signal c1 : INTEGER := 0;
    signal c2 : INTEGER := 0;
    signal b : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
    
--    signal speed : STD_LOGIC :='0';

begin

        deb1: entity work.debounce
        port map(
            CLK => clk,
            x => speed1,
            DBx => db1
        );

        deb2: entity work.debounce
        port map(
            CLK => clk,
            x => speed2,
            DBx => db2
        );
        
        deb3: entity work.debounce
        port map(
            CLK => clk,
            x => return1,
            DBx => r1
        );
        
        deb4: entity work.debounce
        port map(
            CLK => clk,
            x => return2,
            DBx => r2
        );

process(clk)
begin

        if(db1'event and db1 = '1') then
            temp_speed1 <= not temp_speed1;
           -- b(4) <= temp_speed1;
            
        end if;
        
        if(db2'event and db2 = '1') then
            temp_speed2 <= not temp_speed2;
            --b(0) <= temp_speed2;
        
        end if;

  if(clk'event and clk='1') then
    if(reset = '1') then
        count <= 0;
        led_temp <= (others=>'0');
        dir <= 1;
        bspeed <= '0';
        score1 <= 0;
        score2 <= 0;
        curpos <= 7;
        led_temp(curpos) <= '1';
        button1 <= '0';
        button2 <= '0';
        c1 <= 0;
        c2 <= 0;
        temp_speed1 <= '0';
        temp_speed2 <= '0';
        b <= "0000000011001100";
        bsp <= 2*10**7 ;
--        db1<='0';
--        db2<='0';
        
    elsif(score1 = 9) then
        b(7 downto 4) <= "1111";
        b(3 downto 0) <= "0010";

    elsif(score2 = 9) then
        b(7 downto 4) <= "1111";
        b(3 downto 0) <= "0001";
    
    else
        count <= count + 1;
        if(c1>0) then
            c1 <= c1-1;
        end if;
        
        if(c2>0) then
            c2 <= c2-1;
        end if;
            
        if(r1 = '1' and button1='0') then--try r1'event and taking outside clk'event block
            button1 <= '1';
            c1 <= 1*10**8;  
        end if;
        
        if(r2 = '1' and button2='0') then
            button2 <= '1';
            c2 <= 1*10**8;
        end if;
        
--        if(db1'event and db1 = '1') then
--            temp_speed1 <= not temp_speed1;
--            b(4) <= temp_speed1;
            
--        end if;
        
--        if(db2'event and db2 = '1') then
--            temp_speed2 <= not temp_speed2;
--            b(0) <= temp_speed2;
        
--        end if;
        
        if(c1=0 or c1<0) then
            button1<= '0';
        end if;
        
        if(c2=0 or c2<0) then
            button2<= '0';
        end if;
        
--        if button1 = '1' then
--            b(3) <= '1';
--        else
--            b(3) <= '0';
--        end if;

--        if button2 = '1' then
--            b(11) <= '1';
--        else
--            b(11) <= '0';
--        end if;
        
    end if;
    
    
--    if(count > bsp) then
--            led_temp(curpos) <= '0';
--            count <= 0;
--            curpos <= curpos + dir;
    
--            if(curpos = 0) then
--                    dir <= 1;
                    
--                    if(sw1='1' or button1='1') then
--                            if(temp_speed1 = '1') then
--                                    bsp <= 10*10**6;
--                            else
--                                    bsp <= 4*10**7;
--                            end if;
--                    else
--                            score2 <= score2 + 1;
--                            curpos <= 7;
--                    end if;
        
--            elsif(curpos = 15) then
--                    dir <= -1;
            
--                    if(sw2='1' or button2='1') then
--                            if(temp_speed2 = '1') then
--                                    bsp <= 10*10**6;
--                            else
--                                    bsp <= 4*10**7;
--                            end if;
--                    else
--                            score1 <= score1 + 1;
--                            curpos <= 8;
--                    end if;
        
--            else
--                    led_temp(curpos + dir) <= '1';
--                    --curpos <= curpos + dir;
            
--            end if;
--    end if;
    
--    if(count > bsp) then
--        led_temp(curpos) <= '0';
--        led_temp(curpos + dir) <= '1';
--        curpos <= curpos + dir;
--        count <= 0;
        
--        if(curpos =0) then
--            if(sw1 = '1' or button1='1') then
--                dir <= 1;
--                --bspeed <= temp_speed1;
--                if(temp_speed1 = '1') then
--                    bsp <= 10*10**6;
--                else
--                    bsp <= 4*10**7;
--                end if;
--                --led_temp(0) <= '0';
--                --led_temp(1) <= '1';
            
--            else
--                --led_temp(10) <= '1';
--                led_temp(3 downto 0) <= "0000";
--                score2 <= score2 +1 ;
--                count <= 0;---2*10**8;--wait time 2 sec
                
--                curpos <= 7;
--                --if(curpos = 7) then
--                    dir <= 1;--(-1)*dir ;
--               -- end if;        
--            end if;
        
--        elsif(curpos = 15) then
--            if(sw2 = '1' or button2='1') then
--               dir <= -1;
--               --bspeed <= temp_speed2;
--               if(temp_speed2 = '1') then
--                   bsp <= 10*10**6;
--               else
--                   bsp <= 4*10**7;
--               end if;
--               --led_temp(15) <= '0';
--               --led_temp(14) <= '1';
        
--            else
--                --led_temp(5) <= '1';
--                led_temp(15 downto 12) <= "0000";
--                score1 <= score1 +1 ;
--                count <= 0;---2*10**8;--wait time 2 sec
                
--                curpos <= 8;                
--                --if(curpos = 8) then
--                    dir <= -1;--(-1)*dir ;
--                --end if;
                   
--            end if;
       
--        end if;
        
--    end if;
    
    
    if(count > bsp) then
        led_temp(curpos) <= '0';
        led_temp(curpos + dir) <= '1';
        curpos <= curpos + dir;
        count <= 0;

        
        if(curpos =0) then
            if(sw1 = '1' or button1='1') then
                dir <= 1;
                --bspeed <= temp_speed1;
                if(temp_speed1 = '1') then
                    bsp <= 5*10**6;
                else
                    bsp <= 2*10**7;
                end if;
                --led_temp(0) <= '0';
                --led_temp(1) <= '1';
            
            else
                --led_temp(10) <= '1';
                led_temp(3 downto 0) <= "0000";
                score2 <= score2 +1 ;
                count <= 0;---2*10**8;--wait time 2 sec
                
                curpos <= 7;
                --if(curpos = 7) then
                    dir <= 1;--(-1)*dir ;
                --end if;        
            end if;
        
        elsif(curpos = 15) then
            if(sw2 = '1' or button2='1') then
               dir <= -1;
               --bspeed <= temp_speed2;
               if(temp_speed2 = '1') then
                   bsp <= 5*10**6;
               else
                   bsp <= 2*10**7;
               end if;
               --led_temp(15) <= '0';
               --led_temp(14) <= '1';
        
            else
                --led_temp(5) <= '1';
                led_temp(15 downto 12) <= "0000";
                score1 <= score1 +1 ;
                count <= 0;---2*10**8;--wait time 2 sec
                
                curpos <= 8;                
                --if(curpos = 8) then
                    dir <= -1;--(-1)*dir ;
                --end if;
                   
            end if;
       
        end if;
        
    end if;   
    
    case score2 is
      when 0 => b(15 downto 12) <= "0000";
      when 1 => b(15 downto 12) <= "0001";
      when 2 => b(15 downto 12) <= "0010";
      when 3 => b(15 downto 12) <= "0011";
      when 4 => b(15 downto 12) <= "0100";
      when 5 => b(15 downto 12) <= "0101";
      when 6 => b(15 downto 12) <= "0110";
      when 7 => b(15 downto 12) <= "0111";
      when 8 => b(15 downto 12) <= "1000";
      when 9 => b(15 downto 12) <= "1001";
      when others => b(15 downto 12) <= "1111";
    end case;
    
    case score1 is
      when 0 => b(11 downto 8) <= "0000";
      when 1 => b(11 downto 8) <= "0001";
      when 2 => b(11 downto 8) <= "0010";
      when 3 => b(11 downto 8) <= "0011";
      when 4 => b(11 downto 8) <= "0100";
      when 5 => b(11 downto 8) <= "0101";
      when 6 => b(11 downto 8) <= "0110";
      when 7 => b(11 downto 8) <= "0111";
      when 8 => b(11 downto 8) <= "1000";
      when 9 => b(11 downto 8) <= "1001";
      when others => b(11 downto 8) <= "1111";
    end case;                     
            
    case temp_speed1 is
      when '0' => b(3 downto 0) <= "1100";
      when others => b(3 downto 0) <= "1101";
    end case;     

    case temp_speed2 is
      when '0' => b(7 downto 4) <= "1100";
      when others => b(7 downto 4) <= "1101";
    end case;
    
    if(score1 = 9) then
        b(7 downto 0) <= "11110010";
    end if;
    
    if(score2 = 9) then
        b(7 downto 0) <= "11110001";
    end if;
    
    
    
--    if button1 = '1' then
--        led_temp(3) <= '1';
--    else
--        led_temp(3) <= '0';
--    end if;

--    if button2 = '1' then
--        led_temp(12) <= '1';
--    else
--        led_temp(12) <= '0';
--    end if;
        
  end if; 
  
    led(15 downto 0) <= led_temp(15 downto 0);

end process;

    
    dis : entity work.display
    port map(
    b=>b,
    clk=>clk,
    cathode(6 downto 0) => cathode(6 downto 0),
    anode(3 downto 0) => anode(3 downto 0),
    pushbutton => '0'
    );

end Behavioral;