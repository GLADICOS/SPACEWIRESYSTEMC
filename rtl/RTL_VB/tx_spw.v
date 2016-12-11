//+FHDR------------------------------------------------------------------------
//Copyright (c) 2013 Latin Group American Integhrated Circuit, Inc. All rights reserved
//GLADIC Open Source RTL
//-----------------------------------------------------------------------------
//FILE NAME	 :
//DEPARTMENT	 : IC Design / Verification
//AUTHOR	 : Felipe Fernandes da Costa
//AUTHOR’S EMAIL :
//-----------------------------------------------------------------------------
//RELEASE HISTORY
//VERSION DATE AUTHOR DESCRIPTION
//1.0 YYYY-MM-DD name
//-----------------------------------------------------------------------------
//KEYWORDS : General file searching keywords, leave blank if none.
//-----------------------------------------------------------------------------
//PURPOSE  : ECSS_E_ST_50_12C_31_july_2008
//-----------------------------------------------------------------------------
//PARAMETERS
//PARAM NAME		RANGE	: DESCRIPTION : DEFAULT : UNITS
//e.g.DATA_WIDTH	[32,16]	: width of the DATA : 32:
//-----------------------------------------------------------------------------
//REUSE ISSUES
//Reset Strategy	:
//Clock Domains		:
//Critical Timing	:
//Test Features		:
//Asynchronous I/F	:
//Scan Methodology	:
//Instantiations	:
//Synthesizable (y/n)	:
//Other			:
//-FHDR------------------------------------------------------------------------

