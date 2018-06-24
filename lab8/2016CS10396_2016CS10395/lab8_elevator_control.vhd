----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.09.2017 21:24:35
-- Design Name: 
-- Module Name: lab8_elevator_control - Behavioral
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

entity lab8_elevator_control is
    Port (  up_request : in STD_LOGIC_VECTOR (3 downto 0);
            down_request : in STD_LOGIC_VECTOR (3 downto 0);
            up_request_indicator : out STD_LOGIC_VECTOR (3 downto 0);
            down_request_indicator : out STD_LOGIC_VECTOR (3 downto 0);
            reset : in STD_LOGIC;
            cathode : out STD_LOGIC_VECTOR (6 downto 0);
            anode : out STD_LOGIC_VECTOR (3 downto 0);
            door_open : in STD_LOGIC_VECTOR (1 downto 0);
            door_closed : in STD_LOGIC_VECTOR (1 downto 0);
            clk : in STD_LOGIC;
            lift1_floor : in STD_LOGIC_VECTOR (3 downto 0);
            lift2_floor : in STD_LOGIC_VECTOR (3 downto 0);
            lift1_floor_indicator : out STD_LOGIC_VECTOR (3 downto 0);
            lift2_floor_indicator : out STD_LOGIC_VECTOR (3 downto 0);
            sim_mode : in STD_LOGIC);
end lab8_elevator_control;

architecture Behavioral of lab8_elevator_control is




	component lab4_seven_segment_display is
	   port ( b     : in std_logic_vector(15 downto 0);
		  clk        : in    std_logic; 
		  pushbutton : in    std_logic; 
		  anode      : out   std_logic_vector (3 downto 0); 
		  cathode    : out   std_logic_vector (6 downto 0));
	end component;
	
	
	
	
    signal lift1_s : STD_LOGIC_VECTOR (1 downto 0) :="10";     --current status
    signal lift1_cf : integer :=0;                             -- current floor
    --signal lift1_s2 : STD_LOGIC_VECTOR (1 downto 0);        --no use
    --signal lift1_f : STD_LOGIC_VECTOR (1 downto 0);         --destination floor,no use
    signal lift1_d : STD_LOGIC :='1';                         --door open or close
  --  signal lift1_ideal : STD_LOGIC;                     --no use
    --signal lift2_ideal : STD_LOGIC;
    signal lift2_s : STD_LOGIC_VECTOR (1 downto 0) :="10";
    signal lift2_cf : integer :=0;
    --signal lift2_s2 : STD_LOGIC_VECTOR (1 downto 0);
    --signal lift2_f : STD_LOGIC_VECTOR (1 downto 0);
    signal lift2_d : STD_LOGIC :='1';
--    signal req0 : STD_LOGIC_VECTOR (1 downto 0);
--    signal req1 : STD_LOGIC_VECTOR (1 downto 0);
--    signal req2 : STD_LOGIC_VECTOR (1 downto 0);
--    signal req3 : STD_LOGIC_VECTOR (1 downto 0);

    signal req : STD_LOGIC_VECTOR(13 downto 0) :="00000000000000";
    signal lift1_dir : integer :=1;
    signal lift2_dir : integer :=1;
    
    signal lift1_fr : STD_LOGIC_VECTOR (23 downto 0) :="000000000000000000000000";     --floor that are to be visited
    signal lift2_fr : STD_LOGIC_VECTOR (23 downto 0) :="000000000000000000000000";
    signal count1 : INTEGER :=0;
    signal count2 : INTEGER :=0;
    signal output : STD_LOGIC_VECTOR(7 downto 0) :="00000000";

    --req0(0) tells if there is request at floor 0 to go up
    --req0(1) tells if there is request at floor 0 to go down


