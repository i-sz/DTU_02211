LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY memory_access is
	GENERIC ( MIPS_SIZE : NATURAL; RAM_SIZE	: NATURAL; ADDR_SIZE : NATURAL );
port(
	clk : in std_logic;
	rst : in std_logic;
	wr  : in std_logic;
	rd  : in std_logic;
	reg3_addr_i : in  std_logic_vector(4 downto 0);
	reg3_addr_o : out  std_logic_vector(4 downto 0); -- decide if wb is needed and pass the address to wb	
	addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_data : in std_logic_vector(MIPS_SIZE-1 downto 0);
	rd_data : out std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_to_mem : out std_logic;
	rd_from_mem : out std_logic;
	branch_i : in std_logic;
	branch_o : out std_logic;
	wb_reg_i : in std_logic;
	wb_reg_o : out std_logic
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
	(   clk			    : IN  std_logic; 
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
		reg3_addr_i : in  std_logic_vector(4 downto 0);
	    reg3_addr_o : out  std_logic_vector(4 downto 0); -- decide if wb is needed and pass the address to wb	
		addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
		addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
		rd_data_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
		rd_data_out : out std_logic_vector(MIPS_SIZE-1 downto 0)
	);
	end COMPONENT;
  
   signal rd_data_s : std_logic_vector(MIPS_SIZE-1 downto 0);
   signal rd_s, wb_reg_i_s : std_logic; 
BEGIN

	Data_Mem_RAM: Data_Memory 
	GENERIC map	( MIPS_SIZE, RAM_SIZE)
	PORT map (clk  => clk,
	   rst => rst,
		ramdata_in => wr_data,
		addr => addr_in,
		ram_write => wr,
		ram_read => rd,
		ramdata_out => rd_data_s
	);

	MEM_WB_regs_i : MEM_WB_regs
	GENERIC map	( MIPS_SIZE, ADDR_SIZE)
	port map (clk  => clk,
		rst => rst,
		reg3_addr_i => reg3_addr_i,
		reg3_addr_o => reg3_addr_o,
		addr_in => addr_in,
		addr_out => addr_out,
		rd_data_in => rd_data_s,
		rd_data_out => rd_data
	);
	
	
	process (clk,rst)
	begin 
	if (rst = '1') then
		  wr_to_mem    <= '0';
		  rd_s <= '0';
		  rd_from_mem <= '0';
		  branch_o <= '0';
		  wb_reg_i_s <='0';
		  wb_reg_o <=  '0';
		  
		elsif clk'event and clk = '1' then
			wr_to_mem <= wr;
			rd_s <= rd;
			rd_from_mem <= rd_s;
			branch_o <= branch_i;
			wb_reg_i_s <= wb_reg_i;
			wb_reg_o <= wb_reg_i_s;
		end if;

    end process;
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
    reg3_addr_i : in  std_logic_vector(4 downto 0);
	reg3_addr_o : out  std_logic_vector(4 downto 0); -- decide if wb is needed and pass the address to wb		
	addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	rd_data_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	rd_data_out : out std_logic_vector(MIPS_SIZE-1 downto 0)
);
end MEM_WB_regs; 

ARCHITECTURE behaviour OF MEM_WB_regs IS


BEGIN
  process (clk,rst) --,addr_in,rd_data_in,reg3_addr_i
  begin
	  if (rst = '1') then
		  addr_out    <= (others => '0');
		  rd_data_out <= (others => '0');
		  reg3_addr_o <= (others => '0');
		elsif clk'event and clk = '1' then
		  addr_out    <= addr_in;
		  rd_data_out <= rd_data_in;
          reg3_addr_o	<= 	reg3_addr_i;
		end if;
 end process;
END behaviour;
