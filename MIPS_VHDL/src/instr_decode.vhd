-------------- Decoding instrunctions------------

-- 
-- DTU - 02211 Advanced computer architecture F14 
-- Harri Antero Laine(s131196)  Istvan Szonyi(s131153) Komlan Tom Evon(s072728)


library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity instr_decode is
	port(
		clk : in std_logic;
		instr : in std_logic_vector(MIPS_SIZE-1 downto 0);
		reg_read_2 : out std_logic_vector(MIPS_SIZE-1 downto 0);
		reg_read_3 : out std_logic_vector(MIPS_SIZE-1 downto 0);
		write_reg_addr : out std_logic_vector(4 downto 0);
		jmp_addr : out std_logic_vector(25 downto 0);
		pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
		pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
		sign_extend = out std_logic_vector(7 downto 0);
		-- alu_ctrl = 010 -> ADD, 110 -> SUB, 000 -> AND, 001 -> OR, 111 -> SLT, 100 -> MULT, 011 -> DIV
		alu_ctrl : out std_logic_vector(2 downto 0);
	)
end instr_decode;

architecture behavior of instr_decode is
	signal reg_2_p, reg_3_p : std_logic_vector(MIPS_SIZE-1 downto 0);
	signal write_reg_addr_p : std_logic_vector(4 downto 0);
	signal jmp_addr_p : std_logic_vector(25 downto 0);
	signal alu_ctrl_p : std_logic_vector(2 downto 0);
	signal sign_extend_p : std_logic_vector(7 downto 0);
	
begin
	case instr(31 downto 26) is
		when "000000" => --register functions
			-- read register 2 and 3 and get register write address
			write_reg_addr <= instr(25 downto 21);
			reg_2_p <= register_data(instr(20 downto 16)); --from r2
			reg_3_p <= register_data(instr(15 downto 11)); --from r3
			case instr(5 downto 0) is
				when "100000" => --add
					alu_ctrl_p <= "010"
				when "100010" => --sub
					alu_ctrl_p <= "110"
				when "100100" => --mult
					alu_ctrl_p <= "100"
				when "100101" => --div
					alu_ctrl_p <= "011"
				when "101000" => --and
					alu_ctrl_p <= "001"
				when "101001" => --or
					alu_ctrl_p <= "111"
				when "110100" => --slt
					alu_ctrl_p <= "100"
				when "111000" => --srl
				when "111001" => --slr
				when others =>
			end case;
		when "000001" => --jmp
			jmp_addr <= instr(25 downto 0);
			case jmp_addr(25) is
				when "1" =>
					sign_extend_p <= "1" & instr(6 downto 0);
				when others =>
					sign_extend_p <= "0" & instr(6 downto 0);
			end case;
		when others => --immediate and rest
			case instr(31 downto 26) is
				write_reg_addr_p <= instr(25 downto 21);
				reg_2_p <= register_data(instr(20 downto 16)); --from r2
				reg_3_p <= register_data(instr(15 downto 0)); --from imm
				when "100001" => --addi
					alu_ctrl_p <= "010"
				when "000010" => --beq
					case instr(15) is
						when "1" =>
							sign_extend_p <= "1" & instr(6 downto 0);
						when others =>
							sign_extend_p <= "0" & instr(6 downto 0);
					end case;
				when "100000" => --lb
				when "110000" => --sb
				when others =>
			end case;
	end case
	process(clk,rst)
	begin
	if rst='1' then
		reg_read_2 <= (others => '0');
		reg_read_3 <= (others => '0');
		alu_ctrl <= (others => '0');
		sign_extend <= (others => '0');
	elsif rising_edge(clk) then 
		reg_read_2 <= reg_2_p;
		reg_read_3 <= reg_3_p;
		alu_ctrl <= alu_ctrl_p;
		sign_extend <= sign_extend_p;
	end if;
	end process;
end behavior
		