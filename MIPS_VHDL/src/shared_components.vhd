-------------- Adder ------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY adder IS                                
    GENERIC (N:     NATURAL := 8);                     -- Width of inputs.
    PORT (
    	adderin1:  IN  std_logic_vector(N DOWNTO 1);   -- Input.
    	adderin2:  IN  std_logic_vector(N DOWNTO 1);   -- Input.
		Cin:       IN  STD_LOGIC;
	    Cout:      OUT STD_LOGIC;		
        adderout:  OUT std_logic_vector(10 DOWNTO 1));   -- Output.
END adder;
ARCHITECTURE behaviour OF adder IS
BEGIN
    Cout  <=  adderin1(N) & adderin1(N);
    adderout <= std_logic_vector((unsigned(adderin1) + unsigned(adderin2)+unsigned(Cin)));
END behaviour;

-------------- 2 input MUX ------------
library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity mux2 is -- two-input multiplexer
    generic(width: integer);
    port(in0, in1: in  STD_LOGIC_VECTOR(width-1 downto 0);
         sel:      in  STD_LOGIC;
         y:        out STD_LOGIC_VECTOR(width-1 downto 0));
end;
architecture mux2_arc of mux2 is
begin
    y <= in0 when sel = '0' else in1;
end;

------------------- reg24b  -------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity reg24b is
    GENERIC (N:     NATURAL := 8);                     -- Width of inputs.
	PORT(
		     Ain     : IN  std_logic_vector(N-1 DOWNTO 0);
		     clk     : IN  std_logic;
		     reset   : IN std_logic;
		     reg_out : OUT	std_logic_vector(N-1 DOWNTO 0)
	);
	END reg24b;
ARCHITECTURE reg_arc OF reg24b IS
  signal input : std_logic_vector(N-1 DOWNTO 0);
 Begin    
   process(clk,reset)     
    begin
    if (reset = '1') then
     input <= (others => '0');
    elsif clk'event and clk = '1' then
     input <= Ain;
    end if;
  end process;
  reg_out <= input;
end reg_arc;
