library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--程序计数器，指向内存中的指令地址，每执行一条指令后自动加1，指向下一条指令
entity PC is
port(
	reset : in std_logic;
	cp : in std_logic;
	LoadPC : in std_logic;
	IncPC : in std_logic;
	inputPC : in std_logic_vector(15 downto 0);
	outPC : out std_logic_vector(15 downto 0)
);
end entity;

architecture PC_body of PC is
signal PC : std_logic_vector(15 downto 0);
begin
	process(reset,LoadPC,inputPC,IncPC,PC,cp)
	begin
		if reset='1' then
			PC<="0000000000000000";
		elsif cp'event and cp='1' then
			if LoadPC='1' then
				PC<=inputPC;
			elsif IncPC='1' then
				PC<=PC+1;
			end if;
		end if;
	end process;
		outPC<=PC;
end  architecture;