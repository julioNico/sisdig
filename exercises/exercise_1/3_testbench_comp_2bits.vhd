-- Disciplina: Sistemas Digitais

-- Exercício: Modificar o testbench para o comparador de igualdade de dois bits 
-- para que seja possível testar a saída para todas as combinações da entrada.
-- (do livro FPGA Prototyping by VHDL Examples: Xilinx Spartan-3 Version)

-- Autor: Julio Nico Dantas dos Santos 
-- GitHub: https://github.com/julioNico


-- Listing 1.5
library ieee;
use ieee.std_logic_1164.all;
entity eq2_testbench is
end eq2_testbench;

architecture tb_arch of eq2_testbench is
   signal test_in0, test_in1: std_logic_vector(1 downto 0);
   signal test_out: std_logic;
begin
   -- instantiate the circuit under test
   uut: entity work.eq2(struc_arch)
      port map(a=>test_in0, b=>test_in1, aeqb=>test_out);
   -- test vector generator
   process
   begin
      --                  in1 in0 
      -- test vector 01 -> 00 00
      test_in0 <= "00";
      test_in1 <= "00"; 
      wait for 200 ns;
      -- test vector 02 -> 00 01
      test_in0 <= "01"; 
      test_in1 <= "00";
      wait for 200 ns;
      -- test vector 03 -> 00 10
      test_in0 <= "10";
      test_in1 <= "00";
      wait for 200 ns;
      -- test vector 04 -> 00 11
      test_in0 <= "11";
      test_in1 <= "00";
      wait for 200 ns;
      -- test vector 05 -> 01 00
      test_in0 <= "00";
      test_in1 <= "01";
      wait for 200 ns;
      -- test vector 06 -> 01 01
      test_in0 <= "01";
      test_in1 <= "01";
      wait for 200 ns;
      -- test vector 07 -> 01 10
      test_in0 <= "10";
      test_in1 <= "01";
      wait for 200 ns;
      -- test vector 08 -> 01 11
      test_in0 <= "11";
      test_in1 <= "01";
      wait for 200 ns;
      -- test vector 09 -> 01 11
      test_in0 <= "11";    
      test_in1 <= "01";    
      wait for 200 ns;      
      -- test vector 10 -> 10 00
      test_in0 <= "00";
      test_in1 <= "10";
      wait for 200 ns;
      -- test vector 11 -> 10 01
      test_in0 <= "01";
      test_in1 <= "10";
      wait for 200 ns;
      -- test vector 12 -> 10 10
      test_in0 <= "10";
      test_in1 <= "10";
      wait for 200 ns;
      -- test vector 13 -> 10 11
      test_in0 <= "11";
      test_in1 <= "10";
      wait for 200 ns;
      -- test vector 14 -> 11 00
      test_in0 <= "00";
      test_in1 <= "11";
      wait for 200 ns;
      -- test vector 15 -> 11 01
      test_in0 <= "01";
      test_in1 <= "11";
      wait for 200 ns;
      -- test vector 16 -> 11 10
      test_in0 <= "10";
      test_in1 <= "11";
      wait for 200 ns;
      -- test vector 16 -> 11 11
      test_in0 <= "11";
      test_in1 <= "11";
      wait for 200 ns;                                                                          
      -- terminate simulation
      assert false
         report "Simulation Completed"
       severity failure;
   end process;
end tb_arch;