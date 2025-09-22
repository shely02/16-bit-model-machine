library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--变址寄存器，存储内存地址，支持自增
entity BX is
    port( clk :in std_logic;
        reset : in std_logic;
        register_b_in : in std_logic_vector(15 downto 0);
        loadBX : in std_logic;--给BX赋值
        IncBX : in std_logic;--BX地址自增1
        --BX_Bus : in std_logic;--输出总线
        register_b_out : out std_logic_vector(15 downto 0));
end entity;

architecture behave of BX is
begin
    process(clk,reset)
        variable temp : std_logic_vector(15 downto 0):= (others => '0');
    begin
        if reset = '1' then
            temp := (others => '0');
        elsif rising_edge(clk) then
            if loadBX = '1' then
                temp :="0001010" & register_b_in(8 downto 0);--00010为LOAD1，为寄存器直接寻址10
                elsif IncBX = '1' then
                    temp := temp+1;
            end if;
        end if;
        register_b_out <= temp;
    end process;
end behave;