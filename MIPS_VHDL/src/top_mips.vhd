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
	reset : in std_logic;
	wr_ena : out std_logic;
	rd_ena : out std_logic;
   uart_rd_ena : in  std_logic;
   addr_adapter   : out  std_logic_vector(4 downto 0);
   data_out    : out std_logic_vector(31 downto 0);
   data_in     : in std_logic_vector(31 downto 0)
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
	reg_2_data : out std_logic_vector(MIPS_SIZE-1 downto 0);
	reg_3_data : out std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_flag    : in std_logic;
	reg1_wb_addr : in std_logic_vector(ADDR_SIZE-1 downto 0);  -- Reg3 addr From Write back
	reg1_wb_data : in std_logic_vector(MIPS_SIZE-1 downto 0);-- Reg3 data From Write back 	
	reg_1_addr : out std_logic_vector(ADDR_SIZE-1 downto 0); -- forwarded reg3 address
	pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	pc_sel_out: out std_logic;
	sign_extend : out std_logic_vector(31 downto 0);
	alu_ctrl : out std_logic_vector(2 downto 0);
	alu_src : out std_logic;
	wr_to_mem : out std_logic;
	rd_from_mem : out std_logic;
	branch : out std_logic
);
end component;

component execute is
port(
	clk : in std_logic;
	rst : in std_logic; 
	a   : in std_logic_vector(31 downto 0);
	b   : in std_logic_vector(31 downto 0);
	reg3_addr_i : in  std_logic_vector(4 downto 0);
	reg3_addr_o : out  std_logic_vector(4 downto 0); -- decide if wb is needed and pass the address to wb
	sign_extend : in std_logic_vector(31 downto 0);
	alu_ctrl : in std_logic_vector(2 downto 0);
	alu_src : in  std_logic;
	pc_addr_in : in std_logic_vector(31 downto 0);
	pc_sel_in : in std_logic;
	alu_result : out std_logic_vector(31 downto 0);
	pc_sel_out : out std_logic; -- controls the mux in IF
	pc_address_out : out std_logic_vector(31 downto 0);  --input to the PC_ADDR mux
	b_out : out std_logic_vector(31 downto 0);
	wr_to_mem : in std_logic;
	rd_from_mem : in std_logic;
	memory_wr  : out std_logic;
	memory_rd  : out std_logic;
	branch_i : in std_logic;
	branch_o : out std_logic
	);
end component;

component  memory_access is
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
	branch_o : out std_logic
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
	wr_data : out std_logic_vector(MIPS_SIZE-1 downto 0);
	wr_mem_wb : in std_logic;
	rd_mem_wb : in std_logic;
	branch : in std_logic

);
end component;

--------internal signals-------
-- Instr_Fetch	
signal pc_sel_s                        : std_logic;
signal pc_addr_stage1                  : std_logic_vector(MIPS_SIZE-1 downto 0);
signal instr_s                         : std_logic_vector(MIPS_SIZE-1 downto 0);	

-- Instr_decode
signal wr_data_s                       : std_logic_vector(MIPS_SIZE-1 downto 0);
signal r2_s,r3_s                       : std_logic_vector(MIPS_SIZE-1 downto 0);
signal r1_addr_s                       : std_logic_vector(ADDR_SIZE-1 downto 0);
signal r1_data_s                       : std_logic_vector(MIPS_SIZE-1 downto 0);
signal pc_addr_stage2                  : std_logic_vector(MIPS_SIZE-1 downto 0);
signal sign_extend_s                   : std_logic_vector(31 downto 0);
signal alu_ctrl_s                      : std_logic_vector(2 downto 0);
signal wr_flag_s,wb_ena_s              : std_logic;
signal alu_src_s					   : std_logic;
signal wr_to_mem_s, rd_from_mem_s : std_logic;
signal branch_s : std_logic;





-- execute
signal pc_addr_stage3                    : std_logic_vector(MIPS_SIZE-1 downto 0);
signal alu_output_s                      : std_logic_vector(MIPS_SIZE-1 downto 0);
signal ctrl_s                            : std_logic_vector(2 downto 0);
signal reg1_addr_ex_s,reg1_addr_ex_s1                : std_logic_vector(ADDR_SIZE-1 downto 0);
signal reg1_addr_id_s					 : std_logic_vector(ADDR_SIZE-1 downto 0);

signal pc_sel_ss : std_logic;
signal b_out_s : std_logic_vector(31 downto 0);
	
