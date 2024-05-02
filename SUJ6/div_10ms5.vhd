library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_10ms5 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clkOut : out STD_LOGIC);
end div_10ms5;

architecture rtl of div_10ms5 is

signal cnt : std_logic_vector(18 downto 0) := (others => '0');

begin
process(clk, rst)
begin
    if (rst = '1') then
        cnt <= (others => '0');
    elsif (clk'event and CLK = '1') then
        cnt <= cnt + 1;
    end if;
end process;

clkOut <= cnt(18);

end rtl;
