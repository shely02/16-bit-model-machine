library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ALU is
    port(
        a,b : in std_logic_vector(15 downto 0);
        result : out std_logic_vector(15 downto 0);
        op : in std_logic_vector(1 downto 0)
    );
end entity;

architecture Behavioral of ALU is
begin
    process(a,b)
    begin
        result <= a + b;
    end process;
end architecture;
