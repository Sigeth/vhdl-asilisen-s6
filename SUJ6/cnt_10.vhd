library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cnt_10 is
    Port ( Q : in STD_LOGIC;
           rst : in STD_LOGIC;
           numberToDisplay : out STD_LOGIC_VECTOR(3 downto 0);
           pulseOut : out STD_LOGIC);
end cnt_10;

architecture rtl of cnt_10 is

signal cnt : std_logic_vector(3 downto 0) := (others => '0');

begin

process(Q, rst)
begin
    if (rst = '1') then
        cnt <= (others => '0');
    elsif (Q'event and Q = '1') then
        if (cnt = "1001") then
            cnt <= (others => '0');
            pulseOut <= '1';
        else
            cnt <= cnt + 1;
            pulseOut <= '0';
        end if;
    end if;
end process;

numberToDisplay <= cnt;

end rtl;
