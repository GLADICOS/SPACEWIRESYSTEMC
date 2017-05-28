/*
 Copyright (C) 2017  Intel Corporation. All rights reserved.
 Your use of Intel Corporation's design tools, logic functions 
 and other software and tools, and its AMPP partner logic 
 functions, and any output files from any of the foregoing 
 (including device programming or simulation files), and any 
 associated documentation or information are expressly subject 
 to the terms and conditions of the Intel Program License 
 Subscription Agreement, the Intel Quartus Prime License Agreement,
 the Intel MegaCore Function License Agreement, or other 
 applicable license agreement, including, without limitation, 
 that your use is for the sole purpose of programming logic 
 devices manufactured by Intel and sold by Intel or its 
 authorized distributors.  Please refer to the applicable 
 agreement for further details.
*/
MODEL
/*MODEL HEADER*/
/*
 This file contains Fast Corner delays for the design using part 5CSEMA4U23C6
 with speed grade M, core voltage 1.1V, and temperature 85 Celsius

*/
MODEL_VERSION "1.0";
DESIGN "spw_ulight_nofifo";
DATE "05/27/2017 23:50:14";
PROGRAM "Quartus Prime";



INPUT FPGA_CLK1_50;
INPUT KEY[0];
INPUT KEY[1];
OUTPUT LED[5];
OUTPUT LED[6];
OUTPUT LED[7];
OUTPUT LED[0];
OUTPUT LED[1];
OUTPUT LED[2];
OUTPUT LED[3];
OUTPUT LED[4];

/*Arc definitions start here*/
pos_KEY[0]__FPGA_CLK1_50__setup:		SETUP (POSEDGE) KEY[0] FPGA_CLK1_50 ;
pos_KEY[1]__FPGA_CLK1_50__setup:		SETUP (POSEDGE) KEY[1] FPGA_CLK1_50 ;
pos_KEY[0]__FPGA_CLK1_50__hold:		HOLD (POSEDGE) KEY[0] FPGA_CLK1_50 ;
pos_KEY[1]__FPGA_CLK1_50__hold:		HOLD (POSEDGE) KEY[1] FPGA_CLK1_50 ;
pos_FPGA_CLK1_50__LED[0]__delay:		DELAY (POSEDGE) FPGA_CLK1_50 LED[0] ;
pos_FPGA_CLK1_50__LED[1]__delay:		DELAY (POSEDGE) FPGA_CLK1_50 LED[1] ;
pos_FPGA_CLK1_50__LED[2]__delay:		DELAY (POSEDGE) FPGA_CLK1_50 LED[2] ;
pos_FPGA_CLK1_50__LED[3]__delay:		DELAY (POSEDGE) FPGA_CLK1_50 LED[3] ;
pos_FPGA_CLK1_50__LED[4]__delay:		DELAY (POSEDGE) FPGA_CLK1_50 LED[4] ;
pos_FPGA_CLK1_50__LED[5]__delay:		DELAY (POSEDGE) FPGA_CLK1_50 LED[5] ;
pos_FPGA_CLK1_50__LED[6]__delay:		DELAY (POSEDGE) FPGA_CLK1_50 LED[6] ;

ENDMODEL
