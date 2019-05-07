# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Matheus Moreira/Documents/UnB/PCR/Prova_PCR_Fusao_Sensorial/Prova_PCR_Fusao_Sensorial.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Matheus Moreira/Documents/UnB/PCR/Prova_PCR_Fusao_Sensorial/Prova_PCR_Fusao_Sensorial.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/Matheus Moreira/Documents/GitHub/Circuitos_Reconfiguraveis/simauto/fpupack.vhd}
  {C:/Users/Matheus Moreira/Documents/GitHub/Circuitos_Reconfiguraveis/operadorFloatingPoint/fixMul.vhd}
  {C:/Users/Matheus Moreira/Documents/GitHub/Circuitos_Reconfiguraveis/simauto/entities.vhd}
  {C:/Users/Matheus Moreira/Documents/GitHub/Circuitos_Reconfiguraveis/simauto/multiplierfsm_v2.vhd}
  {C:/Users/Matheus Moreira/Documents/GitHub/Circuitos_Reconfiguraveis/operadorFloatingPoint/divNR.vhd}
  {C:/Users/Matheus Moreira/Documents/GitHub/Circuitos_Reconfiguraveis/simauto/addsubfsm_v6.vhd}
  {C:/Users/Matheus Moreira/Documents/UnB/PCR/Prova_PCR_Fusao_Sensorial/Prova_PCR_Fusao_Sensorial.srcs/sources_1/new/Fusao_sensorial.vhd}
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}

synth_design -top Fusao_sensorial -part xc7a35tcpg236-1


write_checkpoint -force -noxdef Fusao_sensorial.dcp

catch { report_utilization -file Fusao_sensorial_utilization_synth.rpt -pb Fusao_sensorial_utilization_synth.pb }
