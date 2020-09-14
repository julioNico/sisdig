-- Disciplina: Sistemas Digitais
-- EXEMPLO 5–14 do Livro, pag. 286 
-- Livro: Sistemas Digitais - fundamentos e aplicações
-- Autor do Livro: floyd, thomas l

--   A abordagem de fluxo de dados resulta num código muito mais
--     simples para essa função lógica em particular. Entretanto, nas situações em que uma
--     função lógica consiste de muitos blocos de lógica complexa, a abordagem estrutural
--     pode ter uma vantagem sobre a abordagem de fluxo de dados.

--*********************************
--Abordagem ESTRUTURAL:
--*********************************

entity SOP_Logic is

    port (
        IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8: in bit;  --Inputs
        OUT4: out bit --Outputs
    );

end entity SOP_Logic;

architecture LogicOperation of SOP_Logic is
    
    -- declaração de componente para uma porta NAND de 3 entradas
    component NAND_gate3 is

        port (
            A, B, C: in bit;
            X:out bit
        );

    end component NAND_gate3;
    
    -- declaração de componente para uma porta NAND de 2 entradas
    component NAND_gate2 is

        port (
            A, B: in bit;
            X: out bit
        );

    end component NAND_gate2;
       
    -- declaração dos fios que conectam os componentes

    signal OUT1, OUT2, OUT3: bit;

    -- Descrevendo o circuito reaproveitando os componentes prontos.
begin
    G1: NAND_gate3 port map (A => IN1, B => IN2, C => IN3, X => OUT1);
    G2: NAND_gate3 port map (A => IN4, B => IN5, C => IN6, X => OUT2);
    G3: NAND_gate2 port map (A => IN7, B => IN8, X => OUT3);
    G4: NAND_gate3 port map (A => OUT1, B => OUT2, C => OUT3, X => OUT4);
end architecture LogicOperation;


--*********************************
--Abordagem de FLUXO DE DADOS:
--*********************************

entity SOP_Logic is
    port (
        IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8: in bit;
        OUT4: out bit
    );
end entity SOP_Logic;

architecture LogicOperation of SOP_Logic is
begin

    OUT4 <= (IN1 and IN2 and IN3) or (IN4 and IN5 and IN6) or (IN7 and IN8);
    
end architecture LogicOperation;