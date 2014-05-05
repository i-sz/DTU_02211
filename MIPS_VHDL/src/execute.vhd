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
	pc_sel_in : in std_logic;
	alu_result : out std_logic_vector(31 downto 0);
	pc_sel_out : out std_logic; -- controls the mux in IF
	pc_address_out : out std_logic_vector(31 downto 0);	--input to the PC_ADDR mux
	b_out : out std_logic_vector(31 downto 0);
	wr_to_mem : in std_logic;
	rd_from_mem : in std_logic;
	memory_wr  : out std_logic;
	memory_rd  : out std_logic
);
end execute;


architecture behaviour of execute is

signal input_a, input_b : std_logic_vector(31 downto 0);
signal branch_address, jump_or_branch_address  : std_logic_vector(31 downto 0);
--signals for the pipeline stage
signal alu_result_p : std_logic_vector(31 downto 0);
signal ctrl_p : std_logic_vector(2 downto 0);




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

process(pc_sel_in, a, sign_extend, pc_addr_in)
begin
  if (pc_sel_in = '1' ) then
  	if (a = "00000000000000000000000000000000") then
		case sign_extend(31) is
			when '1' =>
				jump_or_branch_address <= std_logic_vector(unsigned(pc_addr_in(31 DOWNTO 0)) + unsigned(sign_extend(31 DOWNTO 0) shift_left 2));
			when others =>
				jump_or_branch_address <= std_logic_vector(unsigned(pc_addr_in(31 DOWNTO 0)) - unsigned(sign_extend(31 DOWNTO 0) shift_left 2));
		end case;
  	else	
		jump_or_branch_address <= sign_extend;
	end if;
  else
  	jump_or_branch_address <= std_logic_vector(unsigned(pc_addr_in));
  end if;	
end process;  		

--branch_address <= std_logic_vector(unsigned(pc_addr_in(31 DOWNTO 0)) + unsigned(sign_extend(31 DOWNTO 0)));  
--jump_or_branch_address <= branch_address when (a = x"00000000") else sign_extend;

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
	elsif rising_edge(CLK) then 
		alu_result <= alu_result_p;
		reg3_addr_o <= reg3_addr_i;
		pc_address_out <= jump_or_branch_address; --jump_or_branch_address
		pc_sel_out <= pc_sel_in;
		b_out <= b;
		memory_wr  <= wr_to_mem;
		memory_rd  <= rd_from_mem;
	end if;
end process;	  
		

end behaviour;





