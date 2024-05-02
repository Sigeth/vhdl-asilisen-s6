library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity enc_2v4 is
    Port ( activeNode : in STD_LOGIC_VECTOR (1 downto 0);
           anCode : out STD_LOGIC_VECTOR (3 downto 0));
end enc_2v4;

architecture rtl of enc_2v4 is
begin
process(activeNode)
variable i : integer range 0 to 3 := to_integer(unsigned(activeNode));
begin
    i := to_integer(unsigned(activeNode));
    for j in 3 downto 0 loop
        if j = (3 - i) then
            anCode(j) <= '0';
        else
            anCode(j) <= '1';
        end if;
    end loop;
end process;

end rtl;
