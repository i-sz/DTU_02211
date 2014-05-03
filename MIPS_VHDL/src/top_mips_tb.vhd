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
	reset : in std_logic;
	wr_ena : out std_logic;
    uart_rd_ena : in  std_logic;
    addr_adapter   : out  std_logic_vector(4 downto 0);
    data_out    : out std_logic_vector(31 downto 0);
    data_in     : in std_logic_vector(31 downto 0)
);
END component; 

    signal clk	 : std_logic;
	signal reset : std_logic;
	signal wr_ena_s       :std_logic;
    signal addr_adapter_s :std_logic_vector(4 downto 0);
    signal data_out_s     :std_logic_vector(31 downto 0);
BEGIN

top_mips_i : top_mips 
	GENERIC map (MIPS_SIZE => 32, ADDR_SIZE => 5)
	port map (
		clock => clk,
		reset => reset,
        wr_ena => wr_ena_s,
        uart_rd_ena => '0',
        addr_adapter => addr_adapter_s,
        data_out => data_out_s,
        data_in => (others =>'0')
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
