`timescale 1ns/1ns
`default_nettype none

module module_tb;

	reg CLK;

	reg CLK_SIM;

	/*SPWTCR*/
	wire CLOCK;
	wire RESETn;
	wire LINK_START;
	wire LINK_DISABLE;
	wire AUTOSTART;
	wire [2:0] CURRENTSTATE;
	wire [10:0] FLAGS;
	wire [8:0] DATA_I;
	wire WR_DATA;
	wire TX_FULL;
	wire [8:0] DATA_O;
	wire RD_DATA;
	wire RX_EMPTY;
	wire TICK_OUT;
	wire [7:0] TIME_OUT;
	wire TICK_IN;
	wire [7:0] TIME_IN;
	wire [6:0] TX_CLK_DIV;
	wire SPILL_ENABLE;
	wire Din; 
	wire Sin;
	wire Dout;
	wire Sout;

	wire [3:0] SPW_SC_FSM;
	wire [3:0] SPW_SC_FSM_OUT;
	wire RX_CLOCK_RECOVERY_SC;
	wire TX_CLOCK_RECOVERY_VLOG;
	wire TX_CLOCK_OUT;
	wire TX_CLOCK_OUT_SC;

	assign RX_CLOCK_RECOVERY_SC = Din ^ Sin;
	assign TX_CLOCK_OUT_SC = TX_CLOCK_OUT;
	assign SPW_SC_FSM_OUT = SPW_SC_FSM;

	assign TX_CLOCK_RECOVERY_VLOG = Dout ^ Sout;

	assign CLOCK = CLK;

	initial CLK = 1'b0;
	always #(10) CLK = ~CLK;

	initial CLK_SIM = 1'b0;
	always #(1) CLK_SIM = ~CLK_SIM;

	integer i;

	initial
	 begin

		$dumpfile("module_tb.vcd");
		$dumpvars(0,module_tb);
		$global_init;
		i=0;

	 end


	SpwTCR DUT_TCR (
			.CLOCK(CLOCK),
			.RESETn(RESETn),
			.LINK_START(LINK_START),
			.LINK_DISABLE(LINK_DISABLE),
			.AUTOSTART(AUTOSTART),
			.CURRENTSTATE(CURRENTSTATE),
			.FLAGS(FLAGS),
			.DATA_I(DATA_I),
			.WR_DATA(WR_DATA),
			.TX_FULL(TX_FULL),
			.DATA_O(DATA_O),
			.RD_DATA(RD_DATA),
			.RX_EMPTY(RX_EMPTY),
			.TICK_OUT(TICK_OUT),
			.TIME_OUT(TIME_OUT),
			.TICK_IN(TICK_IN),
			.TIME_IN(TIME_IN),
			.TX_CLK_DIV(TX_CLK_DIV),
			.SPILL_ENABLE(SPILL_ENABLE),
			.Din(Din), 
			.Sin(Sin),
			.Dout(Dout),
			.Sout(Sout)
		);

	always@(posedge CLK , negedge CLK)
		$global_reset;

	always@(posedge CLK_SIM)
		$run_sim;

	always@(posedge CLK)
		$write_tx_spw;

	always@(posedge CLK)
		$receive_rx_spw;

	//FLAG USED TO FINISH SIMULATION PROGRAM 
	always@(posedge CLK)
	begin
		wait(i == 1);
		$finish();
	end

endmodule