-- memory_access
signal pc_addr_stage4                     : std_logic_vector(MIPS_SIZE-1 downto 0);
signal addr_s                             : std_logic_vector(MIPS_SIZE-1 downto 0);
signal rd_data_s                          : std_logic_vector(MIPS_SIZE-1 downto 0);
signal wr_reg_stage4                      : std_logic_vector(ADDR_SIZE-1 downto 0);
signal mem_wr                             : std_logic;
signal mem_rd                             : std_logic;
signal wr_mem_ma						  : std_logic;
signal rd_mem_ma						  : std_logic;
signal branch_sm						  : std_logic;
	
-- write_back
signal wr_reg_stage5                      : std_logic_vector(ADDR_SIZE-1 downto 0);
signal branch_mw						  : std_logic;

--uart adapter signals
signal uart_rd_ena_s								: std_logic;
signal data_in_s									: std_logic_vector(31 downto 0);	
signal addr_in_s                      : std_logic_vector(ADDR_SIZE-1 downto 0);

	
BEGIN

--Port maps

instr_fetch_i : instr_fecth
GENERIC Map (MIPS_SIZE,4)
port map(
	clk	=> clock,
	rst => reset,
	pc_sel => pc_sel_ss,
	pc_addr_in => pc_addr_stage3,
	pc_addr_out => pc_addr_stage1,
	instr => instr_s 
	);

instr_decode_i : instr_decode
GENERIC Map (MIPS_SIZE, ADDR_SIZE)
port map(
	clk => clock,
	rst => reset,
	instr => instr_s,
	reg_2_data => r2_s,
	reg_3_data => r3_s,
	wr_flag => wr_flag_s, 
	reg1_wb_addr => addr_in_s, -- coming from wb r1_addr_s
	reg1_wb_data => data_in_s, -- coming from wb r1_data_s
	reg_1_addr => reg1_addr_id_s,  -- going to execution
	pc_addr_in => pc_addr_stage1,
	pc_addr_out => pc_addr_stage2,
	pc_sel_out => pc_sel_s,
	sign_extend => sign_extend_s,
	alu_ctrl => alu_ctrl_s,
	alu_src => alu_src_s,
	wr_to_mem => wr_to_mem_s,
	rd_from_mem => rd_from_mem_s,
	branch => branch_s
);			
	
execute_i : execute
port map(
	clk => clock,
	rst => reset,
	a => r2_s,
	b => r3_s,
	reg3_addr_i => reg1_addr_id_s,
	reg3_addr_o => reg1_addr_ex_s,
	sign_extend => sign_extend_s,
	alu_ctrl => alu_ctrl_s,
	alu_src => alu_src_s,
	pc_addr_in => pc_addr_stage2,
	pc_sel_in =>  pc_sel_s,
	alu_result => alu_output_s,
	pc_sel_out =>  pc_sel_ss,
	pc_address_out => pc_addr_stage3,
	b_out => b_out_s, --input to Memory_access
	memory_wr => mem_wr,
	memory_rd => mem_rd,
	wr_to_mem => wr_to_mem_s,
	rd_from_mem => rd_from_mem_s,
	branch_i => branch_s,
	branch_o => branch_sm
	);	

memory_access_i : memory_access
GENERIC Map (MIPS_SIZE,5,ADDR_SIZE)  
port map(
	clk => clock,
	rst => reset,
    wr => mem_wr,
	rd => mem_rd,
	reg3_addr_i => reg1_addr_ex_s,
	reg3_addr_o => reg1_addr_ex_s1,
	addr_in => alu_output_s, 
	addr_out => addr_s,
	wr_data => b_out_s,
	rd_data => rd_data_s,
	wr_to_mem => wr_mem_ma,
	rd_from_mem => rd_mem_ma,
	branch_i => branch_sm,
	branch_o => branch_mw
);


write_back_i : write_back
GENERIC Map (MIPS_SIZE, ADDR_SIZE)
port map(
    clk => clock,
	rst => reset,
	rd_data => rd_data_s,
	alu_result => addr_s,
	wr_reg_in => reg1_addr_ex_s1,
	wr_reg_out => r1_addr_s,
	wr_flag => wb_ena_s,
	wr_data => r1_data_s,
	wr_mem_wb => wr_mem_ma,
	rd_mem_wb => rd_mem_ma,
	branch => branch_mw
);
	
	rd_ena  <= mem_rd;
    wr_ena <= mem_wr;
    addr_adapter <= alu_output_s(4 downto 0);
    data_out <= b_out_s;
    data_in_s <= data_in when (uart_rd_ena='1') else r1_data_s;
    addr_in_s <= r1_addr_s;
	wr_flag_s <= uart_rd_ena or wb_ena_s;
   	
end structural;
