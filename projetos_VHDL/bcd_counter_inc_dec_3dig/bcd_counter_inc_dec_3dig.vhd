-- Disciplina: Sistemas Digitais
-- Circuito Contador BCD de 3 Dígitos.
-- Autor: Julio Nico Dantas dos Santos
-- GITHUB: https://github.com/julioNico
-------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY counter IS
    GENERIC (n : INTEGER := 4); -- Indica a quantidade de bits do contador
    PORT (
        clk, reset, inc, dec : IN STD_LOGIC;
        bcd2, bcd1, bcd0 : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
    );
END counter;

ARCHITECTURE arch OF counter IS

    SIGNAL d0_reg, d1_reg, d2_reg : unsigned(n - 1 DOWNTO 0);
    SIGNAL d0_next, d1_next, d2_next : unsigned(n - 1 DOWNTO 0);
    SIGNAL inc_ant : BIT;
    SIGNAL dec_ant : BIT;
BEGIN

    clock_reset : PROCESS (clk, reset)
    BEGIN
        -- Clock de subida
        IF RISING_EDGE(clk) THEN
            d2_reg <= d2_next;
            d1_reg <= d1_next;
            d0_reg <= d0_next;
        END IF;

        -- reset assincrono
        IF reset = '1' THEN
            d0_reg <= (OTHERS => '0');
            d1_reg <= (OTHERS => '0');
            d2_reg <= (OTHERS => '0');
        END IF;
    END PROCESS;

    contagem : PROCESS (d0_reg, d1_reg, d2_reg, inc, dec)
    BEGIN
        -- defult
        d0_next <= d0_reg;
        d1_next <= d1_reg;
        d2_next <= d2_reg;
        -- Controle de inc e dec após inc == 0 e dec == 0;
        IF inc = '1' AND dec = '0' THEN
            inc_ant <= '1';
            dec_ant <= '0';
        ELSIF inc = '0' AND dec = '1' THEN
            inc_ant <= '0';
            dec_ant <= '1';
        END IF;
        --incrementa
        IF inc_ant = '1' THEN

            -- unidade XX9
            IF d0_next /= 9 THEN
                d0_next <= d0_next + 1;
            ELSE
                d0_next <= (OTHERS => '0');

                -- unidade X99
                IF d1_next /= 9 THEN
                    d1_next <= d1_next + 1;
                ELSE
                    d1_next <= (OTHERS => '0');

                    -- unidade 999
                    IF d2_next /= 9 THEN
                        d2_next <= d2_next + 1;
                    ELSE
                        d2_next <= (OTHERS => '0');
                    END IF;
                END IF;
            END IF;
        END IF;
            --decrementa
            -------------------
            IF dec_ant = '1' THEN

                -- unidade XX9
                IF d0_next /= 0 THEN
                    d0_next <= d0_next - 1;
                ELSE
                    d0_next <= "1001";

                    -- unidade X99
                    IF d1_next /= 0 THEN
                        d1_next <= d1_next - 1;
                    ELSE
                        d1_next <= "1001";

                        -- unidade 999
                        IF d2_next /= 0 THEN
                            d2_next <= d2_next - 1;
                        ELSE
                            d2_next <= "1001";
                        END IF;
                    END IF;
                END IF;
            END IF;
        END PROCESS contagem;

            bcd0 <= STD_LOGIC_VECTOR(d0_next);
            bcd1 <= STD_LOGIC_VECTOR(d1_next);
            bcd2 <= STD_LOGIC_VECTOR(d2_next);
        END arch;