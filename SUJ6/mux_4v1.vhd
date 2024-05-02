library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_4v1 is
    Port ( tenminutes : in STD_LOGIC_VECTOR (3 downto 0);
           minutes : in STD_LOGIC_VECTOR (3 downto 0);
           tenseconds : in STD_LOGIC_VECTOR (3 downto 0);
           seconds : in STD_LOGIC_VECTOR (3 downto 0);
           activeNode : in STD_LOGIC_VECTOR (1 downto 0);
           muxOut : out STD_LOGIC_VECTOR (3 downto 0));
end mux_4v1;

architecture rtl of mux_4v1 is
begin

process(activeNode)
begin
    case activeNode is
    when "00" => muxOut <= tenminutes;
    when "01" => muxOut <= minutes;
    when "10" => muxOut <= tenseconds;
    when "11" => muxOut <= seconds;
    end case;
end process;

end rtl;
