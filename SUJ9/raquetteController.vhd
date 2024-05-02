library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity raquetteController is
    port(clk : in STD_LOGIC;
        initialized : in STD_LOGIC;
        
        btnUp : in STD_LOGIC;
        btnDown : in STD_LOGIC;
        
        y : inout STD_LOGIC_VECTOR(9 downto 0)
    );
end raquetteController;

architecture Behavioral of raquetteController is

signal cnt : std_logic_vector(12 downto 0) := (others => '0');

begin

process(clk)
constant maxWidth : integer := 640;
constant maxHeight : integer := 480;

constant raquetteWidth : integer := maxWidth/64;
constant raquetteHeight : integer := maxHeight/16;
begin
    if (clk'event and clk = '1') then
        if (initialized = '1') then
            if (btnUp = '1' and y > raquetteHeight/2) then
                y <= y - 1;
            elsif (btnDown = '1' and y < maxHeight - raquetteHeight/2) then
                y <= y + 1;
            end if;
        else
            y <= "0011110000"; -- maxHeight/2
        end if;
    end if;
end process;
end Behavioral;
