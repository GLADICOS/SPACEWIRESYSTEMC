
module spw_ulight_nofifo (
	auto_start_0_external_connection_export,
	auto_start_external_connection_export,
	clk_clk,
	clock_sel_external_connection_export,
	credit_error_rx_0_external_connection_export,
	credit_error_rx_external_connection_export,
	data_en_to_w_0_external_connection_export,
	data_en_to_w_external_connection_export,
	data_rx_r_0_external_connection_export,
	data_rx_r_external_connection_export,
	data_rx_ready_0_external_connection_export,
	data_rx_ready_external_connection_export,
	data_tx_ready_0_external_connection_export,
	data_tx_ready_external_connection_export,
	data_tx_to_w_0_external_connection_export,
	data_tx_to_w_external_connection_export,
	fsm_info_0_external_connection_export,
	fsm_info_external_connection_export,
	led_fpga_external_connection_export,
	link_disable_0_external_connection_export,
	link_disable_external_connection_export,
	link_start_0_external_connection_export,
	link_start_external_connection_export,
	monitor_a_external_connection_export,
	monitor_b_external_connection_export,
	pll_tx_locked_export,
	pll_tx_outclk0_clk,
	pll_tx_outclk1_clk,
	pll_tx_outclk2_clk,
	pll_tx_outclk3_clk,
	pll_tx_outclk4_clk,
	reset_reset_n,
	send_fct_now_0_external_connection_export,
	send_fct_now_external_connection_export,
	timec_en_to_tx_0_external_connection_export,
	timec_en_to_tx_external_connection_export,
	timec_rx_r_0_external_connection_export,
	timec_rx_r_external_connection_export,
	timec_rx_ready_0_external_connection_export,
	timec_rx_ready_external_connection_export,
	timec_tx_ready_0_external_connection_export,
	timec_tx_ready_external_connection_export,
	timec_tx_to_w_0_external_connection_export,
	timec_tx_to_w_external_connection_export);	

	output		auto_start_0_external_connection_export;
	output		auto_start_external_connection_export;
	input		clk_clk;
	output	[2:0]	clock_sel_external_connection_export;
	output		credit_error_rx_0_external_connection_export;
	output		credit_error_rx_external_connection_export;
	output		data_en_to_w_0_external_connection_export;
	output		data_en_to_w_external_connection_export;
	input	[8:0]	data_rx_r_0_external_connection_export;
	input	[8:0]	data_rx_r_external_connection_export;
	input		data_rx_ready_0_external_connection_export;
	output		data_rx_ready_external_connection_export;
	input		data_tx_ready_0_external_connection_export;
	input		data_tx_ready_external_connection_export;
	output	[8:0]	data_tx_to_w_0_external_connection_export;
	output	[8:0]	data_tx_to_w_external_connection_export;
	input	[5:0]	fsm_info_0_external_connection_export;
	input	[5:0]	fsm_info_external_connection_export;
	output	[5:0]	led_fpga_external_connection_export;
	output		link_disable_0_external_connection_export;
	output		link_disable_external_connection_export;
	output		link_start_0_external_connection_export;
	output		link_start_external_connection_export;
	input	[13:0]	monitor_a_external_connection_export;
	input	[13:0]	monitor_b_external_connection_export;
	output		pll_tx_locked_export;
	output		pll_tx_outclk0_clk;
	output		pll_tx_outclk1_clk;
	output		pll_tx_outclk2_clk;
	output		pll_tx_outclk3_clk;
	output		pll_tx_outclk4_clk;
	input		reset_reset_n;
	output		send_fct_now_0_external_connection_export;
	output		send_fct_now_external_connection_export;
	output		timec_en_to_tx_0_external_connection_export;
	output		timec_en_to_tx_external_connection_export;
	input	[7:0]	timec_rx_r_0_external_connection_export;
	input	[7:0]	timec_rx_r_external_connection_export;
	input		timec_rx_ready_0_external_connection_export;
	input		timec_rx_ready_external_connection_export;
	input		timec_tx_ready_0_external_connection_export;
	input		timec_tx_ready_external_connection_export;
	output	[7:0]	timec_tx_to_w_0_external_connection_export;
	output	[7:0]	timec_tx_to_w_external_connection_export;
endmodule
