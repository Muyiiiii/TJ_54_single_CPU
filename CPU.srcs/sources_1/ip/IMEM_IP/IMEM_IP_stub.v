// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Tue May 09 02:19:01 2023
// Host        : DESKTOP-25PF8VM running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/YangJie/Desktop/doing/CPU/test/CPU/CPU.srcs/sources_1/ip/IMEM_IP/IMEM_IP_stub.v
// Design      : IMEM_IP
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_10,Vivado 2016.2" *)
module IMEM_IP(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[10:0],spo[31:0]" */;
  input [10:0]a;
  output [31:0]spo;
endmodule