begin

    process(clk,reset)
   -- variable count1: integer :=0;
   -- variable count2: integer :=0;
    begin
    
        if (reset = '1') then
            lift1_s <= "10";
            lift1_d <= '1';
            lift2_s <= "10";
            lift2_d <= '1';
            lift1_fr <= (others => '0');
            lift2_fr <= (others => '0');
            req <= (others => '0');
            lift1_dir <= 1;
            lift2_dir <= 1;
            lift1_cf <= 0 ;
            lift2_cf <= 0 ;
            count1 <=0;
            count2 <= 0;
            lift1_floor_indicator <="0000";
            lift2_floor_indicator <="0000";
            up_request_indicator<="0000";
            down_request_indicator<="0000";
        
        -----------------------------------------------------------------------------------------------
        -- registering up request from different floors
        
        elsif(clk'event and clk='1') then
        
            if (up_request(0)='1') then
                req(10) <= '1';
                up_request_indicator(0) <= '1';
            end if;
            
            if (up_request(1)='1') then
                req(11) <= '1';
                up_request_indicator(1) <= '1';
            end if;
            
            if (up_request(2)='1') then
                req(12) <= '1';
                up_request_indicator(2) <= '1';
            end if;
            
            if (up_request(3)='1') then
                req(13) <= '1';
                up_request_indicator(3) <= '1';
            end if;
            
            -----------------------------------------------------------------------------------------------
            -- registering down request from different floor
            
            
            if (down_request(0)='1') then
                req(00) <= '1';
                down_request_indicator(0) <= '1';
            end if;
            
            if (down_request(1)='1') then
                req(01) <= '1';
                down_request_indicator(1) <= '1';
            end if;
            
            if (down_request(2)='1') then
                req(02) <= '1';
                down_request_indicator(2) <= '1';
            end if;
            
            if (down_request(3)='1') then
                req(03) <= '1';
                down_request_indicator(3) <= '1';
            end if;
            
            ------------------------------------------------------------------------------------------------
            --registering requests for floors from within the lifts
            
            if (lift1_floor(0)='1' and lift1_cf /= 0 ) then
                lift1_fr(20) <= '1';
                --lift1_fr(10) <= '1';
                lift1_floor_indicator(0) <= '1';
            end if;
            
            if (lift1_floor(1)='1' and lift1_cf /= 1) then
                lift1_fr(21) <= '1';
                --lift1_fr(11) <= '1';
                lift1_floor_indicator(1) <= '1';
            end if;
            
            if (lift1_floor(2)='1' and lift1_cf /= 2) then
                lift1_fr(22) <= '1';
                --lift1_fr(12) <= '1';
                lift1_floor_indicator(2) <= '1';
            end if;
            
            if (lift1_floor(3)='1' and lift1_cf /= 3) then
                lift1_fr(23) <= '1';
                --lift1_fr(13) <= '1';
                lift1_floor_indicator(3) <= '1';
            end if;
            
            -------------------------------------------------------------------------------------------------
            
            if (lift2_floor(0)='1' and lift2_cf /= 0) then
                lift2_fr(20) <= '1';
                --lift2_fr(10) <= '1';
                lift2_floor_indicator(0) <= '1';
            end if;
            
            if (lift2_floor(1)='1' and lift2_cf /= 1) then
                lift2_fr(21) <= '1';
                --lift2_fr(11) <= '1';
                lift2_floor_indicator(1) <= '1';
            end if;
            
            if (lift2_floor(2)='1' and lift2_cf /= 2) then
                lift2_fr(22) <= '1';
                --lift2_fr(12) <= '1';
                lift2_floor_indicator(2) <= '1';
            end if;
            
            if (lift2_floor(3)='1' and lift2_cf /= 3) then
                lift2_fr(23) <= '1';
                --lift2_fr(13) <= '1';
                lift2_floor_indicator(3) <= '1';
            end if;
            
         
                   
            
            if ( lift1_fr = "000000000000000000000000" ) then -- when lift 1 is ideal
                
                lift1_fr(13 downto 0) <= lift1_fr(13 downto 0) or req ;
                --lift1_ideal <= '0';
--                req<="00000000000000";
                if( (lift1_cf=2 and lift1_fr(23)='0' and lift1_fr(13)='0' and lift1_fr(03)='0') or (lift1_cf=1 and lift1_fr(23)='0' and lift1_fr(13)='0' and lift1_fr(03)='0' and lift1_fr(22)='0' and lift1_fr(12)='0' and lift1_fr(02)='0') or (lift1_cf=0 and lift1_fr(23)='0' and lift1_fr(13)='0' and lift1_fr(03)='0' and lift1_fr(22)='0' and lift1_fr(12)='0' and lift1_fr(02)='0' and lift1_fr(21)='0' and lift1_fr(11)='0' and lift1_fr(01)='0') ) then
                    lift1_dir <= 0;
                else
                    lift1_dir <= 1;
                end if;
            
            elsif ( lift2_fr = "000000000000000000000000" ) then  -- when lift 2 is ideal
                
                lift2_fr(13 downto 0) <= lift2_fr(13 downto 0) or req ;
                --lift2_ideal <= '0';
--                req<="00000000000000";
                if( (lift2_cf=2 and lift2_fr(23)='0' and lift2_fr(13)='0' and lift2_fr(03)='0') or (lift2_cf=1 and lift2_fr(23)='0' and lift2_fr(13)='0' and lift2_fr(03)='0' and lift2_fr(22)='0' and lift2_fr(12)='0' and lift2_fr(02)='0') or (lift2_cf=0 and lift2_fr(23)='0' and lift2_fr(13)='0' and lift2_fr(03)='0' and lift2_fr(22)='0' and lift2_fr(12)='0' and lift2_fr(02)='0' and lift2_fr(21)='0' and lift2_fr(11)='0' and lift2_fr(01)='0') ) then
                    lift2_dir <= 0;
                else
                    lift2_dir <= 1;
                end if;
                        
            else    --when no lift is ideal
            
                if(req(10) ='1') then   --up request from floor 0
                    if (lift1_dir = 1 and lift1_cf<=0) then
                        lift1_fr(10) <= '1';
                        req(10)<='0';
                    elsif (lift2_dir = 1 and lift2_cf<=0) then
                        lift2_fr(10) <= '1';
                        req(10)<='0';
                    end if;
                end if;
    
                if(req(11) ='1') then   --up request from floor 1
                    if (lift1_dir = 1 and lift1_cf<=1) then
                        lift1_fr(11) <= '1';
                        req(11)<='0';
                    elsif (lift2_dir = 1 and lift2_cf<=1) then
                        lift2_fr(11) <= '1';
                        req(11)<='0';
                    end if;
                end if;
                
                if(req(12) ='1') then   --up request from floor 2
                    if (lift1_dir = 1 and lift1_cf<=2) then
                        lift1_fr(12) <= '1';
                        req(12)<='0';
                    elsif (lift2_dir = 1 and lift2_cf<=2) then
                        lift2_fr(12) <= '1';
                        req(12)<='0';
                    end if;
                end if;
    
                if(req(03) ='1') then   --down request from floor 3
                    if (lift1_dir = 0 and lift1_cf>=3) then
                        lift1_fr(03) <= '1';
                        req(03)<='0';
                    elsif (lift2_dir = 0 and lift2_cf>=3) then
                        lift2_fr(03) <= '1';
                        req(03)<='0';
                    end if;
                end if;
                
                if(req(02) ='1') then   --down request from floor 2
                    if (lift1_dir = 0 and lift1_cf>=2) then
                        lift1_fr(02) <= '1';
                        req(02)<='0';
                    elsif (lift2_dir = 0 and lift2_cf>=2) then
                        lift2_fr(02) <= '1';
                        req(02)<='0';
                    end if;
                end if;
                
                if(req(01) ='1') then   --down request from floor 1
                    if (lift1_dir = 0 and lift1_cf>=1) then
                        lift1_fr(01) <= '1';
                        req(01)<='0';
                    elsif (lift2_dir = 0 and lift2_cf>=1) then
                        lift2_fr(01) <= '1';
                        req(01)<='0';
                    end if;
                end if;            
    
            end if;
            
            
            --lift 1 controller
            if(  lift1_fr /= "000000000000000000000000" ) then      --when lift1 is not ideal
            
    --                    if(clk'event and clk='1') then
                            count1 <= count1 + 1;
    --                    end if;
    
                        if(lift1_cf >=0 and lift1_cf <=3) then
                             --these 2 lines should not make any difference
    --                        lift1_fr(10*lift1_dir + lift1_cf) <= '0';
    --                        lift1_fr(20 + lift1_cf) <= '0';
                    
                                  --ADD ALL POSSIBLE CASES HERE
                                    if( lift1_s="10" and lift1_d='1' and lift1_fr( 10*lift1_dir + lift1_cf)='0' and lift1_fr(20 + lift1_cf)='0' ) then    --o.5 sec taken to close the door
                                            lift1_s <= "11";    --d=1;
                                            count1 <=0;
                                             --count1 <= count1 + 1;
                   
                    
                                    elsif( lift1_s="11" and lift1_d='1' and lift1_fr( 10*lift1_dir + lift1_cf)='0' and lift1_fr(20 + lift1_cf)='0' and count1=5*(10**7) ) then  --door is fully closed
                                           count1<=0;
                                           --lift1_s <= "11";
                                           lift1_d<='0';
                        
                    
                                     elsif( lift1_s="11" and lift1_d='0' and lift1_fr( 10*lift1_dir + lift1_cf)='0' and lift1_fr(20 + lift1_cf)='0' ) then   --lift has started moving up/down , direction is also corrected
                                               if( lift1_cf=3 and lift1_dir=1 ) then
                                                        lift1_dir<=0;
                                                        lift1_s<="01";
                        
                                               elsif(lift1_cf=0 and lift1_dir=0) then
                                                        lift1_dir<=1;
                                                        lift1_s<="00";
                        
                                               else
                                                        if(lift1_dir=1) then--changed d to dir
                                                                lift1_s<="00";
                                                        else
                                                                lift1_s<="01";  
                                                        end if;
                        
                                               end if;
                                   --lift1_d<='0';
                                    --count1 <= count1 + 1;
                        
                        
                                     elsif( (lift1_s="00" or lift1_s="01") and lift1_d='0' and count1=2*(10**8) ) then   --lift has reached the next floor
                                               count1<=0;
                        
                                               if( lift1_fr( 10*lift1_dir + lift1_cf + (2*lift1_dir) -1)='0' and lift1_fr(20 + lift1_cf + (2*lift1_dir) -1 )='0' ) then
                                                          lift1_cf <= lift1_cf + (2*lift1_dir) -1 ;
                            
                                                else
                                                            lift1_cf <= lift1_cf + (2*lift1_dir) -1 ;
                                                            lift1_s<="11";
    --                               lift1_floor_indicator(lift1_cf)<='0';   --the LED will turn off as soon as the lift doors start opening --TURN OFF THE UP_REQUEST AND DOWN_REQUEST AS WELL.   --cant turn off here as order of execution of statements will lead to different outputs.
                            
    --                        if(lift1_dir=1) then
    --                            up_request( lift1_cf ) <='0';
    --                        else
    --                            down_request( lift1_cf ) <= '0';
    --                        end if;
                        
                                                end if;
    
                                        elsif( lift1_s="11" and lift1_d='0' and ( lift1_fr( 10*lift1_dir + lift1_cf)='1' or lift1_fr(20 + lift1_cf)='1' ) and count1<2 ) then   --turn off the appropriate LEDs
                                                    lift1_floor_indicator(lift1_cf)<='0';
                                                    if(lift1_dir=1) then
                                                                 up_request_indicator( lift1_cf ) <='0';
                                                   else
                                                                 down_request_indicator( lift1_cf ) <= '0';
                                                   end if;                    
                    
                    
                                         elsif( lift1_s="11" and lift1_d='0' and ( lift1_fr( 10*lift1_dir + lift1_cf)='1' or lift1_fr(20 + lift1_cf)='1' ) and count1=5*(10**7) ) then
                                                   count1<=0;
                                                   lift1_s<="10";
                                                   lift1_d<='1';
                                        
                                         elsif( lift1_s="10" and lift1_d='1' and ( lift1_fr( 10*lift1_dir + lift1_cf)='1' or lift1_fr(20 + lift1_cf)='1' ) and count1=1*(10**8)  ) then
                                                   count1<=0;
                                                    lift1_fr( 10*lift1_dir + lift1_cf)<='0'; 
                                                      lift1_fr(20 + lift1_cf)<='0';
                                         
                                         end if;
                
                
                        else -- to correct lift direction, should not be required now.
                                if( lift1_dir = 1 and lift1_cf = 4 ) then
                                            lift1_dir <= 0;
                                            lift1_cf <=3 ;
                                elsif( lift1_dir =0 and lift1_cf = -1 ) then
                                            lift1_dir <= 1 ;
                                            lift1_cf <=0 ;
                                end if;
                        end if;
                        
            
           end if;        
            
            
            --lift 2 controller
           if(  lift2_fr /= "000000000000000000000000" ) then      --when lift2 is not ideal
           
    --                    if(clk'event and clk='1') then
                           count2 <= count2 + 1;
    --                    end if;
    
                       if(lift2_cf >=0 and lift2_cf <=3) then
                            --these 2 lines should not make any difference
    --                        lift2_fr(10*lift2_dir + lift2_cf) <= '0';
    --                        lift2_fr(20 + lift2_cf) <= '0';
                   
                                 --ADD ALL POSSIBLE CASES HERE
                                   if( lift2_s="10" and lift2_d='1' and lift2_fr( 10*lift2_dir + lift2_cf)='0' and lift2_fr(20 + lift2_cf)='0' ) then    --o.5 sec taken to close the door
                                           lift2_s <= "11";    --d=1;
                                           count2 <=0;
                                            --count2 <= count2 + 1;
                  
                   
                                   elsif( lift2_s="11" and lift2_d='1' and lift2_fr( 10*lift2_dir + lift2_cf)='0' and lift2_fr(20 + lift2_cf)='0' and count2=5*(10**7) ) then  --door is fully closed
                                          count2<=0;
                                          --lift2_s <= "11";
                                          lift2_d<='0';
                                      
                  
                                    elsif( lift2_s="11" and lift2_d='0' and lift2_fr( 10*lift2_dir + lift2_cf)='0' and lift2_fr(20 + lift2_cf)='0' ) then   --lift has started moving up/down , direction is also corrected
                                              if( lift2_cf=3 and lift2_dir=1 ) then
                                                       lift2_dir<=0;
                                                       lift2_s<="01";
                       
                                              elsif(lift2_cf=0 and lift2_dir=0) then
                                                       lift2_dir<=1;
                                                       lift2_s<="00";
                       
                                              else
                                                       if(lift2_dir=1) then--changed d to dir
                                                               lift2_s<="00";
                                                       else
                                                               lift2_s<="01";  
                                                       end if;
                       
                                              end if;
                                  --lift2_d<='0';
                                   --count2 <= count2 + 1;
                       
                       
                                    elsif( (lift2_s="00" or lift2_s="01") and lift2_d='0' and count2=2*(10**8) ) then   --lift has reached the next floor
                                              count2<=0;
                       
                                              if( lift2_fr( 10*lift2_dir + lift2_cf + (2*lift2_dir) -1)='0' and lift2_fr(20 + lift2_cf + (2*lift2_dir) -1 )='0' ) then
                                                         lift2_cf <= lift2_cf + (2*lift2_dir) -1 ;
                           
                                               else
                                                           lift2_cf <= lift2_cf + (2*lift2_dir) -1 ;
                                                           lift2_s<="11";
    --                               lift2_floor_indicator(lift2_cf)<='0';   --the LED will turn off as soon as the lift doors start opening --TURN OFF THE UP_REQUEST AND DOWN_REQUEST AS WELL.   --cant turn off here as order of execution of statements will lead to different outputs.
                           
    --                        if(lift2_dir=1) then
    --                            up_request( lift2_cf ) <='0';
    --                        else
    --                            down_request( lift2_cf ) <= '0';
    --                        end if;
                       
                                               end if;
    
                                       elsif( lift2_s="11" and lift2_d='0' and ( lift2_fr( 10*lift2_dir + lift2_cf)='1' or lift2_fr(20 + lift2_cf)='1' ) and count2<5 ) then   --turn off the appropriate LEDs
                                                   lift2_floor_indicator(lift2_cf)<='0';
                                                   if(lift2_dir=1) then
                                                                up_request_indicator( lift2_cf ) <='0';
                                                  else
                                                                down_request_indicator( lift2_cf ) <= '0';
                                                  end if;                    
                   
                   
                                        elsif( lift2_s="11" and lift2_d='0' and ( lift2_fr( 10*lift2_dir + lift2_cf)='1' or lift2_fr(20 + lift2_cf)='1' ) and count2=5*(10**7) ) then
                                                  count2<=0;
                                                  lift2_s<="10";
                                                  lift2_d<='1';
                                       
                                        elsif( lift2_s="10" and lift2_d='1' and ( lift2_fr( 10*lift2_dir + lift2_cf)='1' or lift2_fr(20 + lift2_cf)='1' ) and count2=1*(10**8)  ) then
                                                  count2<=0;
                                                   lift2_fr( 10*lift2_dir + lift2_cf)<='0'; 
                                                     lift2_fr(20 + lift2_cf)<='0';
                                        
                                        end if;
               
               
                       else -- to correct lift direction, should not be required now.
                               if( lift2_dir = 1 and lift2_cf = 4 ) then
                                           lift2_dir <= 0;
                                           lift2_cf <=3 ;
                               elsif( lift2_dir =0 and lift2_cf = -1 ) then
                                           lift2_dir <= 1 ;
                                           lift2_cf <=0 ;
                               end if;
                       end if;
                       
           
          --end if;        
           
                               
                   
                  end if;   
        
        end if;
        
        output(7 downto 6) <= lift1_s;    --display inputs
        output(3 downto 2) <= lift2_s;
        
        if(lift1_cf = 0) then
            output(5 downto 4) <= "00";
        elsif(lift1_cf = 1) then
            output(5 downto 4) <= "01";
        elsif(lift1_cf = 2) then
            output(5 downto 4) <= "10";       
        else
            output(5 downto 4) <= "11";
        end if;
            
            
        if(lift2_cf = 0) then
                output(1 downto 0) <= "00";
            elsif(lift2_cf = 1) then
                output(1 downto 0) <= "01";
            elsif(lift2_cf = 2) then
                output(1 downto 0) <= "10";       
            else
                output(1 downto 0) <= "11";
        end if;
        
--        case lift1_cf is
--        when 0 => output(5 downto 4)<="00";
--        when 1 => output(5 downto 4)<="01";
--        when 2 => output(5 downto 4)<="10";
--        when others => output(5 downto 4)<="11";
--        end case;
        
--        case lift2_cf is
--        when 0 => output(1 downto 0)<="00";
--        when 1 => output(1 downto 0)<="01";
--        when 2 => output(1 downto 0)<="10";
--        when others => output(1 downto 0)<="11";
--        end case;
        
--        if lift1_s="00" then
--            output(7 downto 6) <= "00";
--        elsif lift1_s="00" then
--            output(7 downto 6) <= "01";
--        elsif lift1_s="00" then
--            output(7 downto 6) <= "11";
--        elsif lift1_s="00" then
--            output(7 downto 6) <= "10";
--        end if;
        
--        if lift2_s="00" then
--            output(3 downto 2) <= "00";
--        elsif lift2_s="00" then
--            output(3 downto 2) <= "01";
--        elsif lift2_s="00" then
--            output(3 downto 2) <= "11";
--        elsif lift2_s="00" then
--            output(3 downto 2) <= "10";
--        end if;

    
    end process;
    
	display: lab4_seven_segment_display
    port map( b(15 downto 8) => "00000000", 
              b(7 downto 0) => output(7 downto 0),
              clk => clk,
              pushbutton => '0', 
              anode(3 downto 0) => anode(3 downto 0), 
              cathode(6 downto 0) => cathode(6 downto 0));

end Behavioral;





        







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
   
   signal temp       : std_logic_vector(1 downto 0);
   signal temp_anode : std_logic_vector(3 downto 0);
   
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
--   XLXI_9 : INV
--      port map (I=>XLXN_8,
--                O=>cathode(0));
   
--   XLXI_10 : INV
--      port map (I=>XLXN_9,
--                O=>cathode(1));
   
--   XLXI_11 : INV
--      port map (I=>XLXN_10,
--                O=>cathode(2));
   
--   XLXI_12 : INV
--      port map (I=>XLXN_11,
--                O=>cathode(3));
   
--   XLXI_13 : INV
--      port map (I=>XLXN_12,
--                O=>cathode(4));
   
--   XLXI_14 : INV
--      port map (I=>XLXN_13,
--                O=>cathode(5));
   
--   XLXI_15 : INV
--      port map (I=>XLXN_14,
--                O=>cathode(6));
   
   temp(1 downto 0) <= b(7 downto 6) when temp_anode(3 downto 0)="0111" else b(5 downto 4) when temp_anode(3 downto 0)="1011" else b(3 downto 2) when temp_anode(3 downto 0)="1101" else b(1 downto 0) when temp_anode(3 downto 0)="1110";
   
  cathode(6 downto 0) <= "1100011" when ( temp(1 downto 0)="00" and ( temp_anode(3 downto 0)="0111" or temp_anode(3 downto 0)="1101" ) )
                   else "0100001" when ( temp(1 downto 0)="01" and ( temp_anode(3 downto 0)="0111" or temp_anode(3 downto 0)="1101" ) )
                   else "0100011" when ( temp(1 downto 0)="10" and ( temp_anode(3 downto 0)="0111" or temp_anode(3 downto 0)="1101" ) )
                   else "0100111" when ( temp(1 downto 0)="11" and ( temp_anode(3 downto 0)="0111" or temp_anode(3 downto 0)="1101" ) )
                   else "1000000" when ( temp(1 downto 0)="00" and ( temp_anode(3 downto 0)="1011" or temp_anode(3 downto 0)="1110" ) )
                   else "1111001" when ( temp(1 downto 0)="01" and ( temp_anode(3 downto 0)="1011" or temp_anode(3 downto 0)="1110" ) )
                   else "0100100" when ( temp(1 downto 0)="10" and ( temp_anode(3 downto 0)="1011" or temp_anode(3 downto 0)="1110" ) )
                   else "0110000" when ( temp(1 downto 0)="11" and ( temp_anode(3 downto 0)="1011" or temp_anode(3 downto 0)="1110" ) ) ;
                   
   
   XLXI_17 : INV
      port map (I=>an(0),
                O=>temp_anode(0));
   
   XLXI_18 : INV
      port map (I=>an(1),
                O=>temp_anode(1));
   
   XLXI_19 : INV
      port map (I=>an(2),
                O=>temp_anode(2));
   
   XLXI_20 : INV
      port map (I=>an(3),
                O=>temp_anode(3));
   
   anode(3 downto 0) <= temp_anode(3 downto 0);
   
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


