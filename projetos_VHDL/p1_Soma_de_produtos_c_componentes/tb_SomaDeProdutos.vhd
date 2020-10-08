
-- Disciplina: Sistemas Digitais
-- Circuito Soma de produtos (Componentes).
-- Autor: Julio Nico Dantas dos Santos

-- Biblioteca
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Entidade
ENTITY tb_SomaDeProdutos IS
END tb_SomaDeProdutos;
 
ARCHITECTURE behavior OF tb_SomaDeProdutos IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Soma_de_produtos
    PORT(
         IN1 : IN  std_logic;
         IN2 : IN  std_logic;
         IN3 : IN  std_logic;
         IN4 : IN  std_logic;
         OUT1 : OUT  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal IN1 : std_logic := '0';
   signal IN2 : std_logic := '0';
   signal IN3 : std_logic := '0';
   signal IN4 : std_logic := '0';

 	--Outputs
   signal OUT1 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Soma_de_produtos PORT MAP (
          IN1 => IN1,
          IN2 => IN2,
          IN3 => IN3,
          IN4 => IN4,
          OUT1 => OUT1
        );

   -- Stimulus process
   Battery_Tests: process
   begin		
      -- test vector 1
      IN1 <= '0';
      IN2 <= '0';
		IN3 <= '0';
      IN4 <= '0';
      wait for 200 ns;
      -- test vector 2
      IN1 <= '1';
      IN2 <= '1';
		IN3 <= '1';
      IN4 <= '1';
      wait for 200 ns;
      -- test vector 3
      IN1 <= '1';
      IN2 <= '0';
		IN3 <= '1';
      IN4 <= '0';
      wait for 200 ns;
      -- test vector 4
      IN1 <= '1';
      IN2 <= '1';
		IN3 <= '0';
      IN4 <= '1';
      wait for 200 ns;
      -- test vector 5
      IN1 <= '0';
      IN2 <= '0';
		IN3 <= '1';
      IN4 <= '1';
      wait for 200 ns;
      -- terminate simulation
      assert false
         report "Simulation Completed"
         severity failure;
   end process Battery_Tests;

END;
