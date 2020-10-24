--------------------------------------------------------------------------------
-- Disciplina: Sistemas Digitais
-- Circuito Contador BCD de 3 Dígitos.
-- Autor: Julio Nico Dantas dos Santos
-- GITHUB: https://github.com/julioNico
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_car_detect IS
END tb_car_detect;
 
ARCHITECTURE behavior OF tb_car_detect IS    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal a : std_logic := '0';
   signal b : std_logic := '0';

 	--Outputs
   signal entrou : std_logic := '0';
   signal saiu : std_logic:= '0';

   -- Clock period definitions
   constant clk_period : time := 5 ns;
 
BEGIN
		  
	-- Instantiate the Unit Under Test (UUT)
    counter_unit : entity work.car_detect(moore_arch)
	 port map(clk, reset, a, b, entrou, saiu);
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
 
   --**************************
   -- reset
   --**************************
   -- reset asserted for clk_period/2
   reset <= '1', '0' after clk_period/2;
	
	
	-- Bateria de testes
   Battery_tests :process
   begin
		a <= '1'; 
		b <= '1';		
		wait for 20ns;
		a <= '0'; 
		b <= '1';		
		wait for 20ns;
		a <= '0'; 
		b <= '0';		
		wait for 10ns;
		a <= '0'; 
		b <= '0';		
		wait for 20ns;
		a <= '1'; 
		b <= '0';		
		wait for 20ns;

		-- terminate simulation
      assert false
         report "Simulation Completed"
         severity failure;
   end process Battery_tests;

END;
