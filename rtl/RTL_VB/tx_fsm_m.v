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

module tx_fsm_m (
			input pclk_tx,

			input enable_tx,
			input send_null_tx,
			input send_fct_tx,

			input [13:0] global_counter_transfer,

			input [2:0] fct_flag_p,

			input [8:0]  tx_data_in,
			input [8:0]  tx_data_in_0,
			input process_data,
			input process_data_0,

			input [7:0]  tx_tcode_in,
			input tcode_rdy_trnsp,
			//
			output  reg ready_tx_data,
			output  reg ready_tx_timecode,

			output reg char_sent,
			output reg fct_sent,

			output reg [6:0] state_tx /* synthesis syn_replicate = 1 */,
			output reg [5:0]  last_type /* synthesis syn_replicate = 1 */,

			output reg [13:0] timecode_s,
			output reg [8:0]  txdata_flagctrl_tx_last,

			output reg [7:0]  last_timein_control_flag_tx
		);

localparam [6:0] tx_spw_start              = 7'b0000000,
	   	 tx_spw_null               = 7'b0000001,
	   	 tx_spw_fct                = 7'b0000010,
	   	 tx_spw_null_c             = 7'b0000100,
	   	 tx_spw_fct_c              = 7'b0001000,
	   	 tx_spw_data_c             = 7'b0010000,
	   	 tx_spw_data_c_0           = 7'b0100000,
	   	 tx_spw_time_code_c        = 7'b1000000/* synthesis dont_replicate */;

localparam [5:0] NULL     = 6'b000001,
		 FCT      = 6'b000010,
		 EOP      = 6'b000100,
		 EEP      = 6'b001000,
		 DATA     = 6'b010000,
		 TIMEC    = 6'b100000/* synthesis dont_replicate */;


