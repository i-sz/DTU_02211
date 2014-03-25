-------------- 2 input MUX ------------
library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity mux2 is -- two-input multiplexer
    generic(N: NATURAL);
    port(in0, in1: in  STD_LOGIC_VECTOR(N-1 downto 0);
         sel:      in  STD_LOGIC;
         y:        out STD_LOGIC_VECTOR(N-1 downto 0));
end;
architecture mux2_arc of mux2 is
begin
    y <= in0 when sel = '0' else in1;
end mux2_arc;

------------------- register  -------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity reg is
    GENERIC (N:     NATURAL);  -- Width of inputs.
	PORT(
		     Ain     : IN  std_logic_vector(N-1 DOWNTO 0);
		     clk     : IN  std_logic;
		     rst   : IN std_logic;
		     reg_out : OUT	std_logic_vector(N-1 DOWNTO 0)
	);
	END reg;
ARCHITECTURE behaviour OF reg IS
  signal input : std_logic_vector(N-1 DOWNTO 0);
 Begin    
   process(clk,rst)     
    begin
    if (rst = '1') then
     input <= (others => '0');
    elsif clk'event and clk = '1' then
     input <= Ain;
    end if;
  end process;
  reg_out <= input;
end behaviour;

------------------- FULL adder  -------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity FULL_ADDER is 
    port(
	        in1	 : in	STD_LOGIC;
			in2	 : in	STD_LOGIC;
			Cin	 : in	STD_LOGIC;
			Cout : out	STD_LOGIC;
			Sum	 : out	STD_LOGIC
        );
end FULL_ADDER;

architecture behavior of FULL_ADDER is
signal a,b : std_logic;
begin
	a <= in1 and in2;
	b <= in1 xor in2;
	COUT <= a or ( b and CIN );
	sum <= b xor Cin;    
end behavior;

------------------- adder  -------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
 
entity adder is 
	generic (N: natural);    
	port(
		adderin1 : in	STD_LOGIC_VECTOR(N-1 downto 0);
		adderin2 : in	STD_LOGIC_VECTOR(N-1 downto 0);
		Cin	     : in	STD_LOGIC;
		Cout	 : out	STD_LOGIC;
		adderout : out	STD_LOGIC_VECTOR(N-1 downto 0)
	);
end adder;

architecture behavior of adder is
  
	component FULL_ADDER is
	    port(
			in1	 : in	STD_LOGIC;
			in2	 : in	STD_LOGIC;
			Cin	 : in	STD_LOGIC;
			Cout : out	STD_LOGIC;
			Sum	 : out	STD_LOGIC
	    );
	end component FULL_ADDER;

	signal C_int :	STD_LOGIC_VECTOR (N-1 downto 0);
      
begin
	FA0: FULL_ADDER 
	port map (
			in1	 => adderin1(0),
			in2  => adderin2(0),
			Cin	 => Cin,
			Cout => C_int(0),
			Sum	 => adderout(0)
	);
	ADDERi:
		for i in 1 to N-1 generate
			NEXT_FA:
				FULL_ADDER port map (
					in1	=> adderin1(i),
					in2	=> adderin2(i),	
					Cin	=> C_int(i-1),
					Cout=> C_int(i),
					Sum	=> adderout(i)
				);
		end generate;
	Cout <= C_int(N-1);
	
end behavior;
