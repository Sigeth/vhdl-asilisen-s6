library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_1s is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC);
end div_1s;

architecture rtl of div_1s is

signal cnt : std_logic_vector(27 downto 0) := (others => '0');

begin
process(clk, rst)
begin
    if (rst = '1') then
        cnt <= (others => '0');
    elsif (clk'event and clk = '1') then
        if (cnt = x"5F5E0FF") then
            cnt <= (others => '0');
        else
            cnt <= cnt + 1;
        end if;
    end if;
end process;

pulse <= '1' when cnt = x"5F5E0FF" else '0';

end rtl;
