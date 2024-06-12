library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity image is
    port(clkScreen : in STD_LOGIC;
         clkGame : in STD_LOGIC;
         rst : in STD_LOGIC;
           upP1 : in STD_LOGIC;
           downP1 : in STD_LOGIC;
           upP2 : in STD_LOGIC;
           downP2 : in STD_LOGIC;
           hcount : in STD_LOGIC_VECTOR (10 downto 0);
           vcount : in STD_LOGIC_VECTOR (10 downto 0);
           blank : in STD_LOGIC;
           red : out STD_LOGIC_VECTOR (3 downto 0);
           green : out STD_LOGIC_VECTOR (3 downto 0);
           blue : out STD_LOGIC_VECTOR (3 downto 0));
end image;

architecture rtl of image is

component raquetteController is
    port(clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        initialized : in STD_LOGIC;
        
        btnUp : in STD_LOGIC;
        btnDown : in STD_LOGIC;
        
        y : inout STD_LOGIC_VECTOR(9 downto 0)
    );
end component;

component balleController is
    port(clk : in STD_LOGIC;
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
end component;

signal yRaquetteDroite : std_logic_vector(9 downto 0) := "0011110000"; -- maxHeight/2
signal yRaquetteGauche : std_logic_vector(9 downto 0) := "0011110000"; -- maxHeight/2

signal xBalle : std_logic_vector(9 downto 0) := "0101000000"; -- maxWidth/2
signal yBalle : std_logic_vector(9 downto 0) := "0011110000"; -- maxHeight/2
signal colorBalle : std_logic_vector(1 downto 0);

signal scoreP1 : std_logic_vector(3 downto 0) := "0000";
signal scoreP2 : std_logic_vector(3 downto 0) := "0000";

signal cntToInit : std_logic_vector(12 downto 0) := (others => '0');
signal gameInitialized : std_logic := '0';

begin

process(clkScreen)
constant maxWidth : integer := 640;
constant maxHeight : integer := 480;
variable currentWidth : integer := 0;
variable currentHeight : integer := 0;

constant raquetteWidth : integer := maxWidth/64;
constant raquetteHeight : integer := maxHeight/16;

constant xRD : integer := maxWidth - raquetteWidth - maxWidth/128;
variable yRD : integer;
constant xRG : integer := maxWidth/128;
variable yRG : integer;

constant balleSize : integer := 5;
variable xB : integer;
variable yB : integer;

begin
    if (clkScreen'event and clkScreen = '1') then
        if (blank = '1') then
            red <= (others => '0');
            green <= (others => '0');
            blue <= (others => '0');
        else
            currentWidth := to_integer(unsigned(hcount));
            currentHeight := to_integer(unsigned(vcount));
            yRD := to_integer(unsigned(yRaquetteDroite));
            yRG := to_integer(unsigned(yRaquetteGauche));
            
            xB := to_integer(unsigned(xBalle));
            yB := to_integer(unsigned(yBalle));
            
            red <= "0001";
            green <= "0001";
            blue <= "0001";
            
            -- raquette droite
            if ((currentWidth > xRD and currentWidth < xRD + raquetteWidth)
                and (currentHeight > yRD - raquetteHeight and currentHeight < yRD + raquetteHeight)) then
                red <= "1111";
                green <= "0000";
                blue <= "0000";
            -- raquette gauche
            elsif ((currentWidth > xRG and currentWidth < xRG + raquetteWidth)
                and (currentHeight > yRG - raquetteHeight and currentHeight < yRG + raquetteHeight)) then
                red <= "0000";
                green <= "0100";
                blue <= "1111";
            
            -- balle
            elsif ((currentWidth > xB - balleSize and currentWidth < xB + balleSize)
                and (currentHeight > yB - balleSize and currentHeight < yB + balleSize)) then
                case colorBalle is
                    when "00" =>
                        red <= "1111";
                        green <= "1111";
                        blue <= "1111";
                    when "01" =>
                        red <= "1111";
                        green <= "0000";
                        blue <= "0000";
                    when "10" =>
                        red <= "0000";
                        green <= "0100";
                        blue <= "1111";
                    when others =>
                        red <= "0001";
                        green <= "0001";
                        blue <= "0001";
                end case;
            end if;
            
    --droite
            --trait horizontal haut
             if((currentWidth > 312+60 and currentWidth < 328+60 and (currentHeight > 12 and currentHeight<15 ))and (scoreP2=0 or scoreP2=2 or scoreP2=3 or scoreP2=5 or scoreP2=7 or scoreP2=8 or scoreP2=9))then 
                red <= "1111";
                green <= "0000";
                blue <= "0000";
            end if;
            -- trait vertical haut gauche
            if((currentWidth > 312+60 and currentWidth < 315+60 and (currentHeight > 16 and currentHeight<33 ))
            and (scoreP2=0 or scoreP2=4 or scoreP2=5 or scoreP2=6 or scoreP2=8 or scoreP2=9))
            then 
                red <= "1111";
                green <= "0000";
                blue <= "0000";
            end if;
            -- trait vertical haut droit
            if((currentWidth > 325+60 and currentWidth < 328+60 and (currentHeight > 16 and currentHeight<33 )) 
            and (scoreP2=0 or scoreP2=1 or scoreP2=2 or scoreP2=3 or scoreP2=4 or scoreP2=7 or scoreP2=8 or scoreP2=9))
            then 
                red <= "1111";
                green <= "0000";
                blue <= "0000";
            end if;
      
             -- trait vertical bas gauche
            if((currentWidth > 312+60 and currentWidth < 315+60 and (currentHeight > 38 and currentHeight<55 )) and (scoreP2=0 or scoreP2=2 or scoreP2=2 or scoreP2=6 or scoreP2=8))
            then 
                red <= "1111";
                green <= "0000";
                blue <= "0000";
            end if;
            -- trait vertical bas droit
            if((currentWidth > 325+60 and currentWidth < 328+60 and (currentHeight > 38 and currentHeight<55 ))
            and (scoreP2=0 or scoreP2=1 or scoreP2=3 or scoreP2=4 or scoreP2=5 or scoreP2=6 or scoreP2=7 or scoreP2=8 or scoreP2=9))
            then 
                red <= "1111";
                green <= "0000";
                blue <= "0000";
            end if;
            -- trait horizontal bas
            if((currentWidth > 312+60 and currentWidth < 328+60 and (currentHeight > 56 and currentHeight<59 ) and (scoreP2=0 or scoreP2=2 or scoreP2=3 or scoreP2=5 or scoreP2=6 or scoreP2=9 or scoreP2=8 or scoreP2=9))) then 
                red <= "1111";
                green <= "0000";
                blue <= "0000";
            end if;
                       
             -- trait horizontal milieu
            if((currentWidth > 312+60 and currentWidth < 328+60 and (currentHeight > 34 and currentHeight<37 ) and (scoreP2=2 or scoreP2=3 or scoreP2=4 or scoreP2=5 or scoreP2=6 or scoreP2=9 or scoreP2=8 or scoreP2=9)))then 
                red <= "1111";
                green <= "0000";
                blue <= "0000";
            end if;
               
            --gauche
            
                        --trait horizontal haut
             if((currentWidth > 312-60 and currentWidth < 328-60 and (currentHeight > 12 and currentHeight<15 ))and (scoreP1=0 or scoreP1=2 or scoreP1=3 or scoreP1=5 or scoreP1=7 or scoreP1=8 or scoreP1=9))then 
                red <= "0000";
                green <= "0100";
                blue <= "1111";
            end if;
            -- trait vertical haut gauche
            if((currentWidth > 312-60 and currentWidth < 315-60 and (currentHeight > 16 and currentHeight<33 ))
            and (scoreP1=0 or scoreP1=4 or scoreP1=5 or scoreP1=6 or scoreP1=8 or scoreP1=9))
            then 
                red <= "0000";
                green <= "0100";
                blue <= "1111";
            end if;
            -- trait vertical haut droit
            if((currentWidth > 325-60 and currentWidth < 328-60 and (currentHeight > 16 and currentHeight<33 )) 
            and (scoreP1=0 or scoreP1=1 or scoreP1=2 or scoreP1=3 or scoreP1=4 or scoreP1=7 or scoreP1=8 or scoreP1=9))
            then 
                red <= "0000";
                green <= "0100";
                blue <= "1111";
            end if;
      
             -- trait vertical bas gauche
            if((currentWidth > 312-60 and currentWidth < 315-60 and (currentHeight > 38 and currentHeight<55 ))and (scoreP1=0 or scoreP1=2 or scoreP1=2 or scoreP1=6 or scoreP1=8))
            then 
                red <= "0000";
                green <= "0100";
                blue <= "1111";
            end if;
            -- trait vertical bas droit
            if((currentWidth > 325-60 and currentWidth < 328-60 and (currentHeight > 38 and currentHeight<55 )) and (scoreP1=0 or scoreP1=1 or scoreP1=3 or scoreP1=4 or scoreP1=5 or scoreP1=6 or scoreP1=7 or scoreP1=8 or scoreP1=9))
            then 
                red <= "0000";
                green <= "0100";
                blue <= "1111";
            end if;
            -- trait horizontal bas
            if((currentWidth > 312-60 and currentWidth < 328-60 and (currentHeight > 56 and currentHeight<59 ) and (scoreP1=0 or scoreP1=2 or scoreP1=3 or scoreP1=5 or scoreP1=6 or scoreP1=9 or scoreP1=8 or scoreP1=9))) then 
                red <= "0000";
                green <= "0100";
                blue <= "1111";
            end if;
                       
             -- trait horizontal milieu
            if((currentWidth > 312-60 and currentWidth < 328-60 and (currentHeight > 34 and currentHeight<37 ) and (scoreP1=2 or scoreP1=3 or scoreP1=4 or scoreP1=5 or scoreP1=6 or scoreP1=9 or scoreP1=8 or scoreP1=9))) then 
                red <= "0000";
                green <= "0100";
                blue <= "1111";
            end if;
        end if;
    end if;
end process;

initGame : process(clkGame, rst)
begin
    if (rst = '1') then
        cntToInit <= (others => '0');
        gameInitialized <= '0';
    end if;
    if (clkGame'event and clkGame = '1' and gameInitialized = '0') then
        if (cntToInit = "1001110001000") then
            gameInitialized <= '1';
        end if;
        cntToInit <= cntToInit + 1;
    end if;
end process;

controllerRD : raquetteController
    port map(
        clk => clkGame,
        reset => rst,
        initialized => gameInitialized,
        btnUp => upP1,
        btnDown => downP1,
        y => yRaquetteGauche
    );

controllerRG : raquetteController
    port map(
        clk => clkGame,
        reset => rst,
        initialized => gameInitialized,
        btnUp => upP2,
        btnDown => downP2,
        y => yRaquetteDroite
    );

controllerB : balleController
    port map(
        clk => clkGame,
        reset => rst,
        initialized => gameInitialized,
        xRaquetteD => "1001110001", -- maxWidth - raquetteWidth - maxWidth/128
        yRaquetteD => yRaquetteDroite,
        xRaquetteG => "0000000101", -- maxWidth/128
        yRaquetteG => yRaquetteGauche,
        x => xBalle,
        y => yBalle,
        score1 => scoreP1,
        score2 => scoreP2,
        color => colorBalle
    );
end rtl;
