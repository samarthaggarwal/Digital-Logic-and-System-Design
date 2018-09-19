-- Vhdl test bench created from schematic /home/asobti/Xilinx_projects/lab2_port_switch/lab2_port_switch.sch - Fri Jul 21 15:05:17 2017
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

ENTITY lab2_port_switch_tb IS
END lab2_port_switch_tb;
ARCHITECTURE behavioral OF lab2_port_switch_tb IS 

   COMPONENT lab2_port_switch
   Port ( req0 : in  STD_LOGIC;
			  dest0 : in STD_LOGIC_VECTOR(1 downto 0);
			  din0 : in STD_LOGIC;
			  ack0 : out STD_LOGIC;
           dout0 : out  STD_LOGIC;			  
			  req1 : in  STD_LOGIC;
			  dest1 : in STD_LOGIC_VECTOR(1 downto 0);
			  din1 : in STD_LOGIC;
			  ack1 : out STD_LOGIC;
           dout1 : out  STD_LOGIC;			  
			  req2 : in  STD_LOGIC;
			  dest2 : in STD_LOGIC_VECTOR(1 downto 0);
			  din2 : in STD_LOGIC;
			  ack2 : out STD_LOGIC;
           dout2 : out  STD_LOGIC;
			  src : out STD_LOGIC_VECTOR(1 downto 0)
			  );
   END COMPONENT;

   SIGNAL req0 : STD_LOGIC;
   SIGNAL dest0: STD_LOGIC_VECTOR(1 downto 0);
   SIGNAL din0 : STD_LOGIC;
   SIGNAL ack0 : STD_LOGIC;
   SIGNAL dout0: STD_LOGIC;
   SIGNAL req1 : STD_LOGIC;
   SIGNAL dest1: STD_LOGIC_VECTOR(1 downto 0);
   SIGNAL din1 : STD_LOGIC;
   SIGNAL ack1 : STD_LOGIC;
   SIGNAL dout1: STD_LOGIC;
   SIGNAL req2 : STD_LOGIC;
   SIGNAL dest2: STD_LOGIC_VECTOR(1 downto 0);
   SIGNAL din2 : STD_LOGIC;
   SIGNAL ack2 : STD_LOGIC;
   SIGNAL dout2: STD_LOGIC;
   SIGNAL src  : STD_LOGIC_VECTOR(1 downto 0);

   signal err_cnt_signal : integer;

