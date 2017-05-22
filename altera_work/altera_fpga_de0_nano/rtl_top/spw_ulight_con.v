
module spw_ulight_con(
								input   			FPGA_CLK1_50,
								input          [1:0] KEY,

								//////////// LED ////////////
								/* 3.3-V LVTTL */
								output   [7:0] LED

							);


	wire ppllclk;
	wire ppll_2_MHZ;
	wire ppll_5_MHZ;
	wire ppll_10_MHZ;
	wire ppll_50_MHZ;
	wire ppll_100_MHZ;
	wire ppll_150_MHZ;
	wire ppll_200_MHZ;
	wire ppll_300_MHZ;

	wire top_tx_write;
	wire [8:0] top_tx_data;

	wire top_tx_tick;
	wire [7:0] top_tx_time;

	wire credit_error_rx;
	wire top_send_fct_now;

	wire [8:0] datarx_flag;
	wire buffer_write;

	wire [7:0] time_out;
	wire tick_out;

	wire top_dout;
	wire top_sout;
	
	wire top_din;
	wire top_sin;

	wire top_tx_ready;
	wire top_tx_ready_tick;

	wire [5:0] top_fsm_i;
	
	wire [2:0] clock_sel;
	wire reset_Kn;
		
	wire top_auto_start;
	wire top_link_start;
	wire top_link_disable;
	
	wire resetn_rx;
	wire error_rx;

	wire got_bit_rx;
	wire got_null_rx;
	wire got_nchar_rx;
	wire got_time_code_rx;
	wire got_fct_rx;

	wire enable_tx;
	wire send_null_tx;
	wire send_fct_tx;
	
	wire got_fct_flag_fsm;
	
	/**************************/
	
	wire top_tx_write_0;
	wire [8:0] top_tx_data_0;

	wire top_tx_tick_0;
	wire [7:0] top_tx_time_0;

	wire credit_error_rx_0;
	wire top_send_fct_now_0;

	wire [8:0] datarx_flag_0;
	wire buffer_write_0;

	wire [7:0] time_out_0;
	wire tick_out_0;

	wire top_dout_0;
	wire top_sout_0;
	
	wire top_din_0;
	wire top_sin_0;

	wire top_tx_ready_0;
	wire top_tx_ready_tick_0;

	wire [5:0] top_fsm_i_0;
		
	wire top_auto_start_0;
	wire top_link_start_0;
	wire top_link_disable_0;
	
	wire resetn_rx_0;
	wire error_rx_0;

	wire got_bit_rx_0;
	wire got_null_rx_0;
	wire got_nchar_rx_0;
	wire got_time_code_rx_0;
	wire got_fct_rx_0;

	wire enable_tx_0;
	wire send_null_tx_0;
	wire send_fct_tx_0;
	
	wire got_fct_flag_fsm_0;
	
	wire [13:0] monitor_a;
	wire rx_buffer_write_mon_a;
	wire [13:0] data_a;
	
	wire [13:0] monitor_b;
	wire rx_buffer_write_mon_b;
	wire [13:0] data_b;
	
	wire reset_spw_n_a;
	wire reset_spw_n_b;
	
	wire pll_tx_locked_export;	
	assign  ppllclk = (clock_sel == 3'd0)?ppll_2_MHZ:
			  (clock_sel == 3'd1)?ppll_5_MHZ:
			  (clock_sel == 3'd2)?ppll_10_MHZ:ppll_5_MHZ;
			 // (clock_sel == 3'd3)?ppll_50_MHZ:ppll_5_MHZ;
			  //(clock_sel == 3'd4)?ppll_100_MHZ:ppll_5_MHZ;
			  //(clock_sel == 3'd5)?ppll_200_MHZ:ppll_5_MHZ;
			  //(clock_sel == 8'd5)?ppll_200_MHZ:
			  //(clock_sel == 8'd6)?ppll_300_MHZ:ppll_5_MHZ;	  
			  
	assign top_sin   = top_sout_0;
	assign top_din   = top_dout_0;
		
	assign top_sin_0 = top_sout;
	assign top_din_0 = top_dout;
	
	assign LED[7:7] = pll_tx_locked_export;
	
		
	spw_ulight_nofifo  AXI_INTERFACE (
		.auto_start_external_connection_export(top_auto_start),      //      auto_start_external_connection.export
		.clock_sel_external_connection_export(clock_sel),
		.clk_clk(FPGA_CLK1_50),                                    //                                 clk.clk
		.credit_error_rx_external_connection_export(credit_error_rx), // credit_error_rx_external_connection.export
		.data_en_to_w_external_connection_export(top_tx_write),    //    data_en_to_w_external_connection.export
		.data_rx_r_external_connection_export(datarx_flag),       //       data_rx_r_external_connection.export
		.data_rx_ready_external_connection_export(buffer_write),   //   data_rx_ready_external_connection.export
		.data_tx_ready_external_connection_export(top_tx_ready),   //   data_tx_ready_external_connection.export
		.data_tx_to_w_external_connection_export(top_tx_data),    //    data_tx_to_w_external_connection.export
		.fsm_info_external_connection_export(top_fsm_i),        //        fsm_info_external_connection.export
		.led_fpga_external_connection_export(LED[4:0]),        //        led_fpga_external_connection.export
		.link_disable_external_connection_export(top_link_disable),    //    link_disable_external_connection.export
		.link_start_external_connection_export(top_link_start),      //      link_start_external_connection.export
		.pll_tx_outclk0_clk(ppll_5_MHZ),                         //                      pll_tx_outclk0.clk
		.pll_tx_outclk1_clk(ppll_10_MHZ),                         //                      pll_tx_outclk1.clk
		.pll_tx_outclk2_clk(ppll_50_MHZ),                         //                      pll_tx_outclk2.clk
		.pll_tx_outclk3_clk(ppll_100_MHZ),                         //                      pll_tx_outclk3.clk
		.pll_tx_outclk4_clk(ppll_200_MHZ),                         //                      pll_tx_outclk4.clk
		.reset_reset_n(reset_spw_n_a),                              //                               reset.reset_n
		.send_fct_now_external_connection_export(top_send_fct_now),    //    send_fct_now_external_connection.export
		.timec_en_to_tx_external_connection_export(top_tx_tick),  //  timec_en_to_tx_external_connection.export
		.timec_rx_r_external_connection_export(time_out),      //      timec_rx_r_external_connection.export
		.timec_rx_ready_external_connection_export(tick_out),  //  timec_rx_ready_external_connection.export
		.timec_tx_ready_external_connection_export(top_tx_ready_tick),  //  timec_tx_ready_external_connection.export
		.timec_tx_to_w_external_connection_export(top_tx_time),    //   timec_tx_to_w_external_connection.export
		.pll_tx_locked_export(pll_tx_locked_export),

		.auto_start_0_external_connection_export(top_auto_start_0),      //      auto_start_external_connection.export
		.link_disable_0_external_connection_export(top_link_disable_0),    //    link_disable_external_connection.export
		.link_start_0_external_connection_export(top_link_start_0),      //      link_start_external_connection.export
		
		.credit_error_rx_0_external_connection_export(credit_error_rx_0), // credit_error_rx_external_connection.export
		.data_en_to_w_0_external_connection_export(top_tx_write_0),    //    data_en_to_w_external_connection.export
		.data_rx_r_0_external_connection_export(datarx_flag_0),       //       data_rx_r_external_connection.export
		.data_rx_ready_0_external_connection_export(buffer_write_0),   //   data_rx_ready_external_connection.export
		.data_tx_ready_0_external_connection_export(top_tx_ready_0),  		   //   data_tx_ready_external_connection.export
		.data_tx_to_w_0_external_connection_export(top_tx_data_0),    			//    data_tx_to_w_external_connection.export
		.fsm_info_0_external_connection_export(top_fsm_i_0),        			//        fsm_info_external_connection.export	

		.send_fct_now_0_external_connection_export(top_send_fct_now_0),      //    send_fct_now_external_connection.export
		.timec_en_to_tx_0_external_connection_export(top_tx_tick_0),  		   //  timec_en_to_tx_external_connection.export
		.timec_rx_r_0_external_connection_export(time_out_0),      			   //      timec_rx_r_external_connection.export
		.timec_rx_ready_0_external_connection_export(tick_out_0),  				//  timec_rx_ready_external_connection.export
		.timec_tx_ready_0_external_connection_export(top_tx_ready_tick_0),   //  timec_tx_ready_external_connection.export
		.timec_tx_to_w_0_external_connection_export(top_tx_time_0),		      //   timec_tx_to_w_external_connection.expor
	
		.monitor_a_external_connection_export(data_a),         //         monitor_a_external_connection.export
		.monitor_b_external_connection_export(data_b)         //         monitor_b_external_connection.export	
	);
	
			FSM_SPW FSM(
			.pclk(ppll_100_MHZ),
			.resetn(reset_spw_n_b),

			.auto_start(top_auto_start),
			.link_start(top_link_start),
			.link_disable(top_link_disable),

			.rx_error(error_rx),
			.rx_credit_error(credit_error_rx),
			.rx_got_bit(got_bit_rx),
			.rx_got_null(got_null_rx),
			.rx_got_nchar(got_nchar_rx),
			.rx_got_time_code(got_time_code_rx),
			.rx_got_fct(got_fct_flag_fsm),
			.rx_resetn(resetn_rx),

			.enable_tx(enable_tx),
			.send_null_tx(send_null_tx),
			.send_fct_tx(send_fct_tx),

			.fsm_state(top_fsm_i)
	
			);

	RX_SPW RX(
			.rx_din(top_din),
			.rx_sin(top_sin),

			.rx_resetn(resetn_rx),

			.rx_error(error_rx),
			.rx_got_bit(got_bit_rx),
			.rx_got_null(got_null_rx),
			.rx_got_nchar(got_nchar_rx),
			.rx_got_time_code(got_time_code_rx),
			.rx_got_fct(got_fct_rx),
			.rx_got_fct_fsm(got_fct_flag_fsm),

			.rx_data_flag(datarx_flag),
			.rx_buffer_write(buffer_write),

			.rx_time_out(time_out),
			.rx_tick_out(tick_out)

 			 );

	TX_SPW        TX(
			.pclk_tx(ppllclk),

			.data_tx_i(top_tx_data),
			.txwrite_tx(top_tx_write),
		
			.timecode_tx_i(8'd0),//top_tx_time),
			.tickin_tx(1'b0),//top_tx_tick),
		
			.enable_tx(enable_tx),
			.send_null_tx(send_null_tx),
			.send_fct_tx(send_fct_tx),

			.gotfct_tx(got_fct_rx),
			.send_fct_now(top_send_fct_now),
		
			.tx_dout(top_dout),
			.tx_sout(top_sout),

			.ready_tx_data(top_tx_ready),
			.ready_tx_timecode(top_tx_ready_tick)
			);

			/*****************************/
			
			FSM_SPW FSM_B(
			.pclk(ppll_100_MHZ),
			.resetn(reset_spw_n_b),

			.auto_start(top_auto_start_0),
			.link_start(top_link_start_0),
			.link_disable(top_link_disable_0),

			.rx_error(error_rx_0),
			.rx_credit_error(credit_error_rx_0),
			.rx_got_bit(got_bit_rx_0),
			.rx_got_null(got_null_rx_0),
			.rx_got_nchar(got_nchar_rx_0),
			.rx_got_time_code(got_time_code_rx_0),
			.rx_got_fct(got_fct_flag_fsm_0),
			.rx_resetn(resetn_rx_0),

			.enable_tx(enable_tx_0),
			.send_null_tx(send_null_tx_0),
			.send_fct_tx(send_fct_tx_0),

			.fsm_state(top_fsm_i_0)
	
			);


	RX_SPW RX_B(
			.rx_din(top_din_0),
			.rx_sin(top_sin_0),

			.rx_resetn(resetn_rx_0),

			.rx_error(error_rx_0),
			.rx_got_bit(got_bit_rx_0),
			.rx_got_null(got_null_rx_0),
			.rx_got_nchar(got_nchar_rx_0),
			.rx_got_time_code(got_time_code_rx_0),
			.rx_got_fct(got_fct_rx_0),
			.rx_got_fct_fsm(got_fct_flag_fsm_0),

			.rx_data_flag(datarx_flag_0),
			.rx_buffer_write(buffer_write_0),

			.rx_time_out(time_out_0),
			.rx_tick_out(tick_out_0)

 			 );

	TX_SPW        TX_B(
			.pclk_tx(ppllclk),

			.data_tx_i(9'd0),//top_tx_data_0),
			.txwrite_tx(1'b0),//top_tx_write_0),
		
			.timecode_tx_i(8'd0),//top_tx_time_0),
			.tickin_tx(1'b0),//top_tx_tick_0),
		
			.enable_tx(enable_tx_0),
			.send_null_tx(send_null_tx_0),
			.send_fct_tx(send_fct_tx_0),

			.gotfct_tx(got_fct_rx_0),
			.send_fct_now(top_send_fct_now_0),
		
			.tx_dout(top_dout_0),
			.tx_sout(top_sout_0),

			.ready_tx_data(top_tx_ready_0),
			.ready_tx_timecode(top_tx_ready_tick_0)
			);
			
			detector_tokens A(
								.rx_din(top_dout),
								.rx_sin(top_sout),
								.rx_buffer_write(rx_buffer_write_mon_a),
								.rx_resetn(reset_spw_n_b),
								.info(monitor_a)
							 );
							 
			write_axi dt_a(
							.clock_recovery(rx_buffer_write_mon_a),
							.reset_n(reset_spw_n_b),
							.data_rec(monitor_a),
							.data_stand(data_a)	
			);
			
					
			write_axi dt_b(
							.clock_recovery(rx_buffer_write_mon_b),
							.reset_n(reset_spw_n_b),
							.data_rec(monitor_b),
							.data_stand(data_b)	
			);
		
			detector_tokens B(
								.rx_din(top_dout_0),
								.rx_sin(top_sout_0),
								.rx_buffer_write(rx_buffer_write_mon_b),
								.rx_resetn(reset_spw_n_b),
								.info(monitor_b)
							 );
						 
		  clock_reduce R_2_2MHZ(
										.clk(ppll_100_MHZ),
										.reset_n(pll_tx_locked_export),
										.clk_reduced(ppll_2_MHZ)
									  );
										
			debounce_db db_system_spwulight_a(
											.CLK(FPGA_CLK1_50),
											.PB(KEY[0]),
											.PB_state(reset_spw_n_a),
											.PB_down(LED[6:6])
										);
											
			debounce_db db_system_spwulight_b(
											.CLK(FPGA_CLK1_50),
											.PB(KEY[1]),
											.PB_state(reset_spw_n_b),
											.PB_down(LED[5:5])
										);
endmodule
