

library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;

entity  execute is
port(
	clk : in std_logic;
	rst : in std_logic; 
	a : in std_logic_vector(7 downto 0);
	b : in std_logic_vector(7 downto 0);
	sign_extend : in std_logic_vector(7 downto 0);
	alu_ctrl : in std_logic_vector(7 downto 0);
	alu_src : in  std_logic;
	pc_addr_in : in std_logic_vector(31 downto 0);
	
	alu_result : out std_logic_vector(7 downto 0);
	
	ctrl : out std_logic_vector(2 downto 0);
	
	jump_instr : in std_logic;
	jump_addr : out std_logic;

	branch_out : out std_logic_vector(7 downto 0);
	
);

end execute;


architecture behaviour of execute is

signal input_a, input_b, alu_output : std_logic_vector(7 downto 0);
signal alu_ctrl : std_logic_vector(2 downto 0);

component alu is
port(
	input_a : in std_logic_vector(7 downto 0);
	input_b : in std_logic_vector(7 downto 0);
	ctrl	: in std_logic_vector(2 downto 0);
	output  : in std_logic_vector(7 downto 0)
);

end component;
	
begin

--Port map

alu_i : alu
port map(
	input_a <= input_a,
	input_b <= input_b,
	ctrl <= alu_ctrl,
	output <= alu_rezult
);	


input_a <= A;
input_b <= B when (alu_src ='0') else sign_extend;
ctrl <= alu_ctrl;

--Branching
branch_add <= pc_addr_in (7 DOWNTO 2) + sign_extend (7 DOWNTO 0);
branch_out <= branch_add (7 DOWNTO 0); 
 
 --Jumping
jump_add <= jump_instr (7 DOWNTO 0);
jump_address <= jump_add;

end behaviour;




