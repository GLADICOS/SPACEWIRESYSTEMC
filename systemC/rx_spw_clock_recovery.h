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

#ifndef SPW_RX_CLOCK_RECOVERY_H
#define SPW_RX_CLOCK_RECOVERY_H

class SPW_RX_CLOCK_RECOVERY_SC;

SC_MODULE(SPW_RX_CLOCK_RECOVERY_SC)
{
	sc_in<uint>  DIN_REC;
	sc_in<uint>  SIN_REC;

	sc_out<bool> RX_CLOCK_OUT;

	void RX_CLOCK_XOR()
	{
		RX_CLOCK_OUT = DIN_REC ^ SIN_REC;
	}

	SC_CTOR(SPW_RX_CLOCK_RECOVERY_SC)
	{
		SC_METHOD(RX_CLOCK_XOR);
		sensitive << DIN_REC << SIN_REC;
	}
};
#endif
