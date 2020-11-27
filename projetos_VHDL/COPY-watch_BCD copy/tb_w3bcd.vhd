
-- Disciplina: Sistemas Digitais
-- Circuito: Contador BCD de 3 Dígitos (TestBench).
-- Autor: Julio Nico Dantas dos Santos
-- GITHUB: https://github.com/julioNico
-------------------------------------------
--Importando Biblioteca
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--Declarando Entidade
ENTITY tb_w3bcd IS
END tb_w3bcd;

--Arquitetura de IFs entrelaçados.
ARCHITECTURE behavior OF tb_w3bcd IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT stop_watch
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            inc : IN STD_LOGIC;
            dec : IN STD_LOGIC;
            bcd2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            bcd1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            bcd0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
    --Inputs
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL inc : STD_LOGIC := '0';
    SIGNAL dec : STD_LOGIC := '0';

    --Outputs
    SIGNAL bcd2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL bcd1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL bcd0 : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Clock period definitions
    CONSTANT T : TIME := 20 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut : stop_watch PORT MAP(
        clk => clk,
        reset => reset,
        inc => inc,
        dec => dec,
        bcd2 => bcd2,
        bcd1 => bcd1,
        bcd0 => bcd0
    );

    --**************************
    -- clock
    --**************************
    -- 20 ns clock running forever
    PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR T/2;
        clk <= '1';
        WAIT FOR T/2;
    END PROCESS;
    --**************************
    -- reset
    --**************************
    -- reset asserted for T/2
    reset <= '1', '0' AFTER T/2;

    --**************************
    -- other stimulus
    --**************************
    PROCESS
    BEGIN
        --**************************
        -- test up counter
        --**************************
        dec <= '0';
        inc <= '1';
        WAIT UNTIL falling_edge(clk);
        WAIT UNTIL falling_edge(clk);
        --**************************
        -- test continuos counter
        --**************************
        dec <= '0'; -- count
        inc <= '0';
        FOR i IN 1 TO 100 LOOP -- count 1000 clocks --30us
            WAIT UNTIL falling_edge(clk);
        END LOOP;
        --**************************
        -- test down counter
        --**************************
        dec <= '1';
        inc <= '0';
        FOR i IN 1 TO 1500 LOOP -- count 1000 clocks --30us
        	wait until falling_edge(clk);
        end loop;
        --**************************
        -- other wait conditions
        --**************************
        --	-- continue until q=2
        --	wait until q="010";
        --	wait until falling_edge(clk);
        --	up <= '1';
        --	-- continue until min_tick changes value
        --	wait on min_tick;
        --	wait until falling_edge(clk);
        --	up <= '0';
        --	wait for 4*T;  -- wait for 80 ns
        --	en <= '0';
        --	wait for 4*T;
        --**************************
        -- terminate simulation
        --**************************
        ASSERT false
        REPORT "Simulation Completed"
            SEVERITY failure;
    END PROCESS;
END;