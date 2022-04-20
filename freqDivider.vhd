library ieee;
use ieee.std_logic_1164.all;

entity freqDivider is
    port(
        clkIN : in std_logic; -- clkIN = PIN_G21
        freqOut : out std_logic
    );
end freqDivider;

architecture behav of freqDivider is
signal i : integer := 1;
signal tmp : std_logic := '0';
begin

    process(clkIN, tmp)
    begin
        
    if rising_edge(clkIN) then
        i <= i + 1;
    
    if i = 250000 then -- 100Hz
        tmp <= not tmp;
        i <= 1;
    end if;
    end if;
    
    end process;
    
    freqOut <= tmp;

end behav;