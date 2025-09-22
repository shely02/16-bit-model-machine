 LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY kongzhiqi IS
  port(clk :in std_logic; 
       reset:in std_logic;
         M:in std_logic;
       z_flag:in std_logic;
		 jump:in std_logic;
       IR:in std_logic_vector(15 downto 0);
       PC_bus:out std_logic;
       LoadMAR:out std_logic;
       IncPC:out std_logic;
       MemR:out std_logic;
       LoadMDR:out std_logic;
       selM:out std_logic_vector(1 downto 0);
       MDR_bus:out std_logic;
       LoadIR:out std_logic;
         LoadCX:OUT STD_LOGIC;--
       LoadBX:OUT STD_LOGIC;--
         LoadA:OUT STD_LOGIC;--
         LoadB:OUT STD_LOGIC;--
       Addr_bus:out std_logic;
       AC_bus:out std_logic;
         INCBX:OUT STD_LOGIC;--
         BX_BUS:OUT STD_LOGIC;
         A_BUS:OUT STD_LOGIC;
         B_BUS:OUT STD_LOGIC;
         INCCX:OUT STD_LOGIC;
       Memw:out std_logic;
       LoadAC:out std_logic;
       selA:out std_logic_vector(1 downto 0);
       LoadPC:out std_logic;
       LoadPSW:out std_logic;
       ALUop:out std_logic_vector(4 downto 0);
         F: out std_logic_vector(4 downto 0));         
END kongzhiqi;
ARCHITECTURE kongzhiqi_1 OF kongzhiqi IS 
  TYPE STATE IS (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,s10,s11,s12,s13,s14,s15,s16,s17);  
  SIGNAL  PRESENTSTATE  :STATE;  
  SIGNAL  NEXTSTATE    :STATE;  
BEGIN
SWITCHTONEXTSTATE:PROCESS(clk,reset)  
  BEGIN
    if reset='1'  then PRESENTSTATE <= S0; 
    elsif clk'event AND clk='1' then   
      PRESENTSTATE<=NEXTSTATE;
    end if;
END PROCESS SWITCHTONEXTSTATE;
 
CHANGESTATEMODE:PROCESS(PRESENTSTATE,z_flag,IR)
  BEGIN
    PC_bus<='0';
    LoadMAR<='0';
    IncPC<='0';
    MemR<='0';
    LoadMDR<='0';
    selM<="00";
    MDR_bus<='0';
    LoadIR<='0';
     LoadCX<='0';
     LoadBX<='0';
     LoadA<='0';
     LoadB<='0';
    Addr_bus<='0';
    AC_bus<='0';
     INCBX<='0';
     BX_BUS<='0';
     A_BUS<='0';
     B_BUS<='0';
     INCCX<='0';
    Memw<='0';
    LoadAC<='0';
    selA<="00";
    LoadPC<='0';
    ALUop<="00000";
     if IR(15)='0' then  --累加
  case PRESENTSTATE is
    when S0=>                
        PC_bus <= '1';  
        LoadMAR <= '1';  
        IncPC <= '1';
        NEXTSTATE <= S1;
        F <= "00000";
    when S1=>               
        MemR <= '1';    
        LoadMDR <= '1';  
        selM <= "10";
        NEXTSTATE <= S2;
        F <= "00001";
    when S2 =>
     MDR_bus <= '1';  
        LoadIR <= '1';
        NEXTSTATE <= S3;
        F <= "00010";
    when S3=>           
          F <= "00011";
            IF IR(15 downto 9) = ("0000101") THEN 
          NEXTSTATE <= S4;
             ELSIF IR(15 downto 9)=("0000110") or IR(15 downto 11)=("00010") or IR(15 downto 11)=("00111")  then 
             NEXTSTATE <= S5;
         ELSIF IR(15 downto 11) = ("00011") THEN 
          NEXTSTATE <= S9;--add
         ELSIF IR(15 downto 11) = ("00100") THEN 
          NEXTSTATE <= S11;--inc
             ELSIF IR(15 downto 11) = ("00101") THEN
             NEXTSTATE <= S12;--dec
                 ELSIF IR(15 downto 11) = ("00110") THEN
             NEXTSTATE <= S6;--jnz
         ELSE NEXTSTATE <= S0; 
        End IF;
    when S4=> --LOADBX           
         addr_bus<= '1';
			loadbx<= '1';
        NEXTSTATE <= S0; 
        F <= "00100";
		  
	when S5=>   
	addr_bus<= '1';
	loadmar<= '1';
	if IR(15 downto 11)="00111" then
	nextstate<=s14;
	else NEXTSTATE <= S6; 
	end if;
		F <= "00101";
    when S6 =>          
         MEMR <= '1';
          LoadMDR <= '1';
          SelM <= "10";
        NEXTSTATE <= S7; 
		  if IR(15 downto 9)="0000110" then
		  nextstate<=s7;
		  elsif IR(15 downto 11)="00010" then
		  nextstate<=s8;
		  elsif IR(15 downto 11)="00011" then
		  nextstate<=s10;
		  elsif z_flag = '1' then
		  nextstate<=s0;
		  elsif z_flag ='0' then
		  nextstate<=s13;
		  else nextstate<=s0;
		  end if;
        F <= "00110";
		 when S7 =>  --LOADCX    
		 mdr_bus <= '1';
          Loadcx <= '1';
			 sela<="10";
        NEXTSTATE <= S0; 
		    F <= "00111";
			  when S8 =>  --LOADAC         
       mdr_bus<= '1';
		 loadac<= '1';
		 sela<="10";
          F <= "01000";
        NEXTSTATE <= S0;  
    when S9 =>  --ADD          
     bx_bus<= '1';
	  loadmar<= '1';
          F <= "01001";
        NEXTSTATE <= S6;   
