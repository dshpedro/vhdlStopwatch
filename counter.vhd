library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all; -- operador """+"""
-- possibilita o incremento da saída

entity counter is
    port(
        CLK, R : in std_logic;
        Tclk : out std_logic;
        Q : buffer std_logic_vector(0 to 3)
    );
end counter;

architecture behav of counter is
begin

    Tclk <= not ( Q(3) and Q(0) );

    process(CLK, R)
    begin
    
    if R = '1' then
        Q <= "0000";
    elsif rising_edge(CLK) then
        if Q = "1001" then
            Q <= "0000";
        else
        Q <= Q + 1;
        end if;
    end if;
    
    end process;
end behav;