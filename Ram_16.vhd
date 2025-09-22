library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity Ram_16 is
port(
    reset : in std_logic;
    cp : in std_logic;
    MemR : in std_logic;
    MemW : in std_logic;
    inputMAR : in std_logic_vector(15 downto 0);
    inputMDR : in std_logic_vector(15 downto 0);
    outRAM : out std_logic_vector(15 downto 0) 
);
end entity;

architecture Ram_16_body of RAM_16 is
type arr is array(127 downto 0)of std_logic_vector(15 downto 0);
signal reg : arr;
begin
    process(reset,cp,MemR,MemW,inputMAR,inputMDR)
    begin
    if reset='1' then
            reg(ieee.std_logic_arith.conv_integer("0000000"))<="0000110000001011";--Load0 10	CX 3 CX赋值为3
            reg(ieee.std_logic_arith.conv_integer("0000001"))<="0000101000001000";--Load0 11 BX	2 BX赋值为2
				reg(ieee.std_logic_arith.conv_integer("0000010"))<="0001010000011101";--Load0 11	AC	2 BX的值赋值给AC
            reg(ieee.std_logic_arith.conv_integer("0000011"))<="0001111000000011";--ADD BX与AC相加赋值给AC
            reg(ieee.std_logic_arith.conv_integer("0000100"))<="0010010000000100";--Inc 递增BX
            reg(ieee.std_logic_arith.conv_integer("0000101"))<="0010110000000101";--DEC 递减CX
            reg(ieee.std_logic_arith.conv_integer("0000110"))<="0011010000000011";--JNZ 跳转，为0则store，为1下一指令
            reg(ieee.std_logic_arith.conv_integer("0000111"))<="0011110000001100";--Store
            reg(ieee.std_logic_arith.conv_integer("0001000"))<="0000000000000010";--data0
            reg(ieee.std_logic_arith.conv_integer("0001001"))<="0000000000000001";--data0
            reg(ieee.std_logic_arith.conv_integer("0001010"))<="0000000000000011";--data0
            reg(ieee.std_logic_arith.conv_integer("0001011"))<="0000000000000011";--data10 存储，CX为零，进行累加
				
				
				reg(ieee.std_logic_arith.conv_integer("0001101"))<="1000010000011011";--load0 10 cx CX赋值为7
				reg(ieee.std_logic_arith.conv_integer("0001110"))<="1000110000011000";--load0 10 a 加载寄存器a
				reg(ieee.std_logic_arith.conv_integer("0001111"))<="1001010000011001";--load0 10 b 加载寄存器b
				reg(ieee.std_logic_arith.conv_integer("0010000"))<="1100010000011010";--load0 10 ac
				reg(ieee.std_logic_arith.conv_integer("0010001"))<="1001110000010001";--add1
				reg(ieee.std_logic_arith.conv_integer("0010010"))<="1010010000010010";--deccx
				reg(ieee.std_logic_arith.conv_integer("0010011"))<="1100110000010111";--jump
				reg(ieee.std_logic_arith.conv_integer("0010100"))<="1010110000010100";--add2
				reg(ieee.std_logic_arith.conv_integer("0010101"))<="1010010000010101";--inccx
				reg(ieee.std_logic_arith.conv_integer("0010110"))<="1011010000010001";--jnz
				reg(ieee.std_logic_arith.conv_integer("0010111"))<="1011110000011100";--store
				reg(ieee.std_logic_arith.conv_integer("0011000"))<="0000000000000001";--data10
				reg(ieee.std_logic_arith.conv_integer("0011001"))<="0000000000000001";--data10
				reg(ieee.std_logic_arith.conv_integer("0011010"))<="0000000000000001";--data10
				reg(ieee.std_logic_arith.conv_integer("0011011"))<="0000000000000111";--data10
				
				reg(ieee.std_logic_arith.conv_integer("0011101"))<="0000000000000000";--data10
    elsif cp'event and cp='1' then
        if MemW='1' then
            reg(conv_integer(inputMAR))<=inputMDR;
        end if;
        
    end if;
    end process;
outRAM<=reg(conv_integer(inputMAR)) when MemR='1';
end architecture;