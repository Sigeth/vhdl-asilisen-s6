// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Mon Mar 25 17:16:04 2024
// Host        : linux-dev-pc running 64-bit Pop!_OS 22.04 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/sigeth/Documents/ISEN/VHDL/PROJETS/SUJ7/SUJ7.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(CLK_100MHZ, CLK_25MHZ, reset, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="CLK_100MHZ,CLK_25MHZ,reset,clk_in1" */;
  output CLK_100MHZ;
  output CLK_25MHZ;
  input reset;
  input clk_in1;
endmodule
