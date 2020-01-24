library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_counter is
port(   clk: in std_logic;
		reset: in std_logic;
		address: out std_logic_vector(3 downto 0);
	);
end program_counter;

architecture Behavioral of program_counter is
signal: next_address : std_logic_vector(3 downto 0):= "0000"
signal: int_address: integer;
begin
	int_address = (to_integer(unsigned( next_address ))
    process(clk,reset)
    begin 
    	if reset = '1' then
    		adrs="0000";
    	end if;
        if clk='1' and clk'event then
        	next_address = std_logic_vector(to_unsigned(int_address + 4, 4));
        end if;
    end process;
    address <= next_address;
end Behavioral;