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

module clock_reduce(
			input clk,
			input reset_n,

			output reg clk_reduced
		   );


reg [10:0] counter;

always@(posedge clk)
begin

	if(!reset_n)
	begin
		counter <= 11'd0;
		clk_reduced <= 1'b0;
	end
	else
	begin
		if(counter >=11'd0 && counter <=11'd24 )
		begin
			clk_reduced <= 1'b1;
			counter <= counter + 11'd1;
		end
		else if(counter >=11'd25 && counter <=11'd49 )
		begin
			clk_reduced <= 1'b0;
			counter <= counter + 11'd1;
		end
		else
		begin
			clk_reduced <= 1'b1;
			counter <= 11'd0;
		end

	end

end

endmodule
