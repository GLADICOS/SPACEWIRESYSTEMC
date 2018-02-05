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

			output fct_great_than_zero,

			output get_data,
			output get_data_0,

			output reg tx_dout_e,
			output reg tx_sout_e
		);

localparam [2:0] tx_spw_start              = 3'b000,
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

	reg [8:0] txdata_flagctrl_tx_last;
	reg [7:0]  last_timein_control_flag_tx;

	reg [2:0] next_state_tx/* synthesis dont_replicate */;

	wire [3:0] counter_aux;

	reg char_sent;
	reg fct_sent;

	reg tx_data_flagctrl_tx_last;
	reg last_time_in_control_flag_tx;

	reg [3:0] global_counter_transfer;
	reg [2:0] state_tx;

	wire [13:0] result_shift;

	wire [2:0] fct_flag_p;

	reg last_tx_dout;
	reg last_tx_sout;

	wire [5:0] fct_counter_p;

	wire fct_send_great_than_zero;

	wire last_type_null_fct;
	wire last_type_eop_eep;
	wire last_type_data;
	wire last_type_timec;

	wire tx_dout;
	wire tx_sout;

	reg null_last,fct_last,data_last,eop_eep_last,last_timec;


	assign  last_type_null_fct = (null_last | fct_last)?1'b1:1'b0;
	assign  last_type_eop_eep  = (eop_eep_last)?1'b1:1'b0;
	assign  last_type_data     = (data_last)?1'b1:1'b0;
	assign 	last_type_timec    = (last_timec)?1'b1:1'b0;

	assign result_shift = (state_tx == tx_spw_time_code_c)?{tx_tcode_in[7:0],2'd2,4'b1111} >> global_counter_transfer:
			      (state_tx == tx_spw_data_c & !tx_data_in[8] )?{4'd0,{tx_data_in[7:0],2'b0} >> global_counter_transfer}:
			      (state_tx == tx_spw_data_c & tx_data_in[1:0] == 2'd0 & tx_data_in[8])?{10'd0,eop_s >> global_counter_transfer}:
			      (state_tx == tx_spw_data_c & tx_data_in[1:0] == 2'd1 & tx_data_in[8])?{10'd0,eep_s >> global_counter_transfer}:
			      (state_tx == tx_spw_data_c_0 & !tx_data_in_0[8])?{4'd0,{tx_data_in_0[7:0],2'b0} >> global_counter_transfer}:
			      (state_tx == tx_spw_data_c_0 & tx_data_in_0[1:0] == 2'd0 & tx_data_in_0[8])?{10'd0,eop_s >> global_counter_transfer}:
			      (state_tx == tx_spw_data_c_0 & tx_data_in_0[1:0] == 2'd1 & tx_data_in_0[8])?{10'd0,eep_s >> global_counter_transfer}:
			      (state_tx == tx_spw_fct | state_tx == tx_spw_fct_c)?{10'd0,fct_s >> global_counter_transfer}:
			      (state_tx == tx_spw_null | state_tx == tx_spw_null_c)?{6'd0,null_s >> global_counter_transfer}:14'd1;

	assign tx_dout = (global_counter_transfer == 4'd0 & last_type_null_fct)?~(result_shift[0]^1'b0):
			 (global_counter_transfer == 4'd0 & last_type_eop_eep)?~(result_shift[0]^1'b1):
			 (global_counter_transfer == 4'd0 & last_type_data)?~(result_shift[0]^tx_data_flagctrl_tx_last):
			 (global_counter_transfer == 4'd0 & last_type_timec)?~(result_shift[0]^last_time_in_control_flag_tx):result_shift[0];

	assign tx_sout = (tx_dout == last_tx_dout)?~last_tx_sout:last_tx_sout;

	assign counter_aux = (state_tx == tx_spw_null || state_tx == tx_spw_null_c)?4'd7:
			     (state_tx == tx_spw_fct  || state_tx == tx_spw_fct_c)?4'd3:
			     ((state_tx == tx_spw_data_c  || state_tx == tx_spw_data_c_0) && (!tx_data_in[8] || !tx_data_in_0[8]))?4'd9:
			     ((state_tx == tx_spw_data_c  || state_tx == tx_spw_data_c_0) && ( tx_data_in[8] ||  tx_data_in_0[8]))?4'd3:
			     (state_tx == tx_spw_time_code_c)?4'd13:4'd7;

	assign fct_great_than_zero = (fct_counter_p > 6'd0)?1'b1:1'b0;
	assign fct_send_great_than_zero = (fct_flag_p > 3'd0)?1'b1:1'b0;

	assign get_data   = (state_tx == tx_spw_null_c | state_tx == tx_spw_data_c_0 | state_tx == tx_spw_time_code_c)?1'b1:1'b0;
	assign get_data_0 = (state_tx == tx_spw_data_c)?1'b1:1'b0;

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
			else if(fct_send_great_than_zero)
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
			else if(fct_send_great_than_zero)
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
			else if(fct_send_great_than_zero)
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
			if(fct_send_great_than_zero)
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

always@(posedge pclk_tx)
begin
	if(!enable_tx)
	begin
		null_last    <= 1'b0;
		fct_last     <= 1'b0;
		data_last    <= 1'b0;
		eop_eep_last <= 1'b0;
		last_timec   <= 1'b0;
	end
	else
	begin
		case(state_tx)
		tx_spw_start,tx_spw_null,tx_spw_null_c:
		begin
			null_last    <= 1'b1;
			fct_last     <= 1'b0;
			data_last    <= 1'b0;
			eop_eep_last <= 1'b0;
			last_timec   <= 1'b0;
		end
		tx_spw_fct,tx_spw_fct_c:
		begin
			null_last    <= 1'b0;
			fct_last     <= 1'b1;
			data_last    <= 1'b0;
			eop_eep_last <= 1'b0;
			last_timec   <= 1'b0;
		end
		tx_spw_data_c,tx_spw_data_c_0:
		begin
			if(!tx_data_in[8] || !tx_data_in_0[8])
			begin
				null_last    <= 1'b0;
				fct_last     <= 1'b0;
				data_last    <= 1'b1;
				eop_eep_last <= 1'b0;
				last_timec   <= 1'b0;
			end
			else
			begin

				null_last    <= 1'b0;
				fct_last     <= 1'b0;
				data_last    <= 1'b0;
				eop_eep_last <= 1'b1;
				last_timec   <= 1'b0;
			end
		end
		tx_spw_time_code_c:
		begin		
			null_last    <= 1'b0;
			fct_last     <= 1'b0;
			data_last    <= 1'b0;
			eop_eep_last <= 1'b0;
			last_timec   <= 1'b1;
		end
		default:
		begin
			null_last    <= null_last;
			fct_last     <= fct_last;
			data_last    <= data_last;
			eop_eep_last <= eop_eep_last;
			last_timec   <= last_timec;
		end
		endcase
	end
end


always@(posedge pclk_tx)
begin
	if(!enable_tx)
	begin

		last_tx_dout <=  1'b0;
		last_tx_sout <=  1'b0;

		tx_dout_e <=  1'b0;
		tx_sout_e <=  1'b0;

		tx_data_flagctrl_tx_last     <= 1'b0;
		last_time_in_control_flag_tx <= 1'b0;

		ready_tx_data	  <= 1'b0;
		ready_tx_timecode <= 1'b0;

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

			if(send_null_tx)
			begin
				last_tx_dout <= tx_dout;
				last_tx_sout <= tx_sout;

				tx_dout_e <= tx_dout;
				tx_sout_e <= tx_sout;
			end
			else
			begin
				last_tx_dout <= last_tx_dout;
				last_tx_sout <= last_tx_sout;

				tx_dout_e <=  tx_dout_e;
				tx_sout_e <=  tx_sout_e;
			end
			
		end
		tx_spw_null:
		begin
			tx_dout_e <= tx_dout;
			tx_sout_e <= tx_sout;

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			ready_tx_data <= 1'b0;
			ready_tx_timecode <= 1'b0;

		end
		tx_spw_fct:
		begin
			tx_dout_e <= tx_dout;
			tx_sout_e <= tx_sout;

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			ready_tx_data <= 1'b0;
			ready_tx_timecode <= 1'b0;

			if(global_counter_transfer == counter_aux)
			begin
				fct_sent <= 1'b0;
			end
			else
			begin
				if(fct_send_great_than_zero && global_counter_transfer == 4'd1)
					fct_sent <=  1'b1;
				else
					fct_sent <= 1'b0;
			end
		end
		tx_spw_null_c:
		begin
			tx_dout_e <= tx_dout;
			tx_sout_e <= tx_sout;

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			ready_tx_data <= 1'b0;

			if(global_counter_transfer == counter_aux)
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
			tx_dout_e <= tx_dout;
			tx_sout_e <= tx_sout;

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			if(global_counter_transfer == counter_aux)
			begin		
				char_sent <= 1'b0;	
				fct_sent <=  1'b0;
				ready_tx_timecode <= 1'b0;
			end
			else
			begin
				char_sent <= 1'b0;

				if(fct_send_great_than_zero && global_counter_transfer == 4'd1)
					fct_sent <=  1'b1;
				else
					fct_sent <= 1'b0;

				ready_tx_timecode <= ready_tx_timecode;
			end
		end
		tx_spw_data_c:
		begin
			tx_dout_e <= tx_dout;
			tx_sout_e <= tx_sout;

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			if(!tx_data_in[8])
			begin
				txdata_flagctrl_tx_last <= tx_data_in;

				if(global_counter_transfer == counter_aux)
				begin
					fct_sent <=  1'b0;
					ready_tx_timecode <= 1'b0;
				end
				else if(global_counter_transfer == 4'd4)
				begin
					fct_sent <=  1'b0;
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
					ready_tx_timecode <= ready_tx_timecode;
				 end

			end
			else
			begin

				if(global_counter_transfer == counter_aux)
				begin
					char_sent <= 1'b0;
					fct_sent <=  1'b0;
					ready_tx_data <= 1'b0;
					ready_tx_timecode <= 1'b0;
				end
				else
				begin
					fct_sent <=  1'b0;
					char_sent <= 1'b1;
					ready_tx_data <= 1'b1;
					ready_tx_timecode <= ready_tx_timecode;
				end
			end
		end
		tx_spw_data_c_0:
		begin
			tx_dout_e <= tx_dout;
			tx_sout_e <= tx_sout;

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			if(!tx_data_in_0[8])
			begin

				txdata_flagctrl_tx_last <= tx_data_in_0;

				if(global_counter_transfer == counter_aux)
				begin
					fct_sent <=  1'b0;
					ready_tx_timecode <= 1'b0;
				end
				else if(global_counter_transfer == 4'd5)
				begin
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
					
					ready_tx_timecode <= ready_tx_timecode;

				 end
			end
			else
			begin

				if(global_counter_transfer == counter_aux)
				begin
					fct_sent <=  1'b0;
					char_sent <= 1'b0;
					ready_tx_data <= 1'b0;
					ready_tx_timecode <= 1'b0;
				end
				else
				begin
					ready_tx_data <= 1'b1;
					fct_sent <=  1'b0;
					ready_tx_timecode <= ready_tx_timecode;
					char_sent <= 1'b1;
				end
			end
		end
		tx_spw_time_code_c:
		begin

			tx_dout_e <= tx_dout;
			tx_sout_e <= tx_sout;

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			ready_tx_data <= 1'b0;				
			last_timein_control_flag_tx <= tx_tcode_in;

			if(global_counter_transfer == counter_aux)
			begin
				fct_sent <=  1'b0;
				ready_tx_timecode <= 1'b1;
			end
			else
			begin
				fct_sent <=  1'b0;
				char_sent <= 1'b0;
				ready_tx_timecode <= 1'b0;

			end
		end
		default:
		begin

			tx_dout_e <= tx_dout;
			tx_sout_e <= tx_sout;

			last_tx_dout <= tx_dout;
			last_tx_sout <= tx_sout;

			fct_sent <=  1'b0;
			char_sent <= 1'b0;
		end
		endcase
	end
end


always@(posedge pclk_tx)
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
		tx_spw_null,tx_spw_null_c,tx_spw_fct,tx_spw_fct_c,tx_spw_data_c,tx_spw_data_c_0,tx_spw_time_code_c:
		begin
			if(global_counter_transfer == counter_aux)
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
