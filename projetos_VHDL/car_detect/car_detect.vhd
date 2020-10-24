--------------------------------------------------------------------------------
-- Disciplina: Sistemas Digitais
-- Circuito Detector de carros.
-- Autor: Julio Nico Dantas dos Santos
-- GITHUB: https://github.com/julioNico
-------------------------------------------
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY car_detect IS
    PORT (
        clk, reset : IN STD_LOGIC;
        a, b : IN STD_LOGIC;
        entrou, saiu : OUT STD_LOGIC
    );
END car_detect;

ARCHITECTURE moore_arch OF car_detect IS
    TYPE state_type IS (idle, verify);
    SIGNAL state_reg, state_next : state_type;
BEGIN
    -- state register
    PROCESS (clk, reset)
    BEGIN
        IF (reset = '1') THEN
            state_reg <= idle;
        ELSIF RISING_EDGE(clk) THEN
            state_reg <= state_next;
        END IF;
    END PROCESS;
    -- next-state/output logic
    PROCESS (state_reg, a, b)
    BEGIN
        state_next <= state_reg;
        CASE state_reg IS
            WHEN idle =>
                IF a = '1' OR b = '1' THEN
                    state_next <= verify;
                END IF;
            WHEN verify =>
                IF a = '0' AND b = '1' THEN
                    state_next <= idle;
                    entrou <= '1';
                    saiu <= '0';
                    
                ELSIF a = '1' AND b = '0' THEN
                    state_next <= idle;
                    entrou <= '0';
                    saiu <= '1';                    
                ELSIF a = '0' AND b = '0' THEN
                    state_next <= idle;
                    entrou <= '0';
                    saiu <= '0';
                ELSIF a = '1' AND b = '1' THEN
                    state_next <= idle;
                    entrou <= '0';
                    saiu <= '0';
                END IF;
        END CASE;
    END PROCESS;
END moore_arch;