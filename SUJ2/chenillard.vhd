
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity chenillard is
port (CLK,RST : in std_logic;
		LED: out std_logic_vector(15 downto 0));
end chenillard;
architecture rtl of chenillard is
signal cnt : std_logic_vector(26 downto 0) := (others => '0');
signal ledOn : std_logic_vector(3 downto 0) := (others => '0');
begin
process (CLK,RST)
begin
	if (RST = '1') then
		cnt <= (others => '0');
	elsif (CLK'event and CLK = '1') then
		cnt <= cnt +1;
	end if;
	
	if cnt(26) = '1' then
        ledOn <= cnt(25 downto 22);
        if cnt(21) = '1' then
            LED(to_integer(unsigned(ledOn))) <= '1';
        end if;
    else
        LED <= (others => '0');
        ledOn <= (others => '0');
    end if;

end process;

end rtl;

