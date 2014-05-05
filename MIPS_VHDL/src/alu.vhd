library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;

entity alu is
port(
	input_a : in std_logic_vector(31 downto 0);
	input_b : in std_logic_vector(31 downto 0);
	ctrl	: in std_logic_vector(2 downto 0);
	output  : out std_logic_vector(31 downto 0)
);
end alu;
architecture behaviour of alu is
signal output64  : std_logic_vector(63 downto 0);

begin

process(input_a, input_b, ctrl, output64)
begin
output64 <= (others => '0');
	case ctrl is
		when "000" => output <= std_logic_vector(unsigned(input_a) and unsigned(input_b));
		when "001" => output <= std_logic_vector(unsigned(input_a) or unsigned(input_b));
		when "010" => output <= std_logic_vector(unsigned(input_a) + unsigned(input_b));
		when "011" => output <= std_logic_vector(unsigned(input_a) / unsigned(input_b));
		when "100" => output64 <= std_logic_vector(unsigned(input_a) * unsigned(input_b));
		               output <= output64(31 downto 0);
		when "101" => output <= std_logic_vector(unsigned(input_a) sll to_integer(unsigned(input_b)));
		when "110" => output <= std_logic_vector(unsigned(input_a) - unsigned(input_b));
		when "111" => 
		 if (unsigned(input_a) < unsigned(input_b)) then
		  output <= "00000000000000000000000000000001";
		  else 
		  output <= "00000000000000000000000000000000";
		 end if;  
		when others => output <= (others => '0');
 	end case;
end process;

end behaviour;	
