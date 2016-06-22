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
