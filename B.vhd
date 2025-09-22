library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity B is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           register_b_in : in  STD_LOGIC_VECTOR (15 downto 0);
           load_b : in  STD_LOGIC;
              b_BUS:IN STD_LOGIC;
           register_b_out : out  STD_LOGIC_VECTOR (15 downto 0));
end B;
-- 寄存器A行为
architecture behavioral of B is
begin
    process (clk, reset)
        variable tmp_b : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
    begin
        if reset = '1' then
            tmp_b := (others => '0');
        elsif rising_edge(clk) then
            if load_b = '1' then
                tmp_b := register_b_in;
            end if;
        end if;
        register_b_out <= tmp_b;
    end process;
end behavioral;