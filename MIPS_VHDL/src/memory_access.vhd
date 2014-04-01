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
	wr_data : in std_logic_vector(MIPS_SIZE-1 downto 0);
	rd_data : out std_logic_vector(MIPS_SIZE-1 downto 0)
);
end memory_access; 

ARCHITECTURE behaviour OF memory_access IS


	COMPONENT Data_Memory 
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
    END COMPONENT;

	COMPONENT MEM_WB_regs
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
	end COMPONENT;



BEGIN



	Data_Mem_RAM: Data_Memory 
	GENERIC map	( MIPS_SIZE=>; RAM_SIZE	=> )
	PORT map (rst => rst,
		ramdata_in => ,
		addr => ,
		ram_write => ,
		ram_read => ,
		ramdata_out => 
	);
    END COMPONENT;

	COMPONENT MEM_WB_regs
	port map (clk  => ,
		rst => ,
		pc_addr_in => ,
		pc_addr_out => ,
		addr_in => ,
		addr_out => ,
		wr_reg_in => ,
		wr_reg_out => ,
		wr_data => ,
		rd_data => 
	);
	end COMPONENT;

END behaviour;
