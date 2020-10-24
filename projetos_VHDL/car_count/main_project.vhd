----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:21:38 10/24/2020 
-- Design Name: 
-- Module Name:    main_project - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_project is

    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           bcd0 : out  STD_LOGIC_VECTOR (3 downto 0);
           bcd1 : out  STD_LOGIC_VECTOR (3 downto 0);
           bcd2 : out  STD_LOGIC_VECTOR (3 downto 0));
end main_project;

architecture Behavioral of main_project is
	signal inc, dec	:	std_logic;
begin

		-- Instantiate the Unit Under Test (UUT)
    counter_unit : entity work.counter(arch)
--	 generic map(n)
	 port map(clk => clk, reset => reset, inc => inc, dec => dec, bcd2 => bcd2, bcd1 => bcd1, bcd0 => bcd0);
	 
	 	-- Instantiate the Unit Under Test (UUT)
    car_detect_unit : entity work.car_detect(moore_arch)
	 port map(clk => clk, reset => reset, a => a, b => b, entrou => inc, saiu => dec);

end Behavioral;

