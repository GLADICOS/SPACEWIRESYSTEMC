module SpwTCR(
		input CLOCK,
		input RESETn,
		input LINK_START,
		input LINK_DISABLE,
		input AUTOSTART,
		output logic [2:0] CURRENTSTATE,
		output logic [10:0] FLAGS,
		input [8:0] DATA_I,
		input WR_DATA,
		output logic TX_FULL,
		output logic [8:0] DATA_O,
		input RD_DATA,
		output logic RX_EMPTY,
		output logic TICK_OUT,
		output logic [7:0] TIME_OUT,
		input TICK_IN,
		input [7:0] TIME_IN,
		input [6:0] TX_CLK_DIV,
		input SPILL_ENABLE,
		input Din, 
		input Sin,
		output logic Dout,
		output logic Sout
);



endmodule
