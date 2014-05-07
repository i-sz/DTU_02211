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
       when 4*0    => data <= "10000100011000000000000000001101"; -- addi r03,r00,13
       when 4*1    => data <= "10000100101000000000000000000101"; -- addi r05,r00,5
       when 4*2    => data <= "10000100100000000000000000000001"; -- addi r04,r00,1
       when 4*3    => data <= "10000100001000000000000000000000"; -- addi r01,r00,0
       when 4*4    => data <= "10000001010000000000000000000001"; -- lb r10,r00,1
       when 4*5    => data <= "00000000000000000000000000000000"; -- nop
       when 4*6    => data <= "00000000000000000000000000000000"; -- nop
       when 4*7    => data <= "00000000000000000000000000000000"; -- nop
       when 4*8    => data <= "00000000000000000000000000000000"; -- nop
       when 4*9    => data <= "00000000000000000000000000000000"; -- nop
       when 4*10   => data <= "11000001010000010000000000000010"; -- sb r10,r01,2
       when 4*11   => data <= "00001000001001010000000000010011"; -- beq r01,r05,READMEM
       when 4*12   => data <= "10000100001000010000000000000001"; -- addi r01,r01,1
       when 4*13   => data <= "00000100000000000000000000000100"; -- jmp READUART
       when 4*14   => data <= "00000000000000000000000000000000"; -- nop
       when 4*15   => data <= "00000000000000000000000000000000"; -- nop
       when 4*16   => data <= "00000000000000000000000000000000"; -- nop
       when 4*17   => data <= "00000000000000000000000000000000"; -- nop
       when 4*18   => data <= "00000000000000000000000000000000"; -- nop
       when 4*19   => data <= "10000001011000010000000000000010"; -- lb r11,r01,2
       when 4*20   => data <= "00000000000000000000000000000000"; -- nop
       when 4*21   => data <= "00000000000000000000000000000000"; -- nop
       when 4*22   => data <= "00000000000000000000000000000000"; -- nop
       when 4*23   => data <= "00000000000000000000000000000000"; -- nop
       when 4*24   => data <= "00000000000000000000000000000000"; -- nop
       when 4*25   => data <= "11000001011000000000000000000000"; -- sb r11,r00,0
       when 4*26   => data <= "00000000000000000000000000000000"; -- nop
       when 4*27   => data <= "00000000000000000000000000000000"; -- nop
       when 4*28   => data <= "00000000000000000000000000000000"; -- nop
       when 4*29   => data <= "00000000000000000000000000000000"; -- nop
       when 4*30   => data <= "00000000000000000000000000000000"; -- nop
       when 4*31   => data <= "00001000001000000000000000100010"; -- beq r01,r00,END
       when 4*32   => data <= "00000000001000010010000000100010"; -- sub r01,r01,r04
       when 4*33   => data <= "00000100000000000000000000010011"; -- jmp READMEM
       when 4*34   => data <= "00000000000000000000000000000000"; -- nop
       when 4*35   => data <= "00000000000000000000000000000000"; -- nop
       when 4*36   => data <= "00000000000000000000000000000000"; -- nop
       when 4*37   => data <= "00000000000000000000000000000000"; -- nop
       when 4*38   => data <= "00000000000000000000000000000000"; -- nop
	    when others => data <= "00000000000000000000000000000000"; 
       end case;
	end process;
end behavioral;
