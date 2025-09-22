library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CPU is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           register_a_in : in  STD_LOGIC_VECTOR (15 downto 0);
           load_ac : in  STD_LOGIC;
              CPU_BUS:IN STD_LOGIC;
           register_a_out : out  STD_LOGIC_VECTOR (15 downto 0));
end CPU;
-- 寄存器A行为
architecture behavioral of CPU is
begin
    process (clk, reset)
        variable tmp_a : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
    begin
        if reset = '1' then
            tmp_a := (others => '0');
        elsif rising_edge(clk) then
            if load_ac = '1' then
                tmp_a := register_a_in;
            end if;
        end if;
        register_a_out <= tmp_a;
    end process;
end behavioral;




