-- Disciplina: Sistemas Digitais
-- Exemplo de lógica combinacionao de duas ands e uma or.
-- Autor: Julio Nico Dantas dos Santos

-- Bibliotecas e pacotes

-- Entidade (Entidade basicamente são as descrições de interface com o mundo externo. conectores de entrada e saída das portas lógicas.)

entity and_gate is
    port (
        A, B:   in  bit; --Entradas 
        X:      out bit  --Saídas   
    );
end entity and_gate;

-- Arquitetura

architecture main of and_gade is
begin
    
    Z <= a and b;

end architecture main;
