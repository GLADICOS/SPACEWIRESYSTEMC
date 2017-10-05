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
		output reg tx_dout_e,
		output reg tx_sout_e,
		//
		output  reg ready_tx_data,
		output  reg ready_tx_timecode

		);

localparam [6:0] tx_spw_start              = 7'b0000000,
	   	 tx_spw_null               = 7'b0000001,
	   	 tx_spw_fct                = 7'b0000010,
	   	 tx_spw_null_c             = 7'b0000100,
	   	 tx_spw_fct_c              = 7'b0001000,
	   	 tx_spw_data_c             = 7'b0010000,
	   	 tx_spw_time_code_c        = 7'b0100000;

localparam [5:0] NULL     = 6'b000001,
		 FCT      = 6'b000010,
		 EOP      = 6'b000100,
		 EEP      = 6'b001000,
		 DATA     = 6'b010000,
		 TIMEC    = 6'b100000;


localparam [7:0] null_s = 8'b01110100;
localparam [2:0] fct_s  = 3'b100;
localparam [3:0] eop_s  = 4'b0101;
localparam [3:0] eep_s  = 4'b0110;
localparam [13:0] timecode_ss    = 14'b01110000000000;



	reg [6:0] state_tx;
	reg [6:0] next_state_tx;

	reg [13:0] timecode_s;

	reg [5:0]  last_type;
	reg [8:0]  txdata_flagctrl_tx_last;
	reg [8:0]  tx_data_in;
	reg data_rdy_trnsp;
	reg [7:0]  last_timein_control_flag_tx;
	reg [7:0]  tx_tcode_in;
	reg tcode_rdy_trnsp;

	reg [2:0] fct_send;
	reg [2:0] fct_flag;

	reg [5:0] fct_counter_receive;

	reg block_increment;
	reg block_decrement;
	reg char_sent;

	reg block_increment_fct_send;
	reg block_decrement_fct_send;
	reg fct_sent;

	reg last_tx_dout;
	reg last_tx_sout;

	reg tx_dout;
	reg tx_sout;

	reg tx_dout_null;
	reg tx_dout_fct;
	reg tx_dout_timecode;
	reg tx_dout_data;

	reg [3:0] global_counter_transfer; 



