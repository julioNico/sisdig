-- Disciplina: Sistemas Digitais
-- Circuito Contador Binário.
-- Autor: Julio Nico Dantas dos Santos
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    generic(n   :   integer := 4);  -- Indica a quantidade de bits do contador
    port (
        clk, rst    : in std_logic;
        q           : out std_logic_vector(n-1 downto 0)
        );
end counter;

architecture arch of counter is

    signal q_temp   :   unsigned(n-1 downto 0);

begin

    contagem : process(clk, rst)
    begin
        -- reset assincrono
        if rst = '1' then
            q_temp <= (others => '0');
        elsif RISING_EDGE(clk) then
            if q_temp /= 9 then
					q_temp <= q_temp +1;
            else       -- unidade XX9
					q_temp <= (others => '0'); 
            end if;  
        end if;        
    end process contagem;

    q <= std_logic_vector(q_temp);

end arch; 