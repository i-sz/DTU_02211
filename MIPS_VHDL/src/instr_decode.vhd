-------------- Decoding instrunctions------------

-- 
-- DTU - 02211 Advanced computer architecture F14 
-- Harri Antero Laine(s131196)  Istvan Szonyi(s131153) Komlan Tom Evon(s072728)


library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.all;

entity instr_decode is
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
	rd_from_mem : out std_logic
);
end instr_decode;

architecture behaviour of instr_decode is
	signal reg_1_p, reg_2_p, reg_3_p : std_logic_vector(ADDR_SIZE-1 downto 0);
	signal reg_2data,reg_3data : std_logic_vector(MIPS_SIZE-1 downto 0);
	signal alu_ctrl_p : std_logic_vector(2 downto 0);
	signal sign_extend_p : std_logic_vector(31 downto 0);
	signal alu_src_s, pc_sel_p : std_logic;
	
	signal wr_to_mem_s, rd_from_mem_s : std_logic;
	
component register_file is
	port(
		clk : in std_logic;
		rst : in std_logic;
		rw	: in std_logic;
		r1_addr	: in std_logic_vector(ADDR_SIZE-1 downto 0);
		r2_addr	: in std_logic_vector(ADDR_SIZE-1 downto 0);
		r3_addr	: in std_logic_vector(ADDR_SIZE-1 downto 0);
		wr_data : in std_logic_vector(MIPS_SIZE-1 downto 0);
		
		reg_1 : out std_logic_vector(MIPS_SIZE-1 downto 0);
		reg_2 : out std_logic_vector(MIPS_SIZE-1 downto 0)
	);
end component;	
	
begin

register_file_i : register_file 
port map(
		clk => clk,
		rst => rst,
		rw  => wr_flag,
		r1_addr	=> reg_2_p,
		r2_addr	=> reg_3_p,
		r3_addr	=> reg1_wb_addr,
		wr_data => reg1_wb_data,
		reg_1 => reg_2data, 
		reg_2 => reg_3data
	);
	
	
	process(clk, instr) --should put all needed in here -----------------------------------------------
	begin
	
	alu_ctrl_p <= (others => '0');
	reg_1_p <= (others => '0');
	reg_2_p <= (others => '0');
	reg_3_p <= (others => '0');
	sign_extend_p <= (others => '0');
	pc_sel_p <= '0';
	wr_to_mem_s <= '0';
	rd_from_mem_s <= '0';
	
	case instr(31 downto 26) is
		when "000000" => --register functions
			-- read register 2 and 3 and get register write address
			reg_1_p <= instr(25 downto 21); --from r1
			reg_2_p <= instr(20 downto 16); --from r2
			reg_3_p <= instr(15 downto 11); --from r3
			alu_src_s <= '0';
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
					alu_ctrl_p <= "111";
				when "111000" => --srl
					alu_ctrl_p <= "101";
				when "111001" => --slr
					alu_ctrl_p <= "101";
				when others =>
			end case;
		when "000001" => --jmp
			sign_extend_p(25 downto 0) <= instr(25 downto 0);
			alu_src_s <= '1';
			pc_sel_p <= '1';
			case instr(25) is
				when '1' =>
					sign_extend_p(31 downto 26) <= (others => '1');
				when others =>
					sign_extend_p(31 downto 26) <= (others => '0');
			end case;
		when others => --immediate and rest
			reg_1_p <= instr(25 downto 21); --from r1
			reg_2_p <= instr(20 downto 16); --from r2
			alu_src_s <= '1';
			sign_extend_p(15 downto 0) <= instr(15 downto 0); --from imm (we want to user 32-bit values)
			case instr(15) is
				when '1' =>
					sign_extend_p(31 downto 16) <= (others => '1');
				when others =>
					sign_extend_p(31 downto 16) <= (others => '0');
			end case;			
			case instr(31 downto 26) is
				when "100001" => --addi
					alu_ctrl_p <= "010";
				when "000010" => --beq
					pc_sel_p <= '1' ;
				when "100000" => --lb
					rd_from_mem_s <= '1';
					alu_ctrl_p <= "010";
				when "110000" => --sb
					wr_to_mem_s <= '1';
                 	reg_3_p <= instr(25 downto 21); --r3data from r1
					alu_ctrl_p <= "010";
				when others =>
			end case;
	end case;
	end process;
	
	process(clk,rst,reg_2data,reg_3data,reg_1_p,alu_ctrl_p,sign_extend_p,pc_addr_in)
	begin
		if rst='1' then
			reg_2_data <= (others => '0');
			reg_3_data <= (others => '0');
			alu_ctrl <= (others => '0');
			alu_src <= '0';
			sign_extend <= (others => '0');
			pc_sel_out <= '0';
			wr_to_mem <= '0';
			rd_from_mem <= '0';
		elsif rising_edge(clk) then 
			reg_2_data <= reg_2data;
			reg_3_data <= reg_3data;
			reg_1_addr <= reg_1_p;
			alu_ctrl <= alu_ctrl_p;
			sign_extend <= sign_extend_p;
			pc_addr_out <= pc_addr_in;
			alu_src <= alu_src_s;
			pc_sel_out <= pc_sel_p;
			wr_to_mem <= wr_to_mem_s;
			rd_from_mem <= rd_from_mem_s;
		end if;
	end process;
end behaviour;
