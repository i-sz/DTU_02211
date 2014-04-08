-------------- Decoding instrunctions------------

-- 
-- DTU - 02211 Advanced computer architecture F14 
-- Harri Antero Laine(s131196)  Istvan Szonyi(s131153) Komlan Tom Evon(s072728)


library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.all;

entity instr_decode is
GENERIC (MIPS_SIZE: NATURAL:= 32; ADDR_SIZE: NATURAL:= 8);
	port(
		clk : in std_logic;
		rst : in std_logic;
		instr : in std_logic_vector(MIPS_SIZE-1 downto 0);
		reg_1_addr : out std_logic_vector(ADDR_SIZE-1 downto 0);
		reg_2_addr : out std_logic_vector(ADDR_SIZE-1 downto 0);
		reg_3_addr : out std_logic_vector(ADDR_SIZE-1 downto 0);
		imm : out std_logic_vector(MIPS_SIZE-1 downto 0);
		jmp_addr : out std_logic_vector(25 downto 0);
		pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
		pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
		sign_extend : out std_logic_vector(7 downto 0);
		-- alu_ctrl = 010 -> ADD, 110 -> SUB, 000 -> AND, 001 -> OR, 111 -> SLT, 100 -> MULT, 011 -> DIV, 101 -> SHIFT
		alu_ctrl : out std_logic_vector(2 downto 0)
	);
end instr_decode;

architecture behaviour of instr_decode is
	signal reg_1_p, reg_2_p, reg_3_p : std_logic_vector(ADDR_SIZE-1 downto 0);
	signal imm_p : std_logic_vector(MIPS_SIZE-1 downto 0);
	signal jmp_addr_p : std_logic_vector(25 downto 0);
	signal alu_ctrl_p : std_logic_vector(2 downto 0);
	signal sign_extend_p : std_logic_vector(7 downto 0);
	
component register_file is
	port(
		clk : in std_logic;
		rst : in std_logic;
		rw	: in std_logic;
		r1_addr	: in std_logic_vector(ADDR_SIZE-1 downto 0);
		r2_addr	: in std_logic_vector(ADDR_SIZE-1 downto 0);
		r3_addr	: in std_logic_vector(ADDR_SIZE-1 downto 0);
		wr_data : in std_logic_vector(MIPS_SIZE-1 downto 0);
		
		reg_2 : out std_logic_vector(MIPS_SIZE-1 downto 0);
		reg_3 : out std_logic_vector(MIPS_SIZE-1 downto 0)
	);
end component;	
	
begin

register_file_i : register_file 
port map(
		clk => clk,
		rst => rst,
		rw  => '0',
		r1_addr	=> reg_1_p,
		r2_addr	=> reg_2_p,
		r3_addr	=> reg_3_p,
		wr_data => (others => '0'),
		reg_2 => open, 
		reg_3 => open
	);
	
	process(clk)
	begin
	case instr(31 downto 26) is
		when "000000" => --register functions
			-- read register 2 and 3 and get register write address
			reg_1_p <= instr(25 downto 21); --from r1
			reg_2_p <= instr(20 downto 16); --from r2
			reg_3_p <= instr(15 downto 11); --from r3
			case instr(5 downto 0) is
				when "100000" => --add
					alu_ctrl_p <= "010";
				when "100010" => --sub
					alu_ctrl_p <= "110";
				when "100100" => --mult
					alu_ctrl_p <= "100";
				when "100101" => --div
					alu_ctrl_p <= "011";
				when "101000" => --and
					alu_ctrl_p <= "001";
				when "101001" => --or
					alu_ctrl_p <= "111";
				when "110100" => --slt
					alu_ctrl_p <= "100";
				when "111000" => --srl
					alu_ctrl_p <= "101";
				when "111001" => --slr
					alu_ctrl_p <= "101";
				when others =>
			end case;
		when "000001" => --jmp
			jmp_addr <= instr(25 downto 0);
			case instr(25) is
				when '1' =>
					sign_extend_p <= '1' & instr(6 downto 0);
				when others =>
					sign_extend_p <= '0' & instr(6 downto 0);
			end case;
		when others => --immediate and rest
			reg_1_p <= instr(25 downto 21);
			reg_2_p <= instr(20 downto 16); --from r2
			imm_p(15 downto 0) <= instr(15 downto 0); --from imm (we want to user 32-bit values)
			imm_p(MIPS_SIZE-1 downto 16) <= (others => '0');
			case instr(31 downto 26) is
				when "100001" => --addi
					alu_ctrl_p <= "010";
				when "000010" => --beq
					case instr(15) is
						when '1' =>
							sign_extend_p <= '1' & instr(6 downto 0);
						when others =>
							sign_extend_p <= '0' & instr(6 downto 0);
					end case;
				when "100000" => --lb
				when "110000" => --sb
				when others =>
			end case;
	end case;
	end process;
	
	process(clk,rst)
	begin
		if rst='1' then
			imm <= (others => '0');
			reg_1_addr <= (others => '0');
			reg_2_addr <= (others => '0');
			reg_3_addr <= (others => '0');
			alu_ctrl <= (others => '0');
			sign_extend <= (others => '0');
		elsif rising_edge(clk) then 
			imm <= imm_p;
			reg_1_addr <= reg_1_p;
			reg_2_addr <= reg_2_p;
			reg_3_addr <= reg_3_p;
			alu_ctrl <= alu_ctrl_p;
			sign_extend <= sign_extend_p;
		end if;
	end process;
end behaviour;
