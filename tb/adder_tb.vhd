library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_adder_tb is
end entity my_adder_tb;

architecture tst of my_adder_tb is

  -- component ports
  signal dta, dtb : std_logic_vector(7 downto 0);
  signal dto      : std_logic_vector(7 downto 0);

  -- clock
  signal clk : std_logic := '1';
  signal rstn : std_logic;

begin  -- architecture tst

  -- component instantiation
  DUT: entity work.my_adder
    port map (
      clk => clk,
      rstn => rstn,
      dta => dta,
      dtb => dtb,
      dto => dto);

  -- clock generation
  clk <= not clk after 1 ns;
  rstn <= '0', '1' after 500 ps;

  -- waveform generation
  WaveGen_Proc: process
  begin
    dta <= std_logic_vector(to_signed(3,  dta'length));
    dtb <= std_logic_vector(to_signed(-1, dtb'length));    
    wait until clk = '0';
    wait until clk = '0';
    dta <= std_logic_vector(to_signed(6,  dta'length));
    dtb <= std_logic_vector(to_signed(1, dtb'length));    
    wait until clk = '0';
    dta <= std_logic_vector(to_signed(-4,  dta'length));
    dtb <= std_logic_vector(to_signed(-3, dtb'length));    
    wait until clk = '0';
    dta <= std_logic_vector(to_signed(2**7-1,  dta'length));
    dtb <= std_logic_vector(to_signed(1,  dtb'length));    
    wait until clk = '0';
    wait until clk = '0';

    report "End simulation" severity failure;  -- Finish
  end process WaveGen_Proc;

end architecture tst;
