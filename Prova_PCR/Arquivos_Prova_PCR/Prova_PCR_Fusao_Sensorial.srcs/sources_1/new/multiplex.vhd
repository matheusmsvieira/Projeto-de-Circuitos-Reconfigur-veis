----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 23:59:43
-- Design Name: 
-- Module Name: multiplex - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.fpupack.all;

entity multiplex is
    Port ( reset        :  in  STD_LOGIC;
           sel   		:  in  STD_LOGIC;
           in_A     	:  in std_logic_vector(FP_WIDTH-1 downto 0);
           in_B     	:  in std_logic_vector(FP_WIDTH-1 downto 0);
           outmux_2to1  :  out std_logic_vector(FP_WIDTH-1 downto 0));
end multiplex;

architecture Behavioral of multiplex is

begin

    process(reset, sel, in_A, in_B)
    begin
	   if reset='1' then
	       outmux_2to1 <= in_A;
	   elsif sel='0' then
	       outmux_2to1 <= in_A;
	   else
	       outmux_2to1 <= in_B;
	   end if;
	end process;

end Behavioral;
