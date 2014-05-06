library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;

entity uart_adapter is
GENERIC (MIPS_SIZE: NATURAL:= 32; ADDR_SIZE: NATURAL:= 5);
port(

--global signals

    clk : in std_logic;
    rst : in std_logic;

-- processor interface
    mem_rd_ena       : in std_logic;
	mem_wr_ena       : in std_logic;   -- write enable to memory at execute stage
    mem_data_in      : in std_logic_vector(31 downto 0); -- write_data to memeory from execute stage 
    to_proc_data_in  : out  std_logic_vector(31 downto 0);  --uart data to processor   
    to_proc_rd_ena   : out std_logic;   --rd_ena to the processor to know when the readout happened
    mem_address      : in std_logic_vector(4 downto 0);  -- memory address from the execute stage

-- SIMCON interface to UART
    uart_wr_ena    : out  std_logic;
    uart_rd_ena    : out  std_logic;
    uart_addr      : out  std_logic_vector(1 downto 0);
    uart_wr_data   : out std_logic_vector(31 downto 0);
    uart_rd_data   : in std_logic_vector(31 downto 0);
	uart_rdy_cnt : in std_logic_vector(1 downto 0)
);
end uart_adapter;

architecture behav of uart_adapter is

	COMPONENT Data_Memory 
	GENERIC
	(
		MIPS_SIZE    	: NATURAL;
		RAM_SIZE	    : NATURAL
	);
	PORT
	(   clk			    : IN  std_logic; 
		rst			    : IN  std_logic;                                    --- rst
		ramdata_in		: IN  std_logic_vector(MIPS_SIZE - 1 DOWNTO 0);     --- data input to RAM 
		addr	        : IN  std_logic_vector(MIPS_SIZE - 1 DOWNTO 0);     --- address input
		ram_write		: IN  std_logic;                                    --- Write enable input
		ram_read		: IN  std_logic;                                    --- Read enable input
		ramdata_out		: OUT std_logic_vector(MIPS_SIZE - 1 DOWNTO 0)      --- data output of RAM
	);
    END COMPONENT;

-- write counter
signal cnt : unsigned(4 downto 0) := (others => '0');

--read_counter
signal cnt_rd : unsigned(4 downto 0) := (others => '0');
signal cnt_rd_ena, cnt_rd_ena_f : std_LOGIC;

signal state, next_state : std_logic_vector(2 downto 0) := (others => '0');

constant st_start  : std_logic_vector(2 downto 0) := "000";
constant st_buffer  : std_logic_vector(2 downto 0) := "001";
constant st_read  : std_logic_vector(2 downto 0) := "010";
constant st_wait  : std_logic_vector(2 downto 0) := "011";
constant st_write : std_logic_vector(2 downto 0) := "100";
constant st_wait_more : std_logic_vector(2 downto 0) := "101";
--ram signals

signal address_s : STD_LOGIC_VECTOR (31 DOWNTO 0);
signal data_s, q_s : STD_LOGIC_VECTOR (31 DOWNTO 0);
signal wren_s, rden_s : std_LOGIC;


begin

uart_buffer: Data_Memory 
	GENERIC map	(MIPS_SIZE, ADDR_SIZE)
	PORT map (clk  => clk,
	   rst => rst,
		ramdata_in => data_s,
		addr => address_s,
		ram_write => wren_s,
		ram_read => rden_s,
		ramdata_out => q_s
	);

cnt_rd_ena <= '1' when (cnt_rd_ena_f ='1') else '0';


--write counter
process(clk, rst, mem_wr_ena)
begin
	if rst = '1' then
		cnt <= "00000";
	elsif(rising_edge(clk)) then
		if (mem_wr_ena = '1') then
		cnt <= cnt + 1;
	end if;
end if;	
end process;	

--read counter
process(clk, rst)
begin
	if rst = '1' then
		cnt_rd <= "00000";
	elsif(rising_edge(clk)) then
		if (cnt_rd_ena = '1') then
		cnt_rd <= cnt_rd + 1;
	end if;
end if;	
end process;	




  
process(clk, rst, mem_wr_ena, mem_data_in, mem_address, cnt, cnt_rd, mem_rd_ena, state, uart_rd_data, q_s)  
begin

next_state <= state;

--deffault output values
uart_wr_data <= (others => '0');
uart_wr_ena <= '0';
uart_addr <= "00";
uart_rd_ena <= '0';	
address_s <= (others => '0');
data_s <= (others => '0');
wren_s <= '0';
rden_s <= '0';
cnt_rd_ena_f <='0';

		case (state) is
        when st_start =>  
			if (mem_address(0) = '0' and mem_wr_ena ='1') then
				next_state   <= st_buffer;
			end if;
		
		when st_buffer =>
			data_s <= mem_data_in;
			address_s <= "000000000000000000000000000" & std_logic_vector(cnt);
			wren_s <= mem_wr_ena;
		
		if (cnt = "01100") then
			next_state <= st_read;
		end if;	

	   when st_read =>
			   
				uart_wr_ena  <= '0';
				uart_rd_ena  <= '1';
				uart_addr    <= "00";
				uart_wr_data <=  (others => '0');
				
				
				next_state <= st_wait;
		
		when st_wait =>
		
			
					next_state <= st_write;
			
	
		when st_write =>
		if uart_rd_data(0) = '1' then
				cnt_rd_ena_f <='1'; 
				uart_wr_ena      <= '1';
				uart_rd_ena 	  <= '0';
				uart_addr <= "01";  -- tell the uart that we want to write data
				uart_wr_data <= q_s;  -- write 0+cnt
				address_s <= "000000000000000000000000000" & std_logic_vector(cnt_rd);
				rden_s <= '1';
			end if;	
			next_state <= st_wait_more;
				
		when st_wait_more =>		
		if cnt_rd < "01111" then
			next_state <= st_read;
		end if;
		 when others => null;
	
	end case;			

end process;

--seq
process(clk, rst)
begin
    if rst = '1' then
			state <= st_start;
	elsif rising_edge(clk) then
		state <= next_state;
    end if;
  end process;

end behav;
