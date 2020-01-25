----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2020 09:57:33 PM
-- Design Name: 
-- Module Name: testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench is
--  Port ( clk : in std_logic
--         );
end testbench;

architecture Behavioral of testbench is
signal  clk : std_logic :='0';
type mem is array(0 to 999) of std_logic_vector(31 downto 0);
signal mem_arr : mem :=(    --"00100000000000110000000000000001", -- addi
                            --"10001100000000111111111111111111",  -- negative offset
                            --"10001100000000010000001111101000",
                            --"00000000000000010001000000100000",
                            --"00000000000000010001100000100010",
                            --"10101100000000110000001111101001",
                            --"00000000000000100010000001000000",
                            --"00000000000001000010100001000010" , 
                        others=> "00000000000000000000000000000000");
signal pc : integer :=0;
signal load_ins: std_logic_vector(31 downto 0):=mem_arr(0);
signal start: std_logic:='0';
begin
    dut: entity work.try(Behavioral)
        port map(clk,pc,load_ins,start);
    
    stimulus: process is
    begin
        clk_loop: for k in 0 to 997 loop
             clk<='0';
             pc<=pc+1;         
             wait for 0.1 ns;
             load_ins <= mem_arr(pc);
             clk<='1';
             wait for 0.1 ns;
        end loop clk_loop;
        clk<='0';
        pc<=pc+1;
        wait for 0.1 ns;
        load_ins <= mem_arr(pc);
        clk <= '1';
        start<='1';
        clk_loop1: for k in 0 to 100000000 loop
             clk<='0';     
             wait for 0.1 ns;
             clk<='1';
             wait for 0.1 ns;
        end loop clk_loop1;
        wait;
    end process stimulus;
end Behavioral;
