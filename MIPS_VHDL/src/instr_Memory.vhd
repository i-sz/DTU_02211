library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

entity Instr_Memory is
  GENERIC (N:     NATURAL:= 32);  -- Width of inputs.
  port (address : in std_logic_vector(N-1 downto 0);			
		data    : out std_logic_vector(N-1 downto 0));
end Instr_Memory;

architecture behavioral of Instr_Memory is
signal addr : integer range 0 to 4*31;  
 
begin
addr <= to_integer(unsigned(address));
   process(addr) 
	begin
      case addr is 
		when 4*0   => data <= "00000001000010000000000000100000";--add
		when 4*1   => data <= "00000000100010000000000000100010";--sub
		when 4*2   => data <= "00000000010010000000000000100100";--mult
		when 4*3   => data <= "00000000001000010000000000100101";--div
		when 4*4   => data <= "00000001000010000000000000101000";--and
		when 4*5   => data <= "00000001000010000000000000101001";--or
		when 4*6   => data <= "00000000100010000000000000110100";--slt
		when 4*7   => data <= "00000001000010000000000010111000";--srl
		when 4*8   => data <= "00000001000010000000000100111001";--slr
		when 4*9   => data <= "00000101000010000000001000000000";--jmp 0
		when 4*10  => data <= "00000111000010000000000100000001";--jmp 1
		when 4*11  => data <= "10000101000010000000000000000010";--addi
		when 4*12  => data <= "00001001000010000000000000000100";--beq 0
		when 4*13  => data <= "00001001000010001000000000001000";--beq 1
		when 4*14  => data <= "00100001000010000000000000010000";
		when 4*15  => data <= "00100001000010000000000000100000";
		when 4*16  => data <= "00100000001000000000000000000010";--addi r01,r00,2
		when 4*17  => data <= "00000000010000010000100000100000";--add r02,r01,r01
		when 4*18  => data <= "00000000011000100000100000100010";--sub r03,r02,r01
		when 4*19  => data <= "00000000100000010001000000100100";--mult r04,r01,r02
		when 4*20  => data <= "00000000101001000000100000100101";--div r05,r04,r01
		when 4*21  => data <= "00000000110000010001000000101000";--and r06,r01,r02
		when 4*22  => data <= "00000000111000010001000000101001";--or r07,r01,r02
		when 4*23  => data <= "00000000011000100000100000110100";--slt r03,r02,r01
		when 4*24  => data <= "00010000001000100000000000000001";--addi r01,r00,0
		when 4*25  => data <= "10100000100000000000000011111111";
		when 4*26  => data <= "10000000100000000000000011111111";
		when 4*27  => data <= "00100001000010000000000010000000";
		when 4*28  => data <= "00100001000010000000000100000000";
		when 4*29  => data <= "00100001000010000000001000000000";
		when 4*30  => data <= "00100001000010000000000000000001";
		when 4*31  => data <= "00100001000010000000000000000010"; 
	    when others => data <= "11111111111111111111111111111111"; 
       end case;
	end process;
end behavioral;
