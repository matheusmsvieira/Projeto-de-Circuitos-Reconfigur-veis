// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Thu May 09 09:15:44 2019
// Host        : LAPTOP-R477576D running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/Matheus
//               Moreira/Documents/UnB/PCR/Prova_PCR_Fusao_Sensorial/Prova_PCR_Fusao_Sensorial.srcs/sources_1/ip/ROMmem_xUL/ROMmem_xUL_stub.v}
// Design      : ROMmem_xUL
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_3,Vivado 2016.2" *)
module ROMmem_xUL(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[6:0],douta[26:0]" */;
  input clka;
  input ena;
  input [6:0]addra;
  output [26:0]douta;
endmodule