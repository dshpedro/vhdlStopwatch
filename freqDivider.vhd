library ieee;
use ieee.std_logic_1164.all;

entity freqDivider is
    port(
    clk50M : in std_logic; -- clk50M = PIN_G21
    freqOut : buffer std_logic
    );
end freqDivider;

architecture behav of freqDivider is
signal i : integer := 1;
begin

    process(clk50M, freqOut)
    begin
        
    if rising_edge(clk50M) then
        i <= i + 1;
    
    if i = 50000000 then
        freqOut <= not freqOut;
        i <= 1;
    end if;
    end if;
    
    end process;

end behav;