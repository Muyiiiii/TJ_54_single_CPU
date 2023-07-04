# 
# Synthesis run script generated by Vivado
# 

set_param simulator.modelsimInstallPath C:/modeltech_pe_10.4c/win32pe
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.cache/wt [current_project]
set_property parent.project_path C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.xpr [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/31条指令CPU实验相关文档/31条CPUcoe文件/mips_31_mars_simulate.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_1_addi.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_1_addiu.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_1_lui.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_add.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_addu.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_and.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_andi.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_lwsw.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_lwsw2.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_nor.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_or.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_ori.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_sll.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_sllv.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_slt.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_slti.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_sltiu.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_sltu.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_sra.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_srav.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_srl.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_srlv.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_sub.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_subu.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_xor.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_2_xori.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_3_beq.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_3_bne.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_4_j.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_4_jal.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test_ins/_4_jr.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/32_clz.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/33_divu.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/35_jalr.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/36.39_lbsb2.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/36.39_lbsb.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/37_lbu2.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/37_lbu.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/38_lhu2.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/38_lhu.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/40.41_lhsh2.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/40.41_lhsh.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/42.45_mfc0mtc0.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/43.46_mfhi.mthi.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/44.47_mflo.mtlo.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/48_mul.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/49_multu.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/54_div.hex.coe
add_files C:/Users/YangJie/Desktop/doing/23-54/52_bgez.hex.coe
add_files C:/Users/YangJie/Desktop/doing/CPU/54条指令CPU实验相关文档/54条CPUcoe文件/mips_54_mars_simulate_student_ForWeb.coe
add_files -quiet c:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0.dcp
set_property used_in_implementation false [get_files c:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0.dcp]
read_verilog -library xil_defaultlib {
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/Controller.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/MUL.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/DIV.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/MUX6.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/MUX5.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/HI_or_LO.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/regfile.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/PC.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/MUX4.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/MUX3.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/MUX2.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/MUX1.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/EXT.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/CP0.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/Connect.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/ALU.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/ADD2.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/ADD1.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/cpu.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/DMEM.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/IMEM.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/clk_change.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/seg7x16.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/sccomp_dataflow.v
  C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/sources_1/new/top.v
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/constrs_1/new/cpu_xdc.xdc
set_property used_in_implementation false [get_files C:/Users/YangJie/Desktop/doing/CPU/CPU/test/CPU/CPU.srcs/constrs_1/new/cpu_xdc.xdc]


synth_design -top top -part xc7a100tcsg324-1


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
