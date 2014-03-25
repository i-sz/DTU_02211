library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.numeric_std.all

entity alu is
port(
	input_a : in std_logic_vector(7 downto 0);
	input_b : in std_logic_vector(7 downto 0);
	ctrl	: in std_logic_vector(2 downto 0);
	output  : in std_logic_vector(7 downto 0)
);
end alu;

architecture behaviour of alu is

begin

process(input_a, input_b, ctrl)
begin
	case ctrl is
		when "000" => output <= input_a and input_b;
		when "001" => output <= input_a or input_b;
		when "010" => output <= input_a + input_b;
		when "011" => output <= input_a - input_b;
		when "100" => output <= (others <= '0');
		when "101" => output <= (others <= '0');
		when "110" => output <= (others <= '0');
		when "111" => output <= (others <= '0');
		when others => output <= (others <= '0');
 	end case;
end process;

end behaviour	
