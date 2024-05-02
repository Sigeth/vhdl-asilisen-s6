library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity led_counter is
    port (CLK,RST, btnL, btnR : in std_logic;
            LED: out std_logic_vector(15 downto 0));
end led_counter;

architecture rtl of led_counter is
signal cnt : std_logic_vector(23 downto 0) := (others => '0');
signal ledOn : integer range 0 to 16 := 0;
signal ledActivated : std_logic := '0';
begin
process (CLK,RST,btnL,btnR)
begin    
    if (RST = '1') then
        cnt <= (others => '0');
		ledOn <= 0;
		ledActivated <= '0';
	elsif (CLK'event and CLK = '1') then
		cnt <= cnt + 1;
		if (btnL = '1' and ledOn < 16 and ledActivated = '0') then
            ledOn <= ledOn + 1;
            ledActivated <= '1';
        elsif (btnR = '1' and ledOn > 0 and ledActivated = '0') then
            ledOn <= ledOn - 1;
            ledActivated <= '1';
		end if;
		if (cnt = "10000000000000000000000" and ledActivated = '1') then
            ledActivated <= '0';
        end if;
	end if;
	
	for i in 15 downto 0 loop
	   if (i < ledOn) then
	       LED(i) <= '1';
	   else
	       LED(i) <= '0';
       end if;
	end loop;
end process;


end rtl;
