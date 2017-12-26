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
module bit_capture_control(
			input negedge_clk,
			input posedge_clk,
			input rx_resetn,
			
			input rx_din,
			
			output reg bit_c_0,
			output reg bit_c_1,
			output reg bit_c_2,
			output reg bit_c_3
		  );


always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_c_1      	<= 1'b0;
		bit_c_3      	<= 1'b0;
	end
	else
	begin
		bit_c_1 <= rx_din;
		bit_c_3 <= bit_c_1;
	end

end

always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_c_0   <= 1'b0;
		bit_c_2   <= 1'b0;
	end
	else
	begin
		bit_c_0 <= rx_din;
		bit_c_2 <= bit_c_0;
	end
end


endmodule
