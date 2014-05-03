library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
GENERIC (MIPS_SIZE: NATURAL:= 32; ADDR_SIZE: NATURAL:= 5);
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

end register_file;

architecture behaviour of register_file is

type reg_type is array (31 downto 0) of std_logic_vector(31 downto 0);
signal registers : reg_type;

begin

process(clk,rst,rw,wr_data, r1_addr, r2_addr, r3_addr)
begin
	if rst ='1' then
		for i in 0 to 31 loop
			registers(i) <= (others => '0');
		end loop;
			    registers(0)  <= "00000000000000000000000000000000";
				registers(1)  <= "00000000000000000000000000000001";
				registers(2)  <= "00000000000000000000000000001010";
				registers(3)  <= "00000000000000000000000000010011";
				registers(4)  <= "00000000000000000000000000000100";
				registers(5)  <= "00000000000000000000000000000101";
				registers(6)  <= "00000000000000000000000000000110";
				registers(7)  <= "00000000000000000000000000000111";
				registers(8)  <= "00000000000000000000000000001000";
				registers(9)  <= "00000000000000000000000000001001";
				registers(10) <= "00000000000000000000000000001010";
				registers(11) <= "00000000000000000000000000001011";
				registers(12) <= "00000000000000000000000000001100";
				registers(13) <= "00000000000000000000000000001101";
				registers(14) <= "00000000000000000000000000001110";
				registers(15) <= "00000000000000000000000000001111";
				registers(16) <= "00000000000000000000000000010000";
				registers(17) <= "00000000000000000000000000010001";
				registers(18) <= "00000000000000000000000000010010";
				registers(19) <= "00000000000000000000000000010011";
				registers(20) <= "00000000000000000000000000010100";
				registers(21) <= "00000000000000000000000000010101";
				registers(22) <= "00000000000000000000000000010110";
				registers(23) <= "00000000000000000000000000010111";
				registers(24) <= "00000000000000000000000000011000";
				registers(25) <= "00000000000000000000000000011001";
				registers(26) <= "00000000000000000000000000011010";
				registers(27) <= "00000000000000000000000000011011";
				registers(28) <= "00000000000000000000000000011100";
				registers(29) <= "00000000000000000000000000011101";
				registers(30) <= "00000000000000000000000000011110";
				registers(31) <= "00000000000000000000000000011111";
	 elsif rising_edge(clk) then
		if rw ='1' then
			registers(to_integer(unsigned(r3_addr)))<=wr_data;
		end if;
	end if;
end process;

reg_1 <= (others => '0') when r1_addr="00000" else registers(to_integer(unsigned(r1_addr)));
reg_2 <= (others => '0') when r2_addr="00000" else registers(to_integer(unsigned(r2_addr)));

end behaviour;
