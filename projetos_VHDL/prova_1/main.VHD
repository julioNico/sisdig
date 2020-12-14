----------------------------------------------------------------------------------
-- Disciplina: Sistemas Digitais
-- Circuito Programa geral de multiplicação.	
-- Autor: Julio Nico Dantas dos Santos
-- GITHUB: https://github.com/julioNico
----------------------------------------------------------------------------------
-- Importando bibliotecas
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Declarando Entidade
ENTITY mult_8b_top IS
	PORT (
		clk, reset : IN STD_LOGIC;
		ps2c, ps2d : IN STD_LOGIC
	);
END mult_8b_top;

-- Definindo Arquitetura
ARCHITECTURE arch OF mult_8b_top IS
	CONSTANT KX : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00100010";
	CONSTANT KY : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00110101";
	CONSTANT KEQ : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01010101";
	CONSTANT K1 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00010110";
	CONSTANT K0 : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01000101";

	-- Multipicador signals
	SIGNAL m_z : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL m_start, m_idle, m_done : STD_LOGIC;

	-- Keyboard signals
	SIGNAL key : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL k_done, k_press : STD_LOGIC;

	-- FSM signals
	TYPE state IS (s_idle, s_lx, s_ly, s_wait_mult, s_mult);
	SIGNAL state_reg, state_next : state;
	SIGNAL x_reg, x_next, y_reg, y_next : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL z_reg, z_next : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL n_reg, n_next : unsigned(3 DOWNTO 0);

	BEGIN

	booth : ENTITY work.booth_mult_8bits(arch)
		PORT MAP(
			clk => clk,
			reset => reset,
			x_in => x_reg,
			y_in => y_reg,
			z_out => m_z,
			start => m_start,
			done => m_done,
			idle => m_idle
		);

	teclado : ENTITY work.keyboard(arch)
		PORT MAP(
			clk => clk,
			reset => reset,
			ps2c => ps2c,
			ps2d => ps2d,
			k_done_tick => k_done,
			k_press => k_press,
			k_normal => OPEN,
			key => key
		);

	PROCESS (clk, reset)
	BEGIN
		IF (reset = '1') THEN
			state_reg <= s_idle;
			x_reg <= (OTHERS => '0');
			y_reg <= (OTHERS => '0');
			z_reg <= (OTHERS => '0');
			n_reg <= (OTHERS => '0');
		ELSIF (clk'event AND clk = '1') THEN
			state_reg <= state_next;
			x_reg <= x_next;
			y_reg <= y_next;
			z_reg <= z_next;
			n_reg <= n_next;
		END IF;
	END PROCESS;

	PROCESS (state_reg, x_reg, y_reg, z_reg, n_reg, key, k_done, k_press, m_z, m_done, m_idle)
	BEGIN
		x_next <= x_reg;
		y_next <= y_reg;
		z_next <= z_reg;
		n_next <= n_reg;

		state_next <= state_reg;

		CASE state_reg IS
			WHEN s_idle =>
				IF k_done = '1' AND key = KX AND k_press = '0' THEN
					state_next <= s_lx;
					x_next <= (OTHERS => '0');
					n_next <= (OTHERS => '0');
				ELSIF k_done = '1' AND key = KY AND k_press = '0' THEN
					state_next <= s_ly;
					y_next <= (OTHERS => '0');
					n_next <= (OTHERS => '0');
				ELSIF k_done = '1' AND key = KEQ AND k_press = '0' THEN
					z_next <= (OTHERS => '0');

					IF m_idle = '1' THEN
						state_next <= s_mult;
						m_start <= '1';
					ELSE
						state_next <= s_wait_mult;
					END IF;
				END IF;
			WHEN s_lx =>
				IF n_reg < 8 THEN
					IF k_done = '1' AND k_press = '0' THEN
						n_next <= n_reg + 1;
						IF key = K1 THEN
							x_next <= x_reg(6 DOWNTO 0) & '1';
						ELSIF key = K0 THEN
							x_next <= x_reg(6 DOWNTO 0) & '0';
						ELSE
							n_next <= n_reg;
						END IF;
					END IF;
				ELSE
					state_next <= s_idle;
				END IF;
			WHEN s_ly =>
				IF n_reg < 8 THEN
					IF k_done = '1' AND k_press = '0' THEN
						n_next <= n_reg + 1;
						IF key = K1 THEN
							y_next <= y_reg(6 DOWNTO 0) & '1';
						ELSIF key = K0 THEN
							y_next <= y_reg(6 DOWNTO 0) & '0';
						ELSE
							n_next <= n_reg;
						END IF;
					END IF;
				ELSE
					state_next <= s_idle;
				END IF;
			WHEN s_wait_mult =>
				IF m_idle = '1' THEN
					state_next <= s_mult;
					m_start <= '1';
				END IF;
			WHEN s_mult =>
				IF m_done = '1' THEN
					z_next <= m_z;
					state_next <= s_idle;
				END IF;
		END CASE;
	END PROCESS;
END arch;