`timescale 1ns/1ns

module TX_SPW (
		input pclk_tx,
		//
		input [8:0] data_tx_i,
		input txwrite_tx,
		//
		input [7:0] timecode_tx_i,
		input tickin_tx,
		//
		input enable_tx,
		input send_null_tx,
		input send_fct_tx,
 
		//
		input gotfct_tx,
		input send_fct_now,
		//
		output tx_dout,
		output tx_sout,
		//
		output  ready_tx_data,
		output  ready_tx_timecode

		);

localparam [2:0] tx_spw_start     = 3'b000,
	   	 tx_spw_null      = 3'b001,
	   	 tx_spw_null_fct  = 3'b010,
	   	 tx_spw_full      = 3'b100;

localparam [5:0] NULL     = 6'b000001,
		 FCT      = 6'b000010,
		 EOP      = 6'b000100,
		 EEP      = 6'b001000,
		 DATA     = 6'b010000,
		 TIMEC    = 6'b100000;

	reg [2:0] state_tx;
	reg [2:0] next_state_tx;

	reg [7:0]  null_s;
	reg [3:0]  fct_s;
	reg [3:0]  eop_s;
	reg [3:0]  eep_s;
	reg [13:0] timecode_s;

	reg [5:0]  last_type;
	reg [8:0]  txdata_flagctrl_tx_last;
	reg [7:0]  last_timein_control_flag_tx;

	reg first_time;

	reg enable_null;
	reg enable_fct;
	reg enable_n_char;
	reg enable_time_code;

	reg [2:0] fct_send;
	reg [5:0] fct_counter;

	reg [3:0] global_counter_transfer; 


assign tx_dout = (!enable_tx)?1'b0:
		 ( enable_null & first_time  & global_counter_transfer == 4'd0)?null_s[7]:
		 ( enable_null & !first_time & last_type == NULL  & global_counter_transfer == 4'd0)?  !(null_s[6]^null_s[0]^null_s[1]):
		 ( enable_null & !first_time & last_type == FCT   & global_counter_transfer == 4'd0)?  !(null_s[6]^fct_s[0]^fct_s[1]):
		 ( enable_null & !first_time & last_type == EOP   & global_counter_transfer == 4'd0)?  !(null_s[6]^eop_s[0]^eop_s[1]):
		 ( enable_null & !first_time & last_type == EEP   & global_counter_transfer == 4'd0)?  !(null_s[6]^eep_s[0]^eep_s[1]):
		 ( enable_null & !first_time & last_type == DATA  & global_counter_transfer == 4'd0)?  !(null_s[6]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]):
		 ( enable_null & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0)?  !(null_s[6]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]):
		 ( enable_null & !first_time & global_counter_transfer == 4'd1)?  null_s[6]:
		 ( enable_null & !first_time & global_counter_transfer == 4'd2)?  null_s[5]:
		 ( enable_null & !first_time & global_counter_transfer == 4'd3)?  null_s[4]:
		 ( enable_null & !first_time & global_counter_transfer == 4'd4)?  null_s[3]:
		 ( enable_null & !first_time & global_counter_transfer == 4'd5)?  null_s[2]:
		 ( enable_null & !first_time & global_counter_transfer == 4'd6)?  null_s[1]:
		 ( enable_null & !first_time & global_counter_transfer == 4'd7)?  null_s[0]:
		 ( enable_fct  & !first_time & last_type == NULL  & global_counter_transfer == 4'd0)?  !(fct_s[2]^null_s[0]^null_s[1]):
		 ( enable_fct  & !first_time & last_type == FCT   & global_counter_transfer == 4'd0)?  !(fct_s[2]^fct_s[0]^fct_s[1]):
		 ( enable_fct  & !first_time & last_type == EOP   & global_counter_transfer == 4'd0)?  !(fct_s[2]^eop_s[0]^eop_s[1]):
		 ( enable_fct  & !first_time & last_type == EEP   & global_counter_transfer == 4'd0)?  !(fct_s[2]^eep_s[0]^eep_s[1]):
		 ( enable_fct  & !first_time & last_type == DATA  & global_counter_transfer == 4'd0)?  !(fct_s[2]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]):
		 ( enable_fct  & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0)?  !(fct_s[2]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]):
		 ( enable_fct  & !first_time & global_counter_transfer == 4'd1)?  fct_s[2]:
		 ( enable_fct  & !first_time & global_counter_transfer == 4'd2)?  fct_s[1]:
		 ( enable_fct  & !first_time & global_counter_transfer == 4'd3)?  fct_s[0]:
		 ( enable_time_code & !first_time & last_type == NULL  & global_counter_transfer == 4'd0)?  !(timecode_s[12]^null_s[0]^null_s[1]):
		 ( enable_time_code & !first_time & last_type == FCT   & global_counter_transfer == 4'd0)?  !(timecode_s[12]^fct_s[0]^fct_s[1]):
		 ( enable_time_code & !first_time & last_type == EOP   & global_counter_transfer == 4'd0)?  !(timecode_s[12]^eop_s[0]^eop_s[1]):
		 ( enable_time_code & !first_time & last_type == EEP   & global_counter_transfer == 4'd0)?  !(timecode_s[12]^eep_s[0]^eep_s[1]):
		 ( enable_time_code & !first_time & last_type == DATA  & global_counter_transfer == 4'd0)?  !(timecode_s[12]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]):
		 ( enable_time_code & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0)?  !(timecode_s[12]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]):
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd1)?  timecode_s[12]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd2)?  timecode_s[11]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd3)?  timecode_s[10]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd4)?  timecode_s[9]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd5)?  timecode_s[8]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd6)?  timecode_tx_i[7]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd7)?  timecode_tx_i[6]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd8)?  timecode_tx_i[5]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd9)?  timecode_tx_i[4]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd10)? timecode_tx_i[3]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd11)? timecode_tx_i[2]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd12)? timecode_tx_i[1]:
		 ( enable_time_code & !first_time & global_counter_transfer == 4'd13)? timecode_tx_i[0]:
		 ( enable_n_char    & !first_time & last_type == NULL  & global_counter_transfer == 4'd0)?  !(data_tx_i[8]^null_s[0]^null_s[1]):
		 ( enable_n_char    & !first_time & last_type == FCT   & global_counter_transfer == 4'd0)?  !(data_tx_i[8]^fct_s[0]^fct_s[1]):
		 ( enable_n_char    & !first_time & last_type == EOP   & global_counter_transfer == 4'd0)?  !(data_tx_i[8]^eop_s[0]^eop_s[1]):
		 ( enable_n_char    & !first_time & last_type == EEP   & global_counter_transfer == 4'd0)?  !(data_tx_i[8]^eep_s[0]^eep_s[1]):
	 	 ( enable_n_char    & !first_time & last_type == DATA  & global_counter_transfer == 4'd0)?  !(data_tx_i[8]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]):
		 ( enable_n_char    & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0)?  !(data_tx_i[8]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]):
		 ( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd1)?  data_tx_i[8]:
		 ( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd2)?  data_tx_i[0]:
		 ( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd3)?  data_tx_i[1]:
		 ( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd4)?  data_tx_i[2]:
		 ( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd5)?  data_tx_i[3]:
		 ( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd6)?  data_tx_i[4]:
		 ( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd7)?  data_tx_i[5]:
		 ( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd8)?  data_tx_i[6]:
		 ( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd9)?  data_tx_i[7]:
		 ( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b00 & !first_time & global_counter_transfer == 4'd1)?  eop_s[2]:
		 ( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b00 & !first_time & global_counter_transfer == 4'd2)?  eop_s[1]:
		 ( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b00 & !first_time & global_counter_transfer == 4'd3)?  eop_s[0]:
		 ( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b01 & !first_time & global_counter_transfer == 4'd1)?  eep_s[2]:
		 ( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b01 & !first_time & global_counter_transfer == 4'd2)?  eep_s[1]:
		 ( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b01 & !first_time & global_counter_transfer == 4'd3)?  eep_s[0]:
		 tx_dout;

assign tx_sout = (!enable_tx)?1'b0:
		 ( enable_null &  first_time & global_counter_transfer == 4'd0)?!tx_sout:
		 ( enable_null & !first_time & last_type == NULL   & global_counter_transfer == 4'd0 & !(null_s[6]^null_s[0]^null_s[1]) == tx_dout )?!tx_sout:
		 ( enable_null & !first_time & last_type == FCT    & global_counter_transfer == 4'd0 & !(null_s[6]^fct_s[0]^fct_s[1]) == tx_dout )?!tx_sout:
		 ( enable_null & !first_time & last_type == EOP    & global_counter_transfer == 4'd0 & !(null_s[6]^eop_s[0]^eop_s[1]) == tx_dout )?!tx_sout:
		 ( enable_null & !first_time & last_type == EEP    & global_counter_transfer == 4'd0 & !(null_s[6]^eep_s[0]^eep_s[1]) == tx_dout )?!tx_sout:
		 ( enable_null & !first_time & last_type == DATA   & global_counter_transfer == 4'd0 & !(null_s[6]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]) == tx_dout )?!tx_sout:
		 ( enable_null & !first_time & last_type == TIMEC  & global_counter_transfer == 4'd0 & !(null_s[6]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]) == tx_dout )?!tx_sout:
		 ( enable_null & !first_time & null_s[6] == tx_dout   & global_counter_transfer == 4'd1)? !tx_sout:
		 ( enable_null & !first_time & null_s[5] == tx_dout   & global_counter_transfer == 4'd2)? !tx_sout:
		 ( enable_null & !first_time & null_s[4] == tx_dout   & global_counter_transfer == 4'd3)? !tx_sout:
		 ( enable_null & !first_time & null_s[3] == tx_dout   & global_counter_transfer == 4'd4)? !tx_sout:
		 ( enable_null & !first_time & null_s[2] == tx_dout   & global_counter_transfer == 4'd5)? !tx_sout:
		 ( enable_null & !first_time & null_s[1] == tx_dout   & global_counter_transfer == 4'd6)? !tx_sout:
		 ( enable_null & !first_time & null_s[0] == tx_dout   & global_counter_transfer == 4'd7)? !tx_sout:
		 ( enable_fct  & !first_time & last_type == NULL      & global_counter_transfer == 4'd0 & !(fct_s[2]^null_s[0]^null_s[1]) == tx_dout )?!tx_sout:
		 ( enable_fct  & !first_time & last_type == FCT       & global_counter_transfer == 4'd0 & !(fct_s[2]^fct_s[0]^fct_s[1]) == tx_dout )?!tx_sout:
		 ( enable_fct  & !first_time & last_type == EOP       & global_counter_transfer == 4'd0 & !(fct_s[2]^eop_s[0]^eop_s[1]) == tx_dout )?!tx_sout:
		 ( enable_fct  & !first_time & last_type == EEP       & global_counter_transfer == 4'd0 & !(fct_s[2]^eep_s[0]^eep_s[1]) == tx_dout )?!tx_sout:
		 ( enable_fct  & !first_time & last_type == DATA      & global_counter_transfer == 4'd0 & !(fct_s[2]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]) == tx_dout )?!tx_sout:
		 ( enable_fct  & !first_time & last_type == TIMEC     & global_counter_transfer == 4'd0 & !(fct_s[2]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]) == tx_dout )?!tx_sout:
		 ( enable_fct  & !first_time & FCT[2]    == tx_dout   & global_counter_transfer == 4'd1)? !tx_sout:
		 ( enable_fct  & !first_time & FCT[1]    == tx_dout   & global_counter_transfer == 4'd2)? !tx_sout:
		 ( enable_fct  & !first_time & FCT[0]    == tx_dout   & global_counter_transfer == 4'd3)? !tx_sout:
		 ( enable_time_code  & !first_time & last_type == NULL & global_counter_transfer == 4'd0 & !(timecode_s[12]^null_s[0]^null_s[1]) == tx_dout )?!tx_sout:
		 ( enable_time_code  & !first_time & last_type == FCT  & global_counter_transfer == 4'd0 & !(timecode_s[12]^fct_s[0]^fct_s[1]) == tx_dout )?!tx_sout:
		 ( enable_time_code  & !first_time & last_type == EOP  & global_counter_transfer == 4'd0 & !(timecode_s[12]^eop_s[0]^eop_s[1]) == tx_dout )?!tx_sout:
		 ( enable_time_code  & !first_time & last_type == EEP  & global_counter_transfer == 4'd0 & !(timecode_s[12]^eep_s[0]^eep_s[1]) == tx_dout )?!tx_sout:
		 ( enable_time_code  & !first_time & last_type == DATA & global_counter_transfer == 4'd0 & !(timecode_s[12]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]) == tx_dout )?!tx_sout:
		 ( enable_time_code  & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0 & !(timecode_s[12]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]) == tx_dout )?!tx_sout:
		 ( enable_time_code  & !first_time & timecode_s[12]    == tx_dout   & global_counter_transfer == 4'd1)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_s[11]    == tx_dout   & global_counter_transfer == 4'd2)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_s[10]    == tx_dout   & global_counter_transfer == 4'd3)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_s[9]     == tx_dout   & global_counter_transfer == 4'd4)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_s[8]     == tx_dout   & global_counter_transfer == 4'd5)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_tx_i[7]  == tx_dout   & global_counter_transfer == 4'd6)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_tx_i[6]  == tx_dout   & global_counter_transfer == 4'd7)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_tx_i[5]  == tx_dout   & global_counter_transfer == 4'd8)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_tx_i[4]  == tx_dout   & global_counter_transfer == 4'd9)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_tx_i[3]  == tx_dout   & global_counter_transfer == 4'd10)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_tx_i[2]  == tx_dout   & global_counter_transfer == 4'd11)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_tx_i[1]  == tx_dout   & global_counter_transfer == 4'd12)? !tx_sout:
		 ( enable_time_code  & !first_time & timecode_tx_i[0]  == tx_dout   & global_counter_transfer == 4'd13)? !tx_sout:
		 ( enable_n_char     & !first_time & last_type == NULL & global_counter_transfer == 4'd0 & !(data_tx_i[8]^null_s[0]^null_s[1]) == tx_dout )?!tx_sout:
		 ( enable_n_char     & !first_time & last_type == FCT  & global_counter_transfer == 4'd0 & !(data_tx_i[8]^fct_s[0]^fct_s[1]) == tx_dout )?!tx_sout:
		 ( enable_n_char     & !first_time & last_type == EOP  & global_counter_transfer == 4'd0 & !(data_tx_i[8]^eop_s[0]^eop_s[1]) == tx_dout )?!tx_sout:
		 ( enable_n_char     & !first_time & last_type == EEP  & global_counter_transfer == 4'd0 & !(data_tx_i[8]^eep_s[0]^eep_s[1]) == tx_dout )?!tx_sout:
		 ( enable_n_char     & !first_time & last_type == DATA & global_counter_transfer == 4'd0 & !(data_tx_i[8]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]) == tx_dout )?!tx_sout:
		 ( enable_n_char     & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0 & !(data_tx_i[8]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]) == tx_dout )?!tx_sout:
		 ( enable_n_char     & !data_tx_i[8] & data_tx_i[8] == tx_dout & !first_time & global_counter_transfer == 4'd1)? !tx_sout:
		 ( enable_n_char     & !data_tx_i[8] & data_tx_i[0] == tx_dout & !first_time & global_counter_transfer == 4'd2)?  !tx_sout:
		 ( enable_n_char     & !data_tx_i[8] & data_tx_i[1] == tx_dout & !first_time & global_counter_transfer == 4'd3)?  !tx_sout:
		 ( enable_n_char     & !data_tx_i[8] & data_tx_i[2] == tx_dout & !first_time & global_counter_transfer == 4'd4)?  !tx_sout:
		 ( enable_n_char     & !data_tx_i[8] & data_tx_i[3] == tx_dout & !first_time & global_counter_transfer == 4'd5)?  !tx_sout:
		 ( enable_n_char     & !data_tx_i[8] & data_tx_i[4] == tx_dout & !first_time & global_counter_transfer == 4'd6)?  !tx_sout:
		 ( enable_n_char     & !data_tx_i[8] & data_tx_i[5] == tx_dout & !first_time & global_counter_transfer == 4'd7)?  !tx_sout:
		 ( enable_n_char     & !data_tx_i[8] & data_tx_i[6] == tx_dout & !first_time & global_counter_transfer == 4'd8)?  !tx_sout:
		 ( enable_n_char     & !data_tx_i[8] & data_tx_i[7] == tx_dout & !first_time & global_counter_transfer == 4'd9)?  !tx_sout:
		 ( enable_n_char     &  data_tx_i[8] & (EOP[2] == tx_dout) & data_tx_i[1:0] == 2'b00 & !first_time & global_counter_transfer == 4'd1)? !tx_sout:
		 ( enable_n_char     &  data_tx_i[8] & (EOP[1] == tx_dout) & data_tx_i[1:0] == 2'b00 & !first_time & global_counter_transfer == 4'd2)? !tx_sout:
		 ( enable_n_char     &  data_tx_i[8] & (EOP[0] == tx_dout) & data_tx_i[1:0] == 2'b00 & !first_time & global_counter_transfer == 4'd3)? !tx_sout:
		 ( enable_n_char     &  data_tx_i[8] & (EEP[2] == tx_dout) & data_tx_i[1:0] == 2'b01 & !first_time & global_counter_transfer == 4'd1)? !tx_sout:
		 ( enable_n_char     &  data_tx_i[8] & (EEP[1] == tx_dout) & data_tx_i[1:0] == 2'b01 & !first_time & global_counter_transfer == 4'd2)? !tx_sout:
		 ( enable_n_char     &  data_tx_i[8] & (EEP[0] == tx_dout) & data_tx_i[1:0] == 2'b01 & !first_time & global_counter_transfer == 4'd3)? !tx_sout:
		 tx_sout;


assign ready_tx_timecode = (enable_time_code & global_counter_transfer == 14)?1'b1:1'b0;

assign ready_tx_data     = (enable_n_char & global_counter_transfer == 4'd10  & !data_tx_i[8])?1'b1:
			   (enable_n_char & global_counter_transfer == 4'd4   &  data_tx_i[8])?1'b1:1'b0;

//slots open in another side
always@(posedge send_fct_tx or negedge enable_tx)
begin

	if(!enable_tx)
	begin
		fct_counter <= {6{1'b0}};
	end
	else if(gotfct_tx)
	begin
		fct_counter <= fct_counter + 6'd8;
	end
	else if(enable_n_char)
	begin
		fct_counter <= fct_counter - 6'd1;
	end

end

//slots open in our side
always@(posedge send_fct_now or negedge enable_tx)
begin

	if(!enable_tx)
	begin
		fct_send <= {3{1'b1}};
	end
	else
	begin
		if(enable_n_char && global_counter_transfer == 4'd10  && !data_tx_i[8])
		begin
			fct_send <= fct_send - 6'd1;
		end
		else if(enable_n_char & global_counter_transfer == 4'd4   &  data_tx_i[8])
		begin
			fct_send <= fct_send - 6'd1;
		end
		else
			fct_send <= fct_send + 6'd1;
	end

end

always@(*)
begin

	next_state_tx = state_tx;

	enable_null      = 1'b0;
	enable_fct       = 1'b0;
	enable_n_char    = 1'b0;
	enable_time_code = 1'b0;

	case(state_tx)
	tx_spw_start:
	begin
		if(send_null_tx && enable_tx)
		begin
			next_state_tx = tx_spw_null;
			enable_null = 1'b1;
		end
		else
		begin
			next_state_tx = tx_spw_start;
		end
	end
	tx_spw_null:
	begin
		if(send_null_tx && send_fct_tx && enable_tx)
		begin
			next_state_tx = tx_spw_null_fct;
		end
		else
		begin
			next_state_tx = tx_spw_null;
		end
	end
	tx_spw_null_fct:
	begin
		if(send_fct_tx && gotfct_tx)
		begin
			next_state_tx =  tx_spw_full;
		end
		else if(send_fct_tx && fct_send > 3'd0 && enable_null == 1'b0)
		begin
			enable_fct = 1'b1;
		end
		else if(send_fct_tx && enable_fct == 1'b0 && fct_send == 3'd0)
		begin
			enable_null = 1'b1;
		end
	end
	tx_spw_full:
	begin

		if(tickin_tx && enable_n_char == 1'b0 && enable_fct == 1'b0 && enable_null == 1'b0)
		begin
			enable_time_code = 1'b1;
		end 
		else if(fct_send > 3'd0 && enable_n_char == 1'b0 && enable_time_code == 1'b0 && enable_null == 1'b0)
		begin
			enable_fct = 1'b1;
		end
		else if(txwrite_tx && fct_counter > 6'd0 &&  enable_fct == 1'b0 && enable_time_code == 1'b0 && enable_null == 1'b0)
		begin
			enable_n_char = 1'b1;
		end
		else if(enable_fct == 1'b0 && enable_time_code == 1'b0 && enable_n_char == 1'b0)
		begin
			enable_null = 1'b1;
		end
	end
	endcase

end

always@(posedge pclk_tx)
begin
	if(!enable_tx)
	begin
		null_s <= 8'h74;
		fct_s  <= 4'h4;
		eop_s  <= 4'h5;
		eep_s  <= 4'h6;
		timecode_s <= 14'h1e00;

		//dout_last  <= 1'b0;
		first_time <= 1'b1;
		last_type  <= NULL;

		global_counter_transfer <= 4'd0;
		txdata_flagctrl_tx_last <= 9'd0;
		last_timein_control_flag_tx <= 8'd0;
		//state_tx <= tx_spw_start;
	end
	else
	begin
	
		state_tx <= next_state_tx;

		if(enable_null)
		begin
			if(first_time)
			begin
				first_time <= 1'b0;
				global_counter_transfer <= global_counter_transfer + 4'd1;
			end
			else if(global_counter_transfer < 4'd8)
			begin
				global_counter_transfer <= global_counter_transfer + 4'd1;
			end
			else
			begin
				global_counter_transfer <= 4'd0;
			end
		end
		else if(enable_fct)
		begin
			if(global_counter_transfer < 4'd4)
			begin
				global_counter_transfer <= global_counter_transfer + 4'd1;
			end
			else
			begin
				global_counter_transfer <= 4'd0;
			end
		end
		else if(enable_time_code)
		begin
			if(global_counter_transfer < 4'd14)
			begin
				global_counter_transfer <= global_counter_transfer + 4'd1;
				last_timein_control_flag_tx <= timecode_tx_i;
			end
			else
			begin
				global_counter_transfer <= 4'd0;
			end
		end
		else if(enable_n_char)
		begin
			if(global_counter_transfer < 4'd10 && !data_tx_i[8])
			begin
				global_counter_transfer <= global_counter_transfer + 4'd1;
				txdata_flagctrl_tx_last <= data_tx_i;
			end
			else if(global_counter_transfer < 4'd4 && data_tx_i[8])
			begin
				global_counter_transfer <= global_counter_transfer + 4'd1;
				txdata_flagctrl_tx_last <= data_tx_i;
			end
			else
			begin
				global_counter_transfer <= 4'd0;
			end
		end
		
	end
end

endmodule