localparam [7:0] null_s = 8'b01110100;
localparam [2:0] fct_s  = 3'b100;
localparam [3:0] eop_s  = 4'b0101;
localparam [3:0] eep_s  = 4'b0110;
localparam [13:0] timecode_ss    = 14'b01110000000000/* synthesis dont_replicate */;


	reg [6:0] next_state_tx/* synthesis dont_replicate */;

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
			if(global_counter_transfer == 14'd128)
				next_state_tx = tx_spw_fct;
			else
				next_state_tx = tx_spw_null;
		end
		else
			next_state_tx = tx_spw_null;
	end
	tx_spw_fct:
	begin
		if(send_fct_tx && global_counter_transfer == 14'd8)
		begin
			if(tcode_rdy_trnsp)
			begin
				next_state_tx = tx_spw_time_code_c;
			end 
			else if(fct_flag_p > 3'd0)
			begin
				next_state_tx = tx_spw_fct;
			end
			else 
			begin
				next_state_tx = tx_spw_null_c;
			end
		end
		else
		  	next_state_tx = tx_spw_fct;
	end
	tx_spw_null_c:
	begin
		if(global_counter_transfer == 14'd128)
		begin
			if(tcode_rdy_trnsp)
			begin
				next_state_tx = tx_spw_time_code_c;
			end 
			else if(fct_flag_p > 3'd0)
			begin
				next_state_tx = tx_spw_fct_c;
			end
			else if(process_data)
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
		if(global_counter_transfer == 14'd8)
		begin
			if(tcode_rdy_trnsp)
			begin
				next_state_tx = tx_spw_time_code_c;
			end 
			else if(fct_flag_p > 3'd0)
			begin
				next_state_tx = tx_spw_fct_c;
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
			if(global_counter_transfer == 14'd512)
			begin
				if(tcode_rdy_trnsp)
				begin
					next_state_tx = tx_spw_time_code_c;
				end 
				else if(process_data_0)
				begin
					next_state_tx = tx_spw_data_c_0;				
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
			if(global_counter_transfer == 14'd8)
			begin
				if(tcode_rdy_trnsp)
				begin
					next_state_tx = tx_spw_time_code_c;
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
	tx_spw_data_c_0:
	begin

		if(!tx_data_in_0[8])
		begin
			if(global_counter_transfer == 14'd512)
			begin
				if(tcode_rdy_trnsp)
				begin
					next_state_tx = tx_spw_time_code_c;
				end 
				else if(process_data)
				begin
					next_state_tx = tx_spw_data_c;				
				end
				else 
				begin
					next_state_tx = tx_spw_null_c;
				end
			end
			else
				next_state_tx = tx_spw_data_c_0;			
		end
		else if(tx_data_in_0[8])
		begin
			if(global_counter_transfer == 14'd8)
			begin
				if(tcode_rdy_trnsp)
				begin
					next_state_tx = tx_spw_time_code_c;
				end 
				else 
				begin
					next_state_tx = tx_spw_null_c;
				end
			end
			else
				next_state_tx = tx_spw_data_c_0;	
		end
		

	end
	tx_spw_time_code_c:
	begin
		if(global_counter_transfer == 14'd8192)
		begin
			if(fct_flag_p > 3'd0)
			begin
				next_state_tx = tx_spw_fct_c;
			end
			else if(process_data)
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

		txdata_flagctrl_tx_last <= 9'd0; 

		last_timein_control_flag_tx <= 8'd0;

		char_sent<= 1'b0;
		fct_sent <= 1'b0;

		state_tx <= tx_spw_start;

	end
	else
	begin
		state_tx <= next_state_tx;

		case(state_tx)
		tx_spw_start:
		begin
			ready_tx_data <= 1'b0;
			ready_tx_timecode <= 1'b0;				
		end
		tx_spw_null:
		begin
			ready_tx_data <= 1'b0;
			ready_tx_timecode <= 1'b0;

			if(global_counter_transfer == 14'd128)
			begin
				last_type  <=last_type;
			end
			else 
			begin
				if(global_counter_transfer > 14'd1)
					last_type  <= NULL;
				else
					last_type  <= last_type;
			end
		end
		tx_spw_fct:
		begin
			ready_tx_data <= 1'b0;
			ready_tx_timecode <= 1'b0;

			if(global_counter_transfer == 14'd8)
			begin
				last_type  <=last_type;
				fct_sent <= 1'b0;
			end
			else
			begin
				if(fct_flag_p > 3'd0 && global_counter_transfer == 14'd1)
					fct_sent <=  1'b1;
				else
					fct_sent <= 1'b0;

				last_type  <=FCT;
			end
		end
		tx_spw_null_c:
		begin
			ready_tx_data <= 1'b0;

			if(global_counter_transfer == 14'd128)
			begin
				fct_sent <=  1'b0;
				last_type  <=last_type;
				ready_tx_timecode <= 1'b0;
			end
			else
			begin
				if(global_counter_transfer > 14'd1)
					last_type  <= NULL;
				else
					last_type  <= last_type;

				char_sent <= 1'b0;
				fct_sent <=  1'b0;
				ready_tx_timecode <= ready_tx_timecode;
			end
		end
		tx_spw_fct_c:
		begin
			
			if(global_counter_transfer == 14'd8)
			begin		
				char_sent <= 1'b0;	
				last_type  <=last_type;
				fct_sent <=  1'b0;
				ready_tx_timecode <= 1'b0;
			end
			else
			begin
				char_sent <= 1'b0;

				if(fct_flag_p > 3'd0 && global_counter_transfer == 14'd1)
					fct_sent <=  1'b1;
				else
					fct_sent <= 1'b0;

				if(global_counter_transfer > 14'd1)
					last_type  <=FCT;
				else
					last_type  <=last_type;

				ready_tx_timecode <= ready_tx_timecode;
			end
		end
		tx_spw_data_c:
		begin

			if(!tx_data_in[8])
			begin

				if(global_counter_transfer == 14'd512)
				begin
					fct_sent <=  1'b0;
					last_type  <=last_type;
					ready_tx_timecode <= 1'b0;
				end
				else if(global_counter_transfer == 14'd8)
				begin
					fct_sent <=  1'b0;
					txdata_flagctrl_tx_last <= tx_data_in;
					ready_tx_timecode <= ready_tx_timecode;
				end
				else
				begin
					if(global_counter_transfer < 14'd8)
					begin
						ready_tx_data <= 1'b1;
						char_sent <= 1'b1;
						fct_sent <=  1'b0;
					end
					else
					begin
						last_type  <= DATA;
						fct_sent <=  1'b0;
						ready_tx_data <= 1'b0;
						char_sent <= 1'b0;

							
					end

					txdata_flagctrl_tx_last <= txdata_flagctrl_tx_last;
					ready_tx_timecode <= ready_tx_timecode;
				 end

			end
			else
			begin

				if(global_counter_transfer == 14'd8)
				begin
					char_sent <= 1'b0;
					fct_sent <=  1'b0;
					last_type  <=last_type;
					ready_tx_data <= 1'b0;
					ready_tx_timecode <= 1'b0;
				end
				else
				begin
					if(global_counter_transfer > 14'd1)
					begin
						if(tx_data_in[1:0] == 2'b00)
						begin
							last_type  <=EOP;
						end
						else if(tx_data_in[1:0] == 2'b01)
						begin
							last_type  <=EEP;
						end
					end
					else
						last_type  <=last_type;

					fct_sent <=  1'b0;
					char_sent <= 1'b1;
					txdata_flagctrl_tx_last <= txdata_flagctrl_tx_last;
					ready_tx_data <= 1'b1;
					ready_tx_timecode <= ready_tx_timecode;
				end
			end
		end
		tx_spw_data_c_0:
		begin

			if(!tx_data_in_0[8])
			begin

				if(global_counter_transfer == 14'd512)
				begin
					fct_sent <=  1'b0;
					last_type  <=last_type;
					ready_tx_timecode <= 1'b0;
				end
				else if(global_counter_transfer == 14'd8)
				begin
					txdata_flagctrl_tx_last <= tx_data_in_0;
					fct_sent <=  1'b0;
					ready_tx_timecode <= ready_tx_timecode;
				end
				else
				begin

					if(global_counter_transfer < 14'd4)
					begin
						last_type  <=last_type;
						ready_tx_data <= 1'b1;
						char_sent <= 1'b1;
						fct_sent <=  1'b0;
					end
					else
					begin
						fct_sent <=  1'b0;
						last_type  <= DATA;
						ready_tx_data <= 1'b0;
						char_sent <= 1'b0;
					end

					txdata_flagctrl_tx_last <= txdata_flagctrl_tx_last;					
					ready_tx_timecode <= ready_tx_timecode;

				 end
			end
			else
			begin

				if(global_counter_transfer == 14'd8)
				begin
					fct_sent <=  1'b0;
					char_sent <= 1'b0;
					last_type  <=last_type;
					ready_tx_data <= 1'b0;
					ready_tx_timecode <= 1'b0;
				end
				else
				begin
					if(global_counter_transfer > 14'd1)
					begin
						if(tx_data_in_0[1:0] == 2'b00)
						begin
							last_type  <=EOP;
						end
						else if(tx_data_in_0[1:0] == 2'b01)
						begin
							last_type  <=EEP;
						end
					end
					else
						last_type  <=last_type;

					txdata_flagctrl_tx_last <= txdata_flagctrl_tx_last;
					ready_tx_data <= 1'b1;
					fct_sent <=  1'b0;
					ready_tx_timecode <= ready_tx_timecode;
					char_sent <= 1'b1;
				end
			end
		end
		tx_spw_time_code_c:
		begin

			ready_tx_data <= 1'b0;
				
			if(global_counter_transfer == 14'd8192)
			begin
				fct_sent <=  1'b0;
				ready_tx_timecode <= 1'b1;
				last_type  <= last_type;
			end
			else
			begin
				fct_sent <=  1'b0;
				char_sent <= 1'b0;
				ready_tx_timecode <= 1'b0;

				timecode_s <= {timecode_ss[13:10],2'd2,tx_tcode_in[7:0]};
				last_timein_control_flag_tx <= tx_tcode_in;

				if(global_counter_transfer > 14'd1)
					last_type  <= TIMEC;
				else
					last_type  <= last_type;
			end

		end
		default:
		begin
			fct_sent <=  1'b0;
			char_sent <= 1'b0;
			last_type  		<= last_type;
		end
		endcase
	end
end


endmodule
