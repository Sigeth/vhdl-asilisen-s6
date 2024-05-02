library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cnt_4 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           activeNode : out STD_LOGIC_VECTOR (1 downto 0));
end cnt_4;

architecture rtl of cnt_4 is

signal cnt : std_logic_vector(1 downto 0) := (others => '0');

begin

process(clk, rst)
begin
    if (rst = '1') then
        cnt <= (others => '0');
    elsif (clk'event and clk = '1') then
        cnt <= cnt + 1;
    end if;
end process;

activeNode <= cnt;

end rtl;
