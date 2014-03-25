------------------- instr fetch to decode registers  -------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity ifetch_idecode_regs is
    GENERIC (N:     NATURAL);  -- Width of inputs.
	PORT(clk     : IN  std_logic;
		  rst  : IN std_logic;
	      pc_addr_in	    : IN	std_logic_vector(N-1 downto 0);
	      instr_reg_in	    : IN	std_logic_vector(N-1 downto 0);	
	      pc_addr_out       : OUT	std_logic_vector(N-1 downto 0);
		  instr_reg_out     : OUT	std_logic_vector(N-1 DOWNTO 0)
	);
	END ifetch_idecode_regs;
ARCHITECTURE behaviour OF ifetch_idecode_regs IS
 Begin    
   process(clk,rst,pc_addr_in,instr_reg_in)     
    begin
    if (rst = '1') then
      pc_addr_out <= (others => '0');
	  instr_reg_out <= (others => '0');
    elsif clk'event and clk = '1' then
      pc_addr_out <= pc_addr_in;
	  instr_reg_out <= instr_reg_in;    
	end if;
  end process;
end behaviour;
