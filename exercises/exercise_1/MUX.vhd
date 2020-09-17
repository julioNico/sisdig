-- Disciplina: Sistemas Digitais
-- Exercício: 3 (mux 4 pra 1)    
-- Autor: Julio Nico Dantas dos Santos 
-- GitHub: https://github.com/julioNico

--************************************************************
--MUX 4_1 "when Else" 
--************************************************************
--Biblioteca
library ieee;
use ieee.std_logic_1164.all;

--Entidade
entity mux_4_1 is
    port(
        I0, I1, I2, I3  : in    std_logic_vector(3 downto 0);
        S0, S1          : in    std_logic;
        Y               : out   std_logic
    );

end entity mux_4_1;

architecture main_arch of mux_4_1 is
    
    signal sel  :   std_logic_vector(1 downto 0):="00"; --Sinal de dois bits começando em 00

begin
    
    sel <= S1 & S0; --Concatenação de S1 e S0.

    Y<= I0 when sel = "00" else
        I1 when sel = "01" else
        I2 when sel = "10" else
        I3;

end architecture main_arch;























--************************************************************
--MUX 4_1 "when select" 
--************************************************************
--Biblioteca
library ieee;
use ieee.std_logic_1164.all;

--Entidade
entity mux_4_1 is
    port(
        I0, I1, I2, I3  : in    std_logic_vector(3 downto 0);
        S0, S1          : in    std_logic;
        Y               : out   std_logic
    );

end entity mux_4_1;

architecture main_arch of mux_4_1 is
    
    signal sel  :   std_logic_vector(1 downto 0):="00"; --Sinal de dois bits começando em 00

begin
    
    sel <= S1 & S0; --Concatenação de S1 e S0.

    with s select
        Y<= I0 when "00"
            I1 when "01" 
            I2 when "10"
            I3 when others; -- s = "11"

end architecture main_arch;



























--**********************************************************************
--MUX 4_1 "process if-then-else" (Código sequencial, a ordem importa.) 
--**********************************************************************
--Biblioteca
library ieee;
use ieee.std_logic_1164.all;

--Entidade
entity mux_4_1 is
    port(
        I0, I1, I2, I3  : in    std_logic;
        S0, S1          : in    std_logic;
        Y               : out   std_logic
    );

end entity mux_4_1;

architecture main_arch of mux_4_1 is
    
    signal sel  :   std_logic_vector(1 downto 0):="00"; --Sinal de dois bits começando em 00

begin
    
    process (I0,I1,I2,I3,S0,S1) is
        begin
          if (S0 ='0' and S1 = '0') then
              Y <= I0;
          elsif (S0 ='1' and S1 = '0') then
              Y <= I1;
          elsif (S0 ='0' and S1 = '1') then
              Y <= I2;
          else
              Y <= I3;
          end if;
         
        end process;
        

end architecture main_arch;




















--************************************************************
--MUX 4_1 "process with case" 
--************************************************************
--Biblioteca
library ieee;
use ieee.std_logic_1164.all;

--Entidade
entity mux_4_1 is
    port(
        I0, I1, I2, I3  : in    std_logic_vector(3 downto 0);
        S0, S1          : in    std_logic;
        Y               : out   std_logic
    );

end entity mux_4_1;

architecture main_arch of mux_4_1 is
    
    signal sel  :   std_logic_vector(1 downto 0):="00"; --Sinal de dois bits começando em 00

begin
    
    sel <= S1 & S0; --Concatenação de S1 e S0.
    process(I0, I1, I2, I3, sel)
    begin
        case sel is
            when "00" =>
                Y<= I0
            when "01" =>
                Y<= I1
            when "10" =>
                Y<= I2
            when others =>
                y<= I3;    
        end case;        

end architecture main_arch;