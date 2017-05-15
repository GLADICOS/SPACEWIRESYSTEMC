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
#ifndef TX_RX_SC_TOP_H
#define TX_RX_SC_TOP_H

#include "spw_fsm.h"

#include "tx_spw.h"
#include "tx_clock.h"
#include "link_sc.h"

#include "rx_spw.h"
#include "rx_spw_clock_recovery.h"

#include "send_module_sc.h"

class sc_TOP;

SC_MODULE(sc_TOP)
{

	/*FSM signal*/
	sc_in<bool> CLOCK;
	sc_in<bool> RESET;
	sc_in<bool> LINK_START;
	sc_in<bool> LINK_DISABLE;
	sc_in<bool> AUTO_START;
	sc_out<sc_uint<4> > FSM_SPW_OUT;

	/*Signal come from RX Receiver*/
	sc_signal<bool> GOT_FCT_RX;
	sc_signal<bool> GOT_TIMECODE_RX;
	sc_signal<bool> GOTNCHAR_RX;
	sc_signal<bool> GOTNULL_RX;
	sc_signal<bool> GOTBIT_RX;
	sc_signal<bool> CREDITERROR_RX;
	sc_signal<bool> RXERROR;

	/*Signal come from TX Transmit*/
	sc_signal<bool> ENABLE_TX;
	sc_signal<bool> SEND_NULL_TX;
	sc_signal<bool> SEND_FCT_TX;
	sc_signal<bool> SEND_NCHAR_TX;
	sc_signal<bool> SEND_TIME_CODE_TX;
	
	/*RESET TX / RX*/
	sc_signal<bool> RESET_TX;

	//sc_signal<bool> GOT_FCT_TX;
	//TX ONLY
	sc_signal<bool> TICKIN_TX;
	sc_signal<sc_uint<8> > TIMEIN_CONTROL_FLAG_TX;

	sc_signal<bool> SEND_FCT_NOW_TOP;
	sc_signal<bool> TXWRITE_TX_S;
	sc_signal<sc_uint<9> > TXDATA_FLAGCTRL_TX;

	sc_signal<bool> READY_TX;
	sc_signal<bool> READY_TICK;

	sc_signal<bool> CLOCK_TX_OUT;

	sc_out<uint> DOUT; //TROCAR PARA UINT QUANDO FOR PARA O VPI
	sc_out<uint> SOUT; //TROCAR PARA UINT QUANDO FOR PARA O VPI

	sc_out<sc_uint<4> > FSM_TX;

	//MODULE RX
	sc_in<uint>  DIN;
	sc_in<uint>  SIN;

	sc_signal<bool> ENABLE_RX;
	sc_signal<bool> RESET_RX;

	sc_signal<bool> RX_CLOCK_IN;
	sc_in<bool> BUFFER_READY;
	sc_out<sc_uint<9> > DATARX_FLAG;
	sc_out<bool> BUFFER_WRITE;

	sc_out<sc_uint<8> > TIME_OUT;
	sc_out<bool>	TICK_OUT;
	sc_out<bool>	CONTROL_FLAG_OUT;

	sc_in<sc_uint<10> > CLOCK_GEN;
	sc_in<bool> E_SEND_DATA;

	SPW_TX_SC DUT;
	SPW_TX_CLOCK_SC DUT1;

	SPW_RX_SC DUT2;
	SPW_RX_CLOCK_RECOVERY_SC DUT3;

	SPW_FSM_SC DUT4;

	SPW_TX_SEND_DATA DUT5;

 	SC_CTOR(sc_TOP) : DUT("DUT"),DUT1("DUT1"),DUT2("DUT2"),DUT3("DUT3"),DUT4("DUT4"),DUT5("DUT5")
	{
		DUT1.CLOCK_GEN(CLOCK_GEN);
		DUT1.RESET(RESET);
		DUT1.CLOCK_TX_OUT(CLOCK_TX_OUT);

		DUT.CLOCK_TX(CLOCK_TX_OUT);
		DUT.CLOCK_SYS(CLOCK);
		DUT.RESET_TX(RESET_TX);
		DUT.TICKIN_TX(TICKIN_TX);
		DUT.TIMEIN_CONTROL_FLAG_TX(TIMEIN_CONTROL_FLAG_TX);
		DUT.TXWRITE_TX(TXWRITE_TX_S);
		DUT.TXDATA_FLAGCTRL_TX(TXDATA_FLAGCTRL_TX);

		DUT.SEND_FCT_NOW(SEND_FCT_NOW_TOP);
		DUT.ENABLE_TX(ENABLE_TX);
		DUT.SEND_NULL_TX(SEND_NULL_TX);
		DUT.SEND_FCT_TX(SEND_FCT_TX);
		DUT.SEND_NCHAR_TX(SEND_NCHAR_TX);
		DUT.SEND_TIME_CODE_TX(SEND_TIME_CODE_TX);
		DUT.GOTFCT_TX(GOT_FCT_RX);
		DUT.READY_TX(READY_TX);

		DUT.READY_TICK(READY_TICK);
		DUT.DOUT(DOUT);
		DUT.SOUT(SOUT);
		DUT.FSM_TX(FSM_TX);

		DUT3.DIN_REC(DIN);
		DUT3.SIN_REC(SIN);
		DUT3.RX_CLOCK_OUT(RX_CLOCK_IN);

		DUT2.RX_CLOCK(RX_CLOCK_IN);
		DUT2.DIN(DIN);
		DUT2.SIN(SIN);
		DUT2.CLOCK_SYS(CLOCK);
		DUT2.ENABLE_RX(ENABLE_RX);
		DUT2.RESET_RX(RESET_RX);
		DUT2.RX_ERROR(RXERROR);
		DUT2.RX_CREDIT_ERROR(CREDITERROR_RX);
		DUT2.GOT_BIT(GOTBIT_RX);
		DUT2.GOT_NULL(GOTNULL_RX);
		DUT2.GOT_NCHAR(GOTNCHAR_RX);
		DUT2.GOT_TIME_CODE(GOT_TIMECODE_RX);
		DUT2.GOT_FCT(GOT_FCT_RX);
		DUT2.SEND_FCT_NOW_RX(SEND_FCT_NOW_TOP);

		DUT2.BUFFER_READY(BUFFER_READY);
		DUT2.DATARX_FLAG(DATARX_FLAG);
		DUT2.BUFFER_WRITE(BUFFER_WRITE);
		DUT2.TIME_OUT(TIME_OUT);
		DUT2.TICK_OUT(TICK_OUT);
		DUT2.CONTROL_FLAG_OUT(CONTROL_FLAG_OUT);

		DUT4.CLOCK(CLOCK);
		DUT4.RESET(RESET);
		DUT4.LINK_START(LINK_START);
		DUT4.LINK_DISABLE(LINK_DISABLE);
		DUT4.AUTO_START(AUTO_START);
		DUT4.FSM_SPW_OUT(FSM_SPW_OUT);

		DUT4.GOT_FCT_RX(GOT_FCT_RX);
		DUT4.GOT_TIMECODE_RX(GOT_TIMECODE_RX);
		DUT4.GOTNCHAR_RX(GOTNCHAR_RX);
		DUT4.GOTNULL_RX(GOTNULL_RX);
		DUT4.GOTBIT_RX(GOTBIT_RX);
		DUT4.CREDITERROR_RX(CREDITERROR_RX);
		DUT4.RXERROR_RX(RXERROR);
		DUT4.ENABLE_RX(ENABLE_RX);

		DUT4.ENABLE_TX(ENABLE_TX);
		DUT4.SEND_NULL_TX(SEND_NULL_TX);
		DUT4.SEND_FCT_TX(SEND_FCT_TX);
		DUT4.SEND_NCHAR_TX(SEND_NCHAR_TX);
		DUT4.SEND_TIMECODE_TX(SEND_TIME_CODE_TX);
		DUT4.RESET_TX(RESET_TX);
		DUT4.RESET_RX(RESET_RX);

		DUT5.CLOCK_SEND_DATA(CLOCK);
		DUT5.RESET_SEND_DATA(RESET);
		DUT5.E_SEND_DATA(E_SEND_DATA);
		DUT5.TICKIN_TX_SEND_DATA(TICKIN_TX);
		DUT5.TIMEIN_CONTROL_FLAG_TX_SEND_DATA(TIMEIN_CONTROL_FLAG_TX);
		DUT5.TXWRITE_TX_SEND_DATA(TXWRITE_TX_S);
		DUT5.TXDATA_FLAGCTRL_TX_SEND_DATA(TXDATA_FLAGCTRL_TX);
		DUT5.READY_TX_SEND_DATA(READY_TX);
		DUT5.READY_TICK_DATA(READY_TICK);

		cout << "SC_CTOR(sc_TOP)" << endl;
	}



};

#endif
