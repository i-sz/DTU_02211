--
-- TOP level of MIPS UART
-- 
-- DTU - 02211 Advanced computer architecture F14 
-- Harri Antero Laine(s131196)  Istvan Szonyi(s131153) Komlan Tom Evon(s072728)

-- Description :Top level architecture with the five basic components : 
--		instruction_fetch, instruction_decode, execution, memory_access, write back
--INSTRUCTION FORMAT(32 bits) R-type:
--   opcode | $1(R1) | $2(R2) | $3(R3) | shift | function 
--  31    26 25    21 20    16 15    11 10    6 5        0 
-- Version:	0.1 --initial top architecture
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;

entity top_mips is
port(
	clock : in std_logic;
	reset : in std_logic;
--	uart_tx : in std_logic;
--	uart_rx : in std_logic
);
end top_mips;

architecture structural of top_mips is

component instr_fecth is
port(
	clk	: in std_logic;
	rst : in std_logic;
	pc_sel : in std_logic;
	pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	instr : out std_logic_vector(MIPS_SIZE-1 downto 0) 
);
end component;


component instr_decode is
port(
	clk : in std_logic;
	rst : in std_logic;
	instr : in std_logic_vector(MIPS_SIZE-1 downto 0);
	pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_data : in std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_reg : in std_logic_vector(ADDR_SIZE-1 downto 0);
	offset : out std_logic_vector(MIPS_SIZE-1 downto 0);
    r2_addr, r3_addr: out std_logic_vector(ADDR_SIZE-1 downto 0);
	r1,r2,r3 : out std_logic_vector(MIPS_SIZE-1 downto 0)
);
end component;

component execute is
port(
	clk : in std_logic;
	rst : in std_logic;
	pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	r2_addr, r3_addr: out std_logic_vector(ADDR_SIZE-1 downto 0);
	r1,r2,r3 : in std_logic_vector(MIPS_SIZE-1 downto 0);
	offset : in std_logic_vector(MIPS_SIZE-1 downto 0);
	pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	alu_output : out std_logic_vector(MIPS_SIZE-1 downto 0);
	r2_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	r2_r3_addr_out : std_logic_vector(ADDr_SIZE-1 downto 0)
);
end component;

component  memory_access is
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
end component;   
	
component write_back is
port(
	rst : in std_logic; 
	addr : in std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_reg_in : in std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_reg_out : out std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_data : out std_logic_vector(MIPS_SIZE-1 downto 0);;
	rd_data : in std_logic_vector(MIPS_SIZE-1 downto 0)
);
end component



	
	
begin

--Port maps

isnstr_fetch_i : instr_fetch
port map(
	clk	=> clock,
	rst => reset,
	pc_sel => pc_sel_s,
	pc_addr_in => pc_addr_stage4,
	pc_addr_out => pc_addr_stage1,
	instr => instr_s 
		);

in: in std_logic_vector(MIPS_SIZE-1 downto 0)str_decode_i : instr_decode
port map(
	clk => clock,
	rst => reset,
	instr => insr_S,
	pc_addr_in => pc_addr_stage1,
	pc_addr_out => pc_addr_stage2,
	wr_data => wr_data_s,
	wr_reg => wr_reg_stage2,
	offset => offset_s,
    r2_addr => r2_addr_s
	r3_addr=> r3_addr_s,
	r1 => r1_s,
	r2 => r2_s
);			
	
execute_i : execute
port map(
	clk => clock,
	rst => reset,
	pc_addr_in => pc_addr_stage2,
	r2_addr => r2_addr_s,
	r3_addr => r3_addr_s,
	r1	=> r1_s,
	r2  => r2_s,
	offset => offset_s,
	pc_addr_out => pc_addr_stage3,
	alu_output => alu_output_s,
	r2_out => r2_stage3,
	r2_r3_addr_out => r2_r3_addr_out_s
);	

memory_access_i : memory  
port map(
	clk => clock,
	rst => reset,
	pc_addr_in => pc_addr_stage3,
	pc_addr_out => pc_addr_stage4, 
	addr_in => alu_output_s, 
	addr_out => addr_s,
	wr_reg_in => r2_r3_addr_out_s,
	wr_reg_out => wr_reg_stage4,
	wr_data => r2_stage_3,
	rd_data => rd_data_s
	
);

	
);

write_back_i : write_back
port map(
	rst => reset,
	addr => addr_s,
	wr_reg_in => wr_reg_stage4,
	wr_reg_out => wr_reg_stage5,
	wr_data => wr_data_s,
	rd_data =>rd_data_s
);
	


   	
end top_mips;
