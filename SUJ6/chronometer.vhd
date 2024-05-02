library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity chronometer is
port (CLK,RST : in std_logic;
		seg: out std_logic_vector(6 downto 0);
		an: out std_logic_vector(3 downto 0));
end chronometer;

architecture rtl of chronometer is

signal refreshDisplay : std_logic;
signal refreshNumbers : std_logic_vector(3 downto 0);
signal numbersToDisplay : std_logic_vector(15 downto 0);

signal displayedNode : std_logic_vector(1 downto 0);
signal displayedNumber : std_logic_vector(3 downto 0);

component div_10ms5 is
    port(clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clkOut : out STD_LOGIC);
end component;

component div_1s is
    port(clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC);
end component;

component cnt_10 is
    port(Q : in STD_LOGIC;
           rst : in STD_LOGIC;
           numberToDisplay : out STD_LOGIC_VECTOR(3 downto 0);
           pulseOut : out STD_LOGIC);
end component;

component cnt_6 is
    port(Q : in STD_LOGIC;
           rst : in STD_LOGIC;
           numberToDisplay : out STD_LOGIC_VECTOR(3 downto 0);
           pulseOut : out STD_LOGIC);
end component;

component cnt_4 is
    port(clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           activeNode : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component mux_4v1 is
    port(tenminutes : in STD_LOGIC_VECTOR (3 downto 0);
           minutes : in STD_LOGIC_VECTOR (3 downto 0);
           tenseconds : in STD_LOGIC_VECTOR (3 downto 0);
           seconds : in STD_LOGIC_VECTOR (3 downto 0);
           activeNode : in STD_LOGIC_VECTOR (1 downto 0);
           muxOut : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component enc_4v7 is
    port(numberIn : in STD_LOGIC_VECTOR (3 downto 0);
           segments : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component enc_2v4 is
    port(activeNode : in STD_LOGIC_VECTOR (1 downto 0);
           anCode : out STD_LOGIC_VECTOR (3 downto 0));
end component;

begin

clk_10ms5: div_10ms5
    port map(
            clk => CLK,
            rst => RST,
            clkOut => refreshDisplay
    );
    
clk_1s: div_1s
    port map(
            clk => CLK,
            rst => RST,
            pulse => refreshNumbers(0)
    );
    
nb_counter_seconds : cnt_10
    port map(
            Q => refreshNumbers(0),
            rst => RST,
            numberToDisplay => numbersToDisplay(3 downto 0),
            pulseOut => refreshNumbers(1)
    );
nb_counter_tenseconds : cnt_6
    port map(
            Q => refreshNumbers(1),
            rst => RST,
            numberToDisplay => numbersToDisplay(7 downto 4),
            pulseOut => refreshNumbers(2)
    );
nb_counter_minutes : cnt_10
    port map(
            Q => refreshNumbers(2),
            rst => RST,
            numberToDisplay => numbersToDisplay(11 downto 8),
            pulseOut => refreshNumbers(3)
    );
nb_counter_tenminutes : cnt_6
    port map(
            Q => refreshNumbers(3),
            rst => RST,
            numberToDisplay => numbersToDisplay(15 downto 12)
    );

node_selector : cnt_4
    port map(
            clk => refreshDisplay,
            rst => RST,
            activeNode => displayedNode
    );

chooseNumberToDisplay : mux_4v1
    port map (
            tenminutes => numbersToDisplay(15 downto 12),
            minutes => numbersToDisplay(11 downto 8),
            tenseconds => numbersToDisplay(7 downto 4),
            seconds => numbersToDisplay(3 downto 0),
            activeNode => displayedNode,
            muxOut => displayedNumber
    );

numberToSegments : enc_4v7
    port map(
            numberIn => displayedNumber,
            segments => seg
    );
    
nodeToAnCode : enc_2v4
    port map(
            activeNode => displayedNode,
            anCode => an
    );

end rtl;
