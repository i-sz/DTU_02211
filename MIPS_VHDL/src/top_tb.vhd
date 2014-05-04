LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.numeric_std.all;

ENTITY top_tb IS
END top_tb;

ARCHITECTURE tb_arc OF top_tb is

component top
GENERIC (MIPS_SIZE: NATURAL:= 32; ADDR_SIZE: NATURAL:= 5);

port(
    clk : in std_logic;
    rst : in std_logic;
    uart_tx : out std_logic;
    uart_rx : in std_logic;
    led : out std_logic  --testing purpose
);
end component;

    signal led_s,uart_tx_s,uart_rx_s	 : std_logic;
	signal reset : std_logic;
		signal clk : std_logic :='0';
	
BEGIN
    top_i: top
	port map(
		clk => clk,
		rst => reset,
		uart_tx => uart_tx_s,
		uart_rx => uart_rx_s, 
		led => led_s
	);

   clk_proc: process
		begin
          WAIT FOR 10 ns;
			clk <= not clk;
    end process;
	
	reset_proc: process
		begin
			reset<='1';
			wait for 40 ns;
			reset<='0';
			wait;
	end process;

end tb_arc; 
