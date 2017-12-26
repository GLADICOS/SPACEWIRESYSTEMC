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
module bit_capture_data(
			input negedge_clk,
			input posedge_clk,
			input rx_resetn,
			
			input rx_din,
			
			output reg bit_d_0,//N
			output reg bit_d_1,//P
			output reg bit_d_2,//N
			output reg bit_d_3,//P
			output reg bit_d_4,//N
			output reg bit_d_5,//P
			output reg bit_d_6,//N
			output reg bit_d_7,//P
			output reg bit_d_8,//N
			output reg bit_d_9//P
		  );


always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_d_1  <= 1'b0;
		bit_d_3  <= 1'b0;
		bit_d_5  <= 1'b0;
		bit_d_7  <= 1'b0;
		bit_d_9  <= 1'b0;
	end
	else
	begin
		bit_d_1  <= rx_din;
		bit_d_3  <= bit_d_1;
		bit_d_5  <= bit_d_3;
		bit_d_7  <= bit_d_5;
		bit_d_9  <= bit_d_7;
	end

end

always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_d_0 <= 1'b0;
		bit_d_2 <= 1'b0;
		bit_d_4 <= 1'b0;
		bit_d_6 <= 1'b0;
		bit_d_8 <= 1'b0;

	end
	else
	begin
		bit_d_0 <= rx_din;
		bit_d_2 <= bit_d_0;
		bit_d_4 <= bit_d_2;
		bit_d_6 <= bit_d_4;
		bit_d_8 <= bit_d_6;
	end
end

endmodule
