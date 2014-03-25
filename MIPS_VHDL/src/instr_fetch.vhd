-------------- Fetcing of instrunctions------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY  instr_fecth is
port(
	clk	: in std_logic;
	rst : in std_logic;
	pc_sel : in std_logic;
	pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	instr : out std_logic_vector(MIPS_SIZE-1 downto 0) 
);
END ifetch;

ARCHITECTURE behaviour OF ifetch IS

	component adder                                
		GENERIC (N:     NATURAL := 8); -- Width of inputs.
		PORT (
			adderin1:  IN  std_logic_vector(N DOWNTO 1);   -- Input.
			adderin2:  IN  std_logic_vector(N DOWNTO 1);   -- Input.
			Cin:       IN  STD_LOGIC;
	        Cout:      OUT STD_LOGIC;
			adderout:  OUT std_logic_vector(10 DOWNTO 1));-- Output.
	END component;

    component Instr_Memory                                
        port (rst : in std_logic;
		    rd      : in std_logic;
            address : in std_logic_vector(4 downto 0);			
			data    : inout std_logic_vector(7 downto 0)  );
	END component;




	SIGNAL tmp_1, tmp_2, tmp_3: std_logic_vector(10 DOWNTO 1) := "0000000000";
BEGIN

    adderout <= std_logic_vector((unsigned(adderin1) + unsigned(adderin2)));
END behaviour;
