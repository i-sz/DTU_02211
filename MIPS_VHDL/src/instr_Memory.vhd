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
       when 4*0    => data <= "00000000000000000000000000000000"; -- nop
       when 4*1    => data <= "10000100001000010000000000001010"; -- addi r01,r01,10
       when 4*2    => data <= "00000000000000000000000000000000"; -- nop
       when 4*3    => data <= "10000100010000000000000000000000"; -- addi r02,r00,0
       when 4*4    => data <= "00000000000000000000000000000000"; -- nop
       when 4*5    => data <= "00000000000000000000000000000000"; -- nop
       when 4*6    => data <= "00000000000000000000000000000000"; -- nop
       when 4*7    => data <= "00000000000000000000000000000000"; -- nop
       when 4*8    => data <= "00000000000000000000000000000000"; -- nop
       when 4*9    => data <= "00001000001000100000000000010010"; -- beq r01,r02,END
       when 4*10   => data <= "00000000000000000000000000000000"; -- nop
       when 4*11   => data <= "00000000000000000000000000000000"; -- nop
       when 4*12   => data <= "00000000000000000000000000000000"; -- nop
       when 4*13   => data <= "00000000000000000000000000000000"; -- nop
       when 4*14   => data <= "00000000000000000000000000000000"; -- nop
       when 4*15   => data <= "10000100010000100000000000000001"; -- addi r02,r02,1
       when 4*16   => data <= "00000000000000000000000000000000"; -- nop
       when 4*17   => data <= "00000100000000000000000000001001"; -- jmp LOOP
       when 4*18   => data <= "00000000000000000000000000000000"; -- nop
       when 4*19   => data <= "00000000000000000000000000000000"; -- nop
	    when others => data <= "00000000000000000000000000000000"; 
       end case;
	end process;
end behavioral;
