LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY memory_access is
	GENERIC ( MIPS_SIZE : NATURAL; RAM_SIZE	: NATURAL; ADDR_SIZE : NATURAL );
port(
	clk : in std_logic;
	rst : in std_logic;
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
		MIPS_SIZE    	: NATURAL;
		RAM_SIZE	    : NATURAL
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
	GENERIC (MIPS_SIZE:    NATURAL; ADDR_SIZE : NATURAL ); -- Width of inputs.	
	port(
		clk : in std_logic;
		rst : in std_logic; 
		addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
		addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
		wr_reg_in : in std_logic_vector(ADDR_SIZE-1 downto 0);
		wr_reg_out : out std_logic_vector(ADDR_SIZE-1 downto 0);
		rd_data_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
		rd_data_out : out std_logic_vector(MIPS_SIZE-1 downto 0)
	);
	end COMPONENT;
  
   signal rd_data_s : std_logic_vector(MIPS_SIZE-1 downto 0);
  
BEGIN

	Data_Mem_RAM: Data_Memory 
	GENERIC map	( MIPS_SIZE, RAM_SIZE)
	PORT map (rst => rst,
		ramdata_in => wr_data,
		addr => addr_in,
		ram_write => '1',
		ram_read => '0',
		ramdata_out => rd_data_s
	);

	MEM_WB_regs_i : MEM_WB_regs
	GENERIC map	( MIPS_SIZE, ADDR_SIZE)
	port map (clk  => clk,
		rst => rst,
		addr_in => addr_in,
		addr_out => addr_out,
		wr_reg_in => wr_reg_in,
		wr_reg_out => wr_reg_out,
		rd_data_in => rd_data_s,
		rd_data_out => rd_data
	);

END behaviour;


------------------- Memory access to Write Back registers  -------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MEM_WB_regs is
	GENERIC ( MIPS_SIZE : NATURAL; ADDR_SIZE : NATURAL );
port(
	clk : in std_logic;
	rst : in std_logic; 
	addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_reg_in : in std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_reg_out : out std_logic_vector(ADDR_SIZE-1 downto 0);
	rd_data_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	rd_data_out : out std_logic_vector(MIPS_SIZE-1 downto 0)
);
end MEM_WB_regs; 

ARCHITECTURE behaviour OF MEM_WB_regs IS


BEGIN
  process (clk,rst,addr_in,wr_reg_in,rd_data_in )
  begin
	  if (rst = '1') then
		  addr_out    <= (others => '0');
		  wr_reg_out  <= (others => '0');
		  rd_data_out <= (others => '0');
		elsif clk'event and clk = '1' then
		  addr_out    <= addr_in;
		  wr_reg_out  <= wr_reg_in;
		  rd_data_out <= rd_data_in;    
		end if;
 end process;
END behaviour;
