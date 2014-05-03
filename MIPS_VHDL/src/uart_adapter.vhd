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
	uart_rdy_cnt : in std_logic_vector(1 downto 0)
);
end uart_adapter;

architecture behav of uart_adapater is



begin
process(clk, mem_wr_ena, mem_data_in, mem_address, uart_rdy_cnt)
begin

if rising_edge(clk) then
    uart_wr_data <= (others => '0');
    uart_wr_ena <= '0';
    if mem_wr_ena = '1' then
        if mem_address(0) = '0' then
            uart_wr_data <= mem_data_in;
            uart_wr_ena <= '1'; 
            uart_addr <= "01";
        end if;
    end if;
end if;

if rising_edge(clk) then
    uart_rd_ena <='0';
    to_proc_data_in <= (others => '0');     
    to_proc_rd_ena <= '0';
    uart_addr <= "01";
    if mem_address(0) = '1' then
        uart_rd_ena <='1';
        uart_addr <= "00";
        if (uart_rdy_cnt = "00") then
            to_proc_data_in <=  uart_rd_data; 
				to_proc_rd_ena <='1';      
			end if;
	end if;		
end if; 
        
end process;

end behav;
