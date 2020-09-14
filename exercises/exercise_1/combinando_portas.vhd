-- Disciplina: Sistemas Digitais
-- Exercício: 2 (componentes xor)    
-- Autor: Julio Nico Dantas dos Santos 

--*********************************
-- Abordagem ESTRUTURAL:
--*********************************

--Biblioteca
library ieee;
use ieee.std_logic_1164.all;

-- Entidade
entity xor_2 is

    port (
        a: in std_logic_vector(3 downto 0);  --Inputs
        o1: out std_logic --Outputs
    );

end entity xor_2;

architecture xor2_arch of xor_2 is

    -- declaração do componente xor2
    component xor2 is

        port (
            i1, i2: in std_logic_vector(3 downto 0);
            o1: out std_logic
        );

    end component xor2;
       
    -- declaração dos fios que conectam os componentes

    signal sig1, sig2: std_logic;

    -- Descrevendo o circuito reaproveitando os componentes prontos.
begin
    unit_10: xor2 port map (i1 => a(0), i2 => a(1), o1 => sig1);
    unit_11: xor2 port map (i1 => a(2), i2 => a(3), o1 => sig2);
    unit_2: xor2 port map (i1 => sig1, i2 => sig2, o1 => odd);
end architecture xor2_arch;


--*********************************
--Abordagem de FLUXO DE DADOS ou Descrição a nível de porta:
--*********************************
--Biblioteca
library ieee;
use ieee.std_logic_1164.all;

--Entidade
entity xor_2 is
    port(
        a : in std_logic_vector(3 downto 0);
        odd : out std_logic
    );

end entity xor_2;

architecture xor2_arch of xor_2 is
    signal sig1, sig2: std_logic;
begin
    odd <= sig1 xor sig2;
    sig1 <= (a(0) xor a(1));
    sig2 <= (a(2) xor a(3));
    
end architecture xor2_arch;