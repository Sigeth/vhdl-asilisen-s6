library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity enc_4v7 is
    Port ( numberIn : in STD_LOGIC_VECTOR (3 downto 0);
           segments : out STD_LOGIC_VECTOR (6 downto 0));
end enc_4v7;

architecture rtl of enc_4v7 is
begin

process(numberIn)
begin
    case numberIn is
    when "0000" => segments <= "1000000"; -- "0"     
    when "0001" => segments <= "1111001"; -- "1" 
    when "0010" => segments <= "0100100"; -- "2" 
    when "0011" => segments <= "0110000"; -- "3" 
    when "0100" => segments <= "0011001"; -- "4" 
    when "0101" => segments <= "0010010"; -- "5" 
    when "0110" => segments <= "0000010"; -- "6"
    when "0111" => segments <= "1111000"; -- "7"
    when "1000" => segments <= "0000000"; -- "8"     
    when "1001" => segments <= "0010000"; -- "9" 
    when others => segments <= "0001110"; -- F for default
    end case;
end process;


end rtl;
