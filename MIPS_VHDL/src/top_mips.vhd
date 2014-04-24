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
GENERIC (MIPS_SIZE: NATURAL:= 32; ADDR_SIZE: NATURAL:= 5);
port(
	clock : in std_logic;
	reset : in std_logic
--	uart_tx : out std_logic;
--	uart_rx : in std_logic
);
end top_mips;

architecture structural of top_mips is

component instr_fecth
GENERIC (MIPS_SIZE: NATURAL; PC_incr: NATURAL := 4 );
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
GENERIC (MIPS_SIZE: NATURAL:= 32; ADDR_SIZE: NATURAL:= 5);
port(
	clk : in std_logic;
	rst : in std_logic;
	instr : in std_logic_vector(MIPS_SIZE-1 downto 0);
	reg_1_data : out std_logic_vector(MIPS_SIZE-1 downto 0);
	reg_2_data : out std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_flag    : in std_logic;
    reg3_wb_addr : in std_logic_vector(ADDR_SIZE-1 downto 0);  -- Reg3 addr From Write back
	reg3_wb_data : in std_logic_vector(MIPS_SIZE-1 downto 0);-- Reg3 data From Write back 	
	imm : out std_logic_vector(MIPS_SIZE-1 downto 0);
	reg_3_addr : out std_logic_vector(ADDR_SIZE-1 downto 0); -- forwarded reg3 address
	jmp_addr : out std_logic_vector(25 downto 0);
	pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	sign_extend : out std_logic_vector(31 downto 0);
	alu_ctrl : out std_logic_vector(2 downto 0)
);
end component;

component execute is
port(
	clk : in std_logic;
	rst : in std_logic; 
	a   : in std_logic_vector(31 downto 0);
	b   : in std_logic_vector(31 downto 0);
	reg3_addr_i : in  std_logic_vector(ADDR_SIZE-1 downto 0);
	reg3_addr_o : out  std_logic_vector(ADDR_SIZE-1  downto 0); -- decide if wb is needed and pass the address to wb
	sign_extend : in std_logic_vector(31 downto 0);
	alu_ctrl : in std_logic_vector(2 downto 0);
	alu_src : in  std_logic;
	pc_addr_in : in std_logic_vector(31 downto 0);
	alu_result : out std_logic_vector(31 downto 0);
	ctrl : out std_logic_vector(2 downto 0);
	jump_instr : in std_logic_vector(7 downto 0);
	jump_addr : out std_logic_vector(7 downto 0);
	branch_out : out std_logic_vector(7 downto 0)
);
end component;

component  memory_access is
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
end component;   
	
component write_back is
GENERIC ( MIPS_SIZE : NATURAL; ADDR_SIZE : NATURAL );
port(
	clk : in std_logic;
	rst : in std_logic; 
	rd_data : in std_logic_vector(MIPS_SIZE-1 downto 0);
	alu_result : in std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_reg_in  : in std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_reg_out : out std_logic_vector(ADDR_SIZE-1 downto 0);
	wr_flag : out std_logic;
	wr_data : out std_logic_vector(MIPS_SIZE-1 downto 0)

);
end component;


--------internal signals-------
-- Instr_Fetch	
signal pc_sel_s                        : std_logic := '0';
signal pc_addr_stage1                  : std_logic_vector(MIPS_SIZE-1 downto 0);
signal instr_s                         : std_logic_vector(MIPS_SIZE-1 downto 0);	

-- Instr_decode
signal wr_data_s                       : std_logic_vector(MIPS_SIZE-1 downto 0);
signal r1_s,r2_s                       : std_logic_vector(MIPS_SIZE-1 downto 0);
signal r3_addr_s                       : std_logic_vector(ADDR_SIZE-1 downto 0);
signal r3_data_s                       : std_logic_vector(MIPS_SIZE-1 downto 0);
signal imm_s                           : std_logic_vector(MIPS_SIZE-1 downto 0);
signal jmp_addr_s                      : std_logic_vector(25 downto 0);
signal pc_addr_stage2                  : std_logic_vector(MIPS_SIZE-1 downto 0);
signal sign_extend_s                   : std_logic_vector(31 downto 0);
signal alu_ctrl_s                      : std_logic_vector(2 downto 0);
signal wr_flag_s                       : std_logic;




