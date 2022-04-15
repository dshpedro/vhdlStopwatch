library ieee;
use ieee.std_logic_1164.all;

entity main is
    port(
        Button0, Button1, Button2, Clock_50 : in std_logic;
        HEX3_D, HEX2_D, HEX1_D, HEX0_D : out std_logic_vector(0 to 6)
    );
end main;

architecture behav of main is

component latchRS is
    port
    (
        S, R : in std_logic; -- S = PIN_F1; R = PIN_G3;
        Q : out std_logic
    );
end component;

component counter is
    port(
        CLK, R : in std_logic;
        Q : buffer std_logic_vector(0 to 3)
    );
end component;

signal latQ, counterReset : std_logic;
signal phvector : std_logic_vector(0 to 3);
begin

    lat : latchRS port map ( S => Button2, R => Button1, Q => latQ );
    counter3 : counter port map ( CLK => counterReset, R => counterReset  , Q => phvector);

    counterReset <= (not Button0) or (not latQ); 
    
    
end behav;