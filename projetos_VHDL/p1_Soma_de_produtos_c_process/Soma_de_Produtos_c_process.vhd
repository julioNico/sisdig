-- Disciplina: Sistemas Digitais
-- Circuito/Componente porta "AND".
-- Autor: Julio Nico Dantas dos Santos

-- Biblioteca
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade
entity Soma_de_Produtos is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           X : out  STD_LOGIC);
end Soma_de_Produtos;

-- Arquitetura
architecture hardware of Soma_de_Produtos is
Begin
	process (A(0), A(1), A(2), A(3))
		begin
			if (A(0) and A(1)) = '1' then
				X <= '1';
			elsif (A(2) and A(3)) = '1' then
				X <= '1';
			else
				x <= '0';
			end if;
	end process;

end hardware;