always@(*)
begin
		tx_dout = last_tx_dout;

		case(state_tx)
		tx_spw_start:
		begin
		end
		tx_spw_null,tx_spw_null_c:
		begin
			 if(last_type == NULL  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(null_s[6]^null_s[0]^null_s[1]);
			 end
			 else if(last_type == FCT  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(null_s[6]^fct_s[0]^fct_s[1]);
			 end
			 else if(last_type == EOP  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(null_s[6]^eop_s[0]^eop_s[1]);
			 end
			 else if(last_type == EEP  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(null_s[6]^eep_s[0]^eep_s[1]);
			 end
			 else if(last_type == DATA  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout =  !(null_s[6]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
			 end
			 else if(last_type == TIMEC && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout =  !(null_s[6]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
			 end
			 else if(global_counter_transfer[3:0] == 4'd1)
			 begin
				tx_dout = null_s[6];
			 end
			 else if(global_counter_transfer[3:0] == 4'd2)
			 begin
				tx_dout = null_s[5];
			 end
			 else if(global_counter_transfer[3:0] == 4'd3)
			 begin
				tx_dout = null_s[4];
			 end
			 else if(global_counter_transfer[3:0] == 4'd4)
			 begin
				tx_dout = null_s[3];
			 end
			 else if(global_counter_transfer[3:0] == 4'd5)
			 begin
				tx_dout = null_s[2];
			 end
			 else if(global_counter_transfer[3:0] == 4'd6)
			 begin
				tx_dout = null_s[1];
			 end
			 else if(global_counter_transfer[3:0] == 4'd7)
			 begin
				tx_dout = null_s[0];
			 end
		end
		tx_spw_fct,tx_spw_fct_c:
		begin
			 if(last_type == NULL  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(fct_s[2]^null_s[0]^null_s[1]);
			 end
			 else if(last_type == FCT  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(fct_s[2]^fct_s[0]^fct_s[1]);
			 end
			 else if(last_type == EOP  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(fct_s[2]^eop_s[0]^eop_s[1]);
			 end
			 else if(last_type == EEP  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(fct_s[2]^eep_s[0]^eep_s[1]);
			 end
			 else if (last_type == DATA && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(fct_s[2]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
			 end
			 else if(last_type == TIMEC && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(fct_s[2]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
			 end
			 else if(global_counter_transfer[3:0] == 4'd1)
			 begin
				tx_dout = fct_s[2];
			 end
			 else if(global_counter_transfer[3:0] == 4'd2)
			 begin
				tx_dout = fct_s[1];
			 end
			 else if(global_counter_transfer[3:0] == 4'd3)
			 begin
				tx_dout = fct_s[0];
			 end
		end
	   	tx_spw_data_c:
		begin
			if(!tx_data_in[8] && last_type == NULL  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(tx_data_in[8]^null_s[0]^null_s[1]);
			 end
			 else if(!tx_data_in[8] && last_type == FCT && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(tx_data_in[8]^fct_s[0]^fct_s[1]);
			 end
			 else if(!tx_data_in[8] && last_type == EOP  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(tx_data_in[8]^eop_s[0]^eop_s[1]);
			 end
			 else if(!tx_data_in[8] && last_type == EEP  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(tx_data_in[8]^eep_s[0]^eep_s[1]);
			 end
			 else if(!tx_data_in[8] && last_type == DATA  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(tx_data_in[8]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
			 end
			 else if(!tx_data_in[8] && last_type == TIMEC && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(tx_data_in[8]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
			 end
			 else if(tx_data_in[8]  && tx_data_in[1:0] == 2'b00 && last_type == NULL  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eop_s[2]^null_s[0]^null_s[1]);
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b00 && last_type == FCT   && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eop_s[2]^fct_s[0]^fct_s[1]);
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b00 && last_type == EOP  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eop_s[2]^eop_s[0]^eop_s[1]);
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b00 && last_type == EEP  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eop_s[2]^eep_s[0]^eep_s[1]);
			 end
			 else if(tx_data_in[8]  && tx_data_in[1:0] == 2'b00 && last_type == DATA  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eop_s[2]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
			 end
			 else if(tx_data_in[8]  && tx_data_in[1:0] == 2'b00 && last_type == TIMEC && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eop_s[2]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b01 && last_type == NULL  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eep_s[2]^null_s[0]^null_s[1]);
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b01 && last_type == FCT  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eep_s[2]^fct_s[0]^fct_s[1]);
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b01 && last_type == EOP  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eep_s[2]^eop_s[0]^eop_s[1]);
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b01 && last_type == EEP && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eep_s[2]^eep_s[0]^eep_s[1]);
			 end
			 else if(tx_data_in[8]  && tx_data_in[1:0] == 2'b01 && last_type == DATA && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eep_s[2]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
			 end
			 else if(tx_data_in[8]  &&  tx_data_in[1:0] == 2'b01 && last_type == TIMEC && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(eep_s[2]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
			 end
			 else if(!tx_data_in[8] &&  global_counter_transfer[3:0] == 4'd1)
			 begin
				tx_dout = tx_data_in[8];
			 end
			 else if(!tx_data_in[8] && global_counter_transfer[3:0] == 4'd2)
			 begin
				tx_dout = tx_data_in[0];
			 end
			 else if(!tx_data_in[8] &&  global_counter_transfer[3:0] == 4'd3)
			 begin
				tx_dout = tx_data_in[1];
			 end
			 else if(!tx_data_in[8] && global_counter_transfer[3:0] == 4'd4)
			 begin
				tx_dout = tx_data_in[2];
			 end
			 else if(!tx_data_in[8]  && global_counter_transfer[3:0] == 4'd5)
			 begin
				tx_dout = tx_data_in[3];
			 end
			 else if(!tx_data_in[8]  && global_counter_transfer[3:0] == 4'd6)
			 begin
				tx_dout = tx_data_in[4];
			 end
			 else if(!tx_data_in[8]  && global_counter_transfer[3:0] == 4'd7)
			 begin
				tx_dout = tx_data_in[5];
			 end
			 else if(!tx_data_in[8] &&  global_counter_transfer[3:0] == 4'd8)
			 begin
				tx_dout = tx_data_in[6];
			 end
			 else if(!tx_data_in[8] &&  global_counter_transfer[3:0] == 4'd9)
			 begin
				tx_dout = tx_data_in[7];
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b01 && global_counter_transfer[3:0] == 4'd1)
			 begin
				tx_dout = eep_s[2];
			 end
			 else if( tx_data_in[8] && tx_data_in[1:0] == 2'b01 && global_counter_transfer[3:0] == 4'd2)
			 begin
				tx_dout = eep_s[1];
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b01 && global_counter_transfer[3:0] == 4'd3)
			 begin
				tx_dout = eep_s[0];
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b00 && global_counter_transfer[3:0] == 4'd1)
			 begin
				tx_dout = eop_s[2];
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b00 && global_counter_transfer[3:0] == 4'd2)
			 begin
				tx_dout = eop_s[1];
			 end
			 else if(tx_data_in[8] && tx_data_in[1:0] == 2'b00 && global_counter_transfer[3:0] == 4'd3)
			 begin
				tx_dout = eop_s[0];
			 end
		end
	   	tx_spw_time_code_c:
		begin
			 if(last_type == NULL  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(timecode_s[12]^null_s[0]^null_s[1]);
			 end
			 else if(last_type == FCT   && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(timecode_s[12]^fct_s[0]^fct_s[1]);
			 end
			 else if (last_type == EOP   && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(timecode_s[12]^eop_s[0]^eop_s[1]);
			 end
			 else if( last_type == EEP   && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(timecode_s[12]^eep_s[0]^eep_s[1]);
			 end
			 else if( last_type == DATA  && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(timecode_s[12]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
			 end
			 else if( last_type == TIMEC && global_counter_transfer[3:0] == 4'd0)
			 begin
				tx_dout = !(timecode_s[12]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
			 end
			 else if( global_counter_transfer[3:0] == 4'd1)
			 begin
				tx_dout = timecode_s[12];
			 end
			 else if( global_counter_transfer[3:0] == 4'd2)
			 begin
				tx_dout = timecode_s[11];
			 end
			 else if( global_counter_transfer[3:0] == 4'd3)
			 begin
				tx_dout = timecode_s[10];
			 end
			 else if( global_counter_transfer[3:0] == 4'd4)
			 begin
				tx_dout = timecode_s[9];
			 end
			 else if( global_counter_transfer[3:0] == 4'd5)
			 begin
				tx_dout = timecode_s[8];
			 end
			 else if( global_counter_transfer[3:0] == 4'd6)
			 begin
				tx_dout = timecode_s[0];
			 end
			 else if( global_counter_transfer[3:0] == 4'd7)
			 begin
				tx_dout = timecode_s[1];
			 end
			 else if( global_counter_transfer[3:0] == 4'd8)
			 begin
				tx_dout = timecode_s[2];
			 end
			 else if(global_counter_transfer[3:0] == 4'd9)
			 begin
				tx_dout = timecode_s[3];
			 end
			 else if(global_counter_transfer[3:0] == 4'd10)
			 begin
				tx_dout = timecode_s[4];
			 end
			 else if(global_counter_transfer[3:0] == 4'd11)
			 begin
				tx_dout = timecode_s[5];
			 end
			 else if( global_counter_transfer[3:0] == 4'd12)
			 begin
				tx_dout = timecode_s[6];
			 end
			 else if(global_counter_transfer[3:0] == 4'd13)
			 begin
				tx_dout = timecode_s[7];
			 end
		end
		default:
		begin
		end
		endcase
end

//strobe
always@(*)
begin

	tx_sout = last_tx_sout;

	if(tx_dout == last_tx_dout)
	begin
		tx_sout = !last_tx_sout;
	end
	else if(tx_dout != last_tx_dout)
	begin
		tx_sout = last_tx_sout;	
	end
end


always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin
		fct_flag <= 3'd7;
		block_increment_fct_send <= 1'b0;
		block_decrement_fct_send <= 1'b0;
	end
	else
	begin

		if(block_increment_fct_send)
		begin
			if(!send_fct_now)
				block_increment_fct_send <= 1'b0;
		end
		else if(send_fct_now && !block_increment_fct_send)
		begin
			block_increment_fct_send <= 1'b1;
		end
		else
			block_increment_fct_send <= block_increment_fct_send;

		if(block_decrement_fct_send)
		begin
			if(!fct_sent)
				block_decrement_fct_send <= 1'b0;
		end
		else if(fct_sent && !block_decrement_fct_send)
		begin
			block_decrement_fct_send <= 1'b1;
		end
		else
			block_decrement_fct_send <= block_decrement_fct_send;


		if((send_fct_now && !block_increment_fct_send) && (fct_sent && !block_decrement_fct_send))
		begin
			fct_flag <= fct_flag;
		end
		else if (send_fct_now && !block_increment_fct_send)
		begin
			fct_flag <= fct_flag + 3'd1;
		end
		else if(fct_sent && !block_decrement_fct_send)
		begin
			fct_flag <= fct_flag - 3'd1;
		end
		else 
			fct_flag <= fct_flag;
	end
end




always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin
		fct_counter_receive<= 6'd0;
		block_increment <= 1'b0;
		block_decrement <= 1'b0;
	end
	else
	begin

		if(block_increment)
		begin
			if(!gotfct_tx)
				block_increment <= 1'b0;
		end
		else if(gotfct_tx && !block_increment)
		begin
			block_increment <= 1'b1;
		end
		else
			block_increment <= block_increment;

		if(block_decrement)
		begin
			if(!char_sent)
				block_decrement <= 1'b0;
		end
		else if(char_sent && !block_decrement)
		begin
			block_decrement <= 1'b1;
		end
		else
			block_decrement <= block_decrement;



		if((gotfct_tx && !block_increment) && (char_sent && !block_decrement))
		begin
			if(fct_counter_receive < 6'd48) 
			begin
				fct_counter_receive <= fct_counter_receive + 6'd7;
			end
			else
			begin
				fct_counter_receive <= fct_counter_receive + 6'd6;
			
			end
		end
		else if (gotfct_tx && !block_increment)
		begin
			if(fct_counter_receive < 6'd48) 
			begin
				fct_counter_receive <= fct_counter_receive + 6'd8;
			end
			else
			begin
				fct_counter_receive <= fct_counter_receive + 6'd7;
			end
		end
		else if(char_sent && !block_decrement)
		begin
			fct_counter_receive <= fct_counter_receive - 6'd1;
		end
		else 
			fct_counter_receive <= fct_counter_receive;
	end
end

always@(*)
begin
	next_state_tx = state_tx;

	case(state_tx)
	tx_spw_start:
	begin
		if(send_null_tx && enable_tx)
		begin
			next_state_tx = tx_spw_null;	
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
			if(global_counter_transfer == 4'd0)
				next_state_tx = tx_spw_fct;
		end
		else
			next_state_tx = tx_spw_null;
	end
	tx_spw_fct:
	begin
		if(send_fct_tx && fct_flag > 0)
		begin
			next_state_tx = tx_spw_fct;
		end
		else
		begin
			if(send_fct_tx && fct_counter_receive > 6'd0)
			begin
				if(global_counter_transfer == 4'd0)
				begin
					if(tickin_tx && !ready_tx_timecode && tcode_rdy_trnsp)
					begin
						next_state_tx = tx_spw_time_code_c;
					end 
					else if(fct_flag > 3'd0)
					begin
						next_state_tx = tx_spw_fct_c;
					end
					else if(txwrite_tx && !ready_tx_data && data_rdy_trnsp && fct_counter_receive > 6'd0)
					begin
						next_state_tx = tx_spw_data_c;				
					end
					else 
					begin
						next_state_tx = tx_spw_null_c;
					end
				end
			end
		end
	end
	tx_spw_null_c:
	begin
		if(global_counter_transfer == 4'd7)
		begin
			if(tickin_tx && !ready_tx_timecode && tcode_rdy_trnsp)
			begin
				next_state_tx = tx_spw_time_code_c;
			end 
			else if(fct_flag > 3'd0)
			begin
				next_state_tx = tx_spw_fct_c;
			end
			else if(txwrite_tx && !ready_tx_data && data_rdy_trnsp && fct_counter_receive > 6'd0)
			begin
				next_state_tx = tx_spw_data_c;				
			end
			else 
			begin
				next_state_tx = tx_spw_null_c;
			end
		end
		else
		begin
			next_state_tx = tx_spw_null_c;
		end
	end
	tx_spw_fct_c:
	begin
		if(global_counter_transfer == 4'd3)
		begin
			if(tickin_tx && !ready_tx_timecode && tcode_rdy_trnsp)
			begin
				next_state_tx = tx_spw_time_code_c;
			end 
			else 
			begin
				next_state_tx = tx_spw_null_c;
			end
		end
		else
		begin
			next_state_tx = tx_spw_fct_c;
		end
	end
	tx_spw_data_c:
	begin

		if(!tx_data_in[8])
		begin
			if(global_counter_transfer == 4'd9)
			begin
				if(tickin_tx && !ready_tx_timecode && tcode_rdy_trnsp)
				begin
					next_state_tx = tx_spw_time_code_c;
				end 
				else if(fct_flag > 3'd0)
				begin
					next_state_tx = tx_spw_fct_c;
				end
				else 
				begin
					next_state_tx = tx_spw_null_c;
				end
			end
			else
				next_state_tx = tx_spw_data_c;			
		end
		else if(tx_data_in[8])
		begin
			if(global_counter_transfer == 4'd3)
			begin
				if(tickin_tx && !ready_tx_timecode && tcode_rdy_trnsp)
				begin
					next_state_tx = tx_spw_time_code_c;
				end 
				else if(fct_flag > 3'd0)
				begin
					next_state_tx = tx_spw_fct_c;
				end
				else 
				begin
					next_state_tx = tx_spw_null_c;
				end
			end
			else
				next_state_tx = tx_spw_data_c;	
		end
		

	end
	tx_spw_time_code_c:
	begin
		if(global_counter_transfer == 4'd13)
		begin
			if(fct_flag > 3'd0)
			begin
				next_state_tx = tx_spw_fct_c;
			end
			else if(txwrite_tx && !ready_tx_data && data_rdy_trnsp && fct_counter_receive > 6'd0 )
			begin
				next_state_tx = tx_spw_data_c;				
			end
			else 
			begin
				next_state_tx = tx_spw_null_c;
			end
		end
		else
		begin
			next_state_tx = tx_spw_time_code_c;
		end
	end
	default:
	begin
		next_state_tx = tx_spw_start;
	end
	endcase
end


always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin

		timecode_s    <= 14'b01110000000000;	

		ready_tx_data	  <= 1'b0;
		ready_tx_timecode <= 1'b0;

		last_type  <= NULL;

		global_counter_transfer <= 4'd0;
		txdata_flagctrl_tx_last <= 9'd0;
		tx_data_in <= 9'd0; 
		last_timein_control_flag_tx <= 8'd0;

		char_sent<= 1'b0;
		fct_sent <= 1'b0;

		last_tx_dout      <= 1'b0;
		last_tx_sout 	  <= 1'b0;

		state_tx <= tx_spw_start;

		tx_dout_e <= 1'b0;
		tx_sout_e <= 1'b0;

		data_rdy_trnsp <= 1'b0;

		tx_tcode_in     <= 8'd0;
		tcode_rdy_trnsp <= 1'b0;

	end
	else
	begin
		state_tx <= next_state_tx;

		case(state_tx)
		tx_spw_start:
		begin
		end
		tx_spw_null:
		begin

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			tx_dout_e <= last_tx_dout;
			tx_sout_e <= last_tx_sout;


 			if(txwrite_tx && global_counter_transfer == 4'd5)
			begin
				tx_data_in <= data_tx_i;
				data_rdy_trnsp <= 1'b1;
			end
			else
				tx_data_in <= tx_data_in;

 			if(tickin_tx && global_counter_transfer == 4'd5)
			begin
				tx_tcode_in <= timecode_tx_i;
				tcode_rdy_trnsp <= 1'b1;
			end
			else
				tx_tcode_in <= tx_tcode_in;

			if(global_counter_transfer == 4'd3)
			begin
				ready_tx_timecode <= 1'b0;
				ready_tx_data <= 1'b0;
			end
			else
			begin
				ready_tx_timecode <= ready_tx_timecode;
				ready_tx_data <= ready_tx_data;
			end

			if(global_counter_transfer == 4'd7)
			begin
				last_type  <= NULL;
				global_counter_transfer <= 4'd0;
			end
			else
			begin
				last_type  <= last_type;
				global_counter_transfer <= global_counter_transfer + 4'd1;
			end
			fct_sent <= 0;
		end
		tx_spw_fct:
		begin

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			tx_dout_e <= last_tx_dout;
			tx_sout_e <= last_tx_sout;

	
			ready_tx_data <= ready_tx_data;

			if(global_counter_transfer == 4'd3)
			begin
				last_type  <=FCT;
				global_counter_transfer <= 4'd0;
				fct_sent <= 0;
			end
			else
			begin

				if(fct_flag > 0)
					fct_sent <= 1;
				else
					fct_sent <= fct_sent;

				global_counter_transfer <= global_counter_transfer + 4'd1;
			end
		end
		tx_spw_null_c:
		begin

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			tx_dout_e <= last_tx_dout;
			tx_sout_e <= last_tx_sout;


 			if(txwrite_tx && global_counter_transfer == 4'd5)
			begin
				tx_data_in <= data_tx_i;
				data_rdy_trnsp <= 1'b1;
			end
			else
				tx_data_in <= tx_data_in;

 			if(tickin_tx && global_counter_transfer == 4'd5)
			begin
				tx_tcode_in <= timecode_tx_i;
				tcode_rdy_trnsp <= 1'b1;
			end
			else
				tx_tcode_in <= tx_tcode_in;


			if(global_counter_transfer == 4'd3)
			begin
				char_sent <= 1'b0;
				fct_sent <= 0;
				ready_tx_timecode <= 1'b0;
				ready_tx_data <= 1'b0;
			end
			else
			begin
				ready_tx_timecode <= ready_tx_timecode;
				ready_tx_data <= ready_tx_data;
			end

			if(global_counter_transfer == 4'd7)
			begin
				last_type  <= NULL;
				global_counter_transfer <= 4'd0;
			end
			else
			begin
				last_type  <= last_type;
				global_counter_transfer <= global_counter_transfer + 4'd1;
			end
		end
		tx_spw_fct_c:
		begin

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			tx_dout_e <= last_tx_dout;
			tx_sout_e <= last_tx_sout;

			ready_tx_data <= ready_tx_data;

			if(global_counter_transfer == 4'd3)
			begin		
				char_sent <= 1'b0;	
				last_type  <=FCT;
				fct_sent <= 0;
				global_counter_transfer <= 4'd0;
			end
			else
			begin
				if(fct_flag > 0)
					fct_sent <= 1;
				else
					fct_sent <= fct_sent;

				global_counter_transfer <= global_counter_transfer + 4'd1;
			end
		end
		tx_spw_data_c:
		begin

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			tx_dout_e <= last_tx_dout;
			tx_sout_e <= last_tx_sout;

			fct_sent <= 0;

			if(!tx_data_in[8])
			begin

				if(global_counter_transfer == 4'd9)
				begin
					char_sent <= 1'b1;

					last_type  <= DATA;
					ready_tx_data <= 1'b1;
					data_rdy_trnsp <= 1'b0;
					global_counter_transfer <= 4'd0;
				end
				else
				begin
					ready_tx_data <= 1'b0;
					ready_tx_timecode <= 1'b0;
					global_counter_transfer <= global_counter_transfer + 4'd1;
				end

				if(global_counter_transfer == 4'd4)
					txdata_flagctrl_tx_last <= tx_data_in;


			end
			else if(tx_data_in[8])
			begin

				if(global_counter_transfer == 4'd3)
				begin
					char_sent <= 1'b1;

					if(tx_data_in[1:0] == 2'b00)
					begin
						last_type  <=EOP;
					end
					else if(tx_data_in[1:0] == 2'b01)
					begin
						last_type  <=EEP;
					end

					global_counter_transfer <= 4'd0;
					data_rdy_trnsp <= 1'b0;
					ready_tx_data <= 1'b1;
				end
				else
				begin
					txdata_flagctrl_tx_last <= txdata_flagctrl_tx_last;

					ready_tx_data <= 1'b0;
					ready_tx_timecode <= 1'b0;
					global_counter_transfer <= global_counter_transfer + 4'd1;
				end


			end

		end
		tx_spw_time_code_c:
		begin

			if(txwrite_tx && global_counter_transfer == 4'd6)
			begin
				data_rdy_trnsp <= 1'b1;
				tx_data_in <= data_tx_i;
			end
			else
				tx_data_in <= tx_data_in;


			fct_sent <= 0;
			
			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			tx_dout_e <= last_tx_dout;
			tx_sout_e <= last_tx_sout;
					
			if(global_counter_transfer == 4'd13)
			begin
				ready_tx_timecode <= 1'b1;
				global_counter_transfer <= 4'd0;
			end
			else
			begin
				ready_tx_timecode <= 1'b0;
				global_counter_transfer <= global_counter_transfer + 4'd1;
			end


			if(global_counter_transfer != 4'd13)
			begin
				
				timecode_s <= {timecode_ss[13:10],2'd2,tx_tcode_in[7:0]};
			end
			else
			begin
				ready_tx_data <= 1'b0;
				last_timein_control_flag_tx <= tx_tcode_in;
				last_type  <= TIMEC;
			end

		end
		default:
		begin
			last_type  		<= last_type;
			global_counter_transfer <= global_counter_transfer;
			tx_dout_e 		<= tx_dout_e;
			tx_sout_e 		<= tx_sout_e;
		end
		endcase
	end
end

endmodule
