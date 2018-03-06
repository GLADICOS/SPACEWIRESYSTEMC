
module spw_babasu (
	autostart_external_connection_export,
	clk_clk,
	currentstate_external_connection_export,
	data_i_external_connection_export,
	data_o_external_connection_export,
	flags_external_connection_export,
	link_disable_external_connection_export,
	link_start_external_connection_export,
	pll_0_locked_export,
	pll_0_outclk0_clk,
	rd_data_external_connection_export,
	reset_reset_n,
	rx_empty_external_connection_export,
	spill_enable_external_connection_export,
	tick_in_external_connection_export,
	tick_out_external_connection_export,
	time_in_external_connection_export,
	time_out_external_connection_export,
	tx_clk_div_external_connection_export,
	tx_full_external_connection_export,
	wr_data_external_connection_export);	

	output		autostart_external_connection_export;
	input		clk_clk;
	input	[2:0]	currentstate_external_connection_export;
	output	[8:0]	data_i_external_connection_export;
	input	[8:0]	data_o_external_connection_export;
	input	[10:0]	flags_external_connection_export;
	output		link_disable_external_connection_export;
	output		link_start_external_connection_export;
	output		pll_0_locked_export;
	output		pll_0_outclk0_clk;
	output		rd_data_external_connection_export;
	input		reset_reset_n;
	input		rx_empty_external_connection_export;
	output		spill_enable_external_connection_export;
	output		tick_in_external_connection_export;
	input		tick_out_external_connection_export;
	output	[7:0]	time_in_external_connection_export;
	input	[7:0]	time_out_external_connection_export;
	output	[6:0]	tx_clk_div_external_connection_export;
	input		tx_full_external_connection_export;
	output		wr_data_external_connection_export;
endmodule
