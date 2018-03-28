module SPW_LIGHT_T(
								input   FPGA_CLK1_50,
								input          [1:0] KEY,
								
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
	
        // System clock.
        wire pll_0_outclk0_clk;

        //Receiver sample clock (only for impl_fast)
        wire rxclk;

        // Transmit clock (only for impl_fast)
        wire txclk;

        //Synchronous reset (active-high).
        wire reset_spw_n_b;

        //Enables automatic link start on receipt of a NULL character.
        wire autostart;

        //Enables link start once the Ready state is reached.
        //Without autostart or linkstart, the link remains in state Ready.
        wire linkstart;

        //Do not start link (overrides linkstart and autostart) and/or
        //disconnect a running link.
        wire linkdis;

        //Scaling factor minus 1, used to scale the transmit base clock into
        //the transmission bit rate. The system clock (for impl_generic) or
        //the txclk (for impl_fast) is divided by (unsigned(txdivcnt) + 1).
        //Changing this signal will immediately change the transmission rate.
        //During link setup, the transmission rate is always 10 Mbit/s.
        wire [7:0] txdivcnt;

        //High for one clock cycle to request transmission of a TimeCode.
        //The request is registered inside the entity until it can be processed.
        wire tick_in;

        //Control bits of the TimeCode to be sent. Must be valid while tick_in is high.
        wire [1:0] ctrl_in;

        //Counter value of the TimeCode to be sent. Must be valid while tick_in is high.
        wire [5:0] time_in;

        //Pulled high by the application to write an N-Char to the transmit
        //queue. If "txwrite" and "txrdy" are both high on the rising edge
        //of "clk", a character is added to the transmit queue.
        //This signal has no effect if "txrdy" is low.
        wire txwrite;

        //Control flag to be sent with the next N_Char.
        //Must be valid while txwrite is high.
        wire txflag;

        //Byte to be sent, or "00000000" for EOP or "00000001" for EEP.
        //Must be valid while txwrite is high.
        wire [7:0] txdata;

        //High if the entity is ready to accept an N-Char for transmission.
        wire txrdy;

        //High if the transmission queue is at least half full.
        wire txhalff;

        //High for one clock cycle if a TimeCode was just received.
        wire tick_out;

        //Control bits of the last received TimeCode.
        wire [1:0] ctrl_out;

        //Counter value of the last received TimeCode.
        wire [5:0] time_out;

        //High if "rxflag" and "rxdata" contain valid data.
        //This signal is high unless the receive FIFO is empty.
        wire rxvalid;

        //High if the receive FIFO is at least half full.
        wire rxhalff;

        //High if the received character is EOP or EEP; low if the received
        //character is a data byte. Valid if "rxvalid" is high.
        wire rxflag;

        //Received byte, or "00000000" for EOP or "00000001" for EEP.
        //Valid if "rxvalid" is high.
        wire [7:0] rxdata;

        //Pulled high by the application to accept a received character.
        //If "rxvalid" and "rxread" are both high on the rising edge of "clk",
        //a character is removed from the receive FIFO and "rxvalid", "rxflag"
        //and "rxdata" are updated.
        //This signal has no effect if "rxvalid" is low.
        wire rxread;

        //High if the link state machine is currently in the Started state.
        wire started;

        //High if the link state machine is currently in the Connecting state.
        wire connecting;

        //High if the link state machine is currently in the Run state, indicating
        //that the link is fully operational. If none of started, connecting or running
        //is high, the link is in an initial state and the transmitter is not yet enabled.
        wire running;

        //Disconnect detected in state Run. Triggers a reset and reconnect of the link.
        //This indication is auto-clearing.
        wire errdisc;

        //Parity error detected in state Run. Triggers a reset and reconnect of the link.
        //This indication is auto-clearing.
        wire errpar;

        //Invalid escape sequence detected in state Run. Triggers a reset and reconnect of
        //the link. This indication is auto-clearing.
        wire erresc;

        //Credit error detected. Triggers a reset and reconnect of the link.
        //This indication is auto-clearing.
        wire errcred;	
		  
		spw_light u0 (
			.clk_clk                               (FPGA_CLK1_50),                               //                            clk.clk
			.reset_reset_n                         (reset_spw_n_b),                         //                          reset.reset_n
			/*.memory_mem_a                          (<connected-to-memory_mem_a>),                          //                         memory.mem_a
			.memory_mem_ba                         (<connected-to-memory_mem_ba>),                         //                               .mem_ba
			.memory_mem_ck                         (<connected-to-memory_mem_ck>),                         //                               .mem_ck
			.memory_mem_ck_n                       (<connected-to-memory_mem_ck_n>),                       //                               .mem_ck_n
			.memory_mem_cke                        (<connected-to-memory_mem_cke>),                        //                               .mem_cke
			.memory_mem_cs_n                       (<connected-to-memory_mem_cs_n>),                       //                               .mem_cs_n
			.memory_mem_ras_n                      (<connected-to-memory_mem_ras_n>),                      //                               .mem_ras_n
			.memory_mem_cas_n                      (<connected-to-memory_mem_cas_n>),                      //                               .mem_cas_n
			.memory_mem_we_n                       (<connected-to-memory_mem_we_n>),                       //                               .mem_we_n
			.memory_mem_reset_n                    (<connected-to-memory_mem_reset_n>),                    //                               .mem_reset_n
			.memory_mem_dq                         (<connected-to-memory_mem_dq>),                         //                               .mem_dq
			.memory_mem_dqs                        (<connected-to-memory_mem_dqs>),                        //                               .mem_dqs
			.memory_mem_dqs_n                      (<connected-to-memory_mem_dqs_n>),                      //                               .mem_dqs_n
			.memory_mem_odt                        (<connected-to-memory_mem_odt>),                        //                               .mem_odt
			.memory_mem_dm                         (<connected-to-memory_mem_dm>),                         //                               .mem_dm
			.memory_oct_rzqin                      (<connected-to-memory_oct_rzqin>),                      //                               .oct_rzqin*/
			.autostart_external_connection_export  (autostart),  //  autostart_external_connection.export
			.linkstart_external_connection_export  (linkstart),  //  linkstart_external_connection.export
			.linkdis_external_connection_export    (linkdis),    //    linkdis_external_connection.export
			.txdivcnt_external_connection_export   (txdivcnt),   //   txdivcnt_external_connection.export
			.tick_in_external_connection_export    (tick_in),    //    tick_in_external_connection.export
			.ctrl_in_external_connection_export    (ctrl_in),    //    ctrl_in_external_connection.export
			.time_in_external_connection_export    (time_in),    //    time_in_external_connection.export
			.txwrite_external_connection_export    (txwrite),    //    txwrite_external_connection.export
			.txflag_external_connection_export     (txflag),     //     txflag_external_connection.export
			.txdata_external_connection_export     (txdata),     //     txdata_external_connection.export
			.txrdy_external_connection_export      (txrdy),      //      txrdy_external_connection.export
			.txhalff_external_connection_export    (txhalff),    //    txhalff_external_connection.export
			.tick_out_external_connection_export   (tick_out),   //   tick_out_external_connection.export
			.ctrl_out_external_connection_export   (ctrl_out),   //   ctrl_out_external_connection.export
			.time_out_external_connection_export   (time_out),   //   time_out_external_connection.export
			.rxvalid_external_connection_export    (rxvalid),    //    rxvalid_external_connection.export
			.rxhalff_external_connection_export    (rxhalff),    //    rxhalff_external_connection.export
			.rxflag_external_connection_export     (rxflag),     //     rxflag_external_connection.export
			.rxdata_external_connection_export     (rxdata),     //     rxdata_external_connection.export
			.rxread_external_connection_export     (rxread),     //     rxread_external_connection.export
			.started_external_connection_export    (started),    //    started_external_connection.export
			.connecting_external_connection_export (connecting), // connecting_external_connection.export
			.running_external_connection_export    (running),    //    running_external_connection.export
			.errdisc_external_connection_export    (errdisc),    //    errdisc_external_connection.export
			.errpar_external_connection_export     (errpar),     //     errpar_external_connection.export
			.erresc_external_connection_export     (erresc),
			.errcred_external_connection_export    (errcred),    //    errcred_external_connection.export
			.pll_0_outclk0_clk                     (pll_0_outclk0_clk),                     //                  pll_0_outclk0.clk
			.pll_0_locked_export                   (LED[7])                    //                   pll_0_locked.export
		);

	
			spwstream light_u(
									  .clk(pll_0_outclk0_clk),
									  .rxclk(1'b0),
									  .txclk(1'b0),
									  .rst(reset_spw_n_b),
									  .autostart(autostart),
									  .linkstart(linkstart),
									  .linkdis(linkdis),
									  .txdivcnt(txdivcnt),
									  .tick_in(tick_in),
									  .ctrl_in(ctrl_in),
									  .time_in(time_in),
									  .txwrite(txwrite),
									  .txflag(txflag),
									  .txdata(txdata),
									  .txrdy(txrdy),
									  .txhalff(txhalff),
									  .tick_out(tick_out),
									  .ctrl_out(ctrl_out),
									  .time_out(time_out),
									  .rxvalid(rxvalid),
									  .rxhalff(rxhalff),
									  .rxflag(rxflag),
									  .rxdata(rxdata),
									  .rxread(rxread),
									  .started(started),
									  .connecting(connecting),
									  .running(running),
									  .errdisc(errdisc),
									  .errpar(errpar),
									  .erresc(erresc),
									  .errcred(errcred),
									  .spw_di(din_a),
									  .spw_si(sin_a),
									  .spw_do(dout_a),
									  .spw_so(sout_a)
								  );


			debounce_db db_system_spwulight_b(
											.CLK(FPGA_CLK1_50),
											.PB(KEY[1]),
											.PB_state(reset_spw_n_b),
											.PB_down(LED[5:5])
										);
																	
endmodule
