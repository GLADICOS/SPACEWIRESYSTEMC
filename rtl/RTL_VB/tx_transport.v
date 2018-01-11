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

			input tx_dout,
			input tx_sout,

			output reg tx_dout_e,
			output reg tx_sout_e
);

always@(posedge pclk_tx or negedge enable_tx)
begin

	if(!enable_tx)
	begin
		tx_dout_e <=  1'b0;
		tx_sout_e <=  1'b0;
	end
	else
	begin
		if(send_null_tx)
		begin
			tx_dout_e <= tx_dout;
			tx_sout_e <= tx_sout;
		end
		else
		begin
			tx_dout_e <=  1'b0;
			tx_sout_e <=  1'b0;
		end
	end
end

endmodule