BEGIN

   UUT: lab2_port_switch PORT MAP(
		req0	=>	req0,
		dest0	=>	dest0,
		din0	=>	din0,
		ack0	=>	ack0,
		dout0	=>	dout0,
		req1	=>	req1,
		dest1	=>	dest1,
		din1	=>	din1,
		ack1	=>	ack1,
		dout1	=>	dout1,
		req2	=>	req2,
		dest2	=>	dest2,
		din2	=>	din2,
		ack2	=>	ack2,
		dout2	=>	dout2,
		src	=>	src
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
	variable err_cnt : integer := 0;
        variable s : line;
	constant GND : STD_LOGIC := '0';
	constant SUPPLY : STD_LOGIC := '1';
	constant Port0 : std_logic_vector (1 downto 0)    := b"00";		
	constant Port1 : std_logic_vector (1 downto 0)    := b"01";		
	constant Port2 : std_logic_vector (1 downto 0)    := b"10";		


-- INPUTS												OUTPUTS							
-- req0		dest0[1:0]	din0	req1	dest1[1:0]	din1	req2	dest2[1:0]	din2	ack0	dout0	ack1	dout1	ack2	dout2	src[1:0]
-- SUPPLY	PORT1		GND	SUPPLY	PORT0		SUPPLY	GND	PORT0		GND	GND	SUPPLY	SUPPLY	-	GND	-	PORT1	
-- GND		PORT0		GND	SUPPLY	PORT2		SUPPLY	SUPPLY	PORT1		GND	GND	-	GND	GND	SUPPLY	-	PORT2	
-- SUPPLY	PORT2		GND	GND	PORT0		GND	SUPPLY	PORT0		SUPPLY	GND	SUPPLY	GND	-	SUPPLY	-	PORT2	
-- GND		PORT2		GND	GND	PORT1		GND	GND	PORT0		GND	GND	-	GND	-	GND	-	-	
-- SUPPLY	PORT2		GND	SUPPLY	PORT1		SUPPLY	SUPPLY	PORT0		GND	GND	GND	GND	-	SUPPLY	-	PORT2	
-- SUPPLY	PORT2		SUPPLY	GND	PORT0		GND	GND	PORT0		GND	SUPPLY	-	GND	-	GND	SUPPLY	PORT0	

   BEGIN

-- INPUTS												OUTPUTS							
-- req0		dest0[1:0]	din0	req1	dest1[1:0]	din1	req2	dest2[1:0]	din2	ack0	dout0	ack1	dout1	ack2	dout2	src[1:0]
-- SUPPLY	PORT1		GND	SUPPLY	PORT0		SUPPLY	GND	PORT0		GND	GND	SUPPLY	SUPPLY	-	GND	-	PORT1	

		-- case 0
		wait for 10 ns;	
		req0 <= SUPPLY;
		dest0 <= Port1;
		din0 <= GND;

		req1 <= SUPPLY;
		dest1 <= Port0;
		din1 <= SUPPLY;

		req2 <= GND;
		dest2 <= Port0;
		din2 <= GND;
		 
		wait for 1 ns;
		assert (ack0=GND) report "Error p1>p0,P1 requests Dest0 and P0 requests Dest1";
		assert (dout0=SUPPLY) report "Error p1>p0,P1 requests Dest0 and P0 requests Dest1";

		assert (ack1=SUPPLY) report "Error p1>p0,P1 requests Dest0 and P0 requests Dest1";

		assert (ack2=GND) report "Error p1>p0,P1 requests Dest0 and P0 requests Dest1";

		assert (src=Port1) report "Error p1>p0,P1 requests Dest0 and P0 requests Dest1";

		if (ack0/=GND or dout0/=SUPPLY or ack1/=SUPPLY or ack2/=GND or src/=Port1) then 
			 err_cnt := err_cnt + 1;
		end if;
		

-- INPUTS												OUTPUTS							
-- req0		dest0[1:0]	din0	req1	dest1[1:0]	din1	req2	dest2[1:0]	din2	ack0	dout0	ack1	dout1	ack2	dout2	src[1:0]
-- GND		PORT0		GND	SUPPLY	PORT2		SUPPLY	SUPPLY	PORT1		GND	GND	-	GND	GND	SUPPLY	-	PORT2	
		-- case 1
		wait for 10 ns;	
		req0 <= GND;
		dest0 <= PORT0;
		din0 <= GND;

		req1 <= SUPPLY;
		dest1 <= Port2;
		din1 <= SUPPLY;

		req2 <= SUPPLY;
		dest2 <= Port1;
		din2 <= GND;
		 
		wait for 1 ns;
		assert (ack0=GND) report "p2>p1,P2 requests Dest0 and P1 requests Dest2";

		assert (ack1=GND) report "p2>p1,P2 requests Dest0 and P1 requests Dest2";
		assert (dout1=GND) report "p2>p1,P2 requests Dest0 and P1 requests Dest2";

		assert (ack2=SUPPLY) report "p2>p1,P2 requests Dest0 and P1 requests Dest2";

		assert (src=PORT2) report "p2>p1,P2 requests Dest0 and P1 requests Dest2";

		if (ack0/=GND or ack1/=GND or dout1/=GND or ack2/=SUPPLY or src/=PORT2) then 
			 err_cnt := err_cnt + 1;
		end if;
			
		
-- INPUTS												OUTPUTS							
-- req0		dest0[1:0]	din0	req1	dest1[1:0]	din1	req2	dest2[1:0]	din2	ack0	dout0	ack1	dout1	ack2	dout2	src[1:0]
-- SUPPLY	PORT2		GND	GND	PORT0		GND	SUPPLY	PORT0		SUPPLY	GND	SUPPLY	GND	-	SUPPLY	-	PORT2	
		-- case "2"
		wait for 10 ns;	
		req0 <= SUPPLY;
		dest0 <= Port2;
		din0 <= GND;

		req1 <= SUPPLY;
		dest1 <= Port0;
		din1 <= GND;

		req2 <= SUPPLY;
		dest2 <= Port0;
		din2 <= SUPPLY;
		 
		wait for 1 ns;
		assert (ack0=GND) report "Error p2>p0,P2 requests Dest0 and P0 requests Dest2";
		assert (dout0=SUPPLY) report "Error p2>p0,P2 requests Dest0 and P0 requests Dest2";

		assert (ack1=GND) report "Error p2>p0,P2 requests Dest0 and P0 requests Dest2";

		assert (ack2=SUPPLY) report "Error p2>p0,P2 requests Dest0 and P0 requests Dest2";

		assert (src=Port2) report "Error p2>p0,P2 requests Dest0 and P0 requests Dest2";

		if (ack0/=GND or dout0/=SUPPLY or ack1/=GND or ack2/=SUPPLY or src/=Port2) then 
			 err_cnt := err_cnt + 1;
		end if;
			

-- INPUTS												OUTPUTS							
-- req0		dest0[1:0]	din0	req1	dest1[1:0]	din1	req2	dest2[1:0]	din2	ack0	dout0	ack1	dout1	ack2	dout2	src[1:0]
-- GND		PORT2		GND	GND	PORT1		GND	GND	PORT0		GND	GND	-	GND	-	GND	-	-	
		-- case "3"
		wait for 10 ns;	
		req0 <= GND;
		dest0 <= Port2;
		din0 <= GND;

		req1 <= GND;
		dest1 <= Port1;
		din1 <= GND;

		req2 <= GND;
		dest2 <= Port0;
		din2 <= GND;
		 
		wait for 1 ns;
		assert (ack0=GND) report "Error {req2,req1,req0} = 0,None of them request";

		assert (ack1=GND) report "Error {req2,req1,req0} = 0,None of them request";

		assert (ack2=GND) report "Error {req2,req1,req0} = 0,None of them request";

		if (ack0/=GND or ack1/=GND or ack2/=GND) then 
			 err_cnt := err_cnt + 1;
		end if;

-- INPUTS												OUTPUTS							
-- req0		dest0[1:0]	din0	req1	dest1[1:0]	din1	req2	dest2[1:0]	din2	ack0	dout0	ack1	dout1	ack2	dout2	src[1:0]
-- SUPPLY	PORT2		GND	SUPPLY	PORT1		SUPPLY	SUPPLY	PORT0		GND	GND	GND	GND	-	SUPPLY	-	PORT2	
		-- case "4"
		wait for 10 ns;	
		req0 <= SUPPLY;
		dest0 <= Port2;
		din0 <= GND;

		req1 <= SUPPLY;
		dest1 <= Port1;
		din1 <= SUPPLY;

		req2 <= SUPPLY;
		dest2 <= Port0;
		din2 <= GND;
		 
		wait for 1 ns;
		assert (ack0=GND) report "Error {req2,req1,req0} = 1,All of them request";
		assert (dout0=GND) report "Error {req2,req1,req0} = 1,All of them request";

		assert (ack1=GND) report "Error {req2,req1,req0} = 1,All of them request";

		assert (ack2=SUPPLY) report "Error {req2,req1,req0} = 1,All of them request";

		assert (src=Port2) report "Error {req2,req1,req0} = 1,All of them request";

		if (ack0/=GND or dout0/=GND or ack1/=GND or ack2/=SUPPLY or src/=Port2) then 
			 err_cnt := err_cnt + 1;
		end if;
						

-- INPUTS												OUTPUTS							
-- req0		dest0[1:0]	din0	req1	dest1[1:0]	din1	req2	dest2[1:0]	din2	ack0	dout0	ack1	dout1	ack2	dout2	src[1:0]
-- SUPPLY	PORT2		SUPPLY	GND	PORT0		GND	GND	PORT0		GND	SUPPLY	-	GND	-	GND	SUPPLY	PORT0	
		-- case "5"
		wait for 10 ns;	
		req0 <= SUPPLY;
		dest0 <= Port2;
		din0 <= SUPPLY;

		req1 <= GND;
		dest1 <= PORT0;
		req2 <= GND;
		din1 <= GND;

		dest2 <= Port0;
		din2 <= GND;
		 
		wait for 1 ns;
		assert (ack0=SUPPLY) report "Error p0 requests dest1";

		assert (ack1=GND) report "Error p0 requests dest1";

		assert (ack2=GND) report "Error p0 requests dest1";
		assert (dout2=SUPPLY) report "Error p0 requests dest1";

		assert (src=PORT0) report "Error p0 requests dest1";

		if (ack0/=SUPPLY or ack1/=GND or ack2/=GND or dout2/=SUPPLY or src/=PORT0) then 
			 err_cnt := err_cnt + 1;
		end if;

         err_cnt_signal <= err_cnt;        


		wait for 10 ns;

		-- summary of all the tests
		if (err_cnt=0) then 			
			 assert false 
			 report "Testbench of Lab 2 completed successfully!" 
			 severity note; 
		else 
			 assert true 
			 report "Something wrong, try again" 
			 severity error; 
		end if; 

      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***


END;

