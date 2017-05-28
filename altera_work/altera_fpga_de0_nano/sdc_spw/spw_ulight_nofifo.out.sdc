## Generated SDC file "/home/felipe/Downloads/TEMP/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/sdc_spw/spw_ulight_nofifo.out.sdc"

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
## VERSION "Version 17.0.0 Build 595 04/25/2017 SJ Lite Edition"

## DATE    "Sat May 27 20:46:31 2017"

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
create_clock -name {detector_tokens:B|rx_buffer_write} -period 10.000 -waveform { 0.000 5.000 } [get_registers {detector_tokens:B|rx_buffer_write}]
create_clock -name {debounce_db:db_system_spwulight_b|PB_state} -period 500.000 -waveform { 0.000 250.000 } [get_registers {debounce_db:db_system_spwulight_b|PB_state}]
create_clock -name {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control} -period 10.000 -waveform { 0.000 5.000 } [get_registers {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]
create_clock -name {top_spw_ultra_light:SPW|RX_SPW:RX|is_control} -period 10.000 -waveform { 0.000 5.000 } [get_registers {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]
create_clock -name {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]} -period 10.000 -waveform { 0.000 5.000 } [get_registers {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]
create_clock -name {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]} -period 10.000 -waveform { 0.000 5.000 } [get_registers {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]
create_clock -name {detector_tokens:B|is_control} -period 10.000 -waveform { 0.000 5.000 } [get_registers {detector_tokens:B|is_control}]
create_clock -name {detector_tokens:A|rx_buffer_write} -period 10.000 -waveform { 0.000 5.000 } [get_registers {detector_tokens:A|rx_buffer_write}]
create_clock -name {detector_tokens:A|is_control} -period 10.000 -waveform { 0.000 5.000 } [get_registers {detector_tokens:A|is_control}]
create_clock -name {detector_tokens:B|counter_neg[0]} -period 10.000 -waveform { 0.000 5.000 } [get_registers {detector_tokens:B|counter_neg[0]}]
create_clock -name {detector_tokens:A|counter_neg[0]} -period 10.000 -waveform { 0.000 5.000 } [get_registers {detector_tokens:A|counter_neg[0]}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]} -source [get_pins {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|fpll_0|fpll|refclkin}] -duty_cycle 50/1 -multiply_by 16 -divide_by 2 -master_clock {FPGA_CLK1_50} [get_pins {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]}] 
create_generated_clock -name {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk} -source [get_pins {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 4 -master_clock {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]} [get_pins {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] 
create_generated_clock -name {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk} -source [get_pins {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 80 -master_clock {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]} [get_pins {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] 
create_generated_clock -name {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk} -source [get_pins {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|vco0ph[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 40 -master_clock {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|fpll_0|fpll|vcoph[0]} [get_pins {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.310  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.310  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.260  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.260  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.310  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.310  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.260  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.260  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.280  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.310  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.310  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.260  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.260  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.280  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.310  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.310  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.260  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.260  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.300  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.300  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.300  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.300  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.300  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.300  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.300  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.300  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -setup 0.180  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}] -hold 0.170  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.300  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.300  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.300  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.300  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.300  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.300  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.300  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.300  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|counter_neg[0]}] -rise_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|counter_neg[0]}] -fall_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|counter_neg[0]}] -rise_to [get_clocks {detector_tokens:A|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|counter_neg[0]}] -fall_to [get_clocks {detector_tokens:A|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|counter_neg[0]}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|counter_neg[0]}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|counter_neg[0]}] -rise_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|counter_neg[0]}] -fall_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|counter_neg[0]}] -rise_to [get_clocks {detector_tokens:A|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|counter_neg[0]}] -fall_to [get_clocks {detector_tokens:A|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|counter_neg[0]}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|counter_neg[0]}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|counter_neg[0]}] -rise_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|counter_neg[0]}] -fall_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|counter_neg[0]}] -rise_to [get_clocks {detector_tokens:B|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|counter_neg[0]}] -fall_to [get_clocks {detector_tokens:B|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|counter_neg[0]}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|counter_neg[0]}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|counter_neg[0]}] -rise_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|counter_neg[0]}] -fall_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|counter_neg[0]}] -rise_to [get_clocks {detector_tokens:B|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|counter_neg[0]}] -fall_to [get_clocks {detector_tokens:B|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|counter_neg[0]}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|counter_neg[0]}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|is_control}] -rise_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|is_control}] -fall_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|is_control}] -rise_to [get_clocks {detector_tokens:A|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|is_control}] -fall_to [get_clocks {detector_tokens:A|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|is_control}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|is_control}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|is_control}] -rise_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|is_control}] -fall_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|is_control}] -rise_to [get_clocks {detector_tokens:A|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|is_control}] -fall_to [get_clocks {detector_tokens:A|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|is_control}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|is_control}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|rx_buffer_write}] -rise_to [get_clocks {FPGA_CLK1_50}] -setup 0.280  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|rx_buffer_write}] -rise_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|rx_buffer_write}] -fall_to [get_clocks {FPGA_CLK1_50}] -setup 0.280  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:A|rx_buffer_write}] -fall_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|rx_buffer_write}] -rise_to [get_clocks {FPGA_CLK1_50}] -setup 0.280  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|rx_buffer_write}] -rise_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|rx_buffer_write}] -fall_to [get_clocks {FPGA_CLK1_50}] -setup 0.280  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:A|rx_buffer_write}] -fall_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|is_control}] -rise_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|is_control}] -fall_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|is_control}] -rise_to [get_clocks {detector_tokens:B|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|is_control}] -fall_to [get_clocks {detector_tokens:B|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|is_control}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|is_control}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|is_control}] -rise_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|is_control}] -fall_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|is_control}] -rise_to [get_clocks {detector_tokens:B|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|is_control}] -fall_to [get_clocks {detector_tokens:B|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|is_control}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|is_control}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.360  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.360  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.360  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.360  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.360  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.360  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.360  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.360  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.360  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.360  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.360  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.360  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.360  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.360  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.360  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.360  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.380  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.310  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.310  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.310  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.310  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]  0.240  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:A|is_control}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:A|is_control}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:A|rx_buffer_write}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:A|rx_buffer_write}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:B|is_control}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:B|is_control}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.270  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:B|rx_buffer_write}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:B|rx_buffer_write}]  0.320  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.310  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.310  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.310  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.310  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]  0.240  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:A|counter_neg[0]}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:B|counter_neg[0]}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:A|is_control}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:A|is_control}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:A|rx_buffer_write}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:A|rx_buffer_write}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:B|is_control}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:B|is_control}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.270  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {detector_tokens:B|rx_buffer_write}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {detector_tokens:B|rx_buffer_write}]  0.320  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -rise_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -fall_from [get_clocks {debounce_db:db_system_spwulight_b|PB_state}] -fall_to [get_clocks {FPGA_CLK1_50}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|rx_buffer_write}] -rise_to [get_clocks {FPGA_CLK1_50}] -setup 0.280  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|rx_buffer_write}] -rise_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|rx_buffer_write}] -fall_to [get_clocks {FPGA_CLK1_50}] -setup 0.280  
set_clock_uncertainty -rise_from [get_clocks {detector_tokens:B|rx_buffer_write}] -fall_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|rx_buffer_write}] -rise_to [get_clocks {FPGA_CLK1_50}] -setup 0.280  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|rx_buffer_write}] -rise_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|rx_buffer_write}] -fall_to [get_clocks {FPGA_CLK1_50}] -setup 0.280  
set_clock_uncertainty -fall_from [get_clocks {detector_tokens:B|rx_buffer_write}] -fall_to [get_clocks {FPGA_CLK1_50}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.260  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.260  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.260  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.260  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]  0.190  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.220  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {FPGA_CLK1_50}] -hold 0.060  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -setup 0.170  
set_clock_uncertainty -rise_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {FPGA_CLK1_50}] -hold 0.060  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.260  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  0.260  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.260  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  0.260  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]  0.190  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -rise_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.220  
set_clock_uncertainty -fall_from [get_clocks {FPGA_CLK1_50}] -fall_to [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  0.220  
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

set_false_path  -from  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]  -to  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]
set_false_path  -from  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]  -to  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]
set_false_path  -from  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  -to  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]
set_false_path  -from  [get_clocks {FPGA_CLK1_50}]  -to  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[3].output_counter|divclk}]
set_false_path  -from  [get_clocks {FPGA_CLK1_50}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|counter_neg[0]}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|counter_neg[0]}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {detector_tokens:A|counter_neg[0]}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {detector_tokens:A|is_control}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {detector_tokens:B|is_control}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {detector_tokens:B|counter_neg[0]}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  -to  [get_clocks {debounce_db:db_system_spwulight_b|PB_state}]
set_false_path  -from  [get_clocks {FPGA_CLK1_50}]  -to  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]
set_false_path  -from  [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  -to  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]
set_false_path  -from  [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  -to  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[0].output_counter|divclk}]
set_false_path  -from  [get_clocks {FPGA_CLK1_50}]  -to  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]
set_false_path  -from  [get_clocks {top_spw_ultra_light:SPW_B|RX_SPW:RX|is_control}]  -to  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]
set_false_path  -from  [get_clocks {top_spw_ultra_light:SPW|RX_SPW:RX|is_control}]  -to  [get_clocks {AXI_INTERFACE|pll_tx|altera_pll_i|cyclonev_pll|counter[1].output_counter|divclk}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|PB_state}] -to [get_registers {top_spw_ultra_light:SPW_B|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|PB_state}] -to [get_registers {top_spw_ultra_light:SPW_B|RX_SPW:RX|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|PB_state}] -to [get_registers {top_spw_ultra_light:SPW_B|FSM_SPW:FSM|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|PB_state}] -to [get_registers {top_spw_ultra_light:SPW_B|TX_SPW:TX|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|PB_state}] -to [get_registers {top_spw_ultra_light:SPW|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|PB_state}] -to [get_registers {top_spw_ultra_light:SPW|RX_SPW:RX|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|PB_state}] -to [get_registers {top_spw_ultra_light:SPW|TX_SPW:TX|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|PB_state}] -to [get_registers {top_spw_ultra_light:SPW|FSM_SPW:FSM|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_a|PB_state}] -to [get_registers {detector_tokens:A|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|PB_state}] -to [get_registers {detector_tokens:A|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_b|PB_state}] -to [get_registers {detector_tokens:B|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_a|PB_state}] -to [get_registers {detector_tokens:B|*}]
set_false_path -from [get_keepers {debounce_db:db_system_spwulight_a|PB_state}] -to [get_registers {spw_ulight_nofifo:AXI_INTERFACE|spw_ulight_nofifo_data_rx_r:data_rx_r|*}]
set_false_path -from [get_keepers {top_spw_ultra_light:SPW|FSM_SPW:FSM|state_fsm.*}] -to [get_keepers {top_spw_ultra_light:SPW|TX_SPW:TX|*}]
set_false_path -from [get_keepers {top_spw_ultra_light:SPW_B|FSM_SPW:FSM|state_fsm.*}] -to [get_keepers {top_spw_ultra_light:SPW_B|TX_SPW:TX|*}]
set_false_path -from [get_keepers {top_spw_ultra_light:SPW|FSM_SPW:FSM|state_fsm.*}] -to [get_keepers {top_spw_ultra_light:SPW_B|TX_SPW:TX|*}]
set_false_path -from [get_keepers {top_spw_ultra_light:SPW_B|FSM_SPW:FSM|state_fsm.*}] -to [get_keepers {top_spw_ultra_light:SPW|TX_SPW:TX|*}]
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

