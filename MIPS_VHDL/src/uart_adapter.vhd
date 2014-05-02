library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;

entity uart_adapter is
GENERIC (MIPS_SIZE: NATURAL:= 32; ADDR_SIZE: NATURAL:= 5);
port(

-- to UART
    uart_wr_ena : out std_logic;
    uart_rd_ena : out  std_logic;
    uart_addr   : out  std_logic_vector(1 downto 0);  --uart address
    uart_wr_data: out std_logic_vector(31 downto 0);
    uart_rd_data: in std_logic_vector(31 downto 0);
    uart_rdy_cnt : in std_logic_vector(1 downto 0);

--from execute
    addr_from_execute : in std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_data : in std_logic_vector(MIPS_SIZE-1 downto 0);
    wr  : in std_logic;
	rd  : in std_logic; 

);

end uart_adapter;
