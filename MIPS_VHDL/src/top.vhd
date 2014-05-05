library IEEE;
use IEEE.STD_LOGIC_1164.all;		
use IEEE.numeric_std.all;

entity top is
GENERIC (MIPS_SIZE: NATURAL:= 32; ADDR_SIZE: NATURAL:= 5);

port(
    clk : in std_logic;
    rst : in std_logic;
    uart_tx : out std_logic;
    uart_rx : in std_logic;
    led : out std_logic  --testing purpose
);

end top;

architecture arch of top is

component top_mips
GENERIC (MIPS_SIZE: NATURAL:= 32; ADDR_SIZE: NATURAL:= 5);
port(
	clock : in std_logic;
	reset : in std_logic;
	wr_ena : out std_logic;
	rd_ena : out std_logic;
   uart_rd_ena : in  std_logic;
   addr_adapter   : out  std_logic_vector(4 downto 0);
   data_out    : out std_logic_vector(31 downto 0);
   data_in     : in std_logic_vector(31 downto 0)
);
end component;

component sc_uart
generic (addr_bits : integer := 2;
			 clk_freq : integer := 10_000_000;
			 baud_rate : integer := 115200;
			 txf_depth : integer := 4; 
			 txf_thres : integer := 2;
			 rxf_depth : integer := 4; 
			 rxf_thres : integer := 2);
	port (
		clk		: in std_logic;
		reset	: in std_logic;

-- SimpCon interface

		address		: in std_logic_vector(addr_bits-1 downto 0);
		wr_data		: in std_logic_vector(31 downto 0);
		rd, wr		: in std_logic;
		rd_data		: out std_logic_vector(31 downto 0);
		rdy_cnt		: out unsigned(1 downto 0);

		txd		: out std_logic;
		rxd		: in std_logic;
		ncts	: in std_logic;
		nrts	: out std_logic
		);
end component;

component uart_adapter 
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

-- SIMPCon interface to UART
    uart_wr_ena    : out  std_logic;
    uart_rd_ena    : out  std_logic;
    uart_addr      : out  std_logic_vector(1 downto 0);
    uart_wr_data   : out std_logic_vector(31 downto 0);
    uart_rd_data   : in std_logic_vector(31 downto 0);
	 uart_rdy_cnt : in std_logic_vector(1 downto 0)
);
end component;




--signals from mips to uart adapter
signal wr_ena_s, to_proc_rd_ena_s,rd_ena_s : std_logic;
signal mem_data_out_s, mem_data_in_s : std_logic_vector(31 downto 0);
signal mem_address_s :  std_logic_vector(4 downto 0);

--signals from uart adpater to uart
signal wr_s, rd_s : std_logic;
signal wr_data_s, rd_data_s : std_logic_vector(31 downto 0);
signal uart_address_s, rdy_cnt_s : std_logic_vector(1 downto 0);

signal rdy_cnt_s_u : unsigned(1 downto 0);

begin

rdy_cnt_s <= std_logic_vector(rdy_cnt_s_u);




  uart_inst : sc_uart port map       -- Maps internal signals to ports
    (
      address => uart_address_s,
      wr_data => wr_data_s,
      rd      => rd_s,
      wr      => wr_s,
      rd_data => rd_data_s,
      rdy_cnt => rdy_cnt_s_u,
      clk     => clk,
      reset   => rst,
      txd     => uart_tx,
      rxd     => uart_rx,
      ncts    => '0',
      nrts    => open
      );

  mips_inst : top_mips port map
    (
      clock => clk,
	   reset => rst,
        wr_ena => wr_ena_s, 
		rd_ena => rd_ena_s,
		uart_rd_ena => to_proc_rd_ena_s,
		addr_adapter => mem_address_s,  
		data_out  => mem_data_out_s,  
		data_in   => mem_data_in_s
	
);

 uart_adapter_i : uart_adapter port map
	(
	

--global signals

    clk => clk,
    rst => rst,

-- processor interface
    mem_rd_ena => rd_ena_s, 
    mem_wr_ena  => wr_ena_s,     
    mem_data_in =>  mem_data_out_s,     
    to_proc_data_in  =>  mem_data_in_s,
    to_proc_rd_ena   =>	to_proc_rd_ena_s, 
    mem_address      => mem_address_s,

-- SIMPCon interface to UART
    uart_wr_ena    => wr_s,
    uart_rd_ena    => rd_s,
    uart_addr      => uart_address_s,
    uart_wr_data   => wr_data_s,
    uart_rd_data   => rd_data_s,
	 uart_rdy_cnt   => rdy_cnt_s
);
 
      
        

end arch;
