-- Disciplina: Sistemas Digitais
-- Circuito Contador bcd de 3 Dígitos.
-- Autor: Julio Nico Dantas dos Santos
-- GITHUB: https://github.com/julioNico
-------------------------------------------
--Importando Biblioteca
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

--Declarando Entidade
ENTITY stop_watch IS
    PORT (
        clk, reset : IN STD_LOGIC;
        inc, dec : IN STD_LOGIC;
        bcd2, bcd1, bcd0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END stop_watch;

--Arquitetura de IFs entrelaçados.
ARCHITECTURE if_arch OF stop_watch IS

    SIGNAL bcd2_reg, bcd1_reg, bcd0_reg : unsigned(3 DOWNTO 0);
    SIGNAL bcd2_next, bcd1_next, bcd0_next : unsigned(3 DOWNTO 0);
    SIGNAL aux : unsigned(1 DOWNTO 0);
   -- SIGNAL inc_ant : BIT := '0';
    --SIGNAL dec_ant : BIT := '0';

BEGIN
    -- register
    PROCESS (clk, reset)
    BEGIN
        IF (reset = '1') THEN
            bcd0_reg <= (OTHERS => '0');
            bcd1_reg <= (OTHERS => '0');
            bcd2_reg <= (OTHERS => '0');
        ELSIF (clk'event AND clk = '1') THEN
            bcd2_reg <= bcd2_next;
            bcd1_reg <= bcd1_next;
            bcd0_reg <= bcd0_next;
        END IF;
    END PROCESS;

    -- Contagem
    PROCESS (bcd0_reg, bcd1_reg, bcd2_reg, inc, dec, reset)
    BEGIN
        -- defult
        bcd0_next <= bcd0_reg;
        bcd1_next <= bcd1_reg;
        bcd2_next <= bcd2_reg;

        -- controle inc/dec
 --       IF inc = '1' and dec = '0' THEN
 --           inc_ant <= '1';
 -----           dec_ant <= '0';
  ---      ELSIF inc = '0' and dec = '1' THEN
  ---          inc_ant <= '0';
  ---          dec_ant <= '1';
    ---    END IF;  

        -- reset assincrono 
        IF reset = '1' THEN
            bcd0_next <= "0000";
            bcd1_next <= "0000";
            bcd2_next <= "0000";

            --Incrementando
        ELSIF inc = '1' THEN --Incrementando
            
            IF aux = "10" then
                bcd0_next <= bcd0_reg + 1;
                bcd1_next <= bcd1_reg + 1;
                bcd2_next <= bcd2_reg + 1;
            END IF;        

            aux <= "01";    

            --Inicia Operacao.
            IF (bcd0_reg /= 9) THEN
                bcd0_next <= bcd0_reg + 1;
            ELSE -- reach XX9
                bcd0_next <= "0000";
                IF (bcd1_reg /= 9) THEN
                    bcd1_next <= bcd1_reg + 1;
                ELSE -- reach X99
                    bcd1_next <= "0000";
                    IF (bcd2_reg /= 9) THEN
                        bcd2_next <= bcd2_reg + 1;
                    ELSE -- reach 999
                        bcd2_next <= "0000";
                    END IF;
                END IF;
            END IF;
            --Decrementando
        ELSIF dec = '1' THEN --Decrementando
            
            IF aux = "01" then
                bcd0_next <= bcd0_reg - 1;
                bcd1_next <= bcd1_reg - 1;
                bcd2_next <= bcd2_reg - 1;
            END IF;     

            aux <= "10";    

            IF (bcd0_reg /= 0) THEN
                bcd0_next <= bcd0_reg - 1;
            ELSE -- reach XX0
                bcd0_next <= "1001";
                IF (bcd1_reg /= 0) THEN
                    bcd1_next <= bcd1_reg - 1;
                ELSE -- reach X00
                    bcd1_next <= "1001";
                    IF (bcd2_reg /= 0) THEN
                        bcd2_next <= bcd2_reg - 1;
                    ELSE -- reach 0000
                        bcd2_next <= "1001";
                    END IF;
                END IF;
            END IF;
        END IF;
        --Termina Operacao.
    END PROCESS;
    -- output logic
    bcd0 <= STD_LOGIC_VECTOR(bcd0_reg);
    bcd1 <= STD_LOGIC_VECTOR(bcd1_reg);
    bcd2 <= STD_LOGIC_VECTOR(bcd2_reg);
END if_arch;