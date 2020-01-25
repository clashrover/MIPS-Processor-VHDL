library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity try is
port(	clk : in std_logic
	);
end try;


architecture Behavioral of try is

-- Program Counter
signal pc : integer :=0;

-- Register file
type reg_type is array(0 to 2) of std_logic_vector(31	downto 0);
signal reg_file : reg_type :=("00000000000000000000000000000001",
                              "00000000000000000000000000000010",
                              "00000000000000000000000000000000"
                );

Data Memory
--type mem is array(0 to 2) of std_logic_vector(31 downto 0);
--signal memory : mem :=(
						);

signal currentIns : std_logic_vector(31 downto 0) := "00000000000000010001000000010000";

begin
	--currentIns <= memory(pc);
	process(clk)
	begin
		if clk='1' and clk'event then

			if currentIns(31 downto 26)="000000" then 		-- check for addition
					if currentIns(5 downto 0)="100000" then
						reg_file(to_integer(unsigned(currentIns(15 downto 11)))) <= std_logic_vector(unsigned(reg_file(to_integer(unsigned(currentIns(25 downto 21))))) + unsigned(reg_file(to_integer(unsigned(currentIns(20 downto 16))))));
					end if;
			end if;

			if currentIns(31 downto 26)="000000" then 		-- check for subtraction
				if currentIns(5 downto 0)="100010" then
					reg_file(to_integer(unsigned(currentIns(15 downto 11)))) <= std_logic_vector(unsigned(reg_file(to_integer(unsigned(currentIns(25 downto 21))))) - unsigned(reg_file(to_integer(unsigned(currentIns(20 downto 16))))));
				end if;
			end if;

			if currentIns(31 downto 26)="000000" then 		-- check for sll
				if currentIns(5 downto 0)="000000" then 	--check func
					reg_file(to_integer(unsigned(currentIns(15 downto 11)))) <= shift_left(unsigned(reg_file(to_integer(unsigned(currentIns(20 downto 16))))), to_integer(reg_file(to_integer(unsigned(currentIns(10 downto 6))))));
				end if;
			end if;

			if currentIns(31 downto 26)="000000" then 		-- check for slr
				if currentIns(5 downto 0)="000010" then 	--check func
					reg_file(to_integer(unsigned(currentIns(15 downto 11)))) <= shift_right(unsigned(reg_file(to_integer(unsigned(currentIns(20 downto 16))))), to_integer(reg_file(to_integer(unsigned(currentIns(10 downto 6))))));
				end if;
			end if;

	--		if currentInst(31 downto 26)="100011" then 		-- check for lw
	--			reg_file(to_integer(unsigned(currentIns(20 downto 16)))) <= memory(to_integer(reg_file(to_integer(unsigned(currentIns(25 downto 21)))))+to_integer(unsigned(currentIns(15 downto 0))));
	--		end if;

	--		if currentInst(31 downto 26)="101011" then 		-- check for sw
	--			memory(to_integer(reg_file(to_integer(unsigned(currentIns(25 downto 21)))))+to_integer(unsigned(currentIns(15 downto 0)))) <= reg_file(to_integer(unsigned(currentIns(20 downto 16))));
	--		end if;
	
		end if;
	end process;
end Behavioral;



