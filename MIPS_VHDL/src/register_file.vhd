library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
	port(
		clk : in std_logic;
		rst : in std_logic;
		rw	: in std_logic;
		r1_addr	: in std_logic_vector(7 downto 0);
		r2_addr	: in std_logic_vector(7 downto 0);
		r3_addr	: in std_logic_vector(7 downto 0);
		wr_data : in std_logic_vector(31 downto 0);
		reg_2 : out std_logic_vector(31 downto 0);
		reg_3 : out std_logic_vector(31 downto 0)
	);

end register_file;

architecture behav of register_file is

type reg_type is array (31 downto 0) of std_logic_vector(31 downto 0);
signal regsiters : reg_type;

begin

process(clk,rst,rw,wr_data, r1_addr, r2_addr, r3_addr)
begin
	if reset ='1' then
		for i in 0 to 31 loop
			registers(i) <= (others => '0');
		end loop;
	 elsif rising_edge(clk) then
		if rw ='1' then
			reisters(to_integer(unsigned(r3_addr))))<=wr_data;
		end if;
	end if;
end process;

reg_2 <= (others => '0') when r2_addr="00000" else reisters(to_integer(unsigned(r2_addr)));

reg_3 <= (others => '0') when r2_addr="00000" else reisters(to_integer(unsigned(r2_addr)));

end register_file;
