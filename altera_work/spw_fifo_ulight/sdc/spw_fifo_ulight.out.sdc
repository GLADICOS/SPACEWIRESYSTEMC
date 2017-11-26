## Generated SDC file "/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/sdc/spw_fifo_ulight.out.sdc"

## Copyright (C) 2017  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Intel and sold by Intel or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 17.0.2 Build 602 07/19/2017 SJ Lite Edition"

## DATE    "Fri Nov 24 14:56:12 2017"

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

create_clock -name {altera_reserved_tck} -period 33.333 -waveform { 0.000 16.666 } [get_ports {altera_reserved_tck}]
create_clock -name {FPGA_CLK1_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {FPGA_CLK1_50}]
create_clock -name {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e} -period 2.500 -waveform { 0.000 1.250 } [get_registers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]
create_clock -name {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i} -period 2.500 -waveform { 0.000 1.250 } [get_registers {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]
create_clock -name {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i} -period 10.000 -waveform { 0.000 5.000 } [get_registers {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]
create_clock -name {din_a} -period 2.500 -waveform { 0.000 1.250 } [get_ports {din_a}]
create_clock -name {detector_tokens:m_x|ready_data} -period 4.000 -waveform { 0.000 2.000 } [get_registers {detector_tokens:m_x|ready_data}]
create_clock -name {detector_tokens:m_x|ready_control} -period 4.000 -waveform { 0.000 2.000 } [get_registers {detector_tokens:m_x|ready_control}]
create_clock -name {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control} -period 4.000 -waveform { 0.000 2.000 } [get_registers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]
create_clock -name {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data} -period 4.000 -waveform { 0.000 2.000 } [get_registers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {u0|pll_0|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]} -source [get_pins {u0|pll_0|altera_pll_i|cyclonev_pll|fpll_0|fpll|refclkin}] -duty_cycle 50.000 -multiply_by 8 -master_clock {FPGA_CLK1_50} [get_pins { u0|pll_0|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0] }] 
create_generated_clock -name {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk} -source [get_pins {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|vco0ph[0]}] -duty_cycle 50.000 -multiply_by 1 -master_clock {u0|pll_0|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]} [get_pins { u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk }] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -rise_to [get_clocks {din_a}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -fall_to [get_clocks {din_a}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -rise_to [get_clocks {din_a}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -fall_to [get_clocks {din_a}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -rise_to [get_clocks {din_a}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -fall_to [get_clocks {din_a}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -rise_to [get_clocks {din_a}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -fall_to [get_clocks {din_a}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:m_x|ready_control}] -rise_to [get_clocks {detector_tokens:m_x|ready_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:m_x|ready_control}] -fall_to [get_clocks {detector_tokens:m_x|ready_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:m_x|ready_control}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:m_x|ready_control}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:m_x|ready_control}] -rise_to [get_clocks {detector_tokens:m_x|ready_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:m_x|ready_control}] -fall_to [get_clocks {detector_tokens:m_x|ready_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:m_x|ready_control}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:m_x|ready_control}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:m_x|ready_data}] -rise_to [get_clocks {detector_tokens:m_x|ready_data}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:m_x|ready_data}] -fall_to [get_clocks {detector_tokens:m_x|ready_data}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:m_x|ready_data}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:m_x|ready_data}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:m_x|ready_data}] -rise_to [get_clocks {detector_tokens:m_x|ready_data}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:m_x|ready_data}] -fall_to [get_clocks {detector_tokens:m_x|ready_data}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:m_x|ready_data}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:m_x|ready_data}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {din_a}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {din_a}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {din_a}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {din_a}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.350  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.250  
set_clock_uncertainty -rise_from [get_clocks {din_a}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.250  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  0.350  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.290  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {din_a}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {din_a}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.250  
set_clock_uncertainty -fall_from [get_clocks {din_a}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.250  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.200  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.190  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.200  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.190  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {detector_tokens:m_x|ready_control}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {detector_tokens:m_x|ready_control}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {detector_tokens:m_x|ready_data}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {detector_tokens:m_x|ready_data}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -setup 0.180  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -setup 0.180  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.200  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.190  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.200  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.190  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {detector_tokens:m_x|ready_control}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {detector_tokens:m_x|ready_control}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {detector_tokens:m_x|ready_data}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {detector_tokens:m_x|ready_data}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.220  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  0.220  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.220  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  0.220  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -setup 0.180  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -setup 0.180  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -rise_to [get_clocks {detector_tokens:m_x|ready_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -fall_to [get_clocks {detector_tokens:m_x|ready_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -rise_to [get_clocks {detector_tokens:m_x|ready_data}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -fall_to [get_clocks {detector_tokens:m_x|ready_data}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -rise_to [get_clocks {detector_tokens:m_x|ready_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -fall_to [get_clocks {detector_tokens:m_x|ready_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -rise_to [get_clocks {detector_tokens:m_x|ready_data}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -fall_to [get_clocks {detector_tokens:m_x|ready_data}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -rise_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}] -fall_to [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.270  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {din_a}]  -to  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]
set_false_path  -from  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  -to  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]
set_false_path  -from  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  -to  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]
set_false_path  -from  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  -to  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]
set_false_path  -from  [get_clocks {din_a}]  -to  [get_clocks {din_a}]
set_false_path  -from  [get_clocks {din_a}]  -to  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]
set_false_path  -from  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  -to  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]
set_false_path  -from  [get_clocks {FPGA_CLK1_50}]  -to  [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]
set_false_path  -from  [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  -to  [get_clocks {u0|pll_0|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]
set_false_path  -from  [get_clocks {din_a}]  -to  [get_clocks {FPGA_CLK1_50}]
set_false_path  -from  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  -to  [get_clocks {FPGA_CLK1_50}]
set_false_path  -from  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_100_reduced_i}]  -to  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]
set_false_path  -from  [get_clocks {FPGA_CLK1_50}]  -to  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]
set_false_path  -from  [get_clocks {clock_reduce:R_400_to_2_5_10_100_200_300MHZ|clk_reduced_i}]  -to  [get_clocks {FPGA_CLK1_50}]
set_false_path  -from  [get_clocks {din_a}]  -to  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]
set_false_path  -from  [get_clocks {din_a}]  -to  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]
set_false_path  -from  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  -to  [get_clocks {din_a}]
set_false_path  -from  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  -to  [get_clocks {din_a}]
set_false_path  -from  [get_clocks {detector_tokens:m_x|ready_data}]  -to  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]
set_false_path  -from  [get_clocks {detector_tokens:m_x|ready_control}]  -to  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]
set_false_path  -from  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  -to  [get_clocks {detector_tokens:m_x|ready_data}]
set_false_path  -from  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|tx_dout_e}]  -to  [get_clocks {detector_tokens:m_x|ready_control}]
set_false_path  -from  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_control}]  -to  [get_clocks {FPGA_CLK1_50}]
set_false_path  -from  [get_clocks {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|ready_data}]  -to  [get_clocks {FPGA_CLK1_50}]
set_false_path -from [get_keepers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|FSM_SPW:FSM|rx_resetn}] -to [get_keepers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|RX_SPW:RX|*}]
set_false_path -from [get_keepers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|FSM_SPW:FSM|enable_tx}] -to [get_keepers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|aux_pb}] -to [get_keepers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|FSM_SPW:FSM|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|aux_pb}] -to [get_keepers {detector_tokens:m_x|*}]
set_false_path -from [get_keepers {spw_ulight_con_top_x:A_SPW_TOP|top_spw_ultra_light:SPW|TX_SPW:TX|ready_tx_timecode}] -to [get_keepers {ulight_fifo:u0|ulight_fifo_fifo_empty_rx_status:timecode_tx_ready|readdata[0]}]
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

