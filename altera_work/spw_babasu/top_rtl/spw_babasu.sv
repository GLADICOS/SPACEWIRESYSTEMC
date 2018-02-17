module SPW_BABASU_TOP(
								input   FPGA_CLK1_50,
								input   [1:0] KEY,
								
								input		din_a,
								input		sin_a,
								//input		din_b,
								//input		sin_b,
								output	dout_a,
								output	sout_a,
								//output	dout_b,
								//output	sout_b,
								//////////// LED ////////////
								/* 3.3-V LVTTL */
								output   [7:0] LED

							);
						
			wire CLOCK_200MHZ;	
			wire LINK_START_w;
			wire LINK_DISABLE_w;
			wire AUTOSTART_w;
			wire [2:0] 	CURRENTSTATE_w;
			wire [10:0]	FLAGS_w;
			wire [8:0]	DATA_I_w;
			wire WR_DATA_w;
			wire TX_FULL_w;
			wire [8:0]	DATA_O_w;
			wire RD_DATA_w;
			wire RX_EMPTY_w;
			wire TICK_OUT_w;
			wire [7:0] 	TIME_OUT_w;
			wire TICK_IN_w;
			wire [7:0]	TIME_IN_w;
			wire [6:0]	TX_CLK_DIV_w;
			wire SPILL_ENABLE_w;
							
	spw_babasu u0 (
		.clk_clk                                 (FPGA_CLK1_50),                                 //                              clk.clk
		/*.memory_mem_a                            (<connected-to-memory_mem_a>),                            //                           memory.mem_a
		.memory_mem_ba                           (<connected-to-memory_mem_ba>),                           //                                 .mem_ba
		.memory_mem_ck                           (<connected-to-memory_mem_ck>),                           //                                 .mem_ck
		.memory_mem_ck_n                         (<connected-to-memory_mem_ck_n>),                         //                                 .mem_ck_n
		.memory_mem_cke                          (<connected-to-memory_mem_cke>),                          //                                 .mem_cke
		.memory_mem_cs_n                         (<connected-to-memory_mem_cs_n>),                         //                                 .mem_cs_n
		.memory_mem_ras_n                        (<connected-to-memory_mem_ras_n>),                        //                                 .mem_ras_n
		.memory_mem_cas_n                        (<connected-to-memory_mem_cas_n>),                        //                                 .mem_cas_n
		.memory_mem_we_n                         (<connected-to-memory_mem_we_n>),                         //                                 .mem_we_n
		.memory_mem_reset_n                      (<connected-to-memory_mem_reset_n>),                      //                                 .mem_reset_n
		.memory_mem_dq                           (<connected-to-memory_mem_dq>),                           //                                 .mem_dq
		.memory_mem_dqs                          (<connected-to-memory_mem_dqs>),                          //                                 .mem_dqs
		.memory_mem_dqs_n                        (<connected-to-memory_mem_dqs_n>),                        //                                 .mem_dqs_n
		.memory_mem_odt                          (<connected-to-memory_mem_odt>),                          //                                 .mem_odt
		.memory_mem_dm                           (<connected-to-memory_mem_dm>),                           //                                 .mem_dm
		.memory_oct_rzqin                        (<connected-to-memory_oct_rzqin>),                        //                                 .oct_rzqin
	*/
		.reset_reset_n                           (KEY[1]),                           //                            reset.reset_n
		.link_start_external_connection_export   (LINK_START_w),   //   link_start_external_connection.export
		.link_disable_external_connection_export (LINK_DISABLE_w), // link_disable_external_connection.export
		.autostart_external_connection_export    (AUTOSTART_w),    //    autostart_external_connection.export
		.currentstate_external_connection_export (CURRENTSTATE_w), // currentstate_external_connection.export
		.flags_external_connection_export        (FLAGS_w),        //        flags_external_connection.export
		.data_i_external_connection_export       (DATA_I_w),       //       data_i_external_connection.export
		.wr_data_external_connection_export      (WR_DATA_w),      //      wr_data_external_connection.export
		.tx_full_external_connection_export      (TX_FULL_w),      //      tx_full_external_connection.export
		.data_o_external_connection_export       (DATA_O_w),       //       data_o_external_connection.export
		.rd_data_external_connection_export      (RD_DATA_w),      //      rd_data_external_connection.export
		.rx_empty_external_connection_export     (RX_EMPTY_w),     //     rx_empty_external_connection.export
		.tick_out_external_connection_export     (TICK_OUT_w),     //     tick_out_external_connection.export
		.time_out_external_connection_export     (TIME_OUT_w),     //     time_out_external_connection.export
		.tick_in_external_connection_export      (TICK_IN_w),      //      tick_in_external_connection.export
		.time_in_external_connection_export      (TIME_IN_w),      //      time_in_external_connection.export
		.tx_clk_div_external_connection_export   (TX_CLK_DIV_w),   //   tx_clk_div_external_connection.export
		.spill_enable_external_connection_export (SPILL_ENABLE_w),  // spill_enable_external_connection.export
		.pll_0_outclk0_clk                       (CLOCK_200MHZ)
	);
	
	SPW_TOP spw_babasu_TRC(
		.CLOCK(CLOCK_200MHZ),
		.RESETn(KEY[1]),
		.LINK_START(LINK_START_w),
		.LINK_DISABLE(LINK_DISABLE_w),
		.AUTOSTART(AUTOSTART_w),
		.CURRENTSTATE(CURRENTSTATE_w),
		.FLAGS(FLAGS_w),
		.DATA_I(DATA_I_w),
		.WR_DATA(WR_DATA_w),
		.TX_FULL(TX_FULL_w),
		.DATA_O(DATA_O_w),
		.RD_DATA(RD_DATA_w),
		.RX_EMPTY(RX_EMPTY_w),
		.TICK_OUT(TICK_OUT_w),
		.TIME_OUT(TIME_OUT_w),
		.TICK_IN(TICK_IN_w),
		.TIME_IN(TIME_IN_w),
		.TX_CLK_DIV(TX_CLK_DIV_w),
		.SPILL_ENABLE(SPILL_ENABLE_w),
		.Din(din_a), 
		.Sin(sin_a),
		.Dout(dout_a),
		.Sout(sout_a)
	);
					
endmodule