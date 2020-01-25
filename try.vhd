library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity try is
port(	clk : in std_logic;
        address: in integer;
        ins: in std_logic_vector(31 downto 0);
        start: in std_logic
	);
end try;


architecture Behavioral of try is

-- Program Counter
signal pc : integer :=0;

-- Register file
type reg_type is array(0 to 31) of std_logic_vector(31	downto 0);
signal reg_file : reg_type :=(--"00000000000000000000001111101001",
                              others => "00000000000000000000000000000000"
                );
                
--:=("00000000000000000000000000000000",
--                                              "00000000000000000000000000000010",
--                                              "00000000000000000000000000000000",
--                                              "00000000000000000000000000001000",
--                                              others => "00000000000000000000000000000000"
--                                );
type stype is (load,run);
signal state : stype := load;
 
--Data Memory
type mem is array(0 to 3999) of std_logic_vector(31 downto 0);
signal memory_arr : mem :=(  --1000 => "00000000000000000000000000000001",
                         others => "00000000000000000000000000000000"
						);

--(  "00000000001000110001000000100010",
--                         others => "00000000000000000000000000000000"
--						);

signal currentIns : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";

--10101100001000100000000000000001  sw $2, mem($1 + 1)
--000000,00011,00001,00010,00000,100010  SUB $2 , $3, $1
--000000,00011,00001,00010,00000,100000  ADD $2 , $3, $1
--000000,00001,00011,00010,00000,100010  SUB $2 , $1, $3 
--100011,00000,00001,0000001111101000  lw $1, mem($0 + 1000)
--000000,00000,00010,00100,00010,000000  shift left $t2 by 2 and put into $t4
--000000,00000,00100,00101,00001,000010  shift right $t4 by 1 and put into $t5
signal check: integer :=0;

begin
    currentIns <= memory_arr(pc);
	process(clk)
	begin
	    if state = load then
	       memory_arr(address) <= ins;
	       if start = '1' then
                state <= run;
           end if;
	    end if;
	    if state = run then
            if clk='1' and clk'event then
                if unsigned(currentIns(31 downto 0))="00000000000000000000000000000000" then
                
                elsif unsigned(currentIns(31 downto 26))="000000" and unsigned(currentIns(5 downto 0))="100000" then 		-- check for addition
                    reg_file(to_integer(unsigned(currentIns(15 downto 11)))) <= std_logic_vector(signed(reg_file(to_integer(unsigned(currentIns(25 downto 21))))) + signed(reg_file(to_integer(unsigned(currentIns(20 downto 16))))));
                    pc <= pc+1;
                elsif unsigned(currentIns(31 downto 26))="000000" and unsigned(currentIns(5 downto 0))="100010" then 		-- check for subtraction
                    reg_file(to_integer(unsigned(currentIns(15 downto 11)))) <= std_logic_vector(signed(reg_file(to_integer(unsigned(currentIns(25 downto 21))))) - signed(reg_file(to_integer(unsigned(currentIns(20 downto 16))))));
                    pc <= pc+1;
                elsif unsigned(currentIns(31 downto 26))="000000" and unsigned(currentIns(5 downto 0))="000000" then 		-- check for sll
                    reg_file(to_integer(unsigned(currentIns(15 downto 11)))) <= std_logic_vector(shift_left(unsigned(reg_file(to_integer(unsigned(currentIns(20 downto 16))))), (to_integer(unsigned(currentIns(10 downto 6))))));
                    pc <= pc+1;
                elsif unsigned(currentIns(31 downto 26))="000000" and unsigned(currentIns(5 downto 0))="000010" then 		-- check for slr
                    reg_file(to_integer(unsigned(currentIns(15 downto 11)))) <= std_logic_vector(shift_right(unsigned(reg_file(to_integer(unsigned(currentIns(20 downto 16))))), (to_integer(unsigned(currentIns(10 downto 6))))));
                    pc <= pc+1;
                elsif unsigned(currentIns(31 downto 26))="100011" then 		-- check for lw
                    reg_file(to_integer(unsigned(currentIns(20 downto 16)))) <= memory_arr(to_integer(unsigned(reg_file(to_integer(unsigned(currentIns(25 downto 21))))))+to_integer(signed(currentIns(15 downto 0))));
                    pc <= pc+1;
                elsif unsigned(currentIns(31 downto 26))="101011" then 		-- check for sw
                    memory_arr(to_integer(unsigned(reg_file(to_integer(unsigned(currentIns(25 downto 21))))))+to_integer(signed(currentIns(15 downto 0)))) <= reg_file(to_integer(unsigned(currentIns(20 downto 16))));
                    pc <= pc+1;
                elsif unsigned(currentIns(31 downto 26))="001000" then 		-- check for sw
                    reg_file(to_integer(unsigned(currentIns(20 downto 16)))) <= std_logic_vector(signed(reg_file(to_integer(unsigned(currentIns(25 downto 21))))) + to_integer(unsigned(currentIns(15 downto 0))));
                    pc <= pc+1;
                end if;
            end if;
        end if;
	end process;
end Behavioral;


