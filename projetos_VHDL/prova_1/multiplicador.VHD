----------------------------------------------------------------------------------
-- Disciplina: Sistemas Digitais
-- Circuito Multiplicador de números em complemento de dois.
-- Autor: Julio Nico Dantas dos Santos
-- GITHUB: https://github.com/julioNico
----------------------------------------------------------------------------------
--importando bibliotecas
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--declarando entidade
ENTITY booth_mult_8bits IS
    PORT (
        clk, reset : IN STD_LOGIC;
        start : IN STD_LOGIC;
        x_in, y_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        idle, done : OUT STD_LOGIC;
        z_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));

END booth_mult_8bits;

--Definindo Arquitetura
ARCHITECTURE arch OF booth_mult_8bits IS
    TYPE state IS (s_idle, s_shift, s_done);
    SIGNAL state_reg, state_next : state;
    SIGNAL x_reg, x_next, inv_x_reg : unsigned(7 DOWNTO 0);
    SIGNAL p_reg, p_next : unsigned(16 DOWNTO 0);
    SIGNAL sum : unsigned(7 DOWNTO 0);
    SIGNAL n_reg, n_next : unsigned(3 DOWNTO 0);
BEGIN
   -- state and data registers
    PROCESS (clk, reset)
    BEGIN
        IF (reset = '1') THEN
            state_reg <= s_idle;
            x_reg <= (OTHERS => '0');
            p_reg <= (OTHERS => '0');
            n_reg <= (OTHERS => '0');
        ELSIF (clk'event AND clk = '1') THEN
            state_reg <= state_next;
            x_reg <= x_next;
            p_reg <= p_next;
            n_reg <= n_next;
        END IF;
    END PROCESS;

    inv_x_reg <= unsigned(NOT x_reg) + 1;

    sum <= (p_reg(16 DOWNTO 9) + inv_x_reg) WHEN p_reg(1 DOWNTO 0) = "10" ELSE
        (p_reg(16 DOWNTO 9) + x_reg) WHEN p_reg(1 DOWNTO 0) = "01" ELSE
        p_reg(16 DOWNTO 9);

   -- combinational circuit
    PROCESS (state_reg, x_reg, p_reg, n_reg, sum, x_in, y_in, start)
    BEGIN
        state_next <= state_reg;
        x_next <= x_reg;
        p_next <= p_reg;
        n_next <= n_reg;

        done <= '0';
        idle <= '0';

        CASE state_reg IS
            WHEN s_idle =>
                idle <= '1';
                IF start = '1' THEN
                    state_next <= s_shift;
                    x_next <= unsigned(x_in);
                    p_next <= unsigned("00000000" & y_in & '0');
                    n_next <= (OTHERS => '0');
                END IF;
            WHEN s_shift =>
                IF n_reg < 8 THEN
                    p_next <= sum(7) & sum & p_reg(8 DOWNTO 1);
                    n_next <= n_reg + 1;
                ELSE
                    state_next <= s_done;
                END IF;
            WHEN s_done =>
                done <= '1';
                state_next <= s_idle;
        END CASE;
    END PROCESS;

    -- Saida
    z_out <= STD_LOGIC_VECTOR(p_reg(16 DOWNTO 1));

END arch;