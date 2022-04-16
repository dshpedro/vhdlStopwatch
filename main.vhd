library ieee;
use ieee.std_logic_1164.all;

entity main is
    port(
        Button0, Button1, Button2, Clock_50 : in std_logic;
        HEX3_D, HEX2_D, HEX1_D, HEX0_D : out std_logic_vector(0 to 6)
    );
end main;

architecture behav of main is

component latchRS is -- Latch RS
    port
    (
        S, R : in std_logic; -- S = PIN_F1; R = PIN_G3;
        Q : out std_logic
    );
end component;

component freqDivider is -- divisor de frequência 1/50 000 000
    port(
    clkIN : in std_logic; -- clkIN = PIN_G21
    freqOut : buffer std_logic
    );
end component;

component counter is  -- contador bcd de 4 bits
    port(
        CLK, R : in std_logic;
        Q : buffer std_logic_vector(0 to 3)
    );
end component;

signal latQ : std_logic; -- saída Q do latch
signal counterReset : std_logic; -- reset do contador

signal oneHz : std_logic; -- f = 1Hz
signal clkCounter0 : std_logic; -- clock do contador menos significativo

signal phvector : std_logic_vector(0 to 3); -- 4 bits placeholder vector
begin


    lat : latchRS port map ( S => Button2, R => Button1, Q => latQ );
    
    freqDiv : freqDivider port map ( clkIN => Clock_50 , freqOut => oneHz );
    
    counter3 : counter port map ( CLK => clkCounter0, R => counterReset  , Q => phvector);
    counter2 : counter port map ( CLK => clkCounter0, R => counterReset  , Q => phvector);
    counter1 : counter port map ( CLK => clkCounter0, R => counterReset  , Q => phvector);
    counter0 : counter port map ( CLK => clkCounter0, R => counterReset  , Q => phvector);
    
    counterReset <= (not Button0) or (not latQ); 
    
    clkCounter0 <= latQ and oneHz;
    
end behav;