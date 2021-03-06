--------------------------------------------------------------------------------
-- Disciplina: Sistemas Digitais
-- Circuito Contador BCD de 3 Dígitos.
-- Autor: Julio Nico Dantas dos Santos
-- GITHUB: https://github.com/julioNico
-------------------------------------------
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_counter IS
END tb_counter;
 
ARCHITECTURE behavior OF tb_counter IS 
	constant n  :   integer := 4; -- quantidade de bits do contador (DUT)

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
	signal inc : std_logic := '0';
	signal dec : std_logic := '0';

 	--Outputs
   signal bcd0 : std_logic_vector(3 downto 0) := (others => '0');
   signal bcd1 : std_logic_vector(3 downto 0) := (others => '0');
	signal bcd2 : std_logic_vector(3 downto 0) := (others => '0');
	
   -- Clock period definitions
   constant clk_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    counter_unit : entity work.counter(arch)
	 generic map(n)
	 port map(clk, reset, inc, dec, bcd2, bcd1, bcd0);


   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
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
		inc <= '1'; 
		dec <= '1';		
		wait for clk_period;
		inc <= '1'; 
		dec <= '0';		
		wait for 5us;
		inc <= '0'; 
		dec <= '0';		
		wait for 5us;
		inc <= '0'; 
		dec <= '1';		
		wait for 10us;

		-- terminate simulation
      assert false
         report "Simulation Completed"
         severity failure;
   end process Battery_tests;

END;
