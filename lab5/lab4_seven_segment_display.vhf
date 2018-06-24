--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : lab4_seven_segment_display.vhf
-- /___/   /\     Timestamp : 08/18/2017 22:51:20
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family artix7 -flat -suppress -vhdl /home/btech/cs1160395/lab4_seven_segment_display/lab4_seven_segment_display.vhf -w /home/btech/cs1160395/lab4_seven_segment_display/lab4_seven_segment_display.sch
--Design Name: lab4_seven_segment_display
--Device: artix7
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--
----- CELL CB16CE_HXILINX_lab4_seven_segment_display -----


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
   port ( b          : in    std_logic_vector (15 downto 0); 
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


