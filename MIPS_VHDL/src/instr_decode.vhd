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
		jmp_dst : out std_logic_vector(25 downto 0);
		pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
		pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
		-- alu_ctrl = 010 -> ADD, 110 -> SUB, 000 -> AND, 001 -> OR, 111 -> SLT, 100 -> MULT, 011 -> DIV
		alu_ctrl : out std_logic_vector(2 downto 0);
	)
end instr_decode;

architecture behavior of instr_decode is
	type register_array is array (0 to 31) of std_logic_vector(31 downto 0);
	signal register_data : register_array;
begin
	process(instr)
	begin
		case instr(31 downto 26) is
			when "000000" => --register functions
				write_reg_addr <= instr(25 downto 21);
				reg_read_2 <= register_data(CONV_INTEGER(instr(20 downto 16)));
				reg_read_3 <= register_data(CONV_INTEGER(instr(15 downto 11)));
			-- read register 1, 2 and 3
				case instr(5 downto 0) is
					when "100000" => --add
						alu_ctrl <= "010"
					when "100010" => --sub
						alu_ctrl <= "110"
					when "100100" => --mult
						alu_ctrl <= "100"
					when "100101" => --div
						alu_ctrl <= "011"
					when "101000" => --and
						alu_ctrl <= "001"
					when "101001" => --or
						alu_ctrl <= "111"
					when "110100" => --slt
						alu_ctrl <= "100"
					when "111000" => --srl
					when "111001" => --slr
					when others =>
				end case;
			when "000001" => --jmp
				jmp_dst <= instr(25 downto 0);
			when others => --immediate and rest
				case instr(31 downto 26) is
					write_reg_addr <= instr(25 downto 21);
					reg_read_2 <= register_data(CONV_INTEGER(instr(20 downto 16)));
					reg_read_3 <= register_data(CONV_INTEGER(instr(15 downto 0))); --from imm
					when "100001" => --addi
						alu_ctrl <= "010"
					when "000010" => --beq
					when "100000" => --lb
					when "110000" => --sb
					when others =>
				end case;
		end case
	end process;
end behavior
		