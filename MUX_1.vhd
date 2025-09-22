library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity MUX_1 is
port(
		SELA   :	std_logic_vector(1 downto 0);
		input_1,input_2	:   in std_logic_vector(15 downto 0);    				
		Read_data	: out	std_logic_vector(15 downto 0)  --输出数据	
	);
end MUX_1;

architecture MUX_1_body of MUX_1 is
begin
  process(input_1,input_2)
  begin
    if SELA = "01" then
      Read_data <= input_1; -- 当选择信号为 ”01“ 时，输出为 input_1,alu
    elsif SELA = "10" then
      Read_data <= input_2; -- 当选择信号为 ”10” 时，输出为 input_2，总线 
	 else
      Read_data <= "0000000000000000"; -- 当选择信号为其他时，输出为全0
	   end if;

  end process;
end  MUX_1_body;