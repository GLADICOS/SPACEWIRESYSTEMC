module SPW_JAXA(
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
							
        wire pll_0_outclk0_clk;
        wire transmitClock;
        wire receiveClock;
        wire reset_spw_n_b;

        wire transmitFIFOWriteEnable;
        wire [8:0] transmitFIFODataIn;
        wire transmitFIFOFull;
        wire [5:0] transmitFIFODataCount;
        wire receiveFIFOReadEnable;
        wire [8:0] receiveFIFODataOut;
        wire receiveFIFOFull;
        wire receiveFIFOEmpty;
        wire [5:0] receiveFIFODataCount;

        wire tickIn;
        wire [5:0] timeIn;
        wire [1:0] controlFlagsIn;
        wire tickOut;
        wire [5:0] timeOut;
        wire [1:0] controlFlagsOut;

        wire linkStart;
        wire linkDisable;
        wire autoStart;
        wire [15:0] linkStatus;
        wire [7:0] errorStatus;
        wire [5:0] transmitClockDivideValu;
        wire [5:0] creditCount;
        wire [5:0] outstandingCount;

        wire transmitActivity;
        wire receiveActivity;
               
        wire statisticalInformationClear;
        wire [255:0] statisticalInformation;
		  wire [3:0] statisticalInformation_1;
		  wire [31:0]statisticalInformation_2;
		  wire [31:0]statisticalInformation_3;
		  wire [31:0]statisticalInformation_4;
		  wire [31:0]statisticalInformation_5;
		  wire [31:0]statisticalInformation_6;
		  
		  assign statisticalInformation_2=(statisticalInformation_1== 4'd0)?statisticalInformation[31:0]:
													 (statisticalInformation_1== 4'd1)?statisticalInformation[63:32]:
													 (statisticalInformation_1== 4'd2)?statisticalInformation[95:64]:
													 (statisticalInformation_1== 4'd3)?statisticalInformation[127:96]:
													 (statisticalInformation_1== 4'd4)?statisticalInformation[159:128]:
													 (statisticalInformation_1== 4'd5)?statisticalInformation[191:160]:
													 (statisticalInformation_1== 4'd6)?statisticalInformation[223:192]:statisticalInformation[255:224];
	jaxa u0 (
		.autostart_external_connection_export                   (autoStart),                   //                   autostart_external_connection.export
		.clk_clk                                                (FPGA_CLK1_50),                                                //                                             clk.clk
		.controlflagsin_external_connection_export              (controlFlagsIn),              //              controlflagsin_external_connection.export
		.controlflagsout_external_connection_export             (controlFlagsOut),             //             controlflagsout_external_connection.export
		.creditcount_external_connection_export                 (creditCount),                 //                 creditcount_external_connection.export
		.errorstatus_external_connection_export                 (errorStatus),                 //                 errorstatus_external_connection.export
		.linkdisable_external_connection_export                 (linkDisable),                 //                 linkdisable_external_connection.export
		.linkstart_external_connection_export                   (linkStart),                   //                   linkstart_external_connection.export
		.linkstatus_external_connection_export                  (linkStatus),                  //                  linkstatus_external_connection.export
		/*.memory_mem_a                                           (<connected-to-memory_mem_a>),                                           //                                          memory.mem_a
		.memory_mem_ba                                          (<connected-to-memory_mem_ba>),                                          //                                                .mem_ba
		.memory_mem_ck                                          (<connected-to-memory_mem_ck>),                                          //                                                .mem_ck
		.memory_mem_ck_n                                        (<connected-to-memory_mem_ck_n>),                                        //                                                .mem_ck_n
		.memory_mem_cke                                         (<connected-to-memory_mem_cke>),                                         //                                                .mem_cke
		.memory_mem_cs_n                                        (<connected-to-memory_mem_cs_n>),                                        //                                                .mem_cs_n
		.memory_mem_ras_n                                       (<connected-to-memory_mem_ras_n>),                                       //                                                .mem_ras_n
		.memory_mem_cas_n                                       (<connected-to-memory_mem_cas_n>),                                       //                                                .mem_cas_n
		.memory_mem_we_n                                        (<connected-to-memory_mem_we_n>),                                        //                                                .mem_we_n
		.memory_mem_reset_n                                     (<connected-to-memory_mem_reset_n>),                                     //                                                .mem_reset_n
		.memory_mem_dq                                          (<connected-to-memory_mem_dq>),                                          //                                                .mem_dq
		.memory_mem_dqs                                         (<connected-to-memory_mem_dqs>),                                         //                                                .mem_dqs
		.memory_mem_dqs_n                                       (<connected-to-memory_mem_dqs_n>),                                       //                                                .mem_dqs_n
		.memory_mem_odt                                         (<connected-to-memory_mem_odt>),                                         //                                                .mem_odt
		.memory_mem_dm                                          (<connected-to-memory_mem_dm>),                                          //                                                .mem_dm
		.memory_oct_rzqin                                       (<connected-to-memory_oct_rzqin>),*/                                       //                                                .oct_rzqin
		.outstandingcount_external_connection_export            (outstandingCount),            //            outstandingcount_external_connection.export
		.pll_0_outclk0_clk                                      (pll_0_outclk0_clk),                                      //                                   pll_0_outclk0.clk
		.receiveactivity_external_connection_export             (receiveActivity),             //             receiveactivity_external_connection.export
		.receiveclock_external_connection_export                (receiveClock),                //                receiveclock_external_connection.export
		.receivefifodatacount_external_connection_export        (receiveFIFODataCount),        //        receivefifodatacount_external_connection.export
		.receivefifodataout_external_connection_export          (receiveFIFODataOut),          //          receivefifodataout_external_connection.export
		.receivefifoempty_external_connection_export            (receiveFIFOEmpty),            //            receivefifoempty_external_connection.export
		.receivefifofull_external_connection_export             (receiveFIFOFull),             //             receivefifofull_external_connection.export
		.receivefiforeadenable_external_connection_export       (receiveFIFOReadEnable),       //       receivefiforeadenable_external_connection.export
		//.spacewiredatain_external_connection_export             (spaceWireDataIn),             //             spacewiredatain_external_connection.export
		//.spacewiredataout_external_connection_export            (spaceWireDataOut),            //            spacewiredataout_external_connection.export
		//.spacewirestrobein_external_connection_export           (spaceWireStrobeIn),           //           spacewirestrobein_external_connection.export
		//.spacewirestrobeout_external_connection_export          (spaceWireStrobeOut),          //          spacewirestrobeout_external_connection.export
		.statisticalinformation_0_external_connection_export    (statisticalInformation_2),    //    statisticalinformation_0_external_connection.export
		.statisticalinformation_1_external_connection_export    (statisticalInformation_1),    //    statisticalinformation_1_external_connection.export
		//.statisticalinformation_2_external_connection_export    (statisticalInformation_2),    //    statisticalinformation_2_external_connection.export
		//.statisticalinformation_3_external_connection_export    (statisticalInformation_3),    //    statisticalinformation_3_external_connection.export
		//.statisticalinformation_4_external_connection_export    (statisticalInformation_4),    //    statisticalinformation_4_external_connection.export
		//.statisticalinformation_5_external_connection_export    (statisticalInformation_5),    //    statisticalinformation_5_external_connection.export
		//.statisticalinformation_6_external_connection_export    (statisticalInformation_6),    //    statisticalinformation_6_external_connection.export
		//.statisticalinformation_7_external_connection_export    (statisticalInformation_7),    //    statisticalinformation_7_external_connection.export
		.statisticalinformationclear_external_connection_export (statisticalInformationClear), // statisticalinformationclear_external_connection.export
		.tickin_external_connection_export                      (tickIn),                      //                      tickin_external_connection.export
		.tickout_external_connection_export                     (tickOut),                     //                     tickout_external_connection.export
		.timein_external_connection_export                      (timeIn),                      //                      timein_external_connection.export
		.timeout_external_connection_export                     (timeOut),                     //                     timeout_external_connection.export
		.transmitactivity_external_connection_export            (transmitActivity),            //            transmitactivity_external_connection.export
		.transmitclock_external_connection_export               (transmitClock),               //               transmitclock_external_connection.export
		.transmitclockdividevalue_external_connection_export    (transmitClockDivideValue),    //    transmitclockdividevalue_external_connection.export
		.transmitfifodatacount_external_connection_export       (transmitFIFODataCount),       //       transmitfifodatacount_external_connection.export
		.transmitfifodatain_external_connection_export          (transmitFIFODataIn),          //          transmitfifodatain_external_connection.export
		.transmitfifofull_external_connection_export            (transmitFIFOFull),            //            transmitfifofull_external_connection.export
		.transmitfifowriteenable_external_connection_export     (transmitFIFOWriteEnable)      //     transmitfifowriteenable_external_connection.export
	);

		SpaceWireCODECIP Jaxa_De0_Soc(
		
												 .clock(pll_0_outclk0_clk),
												 .transmitClock(transmitClock),
												 .receiveClock(receiveClock),
												 .reset(reset_spw_n_b),
										
												  .transmitFIFOWriteEnable(transmitFIFOWriteEnable),
												  .transmitFIFODataIn(transmitFIFODataIn),
												  .transmitFIFOFull(transmitFIFOFull),
												  .transmitFIFODataCount(transmitFIFODataCount),
												  .receiveFIFOReadEnable(receiveFIFOReadEnable),
												  .receiveFIFODataOut(receiveFIFODataOut),
												  .receiveFIFOFull(receiveFIFOFull),
												  .receiveFIFOEmpty(receiveFIFOEmpty),
												  .receiveFIFODataCount(receiveFIFODataCount),

												  .tickIn(tickIn),
												  .timeIn(timeIn),
												  .controlFlagsIn(controlFlagsIn),
												  .tickOut(tickOut),
												  .timeOut(timeOut),
												  .controlFlagsOut(controlFlagsOut),

												  .linkStart(linkStart),
												  .linkDisable(linkDisable),
												  .autoStart(autoStart),
												  .linkStatus(linkStatus),
												  .errorStatus(errorStatus),
												  .transmitClockDivideValue(transmitClockDivideValue),
												  .creditCount(creditCount),
												  .outstandingCount(outstandingCount),

												  .transmitActivity(transmitActivity),
												  .receiveActivity(receiveActivity),

												  .spaceWireDataOut(dout_a),
												  .spaceWireStrobeOut(sout_a),
												  .spaceWireDataIn(din_a),
												  .spaceWireStrobeIn(sin_a),
															
												  .statisticalInformationClear(statisticalInformationClear),
												  .statisticalInformation(statisticalInformation)
											  );
	
										
			debounce_db db_system_spwulight_b(
											.CLK(FPGA_CLK1_50),
											.PB(KEY[1]),
											.PB_state(reset_spw_n_b),
											.PB_down(LED[5:5])
										);
																	
endmodule

//VHDL file ("SpaceWireCODECIP.vhdl");