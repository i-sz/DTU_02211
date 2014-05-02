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
	reset : in std_logic
    uart_wr_ena : out std_logic;
    uart_rd_ena : out  std_logic;
    uart_addr   : out  std_logic_vector(1 downto 0);  --uart address
    uart_wr_data: out std_logic_vector(31 downto 0);
    uart_rd_data: in std_logic_vector(31 downto 0);
    uart_rdy_cnt : in std_logic_vector(1 downto 0)
);
end component;

component sc_uart
generic (addr_bits : integer := 2;
			 clk_freq : integer := 50_000_000;
			 baud_rate : integer := 115200;
			 txf_depth : integer := 8; 
			 txf_thres : integer := 8;
			 rxf_depth : integer := 8; 
			 rxf_thres : integer :=8);
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

signal uart_address_s, rdy_cnt_s : std_logic_vector(1 downto 0);
signal wr_data, rd_data : std_logic_vector(31 downto 0);
signal wr, rd : std_logic;


begin

  uart_inst : sc_uart port map       -- Maps internal signals to ports
    (
      address => uart_address_s,
      wr_data => wr_data,
      rd      => rd,
      wr      => wr,
      rd_data => rd_data,
      rdy_cnt => rdy_cnt_s,
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
      uart_wr_ena => wr, 
      uart_rd_ena => rd,
      uart_addr  => uart_address_s, 
      uart_wr_data => wr_data,     
      uart_rd_data => rd_data,
      uart_rdy_cnt => rdy_cnt_s
        

end arch;
