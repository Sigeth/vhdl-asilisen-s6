library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity display_different_digits is
port (CLK,RST : in std_logic;
		seg: out std_logic_vector(6 downto 0);
		an: out std_logic_vector(3 downto 0));
end display_different_digits;

architecture rtl of display_different_digits is

signal refreshDisplay : std_logic_vector(19 downto 0) := (others => '0');
signal activatedNode : std_logic_vector(1 downto 0) := (others => '0');
signal numbers : std_logic_vector(15 downto 0) := "0101010010010011";
signal numberToDisplay : std_logic_vector(3 downto 0);
signal numberUpdated : std_logic := '0';

begin

convertIntToSeg : process(numberToDisplay)
begin
    case numberToDisplay is
    when "0000" => seg <= "1000000"; -- "0"     
    when "0001" => seg <= "1111001"; -- "1" 
    when "0010" => seg <= "0100100"; -- "2" 
    when "0011" => seg <= "0110000"; -- "3" 
    when "0100" => seg <= "0011001"; -- "4" 
    when "0101" => seg <= "0010010"; -- "5" 
    when "0110" => seg <= "0000010"; -- "6"
    when "0111" => seg <= "1111000"; -- "7"
    when "1000" => seg <= "0000000"; -- "8"     
    when "1001" => seg <= "0010000"; -- "9" 
    when "1010" => seg <= "0001000"; -- A
    when "1011" => seg <= "0000011"; -- b
    when "1100" => seg <= "1000110"; -- C
    when "1101" => seg <= "0100001"; -- d
    when "1110" => seg <= "0000110"; -- E
    when "1111" => seg <= "0001110"; -- F
    when others => seg <= "0000000"; -- default
    end case;
end process;

clock10ms5 : process(CLK, RST)
begin
    if (RST = '1') then
        refreshDisplay <= (others => '0');
    elsif (CLK'event and CLK = '1') then
        refreshDisplay <= refreshDisplay + 1;
    end if;
end process;

activatedNode <= refreshDisplay(19 downto 18);

changeNode : process(activatedNode)
variable i : integer range 0 to 3 := to_integer(unsigned(activatedNode));
begin
    i := to_integer(unsigned(activatedNode));
    for j in 3 downto 0 loop
        if j = (3 - i) then
            an(j) <= '0';
        else
            an(j) <= '1';
        end if;
    end loop;
    
    case i is
        when 0 => numberToDisplay <= numbers(3 downto 0);
        when 1 => numberToDisplay <= numbers(7 downto 4);
        when 2 => numberToDisplay <= numbers(11 downto 8);
        when 3 => numberToDisplay <= numbers(15 downto 12);
    end case;

end process;
end rtl;
