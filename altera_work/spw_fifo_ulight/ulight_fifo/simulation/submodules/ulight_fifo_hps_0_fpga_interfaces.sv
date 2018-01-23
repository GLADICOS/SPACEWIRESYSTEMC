// (C) 2001-2017 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


`timescale 1 ns / 1 ns

import verbosity_pkg::*;
import avalon_mm_pkg::*;
import mgc_axi_pkg::*;

module ulight_fifo_hps_0_fpga_interfaces
(
   output wire [  0:  0] h2f_rst_n,
   input  wire [  0:  0] h2f_axi_clk,
   output wire [ 11:  0] h2f_AWID,
   output wire [ 29:  0] h2f_AWADDR,
   output wire [  3:  0] h2f_AWLEN,
   output wire [  2:  0] h2f_AWSIZE,
   output wire [  1:  0] h2f_AWBURST,
   output wire [  1:  0] h2f_AWLOCK,
   output wire [  3:  0] h2f_AWCACHE,
   output wire [  2:  0] h2f_AWPROT,
   output wire [  0:  0] h2f_AWVALID,
   input  wire [  0:  0] h2f_AWREADY,
   output wire [ 11:  0] h2f_WID,
   output wire [ 31:  0] h2f_WDATA,
   output wire [  3:  0] h2f_WSTRB,
   output wire [  0:  0] h2f_WLAST,
   output wire [  0:  0] h2f_WVALID,
   input  wire [  0:  0] h2f_WREADY,
   input  wire [ 11:  0] h2f_BID,
   input  wire [  1:  0] h2f_BRESP,
   input  wire [  0:  0] h2f_BVALID,
   output wire [  0:  0] h2f_BREADY,
   output wire [ 11:  0] h2f_ARID,
   output wire [ 29:  0] h2f_ARADDR,
   output wire [  3:  0] h2f_ARLEN,
   output wire [  2:  0] h2f_ARSIZE,
   output wire [  1:  0] h2f_ARBURST,
   output wire [  1:  0] h2f_ARLOCK,
   output wire [  3:  0] h2f_ARCACHE,
   output wire [  2:  0] h2f_ARPROT,
   output wire [  0:  0] h2f_ARVALID,
   input  wire [  0:  0] h2f_ARREADY,
   input  wire [ 11:  0] h2f_RID,
   input  wire [ 31:  0] h2f_RDATA,
   input  wire [  1:  0] h2f_RRESP,
   input  wire [  0:  0] h2f_RLAST,
   input  wire [  0:  0] h2f_RVALID,
   output wire [  0:  0] h2f_RREADY
);




   altera_avalon_reset_source #(
      .ASSERT_HIGH_RESET(0),
      .INITIAL_RESET_CYCLES(1)
   ) h2f_reset_inst (
      .reset(h2f_rst_n),
      .clk('0)
   );

   mgc_axi_master #(
      .AXI_ID_WIDTH(12),
      .AXI_ADDRESS_WIDTH(30),
      .AXI_WDATA_WIDTH(32),
      .AXI_RDATA_WIDTH(32),
      .index(1)
   ) h2f_axi_master_inst (
      .ARSIZE(h2f_ARSIZE),
      .AWUSER(),
      .WVALID(h2f_WVALID),
      .RLAST(h2f_RLAST),
      .ACLK(h2f_axi_clk),
      .RRESP(h2f_RRESP),
      .ARREADY(h2f_ARREADY),
      .ARPROT(h2f_ARPROT),
      .ARADDR(h2f_ARADDR),
      .BVALID(h2f_BVALID),
      .ARID(h2f_ARID),
      .BID(h2f_BID),
      .ARBURST(h2f_ARBURST),
      .ARCACHE(h2f_ARCACHE),
      .AWVALID(h2f_AWVALID),
      .WDATA(h2f_WDATA),
      .ARUSER(),
      .RID(h2f_RID),
      .RVALID(h2f_RVALID),
      .WREADY(h2f_WREADY),
      .AWLOCK(h2f_AWLOCK),
      .BRESP(h2f_BRESP),
      .ARLEN(h2f_ARLEN),
      .AWSIZE(h2f_AWSIZE),
      .AWLEN(h2f_AWLEN),
      .BREADY(h2f_BREADY),
      .AWID(h2f_AWID),
      .RDATA(h2f_RDATA),
      .AWREADY(h2f_AWREADY),
      .ARVALID(h2f_ARVALID),
      .WLAST(h2f_WLAST),
      .ARESETn(h2f_rst_n),
      .AWPROT(h2f_AWPROT),
      .WID(h2f_WID),
      .AWADDR(h2f_AWADDR),
      .AWCACHE(h2f_AWCACHE),
      .ARLOCK(h2f_ARLOCK),
      .AWBURST(h2f_AWBURST),
      .RREADY(h2f_RREADY),
      .WSTRB(h2f_WSTRB)
   );

endmodule 

