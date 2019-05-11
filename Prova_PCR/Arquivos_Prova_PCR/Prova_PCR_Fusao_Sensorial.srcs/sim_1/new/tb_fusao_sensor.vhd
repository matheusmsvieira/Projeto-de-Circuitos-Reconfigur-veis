----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2019 11:05:56
-- Design Name: 
-- Module Name: tb_fusao_sensor - Behavioral
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
use std.textio.all;
use IEEE.std_logic_textio.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;
use work.fpupack.all;

entity tb_fusao_sensor is
--  Port ( );
end tb_fusao_sensor;

architecture Behavioral of tb_fusao_sensor is

signal reset : std_logic := '0';
signal clk : std_logic := '0';
signal start : std_logic := '0';
signal x_IR_bin : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal x_UL_bin : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal x_IR : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal x_UL : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');

signal saida_xf : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal ready : std_logic := '0';

 signal start_f : STD_LOGIC := '0';
 signal ready_f : STD_LOGIC := '0';
 signal wait_1clk : STD_LOGIC := '0';

-- conter for WOMenable
signal WOMenable : std_logic := '0';

--component top_module is
--Port (      clk   : in STD_LOGIC;
--            reset : in STD_LOGIC;
--            start : in STD_LOGIC;
--            saida_xf : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
--            ready : out STD_LOGIC);
--end component;

component Fusao_sensorial is
    Port (  clk   : in STD_LOGIC;
            reset : in STD_LOGIC;
            start : in STD_LOGIC;
            x_IR  : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
            x_UL  : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
            saida_xf : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
            ready : out STD_LOGIC);
end component;

signal first_start : std_logic := '0';
signal next_start : std_logic := '0';

signal ROMaddress : std_logic_vector(7 downto 0) := (others=>'0');

begin

    -- reset generator
    reset <= '0', '1' after 15 ns, '0' after 25 ns;
    
    -- clock generator
    clk <= not clk after 5 ns; 
    
    -- cria o start 
    first_start <= '0', '1' after 30 ns, '0' after 40 ns; 
    
    uut: Fusao_sensorial port map(
             clk        => clk,
             reset      => reset,
             start      => start,
             x_IR       => x_IR,
             x_UL       => x_UL,
             saida_xf   => saida_xf,
             ready      => ready);
             
        x_IR <= x_IR_bin;
        x_UL <= x_UL_bin;
    
    rom_xIR: process
             file infile    : text is in "x_IR.txt"; -- input file declaration
             variable inline : line; -- line number declaration
             variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
             begin
                 while (not endfile(infile)) loop
                     wait until rising_edge(clk);
                         if first_start='1' or ready='1' then
                             readline(infile, inline);
                             read(inline,dataf);
                             x_IR_bin <= dataf;
                             start <= '1';
                         else
                             start <= '0';
                         end if;
                 end loop;
                 assert not endfile(infile) report "FIM DA LEITURA" severity warning;
                 wait;        
             end process;
             
    rom_xUL: process
             file infile    : text is in "x_UL.txt"; -- input file declaration
             variable inline : line; -- line number declaration
             variable dataf  : std_logic_vector(FP_WIDTH-1 downto 0); 
             begin
                 while (not endfile(infile)) loop
                     wait until rising_edge(clk);
                         if first_start='1' or ready='1' then
                             readline(infile, inline);
                             read(inline,dataf);
                             x_UL_bin <= dataf;
                         end if;
                 end loop;
                 assert not endfile(infile) report "FIM DA LEITURA" severity warning;
                 wait;        
             end process;
             
    WOMenable <= ready;
             
             wom_n1 : process(clk) 
             variable out_line : line;
             file out_file     : text is out "res_FS.txt";
             begin
                 -- write line to file every clock
                 if (rising_edge(clk)) then
                     if WOMenable = '1' then
                         write (out_line, saida_xf);
                         writeline (out_file, out_line);
                     end if; 
                 end if;  
             end process ;

end Behavioral;
