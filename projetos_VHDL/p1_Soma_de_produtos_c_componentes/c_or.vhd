--
-- Disciplina: Sistemas Digitais
-- Circuito/Componente porta "OR".
-- Autor: Julio Nico Dantas dos Santos

-- Biblioteca

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Entidade

entity c_or is 

	port (
		A: in std_logic;
		B: in std_logic;
		X: out std_logic
	);

end entity c_or;

-- Arquitetura

architecture or_arch of c_or is

begin
	x <= A or B;
end;
