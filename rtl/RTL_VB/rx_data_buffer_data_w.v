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
module rx_data_buffer_data_w (
				input negedge_clk,
				input rx_resetn,

				input [1:0] state_data_process,
				input [2:0] control, 
				input last_is_timec,
				input last_is_data,
				input last_is_control,

				output reg rx_buffer_write,
				output reg rx_tick_out
			     );

always@(posedge negedge_clk or negedge rx_resetn)
begin
	
	if(!rx_resetn)
	begin
		rx_buffer_write <= 1'b0;
		rx_tick_out 	<= 1'b0;
	end
	else
	begin

		if(state_data_process == 2'd1)
		begin	
			if(last_is_timec == 1'b1)
			begin
				rx_tick_out  <= 1'b1;
				rx_buffer_write <= 1'b0;
			end
			else if(last_is_data == 1'b1)
			begin
				rx_buffer_write <= 1'b1;
				rx_tick_out 	<= 1'b0;
			end
			else if(last_is_control == 1'b1)
			begin
				if(control[2:0] == 3'd6)
				begin
					rx_buffer_write <= 1'b1;
					rx_tick_out 	<= 1'b0;
				end
				else if(control[2:0] == 3'd5)
				begin
					rx_buffer_write <= 1'b1;
					rx_tick_out 	<= 1'b0;
				end	
				else
				begin
					rx_buffer_write <= 1'b0;
					rx_tick_out 	<= 1'b0;
				end			
			end
			else
			begin
				rx_buffer_write <= 1'b0;
				rx_tick_out 	<= 1'b0;
			end
		end
		else
		begin
			rx_buffer_write <= 1'b0;
			rx_tick_out 	<= 1'b0;
		end
	end
end

endmodule
