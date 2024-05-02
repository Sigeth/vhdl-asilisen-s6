library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity raquette is
    Port ( 
           clk : in STD_LOGIC;
           width : in STD_LOGIC_VECTOR (10 downto 0);
           height : in STD_LOGIC_VECTOR (10 downto 0);
           
           btnUp : in STD_LOGIC;
           btnDown : in STD_LOGIC;
           
           r : out STD_LOGIC_VECTOR(3 downto 0);
           g : out STD_LOGIC_VECTOR(3 downto 0);
           b : out STD_LOGIC_VECTOR(3 downto 0));
end raquette;

architecture rtl of raquette is

begin

process(clk)
variable maxWidth : integer := 640;
variable maxHeight : integer := 480;
variable currentWidth : integer := 0;
variable currentHeight : integer := 0;

variable raquetteWidth : integer := maxWidth/64;
variable raquetteHeight : integer := maxHeight/16;

begin
    if (clk'event and clk = '1') then
        currentWidth := to_integer(unsigned(width));
        currentHeight := to_integer(unsigned(height));
        
        
    end if;
end process;


end rtl;
