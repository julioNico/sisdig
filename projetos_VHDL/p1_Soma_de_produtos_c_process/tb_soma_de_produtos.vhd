
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY tb_soma_de_produtos IS
END tb_soma_de_produtos;
 
ARCHITECTURE behavior OF tb_soma_de_produtos IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Soma_de_Produtos
    PORT(
         A : IN  std_logic_vector(3 downto 0):= "0000";
         X : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal X : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Soma_de_Produtos PORT MAP (
          A => A,
          X => X
        );

   -- Bateria de testes
   Battery_tests :process
   begin
		wait for 200ns;
		A <= "1100";
		wait for 200ns;
		A <= "0110";
		wait for 200ns;
		A <= "0000";
		wait for 200ns;
		A <= "0011";
		wait;
   end process Battery_tests;

END;
