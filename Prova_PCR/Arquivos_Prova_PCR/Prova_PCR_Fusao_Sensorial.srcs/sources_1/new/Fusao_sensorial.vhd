----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 08:47:18
-- Design Name: 
-- Module Name: Fusao_sensorial - Behavioral
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


entity Fusao_sensorial is
    Port (  clk   : in STD_LOGIC;
            reset : in STD_LOGIC;
            start : in STD_LOGIC;
            x_IR  : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
            x_UL  : in STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
            saida_xf : out STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0);
            ready : out STD_LOGIC);
end Fusao_sensorial;

architecture Behavioral of Fusao_sensorial is

constant sigma_z : std_logic_vector(FP_WIDTH-1 downto 0) := "001111110000000000000000000";--0.5
constant sigma_k_i : std_logic_vector(FP_WIDTH-1 downto 0) := "001111011100110011001100110";--0.1
signal sigma_kmais1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');
signal sigma_k : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');

signal outadd_0 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');
signal outdiv_0 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');
--saida do divisor é o sinal Gk+1
signal outmul_0 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');
signal outsub_0 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');
signal outsub_1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');
signal outmul_1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');
signal outadd_1 : STD_LOGIC_VECTOR (FP_WIDTH-1 downto 0) := (others=>'0');

signal rdyadd_0 : std_logic := '0';
signal rdydiv_0 : std_logic := '0';
signal rdymul_0 : std_logic := '0';
signal rdysub_0 : std_logic := '0';
signal rdysub_1 : std_logic := '0';
signal rdymul_1 : std_logic := '0';
signal rdyadd_1 : std_logic := '0';

component multiplex 
    Port ( reset        :  in  STD_LOGIC;
           sel   		:  in  STD_LOGIC;
           in_A     	:  in std_logic_vector(FP_WIDTH-1 downto 0);
           in_B     	:  in std_logic_vector(FP_WIDTH-1 downto 0);
           outmux_2to1  :  out std_logic_vector(FP_WIDTH-1 downto 0));
end component;

begin

    mux: multiplex port map( 
        reset   => reset,
        sel 	=> rdysub_0,
        in_A     	=> sigma_k_i,
        in_B     	=> sigma_kmais1,
        outmux_2to1  => sigma_k);

    add0: addsubfsm_v6 port map(
		reset 	 => reset,
		clk	 	 => clk,   
		op	 	    => '0',   
		op_a	 	 => sigma_z,
		op_b	 	 => sigma_k,
		start_i	 => start,
		addsub_out   => outadd_0,
		ready_as	 => rdyadd_0);
		
    div: divNR port map(
	    reset      => reset,
        clk        => clk,
        op_a         => sigma_k,
        op_b         => outadd_0,
        start_i    => rdyadd_0,
        div_out    => outdiv_0,-- Gk+1
        ready_div  => rdydiv_0);
        
    mul0: multiplierfsm_v2 port map(
        reset      => reset,
        clk          => clk,   
        op_a          => sigma_k,
        op_b          => outdiv_0,
        start_i     => rdydiv_0,
        mul_out   => outmul_0,
        ready_mul => rdymul_0);
        
    sub0: addsubfsm_v6 port map(
            reset      => reset,
            clk          => clk,   
            op             => '1',   
            op_a          => sigma_k,
            op_b          => outmul_0,
            start_i     => rdymul_0,
            addsub_out   => outsub_0,--sigma k+1
            ready_as     => rdysub_0);
            
    sub1: addsubfsm_v6 port map(
            reset      => reset,
            clk          => clk,   
            op             => '1',   
            op_a          => x_IR,
            op_b          => x_UL,
            start_i     => start,
            addsub_out   => outsub_1,
            ready_as     => rdysub_1);
                    
    mul1: multiplierfsm_v2 port map(
            reset      => reset,
            clk          => clk,   
            op_a          => outdiv_0,--Gk+1
            op_b          => outsub_1,
            start_i     => rdydiv_0,
            mul_out   => outmul_1,
            ready_mul => rdymul_1);
                        
    add1: addsubfsm_v6 port map(
            reset      => reset,
            clk          => clk,   
            op             => '0',   
            op_a          => outmul_1,
            op_b          => x_UL,
            start_i     => rdymul_1,
            addsub_out   => outadd_1,-- saida xf
            ready_as     => rdyadd_1);

--Processo para sincronizar a saida e ready
    process(clk, reset)
    begin
        if reset='1' then
            saida_xf <= (others=>'0');
            ready <= '0';
        elsif rising_edge(clk) then
            ready <= '0';
            if rdyadd_1='1' then
                ready <= '1';
                saida_xf <= outadd_1;
            end if;
        end if;
    end process;


end Behavioral;
