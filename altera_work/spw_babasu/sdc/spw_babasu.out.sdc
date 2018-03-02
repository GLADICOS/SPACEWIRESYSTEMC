## Generated SDC file "/home/felipe/Documentos/verilog_projects/GITHUBPROJECTS/SPACEWIRESYSTEMC/altera_work/spw_babasu/sdc/spw_babasu.out.sdc"

## Copyright (C) 2017  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 17.1.1 Internal Build 593 12/11/2017 SJ Lite Edition"

## DATE    "Mon Feb 26 12:55:17 2018"

##
## DEVICE  "5CSEMA4U23C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {FPGA_CLK1_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {FPGA_CLK1_50}]
create_clock -name {din_a} -period 4.800 -waveform { 0.000 2.400 } [get_ports { din_a }]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {u0|pll_0|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} -source [get_pins {u0|pll_0|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|refclkin}] -duty_cycle 50/1 -multiply_by 16 -divide_by 2 -master_clock {FPGA_CLK1_50} [get_pins {u0|pll_0|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]}] 
create_generated_clock -name {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk} -source [get_pins {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 2 -master_clock {u0|pll_0|altera_pll_i|general[0].gpll~FRACTIONAL_PLL|vcoph[0]} [get_pins {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -setup 0.170  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -setup 0.170  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {din_a}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {din_a}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {din_a}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {din_a}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -setup 0.170  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -setup 0.170  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -hold 0.060  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path -to [get_pins -nocase -compatibility_mode {*|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain*|clrn}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

