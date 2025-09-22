library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity AC is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           register_ac_in : in  STD_LOGIC_VECTOR (15 downto 0);
           load_ac : in  STD_LOGIC;
			  --ac_bus:IN STD_LOGIC;
           register_ac_out : out  STD_LOGIC_VECTOR (15 downto 0));
end AC;

architecture behavioral of AC is
begin
    process (clk, reset)
        variable ac_out : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
    begin
        if reset = '1' then
            ac_out := (others => '0');
        elsif rising_edge(clk) then
            if load_ac = '1' then
                ac_out := register_ac_in;
            end if;
        end if;
        register_ac_out <= ac_out;
    end process;
end behavioral;