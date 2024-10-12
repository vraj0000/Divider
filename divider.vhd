library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity divider is
generic(
 n : integer := 8
 );
port(
--	RESET: in std_logic_vector(9 downto 0);
	CLK, Start: in std_logic;
	A, B: in std_logic_vector(n-1 downto 0);
	O_Q, O_R: out std_logic_vector(n-1 downto 0);
	Done: out std_logic
);
end divider;

architecture arch of divider is
	signal state, next_state: integer range 0 to 2;
	signal RA, RB: std_logic_vector(n-1 downto 0);
	signal RR, RQ: std_logic_vector(n-1 downto 0);
	signal C: integer := n;
	
	begin
	process (state, Start)
	
	begin
			case state is
				when 0 => 
					if Start = '1' then
						next_state <= 1;
					else 
						next_state <= 0;
					end if;
				when 1 =>
					next_state <= 2;
				when 2 =>
					if (c=0) then
						next_state <= 0;
					else
						next_state <= 1;
					end if;
			end case;
	end process;

	process (CLK)
	begin
	if (rising_edge(CLK)) then
		state <= next_state;
	end if;
	end process;
	process (state)
	begin
		if (state = 0) then
				RR <= (others => '0');
				RQ  <= (others => '0');
				RA <= A; RB <= B;
				c <= n;
		elsif (state = 1) then
			RR <= RR(n-2 downto 0)&RA(n-1);
			RA <= RA(n-2 downto 0)&'0';
		elsif (state = 2) then
			c <= c-1;
			if (RR >= RB) then
				RR <= RR - RB;
				RQ <= RQ(n-2 downto 0)&'1';
			else	
				RQ <= RQ(n-2 downto 0)&'0';
			end if;
		end if;
		if (c = 0) then
			Done <= '1';
			O_R <= RR;
			O_Q <= RQ;
		end if;
	end process;
end architecture;
