library ieee;
use ieee.std_logic_1164.all;

entity main is
    port(
        PIN_H2, PIN_G3, PIN_F1, Clock_50 : in std_logic; -- btn0Zera, btn1Para, btn2Inicia, PIN_G21
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
        freqOut : out std_logic
    );
end component;

component counter is  -- contador bcd de 4 bits
    port(
        CLK, R : in std_logic;
        Tclk : out std_logic;
        Q : out std_logic_vector(0 to 3)
    );
end component;

component decoder is
    port(
        dcba : in std_logic_vector(0 to 3);
        decoderOut : out std_logic_vector(0 to 6)
    );
end component;

signal latQ : std_logic; -- saída Q do latch
signal counterReset : std_logic; -- reset do contador

signal oneHz : std_logic; -- f = 1Hz
signal clkCounter0 : std_logic; -- clock do contador menos significativo

signal tclk3, tclk2, tclk1, tclk0 : std_logic; -- "Tclk" responsáveis por ativar o próximo contador
signal ctr3Q, ctr2Q, ctr1Q, ctr0Q : std_logic_vector(0 to 3); -- saídas Q dos contadores

begin

    lat : latchRS port map ( S => PIN_F1, R => PIN_G3, Q => latQ );
    freqDiv : freqDivider port map ( clkIN => Clock_50 , freqOut => oneHz );
    
    ctr0 : counter port map ( CLK => clkCounter0, R => counterReset, Tclk => tclk0 , Q => ctr0Q);
    ctr1 : counter port map ( CLK => tclk0, R => counterReset, Tclk => tclk1, Q => ctr1Q);
    ctr2 : counter port map ( CLK => tclk1, R => counterReset, Tclk => tclk2, Q => ctr2Q);
    ctr3 : counter port map ( CLK => tclk2, R => counterReset, Tclk => tclk3 , Q => ctr3Q);
    
    decod0 : decoder port map ( dcba => ctr0Q, decoderOut => HEX0_D);
    decod1 : decoder port map ( dcba => ctr1Q, decoderOut => HEX1_D);
    decod2 : decoder port map ( dcba => ctr2Q, decoderOut => HEX2_D);
    decod3 : decoder port map ( dcba => ctr3Q, decoderOut => HEX3_D);
    
    
    clkCounter0 <= latQ and oneHz;
    counterReset <= (not PIN_H2) or (not latQ); 
    
end behav;