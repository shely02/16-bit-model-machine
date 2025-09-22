library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
--循环计数，提供跳转控制
entity CX is
    port(
        input_data : in std_logic_vector(15 downto 0);
        loadCX : in std_logic;--取数信号，为直接寻址
        IncCX : in std_logic;--自减信号
        clk : in std_logic;
        reset : in std_logic;
        output_data : out std_logic_vector(15 downto 0);
		  jump: out std_logic;
        z_flag : out std_logic);--给CM的输出信号
end entity;

architecture behave of CX is
    signal temp : std_logic_vector(15 downto 0);
    begin
    process(clk,reset)
    begin
        if rising_edge(clk) then
            if loadCX = '1' then
                temp <= input_data;
            end if;
                if IncCX = '1' then
                    temp <= temp-1;
                end if;
                if temp = 0 then
                    output_data <= temp;
						  z_flag<= '1';
						  jump<= '0';
                else 
							output_data <= temp;
                    z_flag <= '0';
						  jump<='1';
                end if;
        end if;
    end process;
end behave;