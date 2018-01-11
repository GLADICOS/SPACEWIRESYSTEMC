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
module rx_data_receive(
				input posedge_clk,
				input rx_resetn,
			
				input ready_control_p_r,
				input ready_data_p_r,
				input ready_control,
				input ready_data,

				input parity_rec_c,
				input parity_rec_d,

				input parity_rec_c_gen,
				input parity_rec_d_gen,

				input [2:0] control_p_r,
				input [2:0] control_l_r,
				input [8:0] dta_timec_p,

				output reg [1:0] state_data_process,

				output reg last_is_control,
				output reg last_is_data,
				output reg last_is_timec,

				output reg rx_error_c,
				output reg rx_error_d,
				output reg rx_got_fct,

				output reg [8:0] rx_data_flag/* synthesis dont_replicate */,

				output reg [7:0] timecode/* synthesis dont_replicate */
		      );

	
	reg  [1:0] next_state_data_process/* synthesis dont_replicate */;

always@(*)
begin

	next_state_data_process = state_data_process;

	case(state_data_process)
	2'd0:
	begin
		if(ready_control_p_r || ready_data_p_r)
		begin
			next_state_data_process = 2'd1;
		end
		else 
		begin
			next_state_data_process = 2'd0;
		end
	end
	2'd1:
	begin
		if(ready_control || ready_data)
		begin
			next_state_data_process = 2'd0;
		end
		else 
		begin
			next_state_data_process = 2'd1;
		end
	end
	default:
	begin
		next_state_data_process = 2'd0;
	end
	endcase
end


always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		last_is_control  <=  1'b0;
		last_is_data 	 <=  1'b0;
		last_is_timec 	 <=  1'b0;

		rx_data_flag     <=  9'd0; 
		timecode    	 <=  8'd0;

		state_data_process <= 2'd0;

		rx_error_c <= 1'b0;
		rx_error_d <= 1'b0;

		rx_got_fct        <= 1'b0;
	end
	else
	begin

		state_data_process <= next_state_data_process;

		case(state_data_process)
		2'd0:
		begin

			rx_error_c <= rx_error_c;
			rx_error_d <= rx_error_d;

			if(ready_control_p_r)
			begin
				
				if(control_l_r[2:0] != 3'd7 && control_p_r[2:0] == 3'd4)
				begin
					rx_got_fct        <= 1'b1;
				end
				else
				begin
					rx_got_fct        <= 1'b0;
				end

				if(control_p_r[2:0] == 3'd6)
				begin
					rx_data_flag <= 9'd257;
				end
				else if(control_p_r[2:0] == 3'd5)
				begin
					rx_data_flag <= 9'd256;
				end
				else
				begin
					rx_data_flag <= rx_data_flag;
				end

				last_is_control 	 <= 1'b1;
				last_is_data    	 <= 1'b0;
				last_is_timec   	 <= 1'b0;

			end
			else if(ready_data_p_r)
			begin
				rx_got_fct        <= 1'b0;

				if(control_p_r[2:0] != 3'd7)
				begin
					rx_data_flag	<= {dta_timec_p[8],dta_timec_p[7],dta_timec_p[6],dta_timec_p[5],dta_timec_p[4],dta_timec_p[3],dta_timec_p[2],dta_timec_p[1],dta_timec_p[0]};					
					last_is_control  	<=1'b0;
					last_is_data     	<=1'b1;
					last_is_timec    	<=1'b0;
				end
				else if(control_p_r[2:0] == 3'd7)
				begin
					timecode     <=  {dta_timec_p[7],dta_timec_p[6],dta_timec_p[5],dta_timec_p[4],dta_timec_p[3],dta_timec_p[2],dta_timec_p[1],dta_timec_p[0]};
					last_is_control  	<= 1'b0;
					last_is_data     	<= 1'b0;
					last_is_timec    	<= 1'b1;
				end
			end
			else
			begin
				rx_got_fct        <= 1'b0;
				timecode    	<= timecode;
			end
			
		end
		2'd1:
		begin

			if(ready_control_p_r)
			begin

				if(parity_rec_c_gen != parity_rec_c)
				begin
					rx_error_c <= 1'b1;
				end
				else
					rx_error_c <= rx_error_c;

				rx_got_fct        <= rx_got_fct;

			end
			else if(ready_data_p_r)
			begin

				if(parity_rec_d_gen != parity_rec_d)
				begin
					rx_error_d <= 1'b1;
				end
				else
					rx_error_d <= rx_error_d;
				
				rx_got_fct        <= 1'b0;

			end
			else
			begin
				rx_error_c <= rx_error_c;
				rx_error_d <= rx_error_d;
				rx_got_fct        <= 1'b0;
			end
			rx_data_flag	<= rx_data_flag;
			timecode    	<= timecode;
		end
		default:
		begin
				rx_data_flag	<= rx_data_flag;
				timecode    	<= timecode;
				rx_got_fct      <= rx_got_fct;
			
		end
		endcase	
	end
end

endmodule
