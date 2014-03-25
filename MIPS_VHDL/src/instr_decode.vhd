-------------- Decoding instrunctions------------

-- 
-- DTU - 02211 Advanced computer architecture F14 
-- Harri Antero Laine(s131196)  Istvan Szonyi(s131153) Komlan Tom Evon(s072728)


library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;

entity instr_decode is
	port(
		clk : in std_logic;
		instr : in std_logic_vector(MIPS_SIZE-1 downto 0);
		reg_read_1 : out std_logic;
		reg_read_2 : out std_logic;
		reg_write : in std_logic;
		write_data : in std_logic;
		alu_op : out std_logic;
	)
end instr_decode;

architecture behavior of instr_decode is
begin
	process(instr)
	begin
		case instr(31 downto 26) is
			when "000000" => --register functions
			-- read register 1, 2 and 3
				case instr(5 downto 0) is
					when "100000" => --add
					when "100010" => --sub
					when "100100" => --mult
					when "100101" => --div
					when "101000" => --and
					when "101001" => --or
					when "110100" => --slt
					when "111000" => --srl
					when "111001" => --slr
					when others =>
				end case;
			--jump
			when "000001" => --jmp
			--immediate (these should be grouped)
			when "100001" => --addi
			when "000010" => --beq
			when "100000" => --lb
			when "110000" => --sb
			when others =>
		end case
	end process;
end behavior
		