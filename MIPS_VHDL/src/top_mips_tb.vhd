LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.numeric_std.all;

ENTITY top_mips_tb IS
END top_mips_tb;

ARCHITECTURE tb_arc OF top_mips_tb IS
  
component top_mips is
GENERIC (MIPS_SIZE: NATURAL; ADDR_SIZE: NATURAL);
port(
	clock : in std_logic;
	reset : in std_logic
--	uart_tx : out std_logic;
--	uart_rx : in std_logic
);
END component; 

    signal clk	 : std_logic;
	signal reset : std_logic;

BEGIN

top_mips_i : top_mips 
	GENERIC map (MIPS_SIZE => 32, ADDR_SIZE => 5)
	port map (
		clock => clk,
		reset => reset
	--	uart_tx => ,
	--	uart_rx => ,
	);
	
    clk_proc: process
		begin
          clk <= '1', '0' AFTER 5 ns;
          WAIT FOR 10 ns;
    end process;
	
	reset_proc: process
		begin
			reset<='1';
			wait for 40 ns;
			reset<='0';
			wait;
	end process;

end tb_arc; 
