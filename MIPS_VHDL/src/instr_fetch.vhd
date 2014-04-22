-------------- Fetcing of instrunctions------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY  instr_fecth is
GENERIC (MIPS_SIZE: NATURAL; PC_incr: NATURAL );
port(
	clk	: in std_logic;
	rst : in std_logic;
	pc_sel : in std_logic;
	pc_addr_in : in std_logic_vector(MIPS_SIZE-1 downto 0);
	pc_addr_out : out std_logic_vector(MIPS_SIZE-1 downto 0);
	instr : out std_logic_vector(MIPS_SIZE-1 downto 0) 
);
END instr_fecth;

ARCHITECTURE behaviour OF instr_fecth IS

	component adder                                
		GENERIC (N:     NATURAL := MIPS_SIZE); -- Width of inputs.
		PORT (
			adderin1:  IN  std_logic_vector(N-1 DOWNTO 0);   -- Input.
			adderin2:  IN  std_logic_vector(N-1 DOWNTO 0);   -- Input.
			Cin:       IN  STD_LOGIC;
	        Cout:      OUT STD_LOGIC;
			adderout:  OUT std_logic_vector(N-1 DOWNTO 0));-- Output.
	END component;

    component Instr_Memory
	    GENERIC (N:     NATURAL := MIPS_SIZE); -- Width of inputs.
        port ( address : in std_logic_vector(N-1 downto 0);			
			data    : out std_logic_vector(N-1 downto 0));
	END component;

	component reg
		GENERIC (N:     NATURAL := MIPS_SIZE);                     -- Width of inputs.
		PORT(
			 Ain     : IN  std_logic_vector(N-1 DOWNTO 0);
			 clk     : IN  std_logic;
			 rst   : IN  std_logic;
			 reg_out : OUT	std_logic_vector(N-1 DOWNTO 0));
	END component;
	
	component mux2  -- two-input multiplexer
		generic(N: NATURAL:= MIPS_SIZE);
		port(in0, in1: in  STD_LOGIC_VECTOR(N-1 downto 0);
			 sel:      in  STD_LOGIC;
			 y:        out STD_LOGIC_VECTOR(N-1 downto 0));
	end component;
	
	component ifetch_idecode_regs
		GENERIC (N:     NATURAL);  -- Width of inputs.
		PORT(clk     : IN  std_logic;
		  rst  : IN std_logic;
		  pc_addr_in	    : IN	std_logic_vector(N-1 downto 0);
		  instr_reg_in	    : IN	std_logic_vector(N-1 downto 0);	
		  pcaddr_out       : OUT	std_logic_vector(N-1 downto 0);
		  instr_reg_out     : OUT	std_logic_vector(N-1 DOWNTO 0));
    END component;
	
	SIGNAL PC_tmp1, PC_tmp3,Instr_tmp : std_logic_vector(MIPS_SIZE-1 DOWNTO 0);
	SIGNAL PC_tmp2 : std_logic_vector(MIPS_SIZE DOWNTO 0);

BEGIN

     PC: reg
		GENERIC Map (N => MIPS_SIZE) -- Width of inputs.
		PORT Map (Ain  => PC_tmp1,
			clk   => clk,
			rst   => rst,
			reg_out  => PC_tmp3 
		);

     PCadder: adder
		GENERIC Map (N => MIPS_SIZE)
		PORT Map (adderin1 => PC_tmp3,
			adderin2 => std_logic_vector(to_unsigned(PC_incr,MIPS_SIZE)),
			Cin => '0',
	        Cout => PC_tmp2(MIPS_SIZE),
			adderout =>PC_tmp2(MIPS_SIZE-1 downto 0) 
	    );

     Instr_Memory1 :Instr_Memory
        GENERIC Map(N => MIPS_SIZE)	 
        port Map ( address => PC_tmp3,
			data => Instr_tmp 
		);
		
     PC_Mux: mux2  -- two-input multiplexer
		generic Map(N => MIPS_SIZE)
		port map (in0 => PC_tmp2(MIPS_SIZE-1 downto 0), 
		     in1 => pc_addr_in,
			 sel => pc_sel,
			 y  => PC_tmp1
		);
		
	 fetch_decode_regs: ifetch_idecode_regs
		GENERIC Map (N => MIPS_SIZE)  -- Width of inputs.
		PORT Map (clk  => clk,
			  rst   => rst,
			  pc_addr_in => PC_tmp2(MIPS_SIZE-1 downto 0),
			  instr_reg_in => Instr_tmp,
			  pcaddr_out => pc_addr_out,
			  instr_reg_out   => instr  
		);

END behaviour;

------------------- instr fetch to decode registers  -------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity ifetch_idecode_regs is
    GENERIC (N:     NATURAL);  -- Width of inputs.
	PORT(clk     : IN  std_logic;
		  rst  : IN std_logic;
	      pc_addr_in	    : IN	std_logic_vector(N-1 downto 0);
	      instr_reg_in	    : IN	std_logic_vector(N-1 downto 0);	
	      pcaddr_out       : OUT	std_logic_vector(N-1 downto 0);
		  instr_reg_out     : OUT	std_logic_vector(N-1 DOWNTO 0)
	);
	END ifetch_idecode_regs;
ARCHITECTURE behaviour OF ifetch_idecode_regs IS
 Begin    
   process(clk,rst,pc_addr_in,instr_reg_in)     
    begin
    if (rst = '1') then
      pcaddr_out <= (others => '0');
	  instr_reg_out <= (others => '0');
    elsif clk'event and clk = '1' then
      pcaddr_out <= pc_addr_in;
	  instr_reg_out <= instr_reg_in;    
	end if;
  end process;
end behaviour;
