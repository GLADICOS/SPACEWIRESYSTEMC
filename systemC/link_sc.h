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
#ifndef CONTROL_SC_H
#define CONTROL_SC_H

class Control_SC
{
	public:
	/*Constructor*/
	Control_SC();
	
	/*initialize systemC model*/
	virtual void init();

	/*Reset the model*/
	virtual bool reset_set();

	/*Run the Env for ammount off time*/
	virtual void run_sim();

	/*Tell to SystemC to finish*/
	virtual void stop_sim();

	/*get dout */
	virtual unsigned int get_value_dout();
	/*get sout*/
	virtual unsigned int get_value_sout();

	/*set sin*/
	virtual void set_rx_sin(unsigned int strobe);
	/*set din*/
	virtual void set_rx_din(unsigned int data);

	virtual unsigned int get_spw_fsm();

	virtual unsigned int finish_simulation();

	//verilog variables 
	virtual bool verilog_linkenable();
	virtual bool verilog_autostart();
	virtual bool verilog_linkdisable();
	virtual float verilog_frequency();

	//tests 
	virtual bool start_tx_test();
	virtual bool enable_time_code_tx_test();
	virtual void end_tx_test();
	virtual unsigned int take_data(unsigned int a);
	virtual int size_data_test();

	virtual void data_o(unsigned int data, unsigned int pos);

	virtual unsigned int clock_tx();


};
#endif
