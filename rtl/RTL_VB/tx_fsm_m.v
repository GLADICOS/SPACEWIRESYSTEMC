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

			input [8:0]  tx_data_in,
			input [8:0]  tx_data_in_0,
			input process_data,
			input process_data_0,

			input gotfct_tx,
			input send_fct_now,
			
			input [7:0]  tx_tcode_in,
			input tcode_rdy_trnsp,
			//
			output  reg ready_tx_data,
			output  reg ready_tx_timecode,

			output [5:0] fct_counter_p,

			output reg [3:0] global_counter_transfer,

			output reg [2:0] state_tx,

			output tx_dout,
			output tx_sout
		);

localparam [6:0] tx_spw_start              = 3'b000,
	   	 tx_spw_null               = 3'b001,
	   	 tx_spw_fct                = 3'b010,
	   	 tx_spw_null_c             = 3'b011,
	   	 tx_spw_fct_c              = 3'b100,
	   	 tx_spw_data_c             = 3'b101,
	   	 tx_spw_data_c_0           = 3'b110,
	   	 tx_spw_time_code_c        = 3'b111/* synthesis dont_replicate */;

localparam [7:0] null_s = 8'b00101111;
localparam [3:0] fct_s  = 4'b0011;
localparam [3:0] eop_s  = 4'b1011;
localparam [3:0] eep_s  = 4'b0111;
localparam [13:0] timecode_ss    = 14'b00000000001111;

