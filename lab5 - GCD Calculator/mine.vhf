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


