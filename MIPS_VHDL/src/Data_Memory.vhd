--------------Data_Memory Block RAM----------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Data_Memory IS
	GENERIC
	(
		MIPS_SIZE    	: integer range 0 to 10 := 10;
		RAM_SIZE	    : integer range 0 to 16 := 16
	);
	PORT
	(
		rst			    : IN  std_logic;                                    --- rst
		ramdata_in		: IN  std_logic_vector(MIPS_SIZE - 1 DOWNTO 0);     --- data input to RAM 
		addr	        : IN  std_logic_vector(MIPS_SIZE - 1 DOWNTO 0);     --- address input
		ram_write		: IN  std_logic;                                    --- Write enable input
		ram_read		: IN  std_logic;                                    --- Read enable input
		ramdata_out		: OUT std_logic_vector(MIPS_SIZE - 1 DOWNTO 0)      --- data output of RAM
	);
END Data_Memory;

ARCHITECTURE rtl OF Data_Memory IS
	--Creating a 2D block ram RAM_SIZE X MIPS_SIZE.
	--Declaration of type and signal of a RAM_SIZE element RAM
    --with each element being MIPS_SIZE bit wide.
	TYPE RAM IS ARRAY(RAM_SIZE-1 DOWNTO 0) OF std_logic_vector(MIPS_SIZE - 1 DOWNTO 0);   
	SIGNAL block_ram : RAM;
BEGIN
	PROCESS (rst,ramdata_in,addr,ram_write,ram_read)
	BEGIN
		IF (rst = '1') THEN --- reset---
		   for j in 0 to RAM_SIZE-1 loop
					block_ram(j) <= (others => '1');
		    end loop;
		----write----
		elsif (ram_write = '1' and ram_read = '0') THEN
			block_ram(to_integer(unsigned(addr))) <= ramdata_in;
        ----read----
		elsif (ram_write = '0' and ram_read = '1') THEN
			ramdata_out <= block_ram(to_integer(unsigned(addr)));
		else
			ramdata_out <= (others => 'Z');
		END IF;
	END PROCESS;
END rtl;
