library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pong is
    port(CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           btnU : in STD_LOGIC;
           btnD : in STD_LOGIC;
           btnL : in STD_LOGIC;
           btnR : in STD_LOGIC;
           Hsync : out STD_LOGIC;
           Vsync : out STD_LOGIC;
           vgaRed : out STD_LOGIC_VECTOR(3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR(3 downto 0);
           vgaBlue : out STD_LOGIC_VECTOR(3 downto 0));
end pong;

architecture rtl of pong is

component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  CLK_100MHZ          : out    std_logic;
  CLK_25MHZ          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  clk_in1           : in     std_logic
 );
end component;

component div_1ms is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clkOut : out STD_LOGIC);
end component;

component vga_controller_640_60 is
    port(
        rst         : in std_logic;
        pixel_clk   : in std_logic;

        hs          : out std_logic;
        vs          : out std_logic;
        hcount      : out std_logic_vector(10 downto 0);
        vcount      : out std_logic_vector(10 downto 0);
        blank       : out std_logic);
end component;

component image is
    port(clkScreen : in STD_LOGIC;
         clkGame : in STD_LOGIC;
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
end component;

signal CLK_PIX : std_logic;
signal CLK_GAME : std_logic;
signal x_pix : std_logic_vector(10 downto 0);
signal y_pix : std_logic_vector(10 downto 0);
signal offScreen : std_logic;

begin

refreshClk : clk_wiz_0
       port map ( 
      -- Clock out ports
       CLK_25MHZ => CLK_PIX,
      -- Status and control signals                
       reset => RST,
       -- Clock in ports
       clk_in1 => CLK
 );

gameClk : div_1ms
    port map (
        clk => CLK,
        rst => RST,
        clkOut => CLK_GAME
    );
    
controller : vga_controller_640_60
    port map(
            rst => RST,
            pixel_clk => CLK_PIX,
            hs => Hsync,
            vs => Vsync,
            hcount => y_pix,
            vcount => x_pix,
            blank => offScreen
    );

display : image
    port map(
            clkScreen => CLK_PIX,
            clkGame => CLK_GAME,
            upP1 => btnU,
            downP1 => btnD,
            upP2 => btnL,
            downP2 => btnR,
            hcount => y_pix,
            vcount => x_pix,
            blank => offScreen,
            red => vgaRed,
            green => vgaGreen,
            blue => vgaBlue
    );
end rtl;
