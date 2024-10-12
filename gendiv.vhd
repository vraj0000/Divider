library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity gendiv is
port(
--	RESET: in std_logic_vector(9 downto 0);
	CLK, Start: in std_logic;
	A, B: in std_logic_vector(63 downto 0);
	O_Q, O_R: out std_logic_vector(63 downto 0);
	Done: out std_logic
);
end entity;

architecture arch of gendiv is
	component divider
		generic(
			n : integer := 64
		);
		port(
			CLK, Start: in std_logic;
			A, B: in std_logic_vector(n-1 downto 0);
			O_Q, O_R: out std_logic_vector(n-1 downto 0);
			Done: out std_logic
		);
	end component;
begin	
divider1 : divider generic map (n => 64) port map(CLK => CLK, Start => Start, A => A, B => B, O_Q => O_Q, O_R => O_R, Done => Done);
	
end architecture;
