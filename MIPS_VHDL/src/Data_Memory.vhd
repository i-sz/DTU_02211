--------------Data_Memory Block RAM----------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Data_Memory IS
	GENERIC
	(
		MIPS_SIZE    	: NATURAL := 32;
		RAM_SIZE	    : NATURAL := 5
	);
	PORT
	(   clk : in std_logic;
		rst			    : IN  std_logic;                                    --- rst
		ramdata_in		: IN  std_logic_vector(MIPS_SIZE - 1 DOWNTO 0);     --- data input to RAM 
		addr	        : IN  std_logic_vector(MIPS_SIZE - 1 DOWNTO 0);     --- address input
		ram_write		: IN  std_logic;                                    --- Write enable input
		ram_read		: IN  std_logic;                                    --- Read enable input
		ramdata_out		: OUT std_logic_vector(MIPS_SIZE - 1 DOWNTO 0)      --- data output of RAM
	);
END Data_Memory;

ARCHITECTURE rtl OF Data_Memory IS
	--Creating a 2D block ram 2^RAM_SIZE-1 X MIPS_SIZE.
	--Declaration of type and signal of a 2^RAM_SIZE-1 element RAM
    --with each element being MIPS_SIZE bit wide.
	TYPE RAM IS ARRAY(2**RAM_SIZE-1 DOWNTO 0) OF std_logic_vector(MIPS_SIZE - 1 DOWNTO 0);   
	SIGNAL block_ram : RAM;
BEGIN
	PROCESS (clk, rst,ramdata_in,addr,ram_write,ram_read)
	BEGIN
		IF (rst = '1') THEN --- reset---
		   for j in 0 to 2**RAM_SIZE-1 loop
					block_ram(j) <= (others => '0');
		    end loop;
		elsif rising_edge(clk) then
			----write----
			if (ram_write = '1' and ram_read = '0') THEN
				block_ram(to_integer(unsigned(addr(4 downto 0)))) <= ramdata_in;
				ramdata_out <= (others => '0');
			----read----
			elsif (ram_write = '0' and ram_read = '1') THEN
				ramdata_out <= block_ram(to_integer(unsigned(addr(4 downto 0))));
			END IF;
		END IF;	
	END PROCESS;
	
	
END rtl;