when S10 =>  --ADD  
 		 mdr_bus<= '1';
		 loadac<= '1';
		 sela<="01";
			  F <= "01010";
        NEXTSTATE <= S0;  
    when S11 =>  --INCBX
        INCBX <= '1';
        NEXTSTATE <= S0; 
          F <= "01011";     
    when S12 => --DECCX
       INCCX <= '1';
        NEXTSTATE <= S0;
          F <= "01100";
    when S13 => --
    mdr_bus<= '1';
	 loadpc<= '1';
	 nextstate<=s0;
        F <= "01101";    
	when s14 => --STORE
     ac_bus<= '1';
	  loadmdr<= '1';
	  selm<="10";
                  F<="01110";
						nextstate<=s15;
	when s15 => 			
	 Memw <= '1';
	 F<="01111";
	 nextstate<=s0;
	 when others=>nextstate<=s0;
         end case;
     else   --other
      case PRESENTSTATE is
      when S0=>               
        PC_bus <= '1';  
        LoadMAR <= '1';  
        IncPC <= '1';
        NEXTSTATE <= S1;
        F <= "00000";
    when S1=>               
        MemR <= '1';    
        LoadMDR <= '1';  
        selM <= "10";
        NEXTSTATE <= S2;
        F <= "00001";
    when S2 =>
     MDR_bus <= '1';  
        LoadIR <= '1';
        NEXTSTATE <= S3;
        F <= "00010";
    when S3=> 
	 addr_bus <= '1';  
	 loadmar <= '1';  
       if IR(15 downto 9)=("1000010") or IR(15 downto 11)=("10001") or IR(15 downto 11)=("10010") or IR(15 downto 11)=("10110") or IR(15 downto 11)=("11000")then
		 nextstate<=s4;
        elsif IR(15 downto 11)=("10011") then
		  nextstate<=s9;
		  elsif IR(15 downto 11)=("10101") then
		  nextstate<=s13;
		  elsif IR(15 downto 11) = ("10100") THEN
		  nextstate<=s11;
		  elsif IR(15 downto 11)=("11001") then
		  nextstate<=s12;
		  elsif IR(15 downto 11)=("10111") then
		  nextstate<=s16;
        End IF;
		  f<="00011";
    when S4=>            
         MEMR <= '1';
          LoadMDR <= '1';
          SelM <= "10";
			 if IR(15 downto 11)="10000" then
			 nextstate<=s5;
			 elsif IR(15 downto 11)="10001" then
			 nextstate<=s6;
			 elsif IR(15 downto 11)="10010" then
			 nextstate<=s7;
			 elsif IR(15 downto 11)=("11000") then
			 nextstate<=s8;
			 elsif z_flag='1' then
			 nextstate<=s0;
			 elsif z_flag='0' then
			 nextstate<=s15;
			 end if;
        F <= "00100";
    when S5 =>  --LOADCX        
         mdr_bus<= '1';
			loadcx<= '1';
        NEXTSTATE <= S0; 
        F <= "00101";
    when S6 =>  --LOADA          
         mdr_bus<= '1';
			loada<= '1';
			nextstate<=s0;
          F <= "00110";        
    when S7 =>  --LOADB
      mdr_bus<= '1';
		loadb<= '1';
        NEXTSTATE <= S0; 
          F <= "00111"; 
		when s8 => --LOADAC
          mdr_bus<= '1';
			loadac<= '1';
			 sela<="10";
				nextstate<=s0;
                  F<="01000";			 
    when S9 =>  --ADD1
        a_bus<= '1';
		  sela<="01";
		  loadac<= '1';
        NEXTSTATE <= S10;
          F <= "01001";
    when S10 => 
        ac_bus<= '1';
		  loada<= '1';
        NEXTSTATE <= S0; 
        F <= "01010"; 
		when s11 => --DECCX
          inccx<= '1';
				nextstate<=s0;
                  F<="01011";
		when s12 => --JZ
				if jump = '1' then
					nextstate <= s0;
				else
					nextstate<=s15;
				end if;
                  F<="01100";				
     when s13 => --ADD2
            b_bus<= '1';
				sela<="01";
				loadac<= '1';
				nextstate<=s14;
                  F<="01101";
		when s14 => 
            ac_bus<= '1';
				loadb<= '1';
				nextstate<=s0;
                  F<="01110";
		when s15 => 
          mdr_bus<= '1';
			 loadpc<= '1';
				nextstate<=s0;
                  F<="01111";
		when s16 => --STORE
            ac_bus<= '1';
				selm<="01";
				loadmdr<= '1';
				nextstate<=s17;
                  F<="10000";
		when s17 => --STORE
           memw<= '1';
				nextstate<=s0;
                  F<="10001";
         end case;
     end if;
  END PROCESS CHANGESTATEMODE;
END kongzhiqi_1;