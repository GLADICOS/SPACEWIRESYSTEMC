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
		output reg tx_dout,
		output reg tx_sout,
		//
		output  reg ready_tx_data,
		output  reg ready_tx_timecode

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

	reg hold_null;
	reg hold_fct;
	reg hold_data;
	reg hold_time_code;

	reg enable_null;
	reg enable_fct;
	reg enable_n_char;
	reg enable_time_code;

	reg [2:0] fct_send;
	reg [2:0] fct_flag;

	reg [5:0] fct_counter;
	reg [5:0] fct_counter_receive;

	reg last_tx_dout;
	reg last_tx_sout;

	reg block_sum;
	reg block_sum_fct_send;

	reg [3:0] global_counter_transfer; 



always@(*)
begin
	tx_dout = 1'b0;

	 if(!enable_tx)
	 begin
	  	tx_dout = 1'b0;
	 end
	 else if( enable_null & first_time  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = null_s[7];
	 end
	 else if( enable_null & !first_time & last_type == NULL  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(null_s[6]^null_s[0]^null_s[1]);
	 end
	 else if( enable_null & !first_time & last_type == FCT   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(null_s[6]^fct_s[0]^fct_s[1]);
	 end
	 else if( enable_null & !first_time & last_type == EOP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(null_s[6]^eop_s[0]^eop_s[1]);
	 end
	 else if( enable_null & !first_time & last_type == EEP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(null_s[6]^eep_s[0]^eep_s[1]);
	 end
	 else if( enable_null & !first_time & last_type == DATA  & global_counter_transfer == 4'd0)
	 begin
		tx_dout =  !(null_s[6]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
	 end
	 else if( enable_null & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0)
	 begin
		tx_dout =  !(null_s[6]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
	 end
	 else if( enable_null & !first_time & global_counter_transfer == 4'd1)
	 begin
		tx_dout = null_s[6];
	 end
	 else if( enable_null & !first_time & global_counter_transfer == 4'd2)
	 begin
		tx_dout = null_s[5];
	 end
	 else if( enable_null & !first_time & global_counter_transfer == 4'd3)
	 begin
		tx_dout = null_s[4];
	 end
	 else if( enable_null & !first_time & global_counter_transfer == 4'd4)
	 begin
		tx_dout = null_s[3];
	 end
	 else if( enable_null & !first_time & global_counter_transfer == 4'd5)
	 begin
		tx_dout = null_s[2];
	 end
	 else if( enable_null & !first_time & global_counter_transfer == 4'd6)
	 begin
		tx_dout = null_s[1];
	 end
	 else if( enable_null & !first_time & global_counter_transfer == 4'd7)
	 begin
		tx_dout = null_s[0];
	 end
	 else if( enable_fct  & !first_time & last_type == NULL  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(fct_s[2]^null_s[0]^null_s[1]);
	 end
	 else if( enable_fct  & !first_time & last_type == FCT   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(fct_s[2]^fct_s[0]^fct_s[1]);
	 end
	 else if( enable_fct  & !first_time & last_type == EOP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(fct_s[2]^eop_s[0]^eop_s[1]);
	 end
	 else if( enable_fct  & !first_time & last_type == EEP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(fct_s[2]^eep_s[0]^eep_s[1]);
	 end
	 else if ( enable_fct  & !first_time & last_type == DATA  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(fct_s[2]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
	 end
	 else if( enable_fct  & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(fct_s[2]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
	 end
	 else if( enable_fct  & !first_time & global_counter_transfer == 4'd1)
	 begin
		tx_dout = fct_s[2];
	 end
	 else if( enable_fct  & !first_time & global_counter_transfer == 4'd2)
	 begin
		tx_dout = fct_s[1];
	 end
	 else if( enable_fct  & !first_time & global_counter_transfer == 4'd3)
	 begin
		tx_dout = fct_s[0];
	 end	
	 else if( enable_time_code & !first_time & last_type == NULL  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(timecode_s[12]^null_s[0]^null_s[1]);
	 end
	 else if( enable_time_code & !first_time & last_type == FCT   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(timecode_s[12]^fct_s[0]^fct_s[1]);
	 end
	 else if ( enable_time_code & !first_time & last_type == EOP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(timecode_s[12]^eop_s[0]^eop_s[1]);
	 end
	 else if( enable_time_code & !first_time & last_type == EEP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(timecode_s[12]^eep_s[0]^eep_s[1]);
	 end
	 else if( enable_time_code & !first_time & last_type == DATA  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(timecode_s[12]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
	 end
	 else if( enable_time_code & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(timecode_s[12]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd1)
	 begin
		tx_dout = timecode_s[12];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd2)
	 begin
		tx_dout = timecode_s[11];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd3)
	 begin
		tx_dout = timecode_s[10];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd4)
	 begin
		tx_dout = timecode_s[9];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd5)
	 begin
		tx_dout = timecode_s[8];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd6)
	 begin
		tx_dout = timecode_s[0];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd7)
	 begin
		tx_dout = timecode_s[1];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd8)
	 begin
		tx_dout = timecode_s[2];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd9)
	 begin
		tx_dout = timecode_s[3];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd10)
	 begin
		tx_dout = timecode_s[4];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd11)
	 begin
		tx_dout = timecode_s[5];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd12)
	 begin
		tx_dout = timecode_s[6];
	 end
	 else if( enable_time_code & !first_time & global_counter_transfer == 4'd13)
	 begin
		tx_dout = timecode_s[7];
	 end
	 else if( enable_n_char   & !data_tx_i[8] & !first_time & last_type == NULL  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(data_tx_i[8]^null_s[0]^null_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & !first_time & last_type == FCT   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(data_tx_i[8]^fct_s[0]^fct_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & !first_time & last_type == EOP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(data_tx_i[8]^eop_s[0]^eop_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & !first_time & last_type == EEP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(data_tx_i[8]^eep_s[0]^eep_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & !first_time & last_type == DATA  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(data_tx_i[8]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(data_tx_i[8]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
	 end
	 else if( enable_n_char   & data_tx_i[8]  & data_tx_i[1:0] == 2'b00 &  !first_time & last_type == NULL  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eop_s[3]^null_s[0]^null_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & data_tx_i[1:0] == 2'b00 & !first_time & last_type == FCT   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eop_s[3]^fct_s[0]^fct_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & data_tx_i[1:0] == 2'b00 & !first_time & last_type == EOP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eop_s[3]^eop_s[0]^eop_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & data_tx_i[1:0] == 2'b00 & !first_time & last_type == EEP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eop_s[3]^eep_s[0]^eep_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8]  & data_tx_i[1:0] == 2'b00 & !first_time & last_type == DATA  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eop_s[3]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
	 end
	 else if( enable_n_char   & !data_tx_i[8]  & data_tx_i[1:0] == 2'b00 & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eop_s[3]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
	 end
	 else if( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b00 & !first_time & global_counter_transfer == 4'd1)
	 begin
		tx_dout = eop_s[2];
	 end
	 else if( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b00 & !first_time & global_counter_transfer == 4'd2)
	 begin
		tx_dout = eop_s[1];
	 end
	 else if( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b00 & !first_time & global_counter_transfer == 4'd3)
	 begin
		tx_dout = eop_s[0];
	 end
	 else if( enable_n_char   & data_tx_i[8]  & data_tx_i[1:0] == 2'b01 &  !first_time & last_type == NULL  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eep_s[3]^null_s[0]^null_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & data_tx_i[1:0] == 2'b01 & !first_time & last_type == FCT   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eep_s[3]^fct_s[0]^fct_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & data_tx_i[1:0] == 2'b01 & !first_time & last_type == EOP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eep_s[3]^eop_s[0]^eop_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & data_tx_i[1:0] == 2'b01 & !first_time & last_type == EEP   & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eep_s[3]^eep_s[0]^eep_s[1]);
	 end
	 else if( enable_n_char   & !data_tx_i[8]  & data_tx_i[1:0] == 2'b01 & !first_time & last_type == DATA  & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eep_s[3]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
	 end
	 else if( enable_n_char   & !data_tx_i[8]  & data_tx_i[1:0] == 2'b01 & !first_time & last_type == TIMEC & global_counter_transfer == 4'd0)
	 begin
		tx_dout = !(eep_s[3]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
	 end
	 else if( enable_n_char   & !data_tx_i[8] & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd1)
	 begin
		tx_dout = data_tx_i[8];
	 end
	 else if( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd2)
	 begin
		tx_dout = data_tx_i[0];
	 end
	 else if( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd3)
	 begin
		tx_dout = data_tx_i[1];
	 end
	 else if( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd4)
	 begin
		tx_dout = data_tx_i[2];
	 end
	 else if( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd5)
	 begin
		tx_dout = data_tx_i[3];
	 end
	 else if( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd6)
	 begin
		tx_dout = data_tx_i[4];
	 end
	 else if( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd7)
	 begin
		tx_dout = data_tx_i[5];
	 end
	 else if( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd8)
	 begin
		tx_dout = data_tx_i[6];
	 end
	 else if( enable_n_char    & !data_tx_i[8] & !first_time & global_counter_transfer == 4'd9)
	 begin
		tx_dout = data_tx_i[7];
	 end
	 else if( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b01 & !first_time & global_counter_transfer == 4'd1)
	 begin
		tx_dout = eep_s[2];
	 end
	 else if( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b01 & !first_time & global_counter_transfer == 4'd2)
	 begin
		tx_dout = eep_s[1];
	 end
	 else if( enable_n_char    &  data_tx_i[8] & data_tx_i[1:0] == 2'b01 & !first_time & global_counter_transfer == 4'd3)
	 begin
		tx_dout = eep_s[0];
	 end
end
	
//strobe
always@(*)
begin
	tx_sout = 1'b0;

	if(!enable_tx)
	begin
		tx_sout = 1'b0;
	end 
	else if((enable_null | enable_fct | enable_n_char | enable_time_code) && tx_dout == last_tx_dout)
	begin
		tx_sout = !last_tx_sout;
	end
	else if((enable_null | enable_fct | enable_n_char | enable_time_code) && tx_dout != last_tx_dout)
	begin
		tx_sout = last_tx_sout;	
	end	
	
end

always@(*)
begin
	fct_counter = 6'd0;

	if(gotfct_tx)
	begin
		if(block_sum)
		begin

		end
		else
		begin
			if(fct_counter_receive < 6'd48) 
			begin
				fct_counter = fct_counter_receive + 6'd8;
			end
			else
			begin
				fct_counter = fct_counter_receive + 6'd7;
			
			end
		end
	end
end

//slots open in our side
always@(*)
begin

	fct_send = {3{1'b0}};

	if(send_fct_now)
	begin
		if(block_sum_fct_send)
		begin

		end
		else
		begin
			if(fct_flag == 3'd7) 
			begin
				fct_send = 3'd0;
			end
			else
			begin
				fct_send = fct_flag + 3'd1;
			
			end
		end
	end
end


always@(*)
begin


	enable_null      = 1'b0;
	enable_fct       = 1'b0;
	enable_n_char    = 1'b0;
	enable_time_code = 1'b0;

	next_state_tx = state_tx;

	case(state_tx)
	tx_spw_start:
	begin
		if(send_null_tx && enable_tx)
		begin
			//if(!hold_null)
				next_state_tx = tx_spw_null;
			
			//enable_null = 1'b1;
		end
		else
		begin
			next_state_tx = tx_spw_start;
		end
	end
	tx_spw_null:
	begin
		enable_null = 1'b1;

		if(!hold_null)
		begin
			if(send_null_tx && send_fct_tx && enable_tx)
				next_state_tx = tx_spw_null_fct;
			else
				next_state_tx = tx_spw_null;	
		end

	end
	tx_spw_null_fct:
	begin

		enable_null   = 1'b1;

		if(send_fct_tx && fct_flag > 0  && !hold_null)
		begin
			next_state_tx = tx_spw_null_fct;
			enable_null = 1'b0;
			enable_fct  = 1'b1;
		end
		else
		begin
			enable_fct = 1'b0;
			if(send_fct_tx && fct_counter_receive > 6'd0)
			begin
				//if(global_counter_transfer == 4'd7)
					next_state_tx =  tx_spw_full;
			end

		end
	end
	tx_spw_full:
	begin
		if(tickin_tx && !hold_null && !hold_fct && !hold_data)
		begin
			enable_time_code = 1'b1;
		end 
		else if(fct_flag > 3'd0 && !hold_null && !hold_time_code && !hold_data)
		begin
			enable_fct  = 1'b1;
		end
		else if((txwrite_tx && fct_counter_receive > 6'd0 && !hold_null && !hold_time_code && !hold_fct) == 1'b1 )
		begin
			enable_n_char = 1'b1;				
		end
		else
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
		null_s        <= 8'b01110100;
		fct_s         <= 4'b0100;
		eop_s         <= 4'b0101;
		eep_s         <= 4'b0110;
		timecode_s    <= 14'b01110000000000;
		
		fct_flag      <= 3'd7;

		first_time 	  <= 1'b1;
		ready_tx_data	  <= 1'b0;
		ready_tx_timecode <= 1'b0;

		hold_null	<= 1'b0;
		hold_fct	<= 1'b0;
		hold_data	<= 1'b0;
		hold_time_code	<= 1'b0;

		last_type  <= NULL;

		global_counter_transfer <= 4'd0;
		txdata_flagctrl_tx_last <= 9'd0;
		last_timein_control_flag_tx <= 8'd0;

		fct_counter_receive <= 6'd0;
	
		block_sum  <= 1'b0;
		block_sum_fct_send <= 1'b0;

		last_tx_dout      <= 1'b0;
		last_tx_sout 	  <= 1'b0;
		state_tx <= tx_spw_start;

	end
	else
	begin
	
		state_tx <= next_state_tx;
		last_tx_dout <= tx_dout;
		last_tx_sout <= tx_sout;

		if(enable_null)
		begin

			ready_tx_data <= 1'b0;
			ready_tx_timecode <= 1'b0;
			//
			if(gotfct_tx && !block_sum)
			begin
				fct_counter_receive <= fct_counter;
				block_sum<= 1'b1;
			end
			else if(!gotfct_tx)
			begin
				block_sum<= 1'b0;
			end
			else
				block_sum <= block_sum;
			//
			if(send_fct_now && !block_sum_fct_send)
			begin
				fct_flag <= fct_send;
				block_sum_fct_send<= 1'b1;
			end
			else if(!send_fct_now)
			begin
				block_sum_fct_send<= 1'b0;
			end
			else
				block_sum_fct_send <= block_sum_fct_send;

			if(first_time)
			begin
				first_time <= 1'b0;
				hold_null  <= 1'b1;
				global_counter_transfer <= global_counter_transfer + 4'd1;
			end
			else if(global_counter_transfer != 4'd7)
			begin
				hold_null <= 1'b1;
				global_counter_transfer <= global_counter_transfer + 4'd1;
			end
			else
			begin
				hold_null <= 1'b0;
				global_counter_transfer <= 4'd0;
			end
		end
		else if(enable_fct)
		begin

			ready_tx_data <= 1'b0;
			ready_tx_timecode <= 1'b0;

			if(gotfct_tx && !block_sum)
			begin
				fct_counter_receive <= fct_counter;
				block_sum<= 1'b1;
			end
			else if(!gotfct_tx)
			begin
				block_sum<= 1'b0;
			end
			else
				block_sum <= block_sum;


			if(global_counter_transfer != 4'd3)
			begin
				hold_fct <= 1'b1;
				global_counter_transfer <= global_counter_transfer + 4'd1;
				//
				if(send_fct_now && !block_sum_fct_send)
				begin
					fct_flag <= fct_send;
					block_sum_fct_send<= 1'b1;
				end
				else if(!send_fct_now)
				begin
					block_sum_fct_send<= 1'b0;
				end
				else
					block_sum_fct_send <= block_sum_fct_send;
			end
			else
			begin
				hold_fct <= 1'b0;
				global_counter_transfer <= 4'd0;
				fct_flag <= fct_flag - 3'd1;
			end
		end
		else if(enable_time_code)
		begin
								
			ready_tx_data <= 1'b0;

			if(gotfct_tx && !block_sum)
			begin
				fct_counter_receive <= fct_counter;
				block_sum<= 1'b1;
			end
			else if(!gotfct_tx)
			begin
				block_sum<= 1'b0;
			end
			else
				block_sum <= block_sum;

			if(global_counter_transfer == 4'd13)
			begin
				ready_tx_timecode <= 1'b1;
			end

			//
			if(send_fct_now && !block_sum_fct_send)
			begin
				fct_flag <= fct_send;
				block_sum_fct_send<= 1'b1;
			end
			else if(!send_fct_now)
			begin
				block_sum_fct_send<= 1'b0;
			end
			else
				block_sum_fct_send <= block_sum_fct_send;

			if(global_counter_transfer < 4'd13)
			begin
				global_counter_transfer <= global_counter_transfer + 4'd1;
				timecode_s <= {timecode_s[13:10],2'd2,timecode_tx_i[7:0]};
			end
			else
			begin
				last_timein_control_flag_tx <= timecode_tx_i;
				global_counter_transfer <= 4'd0;
			end
		end
		else if(enable_n_char)
		begin
			
			ready_tx_timecode <= 1'b0;

			//
			if(send_fct_now && !block_sum_fct_send)
			begin
				fct_flag <= fct_send;
				block_sum_fct_send<= 1'b1;
			end
			else if(!send_fct_now)
			begin
				block_sum_fct_send<= 1'b0;
			end
			else
				block_sum_fct_send <= block_sum_fct_send;

			if(!data_tx_i[8])
			begin

				if(global_counter_transfer == 4'd9)
				begin
					ready_tx_data <= 1'b1;
				end
				else
				begin
					ready_tx_data <= 1'b0;
				end

				if(global_counter_transfer != 4'd9)
				begin
					hold_data <= 1'b1;
					global_counter_transfer <= global_counter_transfer + 4'd1;
					txdata_flagctrl_tx_last <= data_tx_i;

					if(gotfct_tx && !block_sum)
					begin
						fct_counter_receive <= fct_counter;
						block_sum<= 1'b1;
					end
					else if(!gotfct_tx)
					begin
						block_sum<= 1'b0;
					end
					else
						block_sum <= block_sum;
				end
				else
				begin
					hold_data <= 1'b0;
					global_counter_transfer <= 4'd0;
					fct_counter_receive <= fct_counter_receive - 6'd1;
				end

			end
			else if(data_tx_i[8])
			begin

				if(global_counter_transfer == 4'd3)
				begin
					ready_tx_data <= 1'b1;
				end
				else
				begin
					ready_tx_data <= 1'b0;
				end

				if(global_counter_transfer != 4'd3)
				begin
					hold_data <= 1'b1;
					global_counter_transfer <= global_counter_transfer + 4'd1;
					txdata_flagctrl_tx_last <= data_tx_i;

					if(gotfct_tx && !block_sum)
					begin
						fct_counter_receive <= fct_counter;
						block_sum<= 1'b1;
					end
					else if(!gotfct_tx)
					begin
						block_sum<= 1'b0;
					end
					else
						block_sum <= block_sum;
				end
				else
				begin

					hold_data <= 1'b0;
					global_counter_transfer <= 4'd0;
					fct_counter_receive <= fct_counter_receive - 6'd1;
				end
			end

		end
		
	end
end

endmodule
