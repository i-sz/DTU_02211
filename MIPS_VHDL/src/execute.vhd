library IEEE;
use IEEE.STD_LOGIC_1164.all;		
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.numeric_std.all;

entity  execute is
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
	pc_sel_in : in std_logic; -- jump flag
	alu_result : out std_logic_vector(31 downto 0);
	pc_sel_out : out std_logic; -- controls the mux in IF
	pc_address_out : out std_logic_vector(31 downto 0);	--input to the PC_ADDR mux
	b_out : out std_logic_vector(31 downto 0);
	wr_to_mem : in std_logic;
	rd_from_mem : in std_logic;
	memory_wr  : out std_logic;
	memory_rd  : out std_logic;
	branch_i : in std_logic;
	branch_o : out std_logic;
	wb_reg_i : in std_logic; -- write back flag to register file
	data_in_uart : in std_logic_vector(31 downto 0);
	data_in_uart_ex : out std_logic_vector(31 downto 0);
	rd_ena_uart_id :in std_logic;
	rd_ena_uart_ex : out std_logic;	
	wb_reg_o : out std_logic
);
end execute;


architecture behaviour of execute is

signal input_a, input_b : std_logic_vector(31 downto 0);
signal branch_address, jump_or_branch_address  : std_logic_vector(31 downto 0);
--signals for the pipeline stage
signal alu_result_p : std_logic_vector(31 downto 0);
signal ctrl_p : std_logic_vector(2 downto 0);
signal ab_test,pc_sel_actual : std_logic;

signal sign_extend_shifted : std_logic_vector(31 downto 0);





component alu is
port(
	input_a : in std_logic_vector(31 downto 0);
	input_b : in std_logic_vector(31 downto 0);
	ctrl	: in std_logic_vector(2 downto 0);
	output  : out std_logic_vector(31 downto 0)
);

end component;
	
begin

--Port map

alu_i : alu
port map(
	input_a => input_a,
	input_b => input_b,
	ctrl => alu_ctrl,
	output => alu_result_p
);	


input_a <= A;
input_b <= B when (alu_src ='0') else sign_extend;




--Branching 		

sign_extend_shifted <= sign_extend(29 downto 0) & "00";
branch_address <= std_logic_vector(unsigned(sign_extend_shifted));
ab_test <= '1' when a = b else '0';
jump_or_branch_address <= branch_address when ((ab_test = '1' and branch_i ='1') or pc_sel_in = '1') else sign_extend;
pc_sel_actual <= '1' when ((ab_test = '1' and branch_i ='1') or pc_sel_in = '1') else '0';						 



--pipeline stage
process(clk,rst)
begin
	if  rst='1' then
		alu_result <= (others => '0');
		reg3_addr_o <= (others => '0');
		pc_sel_out <= '0';
		pc_address_out <= (others => '0');
		b_out <= (others => '0');
		memory_wr  <= '0';
		memory_rd  <= '0';
		branch_o <= '0';
		wb_reg_o <= '0';
		rd_ena_uart_ex <= '0';
		data_in_uart_ex <= (others => '0');
	elsif rising_edge(CLK) then 
		alu_result <= alu_result_p;
		reg3_addr_o <= reg3_addr_i;
		pc_address_out <= jump_or_branch_address; --jump_or_branch_address
		pc_sel_out <= pc_sel_actual;
		b_out <= b;
		memory_wr  <= wr_to_mem;
		memory_rd  <= rd_from_mem;
		branch_o <= branch_i;
		wb_reg_o  <= wb_reg_i;
		rd_ena_uart_ex <= rd_ena_uart_id;
		data_in_uart_ex <= data_in_uart;
	end if;
end process;	  
		

end behaviour;





