library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity image is
    port(clk : in STD_LOGIC;
           hcount : in STD_LOGIC_VECTOR (10 downto 0);
           vcount : in STD_LOGIC_VECTOR (10 downto 0);
           blank : in STD_LOGIC;
           red : out STD_LOGIC_VECTOR (3 downto 0);
           green : out STD_LOGIC_VECTOR (3 downto 0);
           blue : out STD_LOGIC_VECTOR (3 downto 0));
end image;

architecture rtl of image is

begin

process(clk)
begin
    if (clk'event and clk = '1') then
        if (blank = '1') then
            red <= (others => '0');
            green <= (others => '0');
            blue <= (others => '0');
        else
            -- display purple color
            red <= "1000";
            green <= "0000";
            blue <= "1000";
        end if;
    end if;
end process;


end rtl;
