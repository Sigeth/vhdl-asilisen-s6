library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity balleController is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           initialized : in STD_LOGIC;
           
           xRaquetteD : in STD_LOGIC_VECTOR(9 downto 0);
           yRaquetteD : in STD_LOGIC_VECTOR(9 downto 0);
           xRaquetteG : in STD_LOGIC_VECTOR(9 downto 0);
           yRaquetteG : in STD_LOGIC_VECTOR(9 downto 0);
           
           x : inout STD_LOGIC_VECTOR(9 downto 0);
           y : inout STD_LOGIC_VECTOR(9 downto 0);
           
           score1 : inout STD_LOGIC_VECTOR(3 downto 0);
           score2 : inout STD_LOGIC_VECTOR(3 downto 0);
           
           color : out STD_LOGIC_VECTOR(1 downto 0));
end balleController;

architecture Behavioral of balleController is

signal cnt : std_logic_vector(3 downto 0) := (others => '0');
signal cntSpeed : std_logic_vector(2 downto 0) := (others => '0');

begin
process(clk, reset)
variable speedX : integer := 1;
variable speedY : integer := 1;

constant size : integer := 5;
constant maxWidth : integer := 640;
constant maxHeight : integer := 480;

constant raquetteWidth : integer := maxWidth/64;
constant raquetteHeight : integer := maxHeight/16;

variable xRD : integer;
variable yRD : integer;
variable xRG : integer;
variable yRG : integer;

variable xB : integer;
variable yB : integer;

begin
    if (reset = '1') then
        x <= "0101000000"; -- maxWidth/2
        y <= "0011110000"; -- maxHeight/2
        
        color <= "00";
        
        score1 <= (others => '0');
        score2 <= (others => '0');
    end if;
    if (clk'event and clk = '1') then
        cnt <= cnt + 1;
        if (initialized = '1') then
            if (cntSpeed = "111") then
                if (speedX < 0) then
                    speedX := speedX - 1;
                else
                    speedX := speedX + 1;
                end if;
                
                cntSpeed <= (others => '0');
            end if;
            if (cnt(3) = '1') then
                xB := to_integer(unsigned(x));
                yB := to_integer(unsigned(y));
                
                xRD := to_integer(unsigned(xRaquetteD));
                yRD := to_integer(unsigned(yRaquetteD));
                xRG := to_integer(unsigned(xRaquetteG));
                yRG := to_integer(unsigned(yRaquetteG));
                
                if (yB + size >= maxHeight or yB - size <= 0) then
                    speedY := 0 - speedY;
                end if;
                
                if (xB + size) > xRD or (xB - size) < (xRG + raquetteWidth) then
                
                    if (xB + size) > xRD and (yB + size) >= (yRD - raquetteHeight) and (yB - size) <= (yRD + raquetteHeight) then
                        speedX := 0 - speedX;
                        color <= "01";
                        cntSpeed <= cntSpeed + 1;
                    elsif (xB - size) < (xRG + raquetteWidth) and (yB + size) >= (yRG - raquetteHeight) and (yB - size) <= (yRG + raquetteHeight) then
                        speedX := 0 - speedX;
                        color <= "10";
                        cntSpeed <= cntSpeed + 1;
                    end if;
                    
                    if ((xB + size) > xRD and (yB + size) >= (yRD - raquetteHeight) and (yB - size) <= (yRD - raquetteHeight/2)) or
                        ((xB - size) < (xRG + raquetteWidth) and (yB + size) >= (yRG - raquetteHeight) and (yB - size) <= (yRG - raquetteHeight/2)) then
                        if (speedY < 0) then
                            speedY := speedY + 1;
                        elsif (speedY > 0) then
                            speedY := speedY - 1;
                        else
                            speedY := -1;
                        end if;
                    elsif ((xB + size) > xRD and (yB + size) >= (yRD + raquetteHeight/2) and (yB - size) <= (yRD + raquetteHeight)) or
                            ((xB - size) < (xRG + raquetteWidth) and (yB + size) >= (yRG + raquetteHeight/2) and (yB - size) <= (yRG + raquetteHeight)) then
                        if (speedY > 0) then
                            speedY := speedY + 1;
                        elsif (speedY < 0) then
                            speedY := speedY - 1;
                        else
                            speedY := 1;
                        end if;
                    
                    elsif ((xB + size) > xRD and (yB + size) >= (yRD - raquetteHeight/2) and (yB - size) <= (yRD + raquetteHeight/2)) or
                            ((xB - size) < (xRG + raquetteWidth) and (yB + size) >= (yRG - raquetteHeight/2) and (yB - size) <= (yRG + raquetteHeight/2)) then
                            if (speedY = 0) then
                                speedY := 1;
                            end if;
                    end if;
                end if;
                
                
                
                if (xB + size >= maxWidth or xB - size <= 0) then
                    if (xB + size >= maxWidth) then
                        score1 <= score1 + 1;
                        speedX := 1;
                        if (score1 >= 9) then
                            score1 <= (others => '0');
                            score2 <= (others => '0');
                        end if;
                    elsif (xB - size <= 0) then
                        score2 <= score2 + 1;
                        speedX := -1;
                        if (score2 >= 9) then
                            score1 <= (others => '0');
                            score2 <= (others => '0');
                        end if;
                    end if;
                    x <= "0101000000"; -- maxWidth/2
                    y <= "0011110000"; -- maxHeight/2
                    speedY := 1;
                    color <= "00";
                    cntSpeed <= (others => '0');
                else
                    x <= x + speedX;
                    y <= y + speedY;
                end if;
            end if;
        else
            x <= "0101000000"; -- maxWidth/2
            y <= "0011110000"; -- maxHeight/2
            
            color <= "00";
        end if;
    end if;
end process;


end Behavioral;
