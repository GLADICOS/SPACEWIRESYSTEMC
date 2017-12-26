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
//e.g.DATA_WIDTH	[32,16]	: width of the data : 32:
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
module tx_transport(

			input pclk_tx,
			input enable_tx,
			input send_null_tx,

			input [6:0] state_tx_in,
			input [5:0]  last_type_in,
			input [13:0] global_counter_transfer_in/* synthesis dont_replicate */,

			input [8:0]  tx_data_in,
			input [8:0]  tx_data_in_0,
			input [8:0]  txdata_flagctrl_tx_last,
			input [7:0]  last_timein_control_flag_tx,
			input [13:0] timecode_s,

			output reg tx_dout_e,
			output reg tx_sout_e
		   );


	reg last_tx_dout;
	reg last_tx_sout;

	reg tx_dout/* synthesis dont_replicate */;
	reg tx_sout/* synthesis dont_replicate */;

	reg [6:0] state_tx;
	reg [5:0]  last_type;
	reg [13:0] global_counter_transfer/* synthesis dont_replicate */;

localparam [6:0] tx_spw_start              = 7'b0000000,
	   	 tx_spw_null               = 7'b0000001,
	   	 tx_spw_fct                = 7'b0000010,
	   	 tx_spw_null_c             = 7'b0000100,
	   	 tx_spw_fct_c              = 7'b0001000,
	   	 tx_spw_data_c             = 7'b0010000,
	   	 tx_spw_data_c_0           = 7'b0100000,
	   	 tx_spw_time_code_c        = 7'b1000000/* synthesis dont_replicate */;

localparam [7:0] null_s = 8'b01110100;
localparam [2:0] fct_s  = 3'b100;
localparam [3:0] eop_s  = 4'b0101;
localparam [3:0] eep_s  = 4'b0110;
localparam [13:0] timecode_ss    = 14'b01110000000000/* synthesis dont_replicate */;

localparam [5:0] NULL     = 6'b000001,
		 FCT      = 6'b000010,
		 EOP      = 6'b000100,
		 EEP      = 6'b001000,
		 DATA     = 6'b010000,
		 TIMEC    = 6'b100000/* synthesis dont_replicate */;



