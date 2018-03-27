
module jaxa (
	autostart_external_connection_export,
	clk_clk,
	controlflagsin_external_connection_export,
	controlflagsout_external_connection_export,
	creditcount_external_connection_export,
	errorstatus_external_connection_export,
	linkdisable_external_connection_export,
	linkstart_external_connection_export,
	linkstatus_external_connection_export,
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
	outstandingcount_external_connection_export,
	pll_0_outclk0_clk,
	receiveactivity_external_connection_export,
	receiveclock_external_connection_export,
	receivefifodatacount_external_connection_export,
	receivefifodataout_external_connection_export,
	receivefifoempty_external_connection_export,
	receivefifofull_external_connection_export,
	receivefiforeadenable_external_connection_export,
	spacewiredatain_external_connection_export,
	spacewiredataout_external_connection_export,
	spacewirestrobein_external_connection_export,
	spacewirestrobeout_external_connection_export,
	statisticalinformation_0_external_connection_export,
	statisticalinformation_1_external_connection_export,
	statisticalinformationclear_external_connection_export,
	tickin_external_connection_export,
	tickout_external_connection_export,
	timein_external_connection_export,
	timeout_external_connection_export,
	transmitactivity_external_connection_export,
	transmitclock_external_connection_export,
	transmitclockdividevalue_external_connection_export,
	transmitfifodatacount_external_connection_export,
	transmitfifodatain_external_connection_export,
	transmitfifofull_external_connection_export,
	transmitfifowriteenable_external_connection_export);	

	output		autostart_external_connection_export;
	input		clk_clk;
	output	[1:0]	controlflagsin_external_connection_export;
	input	[1:0]	controlflagsout_external_connection_export;
	input	[5:0]	creditcount_external_connection_export;
	input	[7:0]	errorstatus_external_connection_export;
	output		linkdisable_external_connection_export;
	output		linkstart_external_connection_export;
	input	[15:0]	linkstatus_external_connection_export;
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
	input	[5:0]	outstandingcount_external_connection_export;
	output		pll_0_outclk0_clk;
	input		receiveactivity_external_connection_export;
	output		receiveclock_external_connection_export;
	input		receivefifodatacount_external_connection_export;
	input	[8:0]	receivefifodataout_external_connection_export;
	input		receivefifoempty_external_connection_export;
	input		receivefifofull_external_connection_export;
	output		receivefiforeadenable_external_connection_export;
	output		spacewiredatain_external_connection_export;
	input		spacewiredataout_external_connection_export;
	output		spacewirestrobein_external_connection_export;
	input		spacewirestrobeout_external_connection_export;
	input	[31:0]	statisticalinformation_0_external_connection_export;
	output	[7:0]	statisticalinformation_1_external_connection_export;
	output		statisticalinformationclear_external_connection_export;
	output		tickin_external_connection_export;
	input		tickout_external_connection_export;
	output	[5:0]	timein_external_connection_export;
	input	[5:0]	timeout_external_connection_export;
	input		transmitactivity_external_connection_export;
	output		transmitclock_external_connection_export;
	output	[5:0]	transmitclockdividevalue_external_connection_export;
	input	[5:0]	transmitfifodatacount_external_connection_export;
	output	[8:0]	transmitfifodatain_external_connection_export;
	input		transmitfifofull_external_connection_export;
	output		transmitfifowriteenable_external_connection_export;
endmodule
