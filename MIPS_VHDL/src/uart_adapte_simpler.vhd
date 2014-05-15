library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;

entity uart_adapter is
GENERIC (MIPS_SIZE: NATURAL:= 32; ADDR_SIZE: NATURAL:= 5);
port(

--global signals

    clk : in std_logic;
    rst : in std_logic;

-- processor interface
    mem_rd_ena       : in std_logic;
	mem_wr_ena       : in std_logic;   -- write enable to memory at execute stage
    mem_data_in      : in std_logic_vector(31 downto 0); -- write_data to memeory from execute stage 
    to_proc_data_in  : out  std_logic_vector(31 downto 0);  --uart data to processor   
    to_proc_rd_ena   : out std_logic;   --rd_ena to the processor to know when the readout happened
    mem_address      : in std_logic_vector(4 downto 0);  -- memory address from the execute stage

-- SIMCON interface to UART
    uart_wr_ena    : out  std_logic;
    uart_rd_ena    : out  std_logic;
    uart_addr      : out  std_logic_vector(1 downto 0);
    uart_wr_data   : out std_logic_vector(31 downto 0);
    uart_rd_data   : in std_logic_vector(31 downto 0);
	uart_rdy_cnt   : in std_logic_vector(1 downto 0)
);
end uart_adapter;

architecture behav of uart_adapter is
    signal uart_rdy_cnt_s    : std_logic_vector(1 downto 0);
	signal to_proc_rd_ena_s, to_proc_rd_ena_ss  : std_logic;
	begin
process (clk,rst)
	begin 
	  if (rst = '1') then
		to_proc_rd_ena <= '0';	
		to_proc_rd_ena_s <= '0';
	  elsif clk'event and clk = '1' then
	    to_proc_rd_ena_s <= to_proc_rd_ena_ss;	
		to_proc_rd_ena <= to_proc_rd_ena_s;
	  end if;
	end process;
	
    uart_wr_ena <= mem_wr_ena when (mem_address(4 downto 0) = "00000") else '0' ;
    uart_rd_ena <= mem_rd_ena;
    uart_addr <=  "00" when (mem_address(4 downto 0) = "00010") else "01" ;  --when we write to uart
    uart_wr_data <= mem_data_in;
	to_proc_data_in  <= uart_rd_data;
    uart_rdy_cnt_s <= uart_rdy_cnt;
    to_proc_rd_ena_ss <= '1' when ((mem_address(4 downto 0) = "00001" or mem_address(4 downto 0) = "00010") and mem_rd_ena = '1' ) else '0';
end behav;