always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin
		tx_dout      <= 1'b0;

		last_tx_dout <=  1'b0;
		last_tx_sout <=  1'b0;

		tx_dout_e <=  1'b0;
		tx_sout_e <=  1'b0;

		state_tx <= 7'd0;
		last_type <= 6'd0;
		global_counter_transfer <= 14'd0;
	end
	else
	begin

		state_tx <= state_tx_in;
		last_type <= last_type_in;
		global_counter_transfer <= global_counter_transfer_in;

		tx_dout_e <= tx_dout;
		tx_sout_e <= tx_sout;

		case(state_tx)
		tx_spw_start:
		begin
			if(send_null_tx && enable_tx)
			begin
				tx_dout <= !(null_s[6]^null_s[0]^null_s[1]);
			end
			else
			begin
				tx_dout      <= 1'b0;
			end
		end
		tx_spw_null,tx_spw_null_c:
		begin

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			 if(global_counter_transfer[0] == 1'd1)
			 begin
				 if(last_type == NULL)
				 begin
					tx_dout <= !(null_s[6]^null_s[0]^null_s[1]);
				 end
				 else if(last_type == FCT)
				 begin
					tx_dout <= !(null_s[6]^fct_s[0]^fct_s[1]);
				 end
				 else if(last_type == EOP)
				 begin
					tx_dout <= !(null_s[6]^fct_s[0]^fct_s[1]);
				 end
				 else if(last_type == EEP)
				 begin
					tx_dout <= !(null_s[6]^eep_s[0]^eep_s[1]);
				 end
				 else if(last_type == DATA)
				 begin
					tx_dout      <= !(null_s[6]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
				 end
				 else if(last_type == TIMEC)
				 begin
					tx_dout      <= !(null_s[6]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
				 end
			 end
			 else if(global_counter_transfer[1] == 1'd1)
			 begin
				tx_dout <= null_s[6];
			 end
			 else if(global_counter_transfer[2] == 1'd1)
			 begin
				tx_dout      <= null_s[5];
			 end
			 else if(global_counter_transfer[3] == 1'd1)
			 begin
				tx_dout      <= null_s[4];
			 end
			 else if(global_counter_transfer[4] == 1'd1)
			 begin
				tx_dout      <= null_s[3];
			 end
			 else if(global_counter_transfer[5] == 1'd1)
			 begin
				tx_dout      <= null_s[2];
			 end
			 else if(global_counter_transfer[6] == 1'd1)
			 begin
				tx_dout      <= null_s[1];
			 end
			 else if(global_counter_transfer[7] == 1'd1)
			 begin
				tx_dout      <= null_s[0];
			 end
		end
		tx_spw_fct,tx_spw_fct_c:
		begin

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			 if(global_counter_transfer[0] == 1'd1)
			 begin
				 if(last_type == NULL)
				 begin
					tx_dout <= !(fct_s[2]^null_s[0]^null_s[1]);
				 end
				 else if(last_type == FCT)
				 begin
					tx_dout <= !(fct_s[2]^fct_s[0]^fct_s[1]);
				 end
				 else if(last_type == EOP)
				 begin
					tx_dout <= !(fct_s[2]^eop_s[0]^eop_s[1]);
				 end
				 else if(last_type == EEP)
				 begin
					tx_dout <= !(fct_s[2]^eep_s[0]^eep_s[1]);
				 end
				 else if (last_type == DATA )
				 begin
					tx_dout <= !(fct_s[2]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
				 end
				 else if(last_type == TIMEC)
				 begin
					tx_dout <= !(fct_s[2]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
				 end
			 end
			 else if(global_counter_transfer[1] == 1'd1)
			 begin
				tx_dout <= fct_s[2];
			 end
			 else if(global_counter_transfer[2] == 1'd1)
			 begin
				tx_dout <= fct_s[1];
			 end
			 else if(global_counter_transfer[3] == 1'd1)
			 begin
				tx_dout <= fct_s[0];
			 end
		end
	   	tx_spw_data_c:
		begin

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			if(global_counter_transfer[0] == 1'd1)
			begin

				if(!tx_data_in[8])
				begin
					if(last_type == NULL)
					 begin
						tx_dout <= !(tx_data_in[8]^null_s[0]^null_s[1]);
					 end
					 else if(last_type == FCT)
					 begin
						tx_dout <= !(tx_data_in[8]^fct_s[0]^fct_s[1]);
					 end
					 else if(last_type == EOP)
					 begin
						tx_dout <= !(tx_data_in[8]^eop_s[0]^eop_s[1]);
					 end
					 else if(last_type == EEP)
					 begin
						tx_dout <= !(tx_data_in[8]^eep_s[0]^eep_s[1]);
					 end
					 else if(last_type == DATA)
					 begin
						tx_dout <= !(tx_data_in[8]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
					 end
					 else if(last_type == TIMEC)
					 begin
						tx_dout <= !(tx_data_in[8]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
					 end
				 end
				 else if(tx_data_in[8])
				 begin
					 if(tx_data_in[1:0] == 2'b00)
				 	 begin
						 if(last_type == NULL)
						 begin
							tx_dout <= !(eop_s[2]^null_s[0]^null_s[1]);
						 end
						 else if(last_type == FCT)
						 begin
							tx_dout <= !(eop_s[2]^fct_s[0]^fct_s[1]);
						 end
						 else if(last_type == EOP)
						 begin
							tx_dout <= !(eop_s[2]^eop_s[0]^eop_s[1]);
						 end
						 else if(last_type == EEP)
						 begin
							tx_dout <= !(eop_s[2]^eep_s[0]^eep_s[1]);
						 end
						 else if(last_type == DATA)
						 begin
							tx_dout <= !(eop_s[2]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
						 end
						 else if(last_type == TIMEC)
						 begin
							tx_dout <= !(eop_s[2]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
						 end
					 end
					 else if(tx_data_in[1:0] == 2'b01)
					 begin

						 if(last_type == NULL)
						 begin
							tx_dout <= !(eep_s[2]^null_s[0]^null_s[1]);
						 end
						 else if(last_type == FCT)
						 begin
							tx_dout <= !(eep_s[2]^fct_s[0]^fct_s[1]);
						 end
						 else if(last_type == EOP)
						 begin
							tx_dout <= !(eep_s[2]^eop_s[0]^eop_s[1]);
						 end
						 else if(last_type == EEP)
						 begin
							tx_dout <= !(eep_s[2]^eep_s[0]^eep_s[1]);
						 end
						 else if(last_type == DATA)
						 begin
							tx_dout <= !(eep_s[2]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
						 end
						 else if(last_type == TIMEC)
						 begin
							tx_dout <= !(eep_s[2]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
						 end
					 end
				 end
			 end
			 else if(!tx_data_in[8] )
			 begin
				 if(global_counter_transfer[1] == 1'd1)
				 begin
					tx_dout <= tx_data_in[8];
				 end
				 else if(global_counter_transfer[2] == 1'd1)
				 begin
					tx_dout <= tx_data_in[0];
				 end
				 else if(global_counter_transfer[3] == 1'd1)
				 begin
					tx_dout <= tx_data_in[1];
				 end
				 else if(global_counter_transfer[4] == 1'd1)
				 begin
					tx_dout <= tx_data_in[2];
				 end
				 else if(global_counter_transfer[5] == 1'd1)
				 begin
					tx_dout <= tx_data_in[3];
				 end
				 else if(global_counter_transfer[6] == 1'd1)
				 begin
					tx_dout <= tx_data_in[4];
				 end
				 else if(global_counter_transfer[7] == 1'd1)
				 begin
					tx_dout <= tx_data_in[5];
				 end
				 else if(global_counter_transfer[8] == 1'd1)
				 begin
					tx_dout <= tx_data_in[6];
				 end
				 else if(global_counter_transfer[9] == 1'd1)
				 begin
					tx_dout <= tx_data_in[7];
				 end
			 end
			 else if(tx_data_in[8])
			 begin

				 if(tx_data_in[1:0] == 2'b01)
				 begin
					 if(global_counter_transfer[1] == 1'd1)
					 begin
						tx_dout <= eep_s[2];
					 end
					 else if(global_counter_transfer[2] == 1'd1)
					 begin
						tx_dout <= eep_s[1];
					 end
					 else if(global_counter_transfer[3] == 1'd1)
					 begin
						tx_dout <= eep_s[0];
					 end
				end
				else if(tx_data_in[1:0] == 2'b00 )				
				begin				 	
					if(global_counter_transfer[1] == 1'd1)
					 begin
						tx_dout <= eop_s[2];
					 end
					 else if(global_counter_transfer[2] == 1'd1)
					 begin
						tx_dout <= eop_s[1];
					 end
					 else if(global_counter_transfer[3] == 1'd1)
					 begin
						tx_dout <= eop_s[0];
					 end
				end
			 end
		end
	   	tx_spw_data_c_0:
		begin

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			if(global_counter_transfer[0] == 1'd1)
			begin
				if(!tx_data_in_0[8])
				begin
					if(last_type == NULL)
					 begin
						tx_dout <= !(tx_data_in_0[8]^null_s[0]^null_s[1]);
					 end
					 else if(last_type == FCT)
					 begin
						tx_dout <= !(tx_data_in_0[8]^fct_s[0]^fct_s[1]);
					 end
					 else if(last_type == EOP)
					 begin
						tx_dout <= !(tx_data_in_0[8]^eop_s[0]^eop_s[1]);
					 end
					 else if(last_type == EEP)
					 begin
						tx_dout <= !(tx_data_in_0[8]^eep_s[0]^eep_s[1]);
					 end
					 else if(last_type == DATA)
					 begin
						tx_dout <= !(tx_data_in_0[8]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
					 end
					 else if(last_type == TIMEC)
					 begin
						tx_dout <= !(tx_data_in_0[8]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
					 end
	
				 end
				 else if(tx_data_in_0[8] )
				 begin
				 
					 if(tx_data_in_0[1:0] == 2'b00)
					 begin
						 if(last_type == NULL)
						 begin
							tx_dout <= !(eop_s[2]^null_s[0]^null_s[1]);
						 end
						 else if(last_type == FCT)
						 begin
							tx_dout <= !(eop_s[2]^fct_s[0]^fct_s[1]);
						 end
						 else if(last_type == EOP)
						 begin
							tx_dout <= !(eop_s[2]^eop_s[0]^eop_s[1]);
						 end
						 else if(last_type == EEP)
						 begin
							tx_dout <= !(eop_s[2]^eep_s[0]^eep_s[1]);
						 end
						 else if(last_type == DATA)
						 begin
							tx_dout <= !(eop_s[2]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
						 end
						 else if(last_type == TIMEC)
						 begin
							tx_dout <= !(eop_s[2]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
						 end
					 end
					 else if(tx_data_in_0[1:0] == 2'b01)
					 begin
						 if(last_type == NULL)
						 begin
							tx_dout <= !(eep_s[2]^null_s[0]^null_s[1]);
						 end
						 else if(last_type == FCT)
						 begin
							tx_dout <= !(eep_s[2]^fct_s[0]^fct_s[1]);
						 end
						 else if(last_type == EOP)
						 begin
							tx_dout <= !(eep_s[2]^eop_s[0]^eop_s[1]);
						 end
						 else if(last_type == EEP)
						 begin
							tx_dout <= !(eep_s[2]^eep_s[0]^eep_s[1]);
						 end
						 else if(last_type == DATA)
						 begin
							tx_dout <= !(eep_s[2]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
						 end
						 else if(last_type == TIMEC)
						 begin
							tx_dout <= !(eep_s[2]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
						 end
					 end
				 end
			 end
			 else if(!tx_data_in_0[8])
			 begin

				 if(global_counter_transfer[1] == 1'd1)
				 begin
					tx_dout <= tx_data_in_0[8];
				 end
				 else if(global_counter_transfer[2] == 1'd1)
				 begin
					tx_dout <= tx_data_in_0[0];
				 end
				 else if(global_counter_transfer[3] == 1'd1)
				 begin
					tx_dout <= tx_data_in_0[1];
				 end
				 else if(global_counter_transfer[4] == 1'd1)
				 begin
					tx_dout <= tx_data_in_0[2];
				 end
				 else if(global_counter_transfer[5] == 1'd1)
				 begin
					tx_dout <= tx_data_in_0[3];
				 end
				 else if(global_counter_transfer[6] == 1'd1)
				 begin
					tx_dout <= tx_data_in_0[4];
				 end
				 else if(global_counter_transfer[7] == 1'd1)
				 begin
					tx_dout <= tx_data_in_0[5];
				 end
				 else if(global_counter_transfer[8] == 1'd1)
				 begin
					tx_dout <= tx_data_in_0[6];
				 end
				 else if(global_counter_transfer[9] == 1'd1)
				 begin
					tx_dout <= tx_data_in_0[7];
				 end
			 end
			 else if(tx_data_in_0[8])
			 begin 
				 if(tx_data_in_0[1:0] == 2'b01)
				 begin

					 if(global_counter_transfer[1] == 1'd1)
					 begin
						tx_dout <= eep_s[2];
					 end
					 else if(global_counter_transfer[2] == 1'd1)
					 begin
						tx_dout <= eep_s[1];
					 end
					 else if(global_counter_transfer[3] == 1'd1)
					 begin
						tx_dout <= eep_s[0];
					 end
				 end
				 else if(tx_data_in_0[1:0] == 2'b00)
				 begin
					 if(global_counter_transfer[1] == 1'd1)
					 begin
						tx_dout <= eop_s[2];
					 end
					 else if(global_counter_transfer[2] == 1'd1)
					 begin
						tx_dout <= eop_s[1];
					 end
					 else if(global_counter_transfer[3] == 1'd1)
					 begin
						tx_dout <= eop_s[0];
					 end
				 end
			 end
		end
	   	tx_spw_time_code_c:
		begin

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			 if(global_counter_transfer[0] == 1'd1)
			 begin
				 if(last_type == NULL)
				 begin
					tx_dout <= !(timecode_s[12]^null_s[0]^null_s[1]);
				 end
				 else if(last_type == FCT)
				 begin
					tx_dout <= !(timecode_s[12]^fct_s[0]^fct_s[1]);
				 end
				 else if (last_type == EOP)
				 begin
					tx_dout <= !(timecode_s[12]^eop_s[0]^eop_s[1]);
				 end
				 else if( last_type == EEP)
				 begin
					tx_dout <= !(timecode_s[12]^eep_s[0]^eep_s[1]);
				 end
				 else if( last_type == DATA)
				 begin
					tx_dout <= !(timecode_s[12]^txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7]);
				 end
				 else if( last_type == TIMEC)
				 begin
					tx_dout <= !(timecode_s[12]^last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0]);
				 end
			 end
			 else if( global_counter_transfer[1] == 1'd1)
			 begin
				tx_dout <= timecode_s[12];
			 end
			 else if( global_counter_transfer[2] == 1'd1)
			 begin
				tx_dout <= timecode_s[11];
			 end
			 else if( global_counter_transfer[3] == 1'd1)
			 begin
				tx_dout <= timecode_s[10];
			 end
			 else if( global_counter_transfer[4] == 1'd1)
			 begin
				tx_dout <= timecode_s[9];
			 end
			 else if( global_counter_transfer[5] == 1'd1)
			 begin
				tx_dout <= timecode_s[8];
			 end
			 else if( global_counter_transfer[6] == 1'd1)
			 begin
				tx_dout <= timecode_s[0];
			 end
			 else if( global_counter_transfer[7] == 1'd1)
			 begin
				tx_dout <= timecode_s[1];
			 end
			 else if( global_counter_transfer[8] == 1'd1)
			 begin
				tx_dout <= timecode_s[2];
			 end
			 else if(global_counter_transfer[9] == 1'd1)
			 begin
				tx_dout <= timecode_s[3];
			 end
			 else if(global_counter_transfer[10] == 1'd1)
			 begin
				tx_dout <= timecode_s[4];
			 end
			 else if(global_counter_transfer[11] == 1'd1)
			 begin
				tx_dout <= timecode_s[5];
			 end
			 else if( global_counter_transfer[12] == 1'd1)
			 begin
				tx_dout <= timecode_s[6];
			 end
			 else if(global_counter_transfer[13] == 1'd1)
			 begin
				tx_dout <= timecode_s[7];
			 end
		end
		default:
		begin
		end
		endcase
	end
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

endmodule
