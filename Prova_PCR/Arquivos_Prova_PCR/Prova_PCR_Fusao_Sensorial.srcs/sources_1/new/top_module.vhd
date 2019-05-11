----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2019 09:15:35
-- Design Name: 
-- Module Name: top_module - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;

use work.fpupack.all;
use work.entities.all;

entity top_module is
Port (      clk   : in STD_LOGIC;
            reset : in STD_LOGIC;
            start : in STD_LOGIC;
            sw : in STD_LOGIC;
            led : out STD_LOGIC_VECTOR (15 downto 0));
end top_module;

architecture Behavioral of top_module is

signal x_IR : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal x_UL : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal saida_xf : std_logic_vector(FP_WIDTH-1 downto 0) := (others=>'0');
signal s_led   :  STD_LOGIC_VECTOR (15 downto 0);
signal ready : STD_LOGIC := '0';

signal enable : STD_LOGIC := '0';
signal addra : STD_LOGIC_VECTOR(6 DOWNTO 0):= (others=>'0');
signal douta : STD_LOGIC_VECTOR(26 DOWNTO 0):= (others=>'0');

component Fusao_sensorial is
    Port (  clk   : in STD_LOGIC;
            reset : in STD_LOGIC;
            start : in STD_LOGIC;
            x_IR  : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
            x_UL  : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
            saida_xf : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
            ready : out STD_LOGIC);
end component;

COMPONENT ROMmem_xIR
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(26 DOWNTO 0)
  );
END COMPONENT;

COMPONENT ROMmem_xUL
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(26 DOWNTO 0)
  );
END COMPONENT;
 
 signal start_f : STD_LOGIC := '0';
 signal ready_f : STD_LOGIC := '0';
 signal wait_1clk : STD_LOGIC := '0';
 
begin

      process(clk)
    begin
        if rising_edge(clk) then
             if reset = '1' then
                 s_led <= (others=>'0');
             elsif sw = '1' then
                 s_led <= "00000" & saida_xf(FP_WIDTH-1 downto 16);
             else 
                 s_led <= saida_xf(15 downto 0);
             end if;
        end if;
    end process;

    led <= s_led;


    uut: Fusao_sensorial port map(
             clk        => clk,
             reset      => reset,
             start      => start_f,
             x_IR       => x_IR,
             x_UL       => x_UL,
             saida_xf   => saida_xf,
             ready      => ready_f);

    your_instance_name1 : ROMmem_xIR
      PORT MAP (
        clka => clk,
        ena => enable,
        addra => addra,
        douta => x_IR
      );
  
    your_instance_name2 : ROMmem_xUL
        PORT MAP (
          clka => clk,
          ena => enable,
          addra => addra,
          douta => x_UL
        );
        
    --Process para contador do address
    process(clk, reset, start)
    begin
        if reset='1' then
            addra <= (others=>'0');
            start_f <= '0';
            ready <= '0';
        elsif rising_edge(clk) then
            start_f <= '0';
            --ready <= '0';
            if addra="010000101100011000000000000" then --addra=99
                ready <= '1';
            elsif start='1' then
                start_f <= '1';
            elsif ready_f = '1' then
                addra <= addra+1;
                wait_1clk <= '1';
            elsif wait_1clk = '1' then
                start_f <= '1';
            end if;
        end if;
    
    
    end process;


end Behavioral;
