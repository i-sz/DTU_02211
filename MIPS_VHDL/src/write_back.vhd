
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY write_back is
	GENERIC ( MIPS_SIZE : NATURAL; ADDR_SIZE : NATURAL );
port(
    clk : in std_logic;
    rst : in std_logic;
	rd_data : in std_logic_vector(MIPS_SIZE-1 downto 0); 
	alu_result : in std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_reg_in  : in std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_reg_out : out std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_flag    : out std_logic;
	wr_data   : out std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_mem_wb : in std_logic;
	rd_mem_wb : in std_logic;
	branch : in std_logic;
	wb_reg_i : in std_logic

);
end write_back;


ARCHITECTURE behaviour OF write_back IS

BEGIN

process (clk, rst, alu_result, wr_reg_in, rd_data, wr_mem_wb, rd_mem_wb )
	begin
	 if (rst = '1') then
	   wr_reg_out <= (others => '0');
	   wr_data    <= (others => '0');
	   wr_flag    <= '0';
	elsif clk'event and clk = '1' then
	   wr_reg_out <= wr_reg_in;
		if (rd_mem_wb = '1' and wr_mem_wb = '0'and wb_reg_i = '1') then
			wr_data    <= rd_data;
			wr_flag    <= '1';
		elsif(rd_mem_wb = '0' and wr_mem_wb = '0' and wb_reg_i = '1') then
			wr_data <= alu_result;
			wr_flag    <= '1';
		elsif(wb_reg_i ='0') then
			wr_flag    <= '0';				
		end if;
       	   
	end if;
  end process;

END behaviour;
