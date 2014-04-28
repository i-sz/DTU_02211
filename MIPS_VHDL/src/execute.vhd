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
	alu_result : out std_logic_vector(31 downto 0);
	ctrl : out std_logic_vector(2 downto 0);
	jump_addr_in : in std_logic_vector(31 downto 0); --jump address
	jump_addr_out : out std_logic_vector(31 downto 0);
	branch_out : out std_logic_vector(7 downto 0);
	pc_sel : out std_logic; -- controls the mux in IF
	pc_address_out : out std_logic_vector(31 downto 0)  --input to the PC_ADDR mux
);
end execute;


architecture behaviour of execute is

signal input_a, input_b : std_logic_vector(31 downto 0);
signal branch_add, jump_addr_out, jump_addr_p : std_logic_vector(31 downto 0);
--signals for the pipeline stage
signal alu_result_p : std_logic_vector(31 downto 0);
signal ctrl_p : std_logic_vector(2 downto 0);
signal branch_out_p : std_logic_vector(31 downto 0);



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
ctrl_p <= alu_ctrl;

--Branching
branch_add <= std_logic_vector(unsigned(pc_addr_in(7 DOWNTO 2)) + unsigned(sign_extend(7 DOWNTO 0)));
branch_out_p <= branch_add (7 DOWNTO 0); 
 
 --Jumping
jump_add <= jump_instr; --??
jump_addr_p <= jump_add;


--pipeline stage
process(clk,rst)
begin
	if  rst='1' then
		alu_result <= (others => '0');
		ctrl <= (others => '0');
		jump_addr_out <= (others => '0');
		branch_out <= (others => '0');
		reg3_addr_o <= (others => '0');
		pc_sel <= '0';
		pc_address_out <= (others => '0');

	elsif rising_edge(CLK) then 
		alu_result <= alu_result_p;
		ctrl <= ctrl_p;
		jump_addr_out <= jump_addr_p;
		branch_out <= branch_out_p;
		reg3_addr_o <= reg3_addr_i;
		pc_address_out <= branch_address;
	end if;
end process;	  
		

end behaviour;





