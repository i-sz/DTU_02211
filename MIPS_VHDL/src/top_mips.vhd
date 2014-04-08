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
GENERIC (MIPS_SIZE: NATURAL:= 32; ADDR_SIZE: NATURAL:= 8);
port(
	clock : in std_logic;
	reset : in std_logic
--	uart_tx : in std_logic;
--	uart_rx : in std_logic
);
end top_mips;

architecture structural of top_mips is

component instr_fecth
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
	reg_1 : out std_logic_vector(ADDR_SIZE-1 downto 0);
	reg_2 : out std_logic_vector(ADDR_SIZE-1 downto 0);
	reg_3 : out std_logic_vector(ADDR_SIZE-1 downto 0);
	imm : out std_logic_vector(MIPS_SIZE-1 downto 0);
	jmp_addr : out std_logic_vector(25 downto 0);
	pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	sign_extend = out std_logic_vector(7 downto 0);
	-- alu_ctrl = 010 -> ADD, 110 -> SUB, 000 -> AND, 001 -> OR, 111 -> SLT, 100 -> MULT, 011 -> DIV, 101 -> SHIFT
	alu_ctrl : out std_logic_vector(2 downto 0);
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
	wr_data : in std_logic_vector(MIPS_SIZE-1 downto 0);
	rd_data : out std_logic_vector(MIPS_SIZE-1 downto 0)
);
end component;   
	
component write_back is
port(
	rst : in std_logic; 
	addr : in std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_reg_in : in std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_reg_out : out std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_data : out std_logic_vector(MIPS_SIZE-1 downto 0);
	rd_data : in std_logic_vector(MIPS_SIZE-1 downto 0)
);
end component;


--------internal signals-------
-- Instr_Fetch	
signal pc_sel_s                        : std_logic;
signal pc_addr_stage1, pc_addr_stage4  : std_logic_vector(MIPS_SIZE-1 downto 0);
signal instr_s                         : std_logic_vector(MIPS_SIZE-1 downto 0);	

-- Instr_decode
signal wr_data_s                       : std_logic_vector(MIPS_SIZE-1 downto 0);
signal wr_reg_stage2                   : std_logic_vector(ADDR_SIZE-1 downto 0);
signal offset_s                        : std_logic_vector(MIPS_SIZE-1 downto 0);
signal r2_addr_s, r3_addr_s            : std_logic_vector(ADDR_SIZE-1 downto 0);
signal r1_s,r2_s,r3_s                  : std_logic_vector(MIPS_SIZE-1 downto 0);

-- execute
signal pc_addr_in                      : std_logic_vector(MIPS_SIZE-1 downto 0);
signal r2_addr, r3_addr                : std_logic_vector(ADDR_SIZE-1 downto 0);
signal r1,r2,r3                        : std_logic_vector(MIPS_SIZE-1 downto 0);
signal offset                          : std_logic_vector(MIPS_SIZE-1 downto 0);
signal pc_addr_out                     : std_logic_vector(MIPS_SIZE-1 downto 0);
signal alu_output                      : std_logic_vector(MIPS_SIZE-1 downto 0);
signal r2_out                          : std_logic_vector(MIPS_SIZE-1 downto 0);
signal r2_r3_addr_out                  : std_logic_vector(ADDr_SIZE-1 downto 0);
	
-- memory_access
	
	
BEGIN

--Port maps

instr_fetch_i : instr_fecth
port map(
	clk	=> clock,
	rst => reset,
	pc_sel => pc_sel_s,
	pc_addr_in => pc_addr_stage4,
	pc_addr_out => pc_addr_stage1,
	instr => instr_s 
	);

instr_decode_i : instr_decode
port map(
	clk => clock,
	rst => reset,
	instr => instr_s,
	reg_1_addr => r1_addr,
	reg_2_addr => r2_addr,
	reg_3_addr => r3_addr,
	imm => imm_s,
	jmp_addr => jmp_addr_s,
	pc_addr_in => pc_addr_stage1,
	pc_addr_out => pc_addr_stage2,
	sign_extend => sign_extend,
	alu_ctrl => alu_ctrl_s
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

memory_access_i : memory_access  
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
