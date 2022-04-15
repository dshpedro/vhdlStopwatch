library ieee;
use ieee.std_logic_1164.all;

entity latchRS is
    port
    (
        S, R : in std_logic; -- S = PIN_F1; R = PIN_G3;
        Q : out std_logic
    );
end latchRS;

architecture behav of latchRS is
begin
    process(S, R)
    begin
        if R = '0' then
            Q <= '0';
        elsif S = '0' then
            Q <= '1';
        end if;
    end process;
end behav;