library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

entity Instr_Memory is
  GENERIC (N:     NATURAL:= 32);  -- Width of inputs.
  port (address : in std_logic_vector(N-1 downto 0);			
		data    : out std_logic_vector(N-1 downto 0));
end Instr_Memory;

architecture behavioral of Instr_Memory is
signal addr : integer range 0 to 4*509;  
 
begin
addr <= to_integer(unsigned(address));
   process(addr) 
	begin
      case addr is 
       when 4*0    => data <= "10000100001000000000000000001010"; -- addi r01,r00,10
       when 4*1    => data <= "00000000000000000000000000000000"; -- nop
       when 4*2    => data <= "00000000000000000000000000000000"; -- nop
       when 4*3    => data <= "00000000000000000000000000000000"; -- nop
       when 4*4    => data <= "00000000000000000000000000000000"; -- nop
       when 4*5    => data <= "00000000000000000000000000000000"; -- nop
       when 4*6    => data <= "10000100010000000000000000001111"; -- addi r02,r00,15
       when 4*7    => data <= "00000000000000000000000000000000"; -- nop
       when 4*8    => data <= "00000000000000000000000000000000"; -- nop
       when 4*9    => data <= "00000000000000000000000000000000"; -- nop
       when 4*10   => data <= "00000000000000000000000000000000"; -- nop
       when 4*11   => data <= "00000000000000000000000000000000"; -- nop
       when 4*12   => data <= "10000100011000000000000000000101"; -- addi r03,r00,5
       when 4*13   => data <= "00000000000000000000000000000000"; -- nop
       when 4*14   => data <= "00000000000000000000000000000000"; -- nop
       when 4*15   => data <= "00000000000000000000000000000000"; -- nop
       when 4*16   => data <= "00000000000000000000000000000000"; -- nop
       when 4*17   => data <= "00000000000000000000000000000000"; -- nop
       when 4*18   => data <= "10000100100000000000000000000111"; -- addi r04,r00,7
       when 4*19   => data <= "00000000000000000000000000000000"; -- nop
       when 4*20   => data <= "00000000000000000000000000000000"; -- nop
       when 4*21   => data <= "00000000000000000000000000000000"; -- nop
       when 4*22   => data <= "00000000000000000000000000000000"; -- nop
       when 4*23   => data <= "00000000000000000000000000000000"; -- nop
       when 4*24   => data <= "10000100101000000000000000001100"; -- addi r05,r00,12
       when 4*25   => data <= "00000000000000000000000000000000"; -- nop
       when 4*26   => data <= "00000000000000000000000000000000"; -- nop
       when 4*27   => data <= "00000000000000000000000000000000"; -- nop
       when 4*28   => data <= "00000000000000000000000000000000"; -- nop
       when 4*29   => data <= "00000000000000000000000000000000"; -- nop
       when 4*30   => data <= "10000100110000000000000000010001"; -- addi r06,r00,17
       when 4*31   => data <= "00000000000000000000000000000000"; -- nop
       when 4*32   => data <= "00000000000000000000000000000000"; -- nop
       when 4*33   => data <= "00000000000000000000000000000000"; -- nop
       when 4*34   => data <= "00000000000000000000000000000000"; -- nop
       when 4*35   => data <= "00000000000000000000000000000000"; -- nop
       when 4*36   => data <= "10000100111000000000000000001101"; -- addi r07,r00,13
       when 4*37   => data <= "00000000000000000000000000000000"; -- nop
       when 4*38   => data <= "00000000000000000000000000000000"; -- nop
       when 4*39   => data <= "00000000000000000000000000000000"; -- nop
       when 4*40   => data <= "00000000000000000000000000000000"; -- nop
       when 4*41   => data <= "00000000000000000000000000000000"; -- nop
       when 4*42   => data <= "10000101000000000000000000000010"; -- addi r08,r00,2
       when 4*43   => data <= "00000000000000000000000000000000"; -- nop
       when 4*44   => data <= "00000000000000000000000000000000"; -- nop
       when 4*45   => data <= "00000000000000000000000000000000"; -- nop
       when 4*46   => data <= "00000000000000000000000000000000"; -- nop
       when 4*47   => data <= "00000000000000000000000000000000"; -- nop
       when 4*48   => data <= "11000000001000000000000000001011"; -- sb r01,r00,11
       when 4*49   => data <= "11000000010000000000000000001100"; -- sb r02,r00,12
       when 4*50   => data <= "11000000011000000000000000001101"; -- sb r03,r00,13
       when 4*51   => data <= "11000000100000000000000000001110"; -- sb r04,r00,14
       when 4*52   => data <= "11000000101000000000000000001111"; -- sb r05,r00,15
       when 4*53   => data <= "11000000110000000000000000010000"; -- sb r06,r00,16
       when 4*54   => data <= "11000000111000000000000000010001"; -- sb r07,r00,17
       when 4*55   => data <= "11000001000000000000000000010010"; -- sb r08,r00,18
       when 4*56   => data <= "00000000000000000000000000000000"; -- nop
       when 4*57   => data <= "00000000000000000000000000000000"; -- nop
       when 4*58   => data <= "00000000000000000000000000000000"; -- nop
       when 4*59   => data <= "00000000000000000000000000000000"; -- nop
       when 4*60   => data <= "00000000000000000000000000000000"; -- nop
       when 4*61   => data <= "10000101001000000000000000001000"; -- addi r09,r00,8
       when 4*62   => data <= "10000101010000000000000000000000"; -- addi r10,r00,0
       when 4*63   => data <= "10000101011000000000000000000000"; -- addi r11,r00,0
       when 4*64   => data <= "00000000000000000000000000000000"; -- nop
       when 4*65   => data <= "00000000000000000000000000000000"; -- nop
       when 4*66   => data <= "00000000000000000000000000000000"; -- nop
       when 4*67   => data <= "00000000000000000000000000000000"; -- nop
       when 4*68   => data <= "00000000000000000000000000000000"; -- nop
       when 4*69   => data <= "10000101010010100000000000000001"; -- addi r10,r10,1
       when 4*70   => data <= "00000000000000000000000000000000"; -- nop
       when 4*71   => data <= "00000000000000000000000000000000"; -- nop
       when 4*72   => data <= "00000000000000000000000000000000"; -- nop
       when 4*73   => data <= "00000000000000000000000000000000"; -- nop
       when 4*74   => data <= "00000000000000000000000000000000"; -- nop
       when 4*75   => data <= "10000000001010100000000000001010"; -- lb r01,r10,10
       when 4*76   => data <= "10000000010010100000000000001011"; -- lb r02,r10,11
       when 4*77   => data <= "00000000000000000000000000000000"; -- nop
       when 4*78   => data <= "00000000000000000000000000000000"; -- nop
       when 4*79   => data <= "00000000000000000000000000000000"; -- nop
       when 4*80   => data <= "00000000000000000000000000000000"; -- nop
       when 4*81   => data <= "00000000000000000000000000000000"; -- nop
       when 4*82   => data <= "00000000011000010001000000110100"; -- slt r03,r01,r02
       when 4*83   => data <= "00001001011010010000000000101000"; -- beq r11,r09,END
       when 4*84   => data <= "10000101011010110000000000000001"; -- addi r11,r11,1
       when 4*85   => data <= "00000000000000000000000000000000"; -- nop
       when 4*86   => data <= "00000000000000000000000000000000"; -- nop
       when 4*87   => data <= "00000000000000000000000000000000"; -- nop
       when 4*88   => data <= "00000000000000000000000000000000"; -- nop
       when 4*89   => data <= "00000000000000000000000000000000"; -- nop
       when 4*90   => data <= "00001000011000001111111111101010"; -- beq r03,r00,LOOP
       when 4*91   => data <= "00000100000000000000000000000001"; -- jmp SWAP
       when 4*92   => data <= "00000000000000000000000000000000"; -- nop
       when 4*93   => data <= "00000000000000000000000000000000"; -- nop
       when 4*94   => data <= "00000000000000000000000000000000"; -- nop
       when 4*95   => data <= "00000000000000000000000000000000"; -- nop
       when 4*96   => data <= "00000000000000000000000000000000"; -- nop
       when 4*97   => data <= "10000100011000010000000000000000"; -- addi r03,r01,0
       when 4*98   => data <= "00000000000000000000000000000000"; -- nop
       when 4*99   => data <= "00000000000000000000000000000000"; -- nop
       when 4*100   => data <= "00000000000000000000000000000000"; -- nop
       when 4*101   => data <= "00000000000000000000000000000000"; -- nop
       when 4*102   => data <= "00000000000000000000000000000000"; -- nop
       when 4*103   => data <= "10000100001000100000000000000000"; -- addi r01,r02,0
       when 4*104   => data <= "00000000000000000000000000000000"; -- nop
       when 4*105   => data <= "00000000000000000000000000000000"; -- nop
       when 4*106   => data <= "00000000000000000000000000000000"; -- nop
       when 4*107   => data <= "00000000000000000000000000000000"; -- nop
       when 4*108   => data <= "00000000000000000000000000000000"; -- nop
       when 4*109   => data <= "10000100010000110000000000000000"; -- addi r02,r03,0
       when 4*110   => data <= "00000000000000000000000000000000"; -- nop
       when 4*111   => data <= "00000000000000000000000000000000"; -- nop
       when 4*112   => data <= "00000000000000000000000000000000"; -- nop
       when 4*113   => data <= "00000000000000000000000000000000"; -- nop
       when 4*114   => data <= "00000000000000000000000000000000"; -- nop
       when 4*115   => data <= "11000000010010100000000000001010"; -- sb r02,r10,10
       when 4*116   => data <= "11000000001010100000000000001011"; -- sb r01,r10,11
       when 4*117   => data <= "00000000000000000000000000000000"; -- nop
       when 4*118   => data <= "00000000000000000000000000000000"; -- nop
       when 4*119   => data <= "00000000000000000000000000000000"; -- nop
       when 4*120   => data <= "00000000000000000000000000000000"; -- nop
       when 4*121   => data <= "00000000000000000000000000000000"; -- nop
       when 4*122   => data <= "00000111111111111111111111001010"; -- jmp LOOP
       when 4*123   => data <= "00000000000000000000000000000000"; -- nop
       when 4*124   => data <= "00000000000000000000000000000000"; -- nop
       when 4*125   => data <= "00000000000000000000000000000000"; -- nop
       when 4*126   => data <= "10000100001000000000000000000001"; -- addi r01,r00,1
	    when others => data <= "00000000000000000000000000000000"; 
       end case;
	end process;
end behavioral;
