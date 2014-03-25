library ieee;
use ieee.std_logic_1164.all;

entity Instr_Memory is
  GENERIC (N:     NATURAL);  -- Width of inputs.
  port (address : in std_logic_vector(N-1 downto 0);			
		data    : inout std_logic_vector(N-1 downto 0));
end Instr_Memory;

architecture behavioral of Instr_Memory is
  type mem is array ( 0 to 2**2 - 1) of std_logic_vector(N-1 downto 0);
  
  constant my_Rom : mem := (
    0  => "11100001",
    1  => "00000000",
    2  => "00011111",
    3  => "11101000");
	 
begin
   process(address) 
	begin
     case address is
       when "00000" => data <= my_rom(0);
       when "00001" => data <= my_rom(1);
       when "00010" => data <= my_rom(2);
       when "00011" => data <= my_rom(3); 
       when others => data <= "00000000";
	 end case;
  end process;
end architecture behavioral;
