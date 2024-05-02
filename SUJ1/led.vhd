library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity led is
port (CLK,RST : in std_logic;
		L: out std_logic);
end led;
architecture rtl of led is
signal cnt : std_logic_vector(23 downto 0);
begin
process (CLK,RST)
begin
	if (RST = '1') then
		cnt <= (others => '0');
	elsif (CLK'event and CLK = '1') then
		cnt <= cnt +1;
	end if;
end process;

L <= cnt(23);

end rtl;