-- execute
signal pc_addr_stage3                    : std_logic_vector(MIPS_SIZE-1 downto 0);
signal alu_output_s                      : std_logic_vector(MIPS_SIZE-1 downto 0);
signal ctrl_s                            : std_logic_vector(2 downto 0);
signal jump_addr_s                       : std_logic_vector(7 downto 0);
signal branch_out_s                      : std_logic_vector(7 downto 0);
signal reg3_addr_id_s					 : std_logic_vector(ADDR_SIZE-1 downto 0);
signal reg3_addr_ex_s					 : std_logic_vector(ADDR_SIZE-1 downto 0);

	
-- memory_access
signal pc_addr_stage4                     : std_logic_vector(MIPS_SIZE-1 downto 0);
signal addr_s                             : std_logic_vector(MIPS_SIZE-1 downto 0);
signal rd_data_s                          : std_logic_vector(MIPS_SIZE-1 downto 0);
signal wr_reg_stage4                      : std_logic_vector(ADDR_SIZE-1 downto 0);
	
-- write_back
signal wr_reg_stage5                      : std_logic_vector(ADDR_SIZE-1 downto 0);


	
BEGIN

--Port maps

instr_fetch_i : instr_fecth
GENERIC Map (MIPS_SIZE,4)
port map(
	clk	=> clock,
	rst => reset,
	pc_sel => pc_sel_s,
	pc_addr_in => pc_addr_stage2,
	pc_addr_out => pc_addr_stage1,
	instr => instr_s 
	);

instr_decode_i : instr_decode
GENERIC Map (MIPS_SIZE, ADDR_SIZE)
port map(
	clk => clock,
	rst => reset,
	instr => instr_s,
	reg_1_data => r1_s,
	reg_2_data => r2_s,
	wr_flag => wr_flag_s, 
	reg3_wb_addr => r3_addr_s, -- coming from wb
	reg3_wb_data => r3_data_s, -- coming from wb
	reg_3_addr => reg3_addr_id_s,  -- going to execution
	imm => imm_s,
	jmp_addr => jmp_addr_s,
	pc_addr_in => pc_addr_stage1,
	pc_addr_out => pc_addr_stage2,
	sign_extend => sign_extend_s,
	alu_ctrl => alu_ctrl_s
);			
	
execute_i : execute
port map(
	clk => clock,
	rst => reset,
	a => r1_s,
	b => r2_s,
	reg3_addr_i => reg3_addr_id_s,
	reg3_addr_o => reg3_addr_ex_s,
	sign_extend => sign_extend_s,
	alu_ctrl => alu_ctrl_s,
	alu_src => '0',
	pc_addr_in => pc_addr_stage2,
	alu_result => alu_output_s,
	ctrl => ctrl_s,
	jump_instr => jmp_addr_s(7 downto 0),
    jump_addr  => jump_addr_s,
	branch_out => branch_out_s
	);	

memory_access_i : memory_access
GENERIC Map (MIPS_SIZE,5,ADDR_SIZE)  
port map(
	clk => clock,
	rst => reset, 
	addr_in => alu_output_s, 
	addr_out => addr_s,
	wr_reg_in => branch_out_s(4 downto 0),
	wr_reg_out => wr_reg_stage4,
	wr_data => alu_output_s,
	rd_data => rd_data_s
	
);


write_back_i : write_back
GENERIC Map (MIPS_SIZE, ADDR_SIZE)
port map(
    clk => clock,
	rst => reset,
	rd_data => rd_data_s,
	alu_result => addr_s,
	wr_reg_in => wr_reg_stage4,
	wr_reg_out => r3_addr_s,
	wr_flag => wr_flag_s, 
	wr_data => r3_data_s

);
	


   	
end structural;
