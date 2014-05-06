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
       when 4*0    => data <= "10000100001000000000000001001000"; -- addi r01,r00,72
       when 4*1    => data <= "10000100010000000000000001100101"; -- addi r02,r00,101
       when 4*2    => data <= "10000100011000000000000001101100"; -- addi r03,r00,108
       when 4*3    => data <= "10000100100000000000000001101100"; -- addi r04,r00,108
       when 4*4    => data <= "10000100101000000000000001101111"; -- addi r05,r00,111
       when 4*5    => data <= "10000100110000000000000000100000"; -- addi r06,r00,32
       when 4*6    => data <= "10000100111000000000000001110111"; -- addi r07,r00,119
       when 4*7    => data <= "10000101000000000000000001101111"; -- addi r08,r00,111
       when 4*8    => data <= "10000101001000000000000001110010"; -- addi r09,r00,114
       when 4*9    => data <= "10000101010000000000000001101100"; -- addi r10,r00,108
       when 4*10   => data <= "10000101011000000000000001100100"; -- addi r11,r00,100
       when 4*11   => data <= "10000101100000000000000000100001"; -- addi r12,r00,33
       when 4*12   => data <= "10000111111000000000000001100100"; -- addi r31,r00,100
       when 4*13   => data <= "10000111110000000000000001100100"; -- addi r30,r00,100
       when 4*14   => data <= "10000111101000000000000001100100"; -- addi r29,r00,100
       when 4*15   => data <= "10000111100000000000000001100100"; -- addi r28,r00,100
       when 4*16   => data <= "10000111011000000000000001100100"; -- addi r27,r00,100
       when 4*17   => data <= "10000111010000000000000001100100"; -- addi r26,r00,100
       when 4*18   => data <= "10000111001000000000000001100100"; -- addi r25,r00,100
       when 4*19   => data <= "10000111000000000000000001100100"; -- addi r24,r00,100
       when 4*20   => data <= "10000110111000000000000001100100"; -- addi r23,r00,100
       when 4*21   => data <= "10000110110000000000000001100100"; -- addi r22,r00,100
       when 4*22   => data <= "10000110101000000000000001100100"; -- addi r21,r00,100
       when 4*23   => data <= "10000110100000000000000001100100"; -- addi r20,r00,100
       when 4*24   => data <= "10000111111000001111111111111111"; -- addi r31,r00,-1
       when 4*25   => data <= "00001000000111110000000000011100"; -- beq r00,r31,C2
       when 4*26   => data <= "11000000001000000000000000000000"; -- sb r01,r00,0
       when 4*27   => data <= "00000000000000000000000000000000"; -- nop
       when 4*28   => data <= "10000111110000001111111111111111"; -- addi r30,r00,-1
       when 4*29   => data <= "00001000000111100000000000100000"; -- beq r00,r30,C3
       when 4*30   => data <= "11000000010000000000000000000000"; -- sb r02,r00,0
       when 4*31   => data <= "00000000000000000000000000000000"; -- nop
       when 4*32   => data <= "10000111101000001111111111111111"; -- addi r29,r00,-1
       when 4*33   => data <= "00001000000111010000000000100100"; -- beq r00,r29,C4
       when 4*34   => data <= "11000000011000000000000000000000"; -- sb r03,r00,0
       when 4*35   => data <= "00000000000000000000000000000000"; -- nop
       when 4*36   => data <= "10000111100000001111111111111111"; -- addi r28,r00,-1
       when 4*37   => data <= "00001000000111000000000000101000"; -- beq r00,r28,C5
       when 4*38   => data <= "11000000100000000000000000000000"; -- sb r04,r00,0
       when 4*39   => data <= "00000000000000000000000000000000"; -- nop
       when 4*40   => data <= "10000111011000001111111111111111"; -- addi r27,r00,-1
       when 4*41   => data <= "00001000000110110000000000101100"; -- beq r00,r27,C6
       when 4*42   => data <= "11000000101000000000000000000000"; -- sb r05,r00,0
       when 4*43   => data <= "00000000000000000000000000000000"; -- nop
       when 4*44   => data <= "10000111010000001111111111111111"; -- addi r26,r00,-1
       when 4*45   => data <= "00001000000110100000000000110000"; -- beq r00,r26,C7
       when 4*46   => data <= "11000000110000000000000000000000"; -- sb r06,r00,0
       when 4*47   => data <= "00000000000000000000000000000000"; -- nop
       when 4*48   => data <= "10000111001000001111111111111111"; -- addi r25,r00,-1
       when 4*49   => data <= "00001000000110010000000000110100"; -- beq r00,r25,C8
       when 4*50   => data <= "11000000111000000000000000000000"; -- sb r07,r00,0
       when 4*51   => data <= "00000000000000000000000000000000"; -- nop
       when 4*52   => data <= "10000111000000001111111111111111"; -- addi r24,r00,-1
       when 4*53   => data <= "00001000000110000000000000111000"; -- beq r00,r24,C9
       when 4*54   => data <= "11000001000000000000000000000000"; -- sb r08,r00,0
       when 4*55   => data <= "00000000000000000000000000000000"; -- nop
       when 4*56   => data <= "10000110111000001111111111111111"; -- addi r23,r00,-1
       when 4*57   => data <= "00001000000101110000000000111100"; -- beq r00,r23,C10
       when 4*58   => data <= "11000001001000000000000000000000"; -- sb r09,r00,0
       when 4*59   => data <= "00000000000000000000000000000000"; -- nop
       when 4*60   => data <= "10000110110000001111111111111111"; -- addi r22,r00,-1
       when 4*61   => data <= "00001000000101100000000001000000"; -- beq r00,r22,C11
       when 4*62   => data <= "11000001010000000000000000000000"; -- sb r10,r00,0
       when 4*63   => data <= "00000000000000000000000000000000"; -- nop
       when 4*64   => data <= "10000110101000001111111111111111"; -- addi r21,r00,-1
       when 4*65   => data <= "00001000000101010000000001000100"; -- beq r00,r21,C12
       when 4*66   => data <= "11000001011000000000000000000000"; -- sb r11,r00,0
       when 4*67   => data <= "00000000000000000000000000000000"; -- nop
       when 4*68   => data <= "10000110100000001111111111111111"; -- addi r20,r00,-1
       when 4*69   => data <= "00001000000101000000000001001000"; -- beq r00,r20,END
       when 4*70   => data <= "11000001100000000000000000000000"; -- sb r12,r00,0
       when 4*71   => data <= "00000000000000000000000000000000"; -- nop
       when 4*72   => data <= "00000000000000000000000000000000"; -- nop
       when 4*73   => data <= "00000100000000000000000001001000"; -- jmp END
       when 4*74   => data <= "00000000000000000000000000000000"; -- nop
	    when others => data <= "00000000000000000000000000000000"; 
       end case;
	end process;
end behavioral;
