library ieee;
use ieee.std_logic_1164.all;

entity decoder is
    port(
        dcba : in std_logic_vector(0 to 3);
        decoderOut : out std_logic_vector(0 to 6)
    );
end decoder;

architecture behav of decoder is
begin

    with dcba select
    decoderOut <= "0000001" when "0000",
                  "1001111" when "0001",
                  "0010010" when "0010",
                  "0000110" when "0011",
                  "1001100" when "0100",
                  "0100100" when "0101",
                  "0100000" when "0110",
                  "0001111" when "0111",
                  "0000000" when "1000",
                  "0000100" when "1001",
                  "1111111" when others;

end behav;