localparam [5:0] NULL     = 6'b000001,
		 FCT      = 6'b000010,
		 EOP      = 6'b000100,
		 EEP      = 6'b001000,
		 DATA     = 6'b010000,
		 TIMEC    = 6'b100000;

	reg [8:0] txdata_flagctrl_tx_last;
	reg [7:0]  last_timein_control_flag_tx;

	reg [6:0] next_state_tx/* synthesis dont_replicate */;

	reg char_sent;
	reg fct_sent;

	reg [13:0] timecode_s;
	reg tx_data_flagctrl_tx_last;
	reg last_time_in_control_flag_tx;
	reg [5:0] last_type;

	wire [13:0] result_shift;

	wire [2:0] fct_flag_p;

	reg last_tx_dout;
	reg last_tx_sout;

	assign result_shift = (state_tx == tx_spw_time_code_c)?timecode_s >> global_counter_transfer:
			      (state_tx == tx_spw_data_c & !tx_data_in[8] )?{4'd0,{tx_data_in[7:0],2'b0} >> global_counter_transfer}:
			      (state_tx == tx_spw_data_c & tx_data_in[1:0] == 2'd0 & tx_data_in[8])?{10'd0,eop_s >> global_counter_transfer}:
			      (state_tx == tx_spw_data_c & tx_data_in[1:0] == 2'd1 & tx_data_in[8])?{10'd0,eep_s >> global_counter_transfer}:
			      (state_tx == tx_spw_data_c_0 & !tx_data_in_0[8])?{4'd0,{tx_data_in_0[7:0],2'b0} >> global_counter_transfer}:
			      (state_tx == tx_spw_data_c_0 & tx_data_in_0[1:0] == 2'd0 & tx_data_in_0[8])?{10'd0,eop_s >> global_counter_transfer}:
			      (state_tx == tx_spw_data_c_0 & tx_data_in_0[1:0] == 2'd1 & tx_data_in_0[8])?{10'd0,eep_s >> global_counter_transfer}:
			      (state_tx == tx_spw_fct | state_tx == tx_spw_fct_c)?{10'd0,fct_s >> global_counter_transfer}:
			      (state_tx == tx_spw_null | state_tx == tx_spw_null_c)?{6'd0,null_s >> global_counter_transfer}:14'd1;

	assign tx_dout = (global_counter_transfer == 4'd0 & (last_type == NULL | last_type == FCT))?~(result_shift[0]^1'b0):
			 (global_counter_transfer == 4'd0 & (last_type == EOP | last_type == EEP))?~(result_shift[0]^1'b1):
			 (global_counter_transfer == 4'd0 & (last_type == DATA))?~(result_shift[0]^txdata_flagctrl_tx_last):
			 (global_counter_transfer == 4'd0 & (last_type == TIMEC))?~(result_shift[0]^last_timein_control_flag_tx):result_shift[0];

	assign tx_sout = (tx_dout == last_tx_dout)?~last_tx_sout:last_tx_sout;

always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin
		last_tx_dout <=  1'b0;
		last_tx_sout <=  1'b0;
	end
	else
	begin
		if(send_null_tx)
		begin
			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;
		end
		else
		begin
			last_tx_dout <= last_tx_dout;
			last_tx_sout <= last_tx_sout;
		end

	end
end

always@(*)
begin
	next_state_tx = state_tx;

	case(state_tx)
	tx_spw_start:
	begin
		if(send_null_tx)
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
			if(global_counter_transfer == 4'd7)
				next_state_tx = tx_spw_fct;
			else
				next_state_tx = tx_spw_null;
		end
		else
		begin
			next_state_tx = tx_spw_null;
		end
	end
	tx_spw_fct:
	begin
		if(send_fct_tx && global_counter_transfer == 4'd3)
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
		begin
		  	next_state_tx = tx_spw_fct;
		end
	end
	tx_spw_null_c:
	begin
		if(global_counter_transfer == 4'd7)
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
		if(global_counter_transfer == 4'd3)
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
			if(global_counter_transfer == 4'd9)
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
			begin
				next_state_tx = tx_spw_data_c;	
			end		
		end
		else if(tx_data_in[8])
		begin
			if(global_counter_transfer == 4'd3)
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
			begin
				next_state_tx = tx_spw_data_c;	
			end
		end
		

	end
	tx_spw_data_c_0:
	begin

		if(!tx_data_in_0[8])
		begin
			if(global_counter_transfer == 4'd9)
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
			begin
				next_state_tx = tx_spw_data_c_0;	
			end		
		end
		else if(tx_data_in_0[8])
		begin
			if(global_counter_transfer == 4'd3)
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
			begin
				next_state_tx = tx_spw_data_c_0;	
			end
		end
		

	end
	tx_spw_time_code_c:
	begin
		if(global_counter_transfer == 4'd13)
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

		tx_data_flagctrl_tx_last     <= 1'b0;
		last_time_in_control_flag_tx <= 1'b0;

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
		
		tx_data_flagctrl_tx_last     <= txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7];
		last_time_in_control_flag_tx <= last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0];

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

			last_type  <= NULL;
		end
		tx_spw_fct:
		begin
			ready_tx_data <= 1'b0;
			ready_tx_timecode <= 1'b0;

			last_type  <=FCT;

			if(global_counter_transfer == 4'd3)
			begin
				fct_sent <= 1'b0;
			end
			else
			begin
				if(fct_flag_p > 3'd0 && global_counter_transfer == 4'd1)
					fct_sent <=  1'b1;
				else
					fct_sent <= 1'b0;
			end
		end
		tx_spw_null_c:
		begin
			ready_tx_data <= 1'b0;
			last_type  <= NULL;

			if(global_counter_transfer == 4'd7)
			begin
				ready_tx_timecode <= 1'b0;
			end
			else
			begin
				char_sent <= 1'b0;
				fct_sent <=  1'b0;
				ready_tx_timecode <= ready_tx_timecode;
			end
		end
		tx_spw_fct_c:
		begin

			last_type  <=FCT;

			if(global_counter_transfer == 4'd3)
			begin		
				char_sent <= 1'b0;	
				fct_sent <=  1'b0;
				ready_tx_timecode <= 1'b0;
			end
			else
			begin
				char_sent <= 1'b0;

				if(fct_flag_p > 3'd0 && global_counter_transfer == 4'd1)
					fct_sent <=  1'b1;
				else
					fct_sent <= 1'b0;

				ready_tx_timecode <= ready_tx_timecode;
			end
		end
		tx_spw_data_c:
		begin

			if(!tx_data_in[8])
			begin

				last_type  <= DATA;

				if(global_counter_transfer == 4'd9)
				begin
					fct_sent <=  1'b0;
					ready_tx_timecode <= 1'b0;
				end
				else if(global_counter_transfer == 4'd4)
				begin
					fct_sent <=  1'b0;
					txdata_flagctrl_tx_last <= tx_data_in;
					ready_tx_timecode <= ready_tx_timecode;
				end
				else
				begin
					if(global_counter_transfer < 4'd3)
					begin
						ready_tx_data <= 1'b1;
						char_sent <= 1'b1;
						fct_sent <=  1'b0;
					end
					else
					begin
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

				if(global_counter_transfer == 4'd3)
				begin
					char_sent <= 1'b0;
					fct_sent <=  1'b0;
					last_type  <=last_type;
					ready_tx_data <= 1'b0;
					ready_tx_timecode <= 1'b0;
				end
				else
				begin
					if(global_counter_transfer > 4'd1)
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

				last_type  <= DATA;

				if(global_counter_transfer == 4'd9)
				begin
					fct_sent <=  1'b0;
					ready_tx_timecode <= 1'b0;
				end
				else if(global_counter_transfer == 4'd5)
				begin
					txdata_flagctrl_tx_last <= tx_data_in_0;
					fct_sent <=  1'b0;
					ready_tx_timecode <= ready_tx_timecode;
				end
				else
				begin
					if(global_counter_transfer < 4'd4)
					begin
						ready_tx_data <= 1'b1;
						char_sent <= 1'b1;
						fct_sent <=  1'b0;
					end
					else
					begin
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

				if(global_counter_transfer == 4'd3)
				begin
					fct_sent <=  1'b0;
					char_sent <= 1'b0;
					last_type  <=last_type;
					ready_tx_data <= 1'b0;
					ready_tx_timecode <= 1'b0;
				end
				else
				begin
					if(global_counter_transfer > 4'd1)
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
			last_type  <= TIMEC;

			if(global_counter_transfer == 4'd13)
			begin
				fct_sent <=  1'b0;
				ready_tx_timecode <= 1'b1;
			end
			else
			begin
				fct_sent <=  1'b0;
				char_sent <= 1'b0;
				ready_tx_timecode <= 1'b0;

				timecode_s <= {timecode_ss[13:10],2'd2,tx_tcode_in[7:0]};
				last_timein_control_flag_tx <= tx_tcode_in;
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


always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin
		global_counter_transfer   <= 4'd0;
	end
	else
	begin
		case(state_tx)
		tx_spw_start:
		begin
			if(send_null_tx)
				global_counter_transfer <= global_counter_transfer + 4'd1;
			else
				global_counter_transfer <= 4'd0;

		end
		tx_spw_null,tx_spw_null_c:
		begin
			if(global_counter_transfer == 4'd7)
			begin
				global_counter_transfer <= 4'd0;
			end
			else 
			begin		
				global_counter_transfer <= global_counter_transfer + 4'd1;
			end

		end
		tx_spw_fct,tx_spw_fct_c:
		begin
			if(global_counter_transfer == 4'd3)
			begin		
				global_counter_transfer <= 4'd0;
			end
			else
			begin
				global_counter_transfer <= global_counter_transfer + 4'd1;
			end

		end
		tx_spw_data_c:
		begin

			if(!tx_data_in[8])
			begin

				if(global_counter_transfer == 4'd9)
				begin
					global_counter_transfer <= 4'd0;
				end
				else
				begin
					global_counter_transfer <= global_counter_transfer + 4'd1;
				end

			end
			else
			begin

				if(global_counter_transfer == 4'd3)
				begin
					global_counter_transfer <= 4'd0;
				end
				else
				begin
					global_counter_transfer <= global_counter_transfer + 4'd1;
				end
			end

		end
		tx_spw_data_c_0:
		begin

			if(!tx_data_in_0[8])
			begin

				if(global_counter_transfer == 4'd9)
				begin
					global_counter_transfer <= 4'd0;
				end
				else
				begin
					global_counter_transfer <= global_counter_transfer + 4'd1;
				end

			end
			else
			begin

				if(global_counter_transfer == 4'd3)
				begin
					global_counter_transfer <= 4'd0;
				end
				else
				begin
					global_counter_transfer <= global_counter_transfer + 4'd1;
				end
			end

		end
		tx_spw_time_code_c:
		begin

			if(global_counter_transfer == 4'd13)
			begin
				global_counter_transfer <= 4'd0;
			end
			else
			begin
				global_counter_transfer <= global_counter_transfer + 4'd1;
			end

		end
		default:
		begin
			global_counter_transfer <= global_counter_transfer;
		end
		endcase
	end
end

tx_fct_counter  tx_fct_cnt( 
			.pclk_tx(pclk_tx),
			.enable_tx(enable_tx),

			.gotfct_tx(gotfct_tx),
			.char_sent(char_sent),

			.fct_counter_p(fct_counter_p)
		     );

tx_fct_send	tx_fct_snd(
			.pclk_tx(pclk_tx),
			.enable_tx(enable_tx),
			.send_fct_now(send_fct_now),
			.fct_sent(fct_sent),
			.fct_flag_p(fct_flag_p)
		  );


endmodule
