
-- Disciplina: Sistemas Digitais
-- Circuito Soma de produtos (Componentes).
-- Autor: Julio Nico Dantas dos Santos

-- Biblioteca
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade

entity Soma_de_produtos is
   Port ( 
		IN1 : in  STD_LOGIC;
		IN2 : in  STD_LOGIC;
		IN3 : in  STD_LOGIC;
		IN4 : in  STD_LOGIC;
		OUT1 : out  STD_LOGIC
	);
end entity Soma_de_produtos;

-- Arquitetura

architecture sp_arch of Soma_de_produtos is
		
		-- Componentes
		component c_or is
			port(
					A: in std_logic;
					B: in std_logic;
					X: out std_logic
			);
		end component c_or;

		component c_and is
			port(
				A: in std_logic;
				B: in std_logic;
				X: out std_logic
			);
		end component c_and;
		
		-- Linhas de conexão
		signal Linha_1, Linha_2 : std_logic;

-- Mapeamento do circuito.		
begin

G1: c_and port map(A => IN1, B => IN2, X => Linha_1);
G2: c_and port map(A => IN3, B => IN4, X => Linha_2);
G3: c_or  port map (A => Linha_1, B => Linha_2, X => OUT1);

end architecture sp_arch;

