library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instruction_mem is
port(   clk: in std_logic;
		address: in std_logic_vector(3 downto 0);
		instruction: out std_logic_vector(31 downto 0);
	);
end instruction_mem;

architecture Behavioral of instruction_mem is
signal: addr: std_logic_vector(3 downto 0);
type mem_type is array(0 to 15) of std_logic_vector(31 downto 0);
constant mem_instr: mem_type:=(
	);

begin
	addr<=address;
	instruction <= mem_instr(to_integer(unsigned(mem_instr)));

end Behavioral;
	


if currentInst(31 downto 26)="000000" then 		-- check for addition
			-- Reading at rising edge
			if clk='1' and clk'event then
				if currentIns(5 downto 0)="----" then
					rs_val<= to_integer(unsigned(reg_file(to_integer(unsigned(currentIns(25 downto 21))))));
					rt_val<= to_integer(unsigned(reg_file(to_integer(unsigned(currentIns(20 downto 16))))));
				end if;
			end if;
			-- Writing at falling edge
			if clk='0' and clk'event then
				if currentIns(5 downto 0)="----" then
					reg_file(to_integer(unsigned(currentIns(15 downto 11)))) <= std_logic_vector(to_unsigned(rd, 32));
				end if;
			end if;
		end if;

