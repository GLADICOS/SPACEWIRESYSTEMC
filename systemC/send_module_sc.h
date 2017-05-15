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

#ifndef SPW_TX_SEND
#define SPW_TX_SEND

class SPW_TX_SEND_DATA;

SC_MODULE(SPW_TX_SEND_DATA)
{
	sc_in<bool> CLOCK_SEND_DATA;
	sc_in<bool> RESET_SEND_DATA;
	sc_in<bool> E_SEND_DATA;

	sc_out<bool> TICKIN_TX_SEND_DATA;
	sc_out<sc_uint<8> > TIMEIN_CONTROL_FLAG_TX_SEND_DATA;

	sc_out<bool> TXWRITE_TX_SEND_DATA;
	sc_out<sc_uint<9> > TXDATA_FLAGCTRL_TX_SEND_DATA;

	sc_in<bool> READY_TX_SEND_DATA;
	sc_in<bool> READY_TICK_DATA;

	sc_uint<9> data_send;

	int a = 0;
	int c = 0;

	void SEND_DATA()
	{
		if(!RESET_SEND_DATA)
		{
			TXWRITE_TX_SEND_DATA = false;
			a=0;
		}
		else
		{
			if(E_SEND_DATA && data_generated_sc.size() > 0)
			{
				
				if(a < data_generated_sc.size()-(unsigned int)1)
				{
					data_send = data_generated_sc[a];
					if(!READY_TX_SEND_DATA)
					{
						TXWRITE_TX_SEND_DATA = true;
					}else
					{
						TXWRITE_TX_SEND_DATA = false;
						TXDATA_FLAGCTRL_TX_SEND_DATA= data_send;
					}
				}
				//cout << TXDATA_FLAGCTRL_TX_SEND_DATA.read().to_string(SC_HEX) << " " << READY_TX_SEND_DATA << " " << TXWRITE_TX_SEND_DATA << endl;
			
			}
			
		}
	}


	void INCREMMENT_DATA()
	{
		if(a < data_generated_sc.size()-(unsigned int)1)
			a++;
		else
			a=0;
	}

	void SEND_TIME_CODE()
	{
		if(!RESET_SEND_DATA)
		{
			TICKIN_TX_SEND_DATA = false;
			TIMEIN_CONTROL_FLAG_TX_SEND_DATA = 0;
			c=0;
		}
		else
		{
			if(start_tick_data)
			{
				if( c < 256)
				{

					if(!READY_TICK_DATA)
					{
						TICKIN_TX_SEND_DATA = true;
					}
					else
					{
						TICKIN_TX_SEND_DATA = false;
						c++;
						TIMEIN_CONTROL_FLAG_TX_SEND_DATA = TIMEIN_CONTROL_FLAG_TX_SEND_DATA.read() +1;
					}
				}
				else
				{
					c=0;
					TIMEIN_CONTROL_FLAG_TX_SEND_DATA = 0;
				}
			}
		}
	}
	SC_CTOR(SPW_TX_SEND_DATA)
	{
		SC_METHOD(SEND_DATA);
		sensitive << CLOCK_SEND_DATA;
		SC_METHOD(INCREMMENT_DATA);
		sensitive << READY_TX_SEND_DATA.pos();
		SC_METHOD(SEND_TIME_CODE);
		sensitive << CLOCK_SEND_DATA.pos();
	}
};
#endif
