library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

entity Instr_Memory is
  GENERIC (N:     NATURAL:= 32);  -- Width of inputs.
  port (address : in std_logic_vector(N-1 downto 0);			
		data    : out std_logic_vector(N-1 downto 0));
end Instr_Memory;

architecture behavioral of Instr_Memory is
signal addr : integer range 0 to 4*50760;  
 
begin
addr <= to_integer(unsigned(address));
   process(addr) 
	begin
      case addr is 
       when 4*0    => data <= "10000100001000000000000000000001"; -- addi r01,r00,1
       when 4*1    => data <= "10000100010000010000000000000010"; -- addi r02,r01,2
       when 4*2    => data <= "10000100011000100000000000000011"; -- addi r03,r02,3
       when 4*3    => data <= "10000100100000110000000000000100"; -- addi r04,r03,4
       when 4*4    => data <= "00000011111000010001100000100000"; -- add r31,r01,r03
       when 4*5    => data <= "00000011110111110000100000100000"; -- add r30,r31,r01
       when 4*6    => data <= "00000011111111110001000000100010"; -- sub r31,r31,r02
       when 4*7    => data <= "11000000001000000000000000000001"; -- sb r01,r00,1
       when 4*8    => data <= "11000000010000000000000000000010"; -- sb r02,r00,2
       when 4*9    => data <= "10000100001000000000000000000001"; -- addi r01,r00,1
       when 4*10   => data <= "10000100010000000000000000000010"; -- addi r02,r00,2
       when 4*11   => data <= "10000100011000000000000000000011"; -- addi r03,r00,3
       when 4*12   => data <= "10000100100000000000000000000100"; -- addi r04,r00,4
       when 4*13   => data <= "00000011111000100001000000100100"; -- mult r31,r02,r02
       when 4*14   => data <= "00000011111000100001100000100100"; -- mult r31,r02,r03
       when 4*15   => data <= "10000000001000000000000000000001"; -- lb r01,r00,1
       when 4*16   => data <= "10000000010000000000000000000010"; -- lb r02,r00,2
	    when others => data <= "00000000000000000000000000000000"; 
       end case;
	end process;
end behavioral;
