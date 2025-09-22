library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MUX_2 is
port(
		SELM   :	std_logic_vector(1 downto 0);
		input_3,input_4	:   in std_logic_vector(15 downto 0);    				
		data_out	: out	std_logic_vector(15 downto 0)  --输出数据	
	);
end MUX_2;

architecture MUX_2_body of MUX_2 is
begin
	process(input_3,input_4)--选择器是组合逻辑器件，不需要时钟
	begin
		if SELM="01" then
		   data_out<=input_3; -- 当选择信号为 ”01“ 时，输出为 input_3,总线
		elsif  SELM="10" then
			data_out<=input_4; -- 当选择信号为 ”10” 时，输出为 input_4，主存
		else
         data_out <= "0000000000000000";  -- 当选择信号为其他时，输出为全0
			end if;

  end process;
end MUX_2_body;