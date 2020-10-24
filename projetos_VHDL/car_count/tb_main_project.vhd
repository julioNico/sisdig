--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:30:52 10/24/2020
-- Design Name:   
-- Module Name:   /home/julio/opt/14.7/ISE_DS/projetos/controle_de_estacionamento/tb_main_project.vhd
-- Project Name:  controle_de_estacionamento
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: main_project
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_main_project IS
END tb_main_project;
 
ARCHITECTURE behavior OF tb_main_project IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main_project
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         a : IN  std_logic;
         b : IN  std_logic;
         bcd0 : OUT  std_logic_vector(3 downto 0);
         bcd1 : OUT  std_logic_vector(3 downto 0);
         bcd2 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal a : std_logic := '0';
   signal b : std_logic := '0';

 	--Outputs
   signal bcd0 : std_logic_vector(3 downto 0);
   signal bcd1 : std_logic_vector(3 downto 0);
   signal bcd2 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main_project PORT MAP (
          clk => clk,
          reset => reset,
          a => a,
          b => b,
          bcd0 => bcd0,
          bcd1 => bcd1,
          bcd2 => bcd2
        );

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
		wait for 20ns;
		a <= '0'; 
		b <= '1';	
		wait for 20ns;
		a <= '0'; 
		b <= '0';	
		wait for 20ns;
		a <= '1'; 
		b <= '0';
		wait for 20ns;
		a <= '0'; 
		b <= '1';	
		wait for 20ns;
		-- terminate simulation
      assert false
         report "Simulation Completed"
         severity failure;
   end process Battery_tests;


END;
