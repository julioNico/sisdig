----------------------------------------------------------------------------------
-- Disciplina: Sistemas Digitais
-- Circuito de Interface Teclado PS2.	
-- Autor: Julio Nico Dantas dos Santos
-- GITHUB: https://github.com/julioNico
----------------------------------------------------------------------------------
-- importando bibliotecas
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- declarando entidade
ENTITY keyboard IS
    PORT (
        clk, reset : IN STD_LOGIC;
        ps2d, ps2c : IN STD_LOGIC;
        k_done_tick, k_press, k_normal : OUT STD_LOGIC;
        key : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
END keyboard;

-- Definindo Arquitetura
ARCHITECTURE arch OF keyboard IS
    TYPE state IS (si, smk, sb, se);
    SIGNAL state_reg, state_next : state;

    CONSTANT BRK : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11110000";
    CONSTANT EXD : STD_LOGIC_VECTOR(7 DOWNTO 0) := "11100000";
    SIGNAL input : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL input_done : STD_LOGIC;

    SIGNAL key_reg, key_next : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL normal_reg, normal_next : STD_LOGIC;
    SIGNAL press_reg, press_next : STD_LOGIC;
BEGIN
    receiver : ENTITY work.ps2_rx(arch)
        PORT MAP(
            clk => clk,
            reset => reset,
            ps2c => ps2c,
            ps2d => ps2d,
            rx_done_tick => input_done,
            dout => input,
            rx_en => '1'
        );

    PROCESS (clk, reset)
    BEGIN
        IF (reset = '1') THEN
            key_reg <= "00000000";
            state_reg <= smk;
            normal_reg <= '1';
            press_reg <= '1';
        ELSIF (clk'event AND clk = '1') THEN
            key_reg <= key_next;
            state_reg <= state_next;
            normal_reg <= normal_next;
            press_reg <= press_next;
        END IF;
    END PROCESS;

    -- Lógica de Funcionamento
    PROCESS (key_reg, state_reg, normal_reg, press_reg, input, input_done)
    BEGIN
        key_next <= key_reg;
        state_next <= state_reg;
        normal_next <= normal_reg;
        press_next <= press_reg;

        -- Saidas padrao
        k_done_tick <= '0';

        CASE state_reg IS
            WHEN si =>
                IF input_done = '1' THEN
                    IF input = BRK THEN
                        normal_next <= '1';
                        press_next <= '0';
                        state_next <= sb;
                    ELSIF input = EXD THEN
                        normal_next <= '0';
                        state_next <= se;
                    ELSE
                        key_next <= input;
                        press_next <= '1';
                        normal_next <= '1';
                        state_next <= smk;
                    END IF;
                END IF;
            WHEN se =>
                normal_next <= '0';

                IF input_done = '1' THEN
                    IF input = BRK THEN
                        press_next <= '0';
                        state_next <= sb;
                    ELSE
                        press_next <= '1';
                        key_next <= input;
                        state_next <= smk;
                    END IF;
                END IF;
            WHEN sb =>
                press_next <= '0';

                IF input_done = '1' THEN
                    key_next <= input;
                    state_next <= smk;
                END IF;
            WHEN smk =>
                k_done_tick <= '1';

                IF input_done = '1' THEN
                    IF input = BRK THEN
                        normal_next <= '1';
                        press_next <= '0';
                        state_next <= sb;
                    ELSIF input = EXD THEN
                        normal_next <= '0';
                        state_next <= se;
                    ELSE
                        key_next <= input;
                        press_next <= '1';
                        normal_next <= '1';
                    END IF;
                ELSE
                    press_next <= '1';
                    normal_next <= '1';
                    state_next <= si;
                END IF;
        END CASE;
    END PROCESS;

    key <= key_reg;
    k_press <= press_reg;
    k_normal <= normal_reg;
END arch;