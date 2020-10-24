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

    SIGNAL q0_reg : unsigned(n - 1 DOWNTO 0);
    SIGNAL q1_reg : unsigned(n - 1 DOWNTO 0);
    SIGNAL q2_reg : unsigned(n - 1 DOWNTO 0);
	SIGNAL inc_ant: BIT;
	SIGNAL dec_ant: BIT;	 
BEGIN

    contagem : PROCESS (clk, reset, inc, dec)
    BEGIN
        -- reset assincrono
        IF inc = '1' and dec = '0' THEN
        inc_ant <= '1';
        dec_ant <= '0';
        ELSIF inc = '0' and dec = '1' THEN
        inc_ant <= '0';
        dec_ant <= '1';
        END IF;        
        -- reset assincrono
        IF reset = '1' THEN
            q0_reg <= (OTHERS => '0');
            q1_reg <= (OTHERS => '0');
            q2_reg <= (OTHERS => '0');
        ELSIF RISING_EDGE(clk) THEN
            --incrementa
            IF inc_ant = '1' THEN

                -- unidade XX9
                IF q0_reg /= 9 THEN
                    q0_reg <= q0_reg + 1;
                ELSE
                    q0_reg <= (OTHERS => '0');

                    -- unidade X99
                    IF q1_reg /= 9 THEN
                        q1_reg <= q1_reg + 1;
                    ELSE
                        q1_reg <= (OTHERS => '0');

                        -- unidade 999
                        IF q2_reg /= 9 THEN
                            q2_reg <= q2_reg + 1;
                        ELSE
                            q2_reg <= (OTHERS => '0');
                        END IF;
                    END IF;
                END IF;
            END IF;
            --decrementa
            -------------------
            IF dec_ant = '1' THEN

                -- unidade XX9
                IF q0_reg /= 0 THEN
                    q0_reg <= q0_reg - 1;
                ELSE
                    q0_reg <= "1001";

                    -- unidade X99
                    IF q1_reg /= 0 THEN
                        q1_reg <= q1_reg - 1;
                    ELSE
                        q1_reg <= "1001";

                        -- unidade 999
                        IF q2_reg /= 0 THEN
                            q2_reg <= q2_reg - 1;
                        ELSE
                            q2_reg <= "1001";
                        END IF;
                    END IF;
                END IF;
            END IF;            
        END IF;
    END PROCESS contagem;

    bcd0 <= STD_LOGIC_VECTOR(q0_reg);
    bcd1 <= STD_LOGIC_VECTOR(q1_reg);
    bcd2 <= STD_LOGIC_VECTOR(q2_reg);
END arch;