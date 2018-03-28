
module spw_light (
	autostart_external_connection_export,
	clk_clk,
	connecting_external_connection_export,
	ctrl_in_external_connection_export,
	ctrl_out_external_connection_export,
	errcred_external_connection_export,
	errdisc_external_connection_export,
	erresc_external_connection_export,
	errpar_external_connection_export,
	linkdis_external_connection_export,
	linkstart_external_connection_export,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	pll_0_locked_export,
	pll_0_outclk0_clk,
	reset_reset_n,
	running_external_connection_export,
	rxdata_external_connection_export,
	rxflag_external_connection_export,
	rxhalff_external_connection_export,
	rxread_external_connection_export,
	rxvalid_external_connection_export,
	started_external_connection_export,
	tick_in_external_connection_export,
	tick_out_external_connection_export,
	time_in_external_connection_export,
	time_out_external_connection_export,
	txdata_external_connection_export,
	txdivcnt_external_connection_export,
	txflag_external_connection_export,
	txhalff_external_connection_export,
	txrdy_external_connection_export,
	txwrite_external_connection_export);	

	output		autostart_external_connection_export;
	input		clk_clk;
	input		connecting_external_connection_export;
	output	[1:0]	ctrl_in_external_connection_export;
	input	[1:0]	ctrl_out_external_connection_export;
	input		errcred_external_connection_export;
	input		errdisc_external_connection_export;
	input		erresc_external_connection_export;
	input		errpar_external_connection_export;
	output		linkdis_external_connection_export;
	output		linkstart_external_connection_export;
	output	[12:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[7:0]	memory_mem_dq;
	inout		memory_mem_dqs;
	inout		memory_mem_dqs_n;
	output		memory_mem_odt;
	output		memory_mem_dm;
	input		memory_oct_rzqin;
	output		pll_0_locked_export;
	output		pll_0_outclk0_clk;
	input		reset_reset_n;
	input		running_external_connection_export;
	input	[7:0]	rxdata_external_connection_export;
	input		rxflag_external_connection_export;
	input		rxhalff_external_connection_export;
	output		rxread_external_connection_export;
	input		rxvalid_external_connection_export;
	input		started_external_connection_export;
	output		tick_in_external_connection_export;
	input		tick_out_external_connection_export;
	output	[5:0]	time_in_external_connection_export;
	input	[5:0]	time_out_external_connection_export;
	output	[7:0]	txdata_external_connection_export;
	output	[7:0]	txdivcnt_external_connection_export;
	output		txflag_external_connection_export;
	input		txhalff_external_connection_export;
	input		txrdy_external_connection_export;
	output		txwrite_external_connection_export;
endmodule
