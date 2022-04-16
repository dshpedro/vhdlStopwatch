library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all; -- operador """+"""
-- possibilita o incremento da saída

entity counter is
    port(
        CLK, R : in std_logic;
        Tclk : out std_logic;
        Q : out std_logic_vector(0 to 3)
    );
end counter;

architecture behav of counter is
signal temp : std_logic_vector(0 to 3) := "0000";
begin

    Tclk <= not ( temp(3) and temp(0) );

    process(CLK, R, temp)
    begin
    
    if R = '1' then
        temp <= "0000";
    elsif rising_edge(CLK) then
        if temp = "1001" then
            temp <= "0000";
        else
        temp <= temp + 1;
        end if;
    end if;
    
    end process;
    
    Q <= temp;
end behav;