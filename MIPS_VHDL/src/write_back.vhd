
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY write_back is
port(
	rst : in std_logic; 
	addr : in std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_reg_in : in std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_reg_out : out std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_data : out std_logic_vector(MIPS_SIZE-1 downto 0);;
	rd_data : in std_logic_vector(MIPS_SIZE-1 downto 0)
);
end write_back;


ARCHITECTURE behaviour OF write_back IS

BEGIN


END behaviour;
