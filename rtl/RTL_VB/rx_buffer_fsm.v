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
module rx_buffer_fsm (
			input posedge_clk,
			input rx_resetn,
			
			input last_is_data,
			input last_is_timec,
			input last_is_control,

			output reg rx_got_null,
			output reg rx_got_nchar,
			output reg rx_got_time_code
		     );

always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		rx_got_null 	  <= 1'b0;
		rx_got_nchar 	  <= 1'b0;
		rx_got_time_code  <= 1'b0;
	end
	else
	begin
		if(last_is_data == 1'b1 )
		begin
			rx_got_null 	  <= 1'b0;
			rx_got_nchar 	  <= 1'b1;
			rx_got_time_code  <= 1'b0;
		end
		else if(last_is_timec  == 1'b1)
		begin
			rx_got_null 	  <= 1'b0;
			rx_got_nchar 	  <= 1'b0;
			rx_got_time_code  <= 1'b1;
		end
		else if(last_is_control == 1'b1)
		begin
			rx_got_null 	  <= 1'b1;
			rx_got_nchar 	  <= 1'b0;
			rx_got_time_code  <= 1'b0;
		end
		else
		begin
			rx_got_null 	  <= 1'b0;
			rx_got_nchar 	  <= 1'b0;
			rx_got_time_code  <= 1'b0;
		end
	end
end

endmodule
