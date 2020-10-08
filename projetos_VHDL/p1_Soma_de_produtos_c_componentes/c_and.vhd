
-- Disciplina: Sistemas Digitais
-- Circuito/Componente porta "AND".
-- Autor: Julio Nico Dantas dos Santos

-- Biblioteca
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Entidade
entity c_and is 

	port (
		A: in std_logic;
		B: in std_logic;
		X: out std_logic
	);

end entity c_and;

-- Arquitetura
architecture or_arch of c_and is

begin
	x <= A and B;
end;


