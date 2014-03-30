LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY memory_access is
port(
	clk : in std_logic;
	rst : in std_logic;
	pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0); 
	addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_reg_in : in std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_reg_out : out std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_data : in std_logic_vector(MIPS_SIZE-1 downto 0);;
	rd_data : out std_logic_vector(MIPS_SIZE-1 downto 0)
);
end memory_access; 

ARCHITECTURE behaviour OF memory_access IS

BEGIN


END behaviour;
