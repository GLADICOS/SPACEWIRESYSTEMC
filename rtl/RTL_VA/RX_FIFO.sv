/*
//=================================================================//
//=
//= 	SpwTCR_RX_FIFO
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: FIFO Controller for Receiver.
//=
//=	Version History:
//=	0.1: 17/08/2016 - First Version
//=
//=================================================================//
*/

module SpwTCR_RX_FIFO(
clk,
RESETn,
data_req, 
we,
data_i, 
data_o,
full,
almost_full, 
empty
);

parameter DATA_SIZE = 9;
parameter ADDR_SIZE = 7;

parameter FIFO_SIZE = 2**ADDR_SIZE;

input 								clk; 
input 								RESETn;
input 								data_req; 
input 								we; 
input			 [DATA_SIZE-1:0] 	data_i; 
output logic [DATA_SIZE-1:0] 	data_o;
output logic 						full;  
output logic 						almost_full;
output logic 						empty;

logic [ADDR_SIZE:0]				wrusedw;

logic re_ff1;
logic re_ff2;
logic rdreq_w;
always @(posedge clk, negedge RESETn)
begin
if(!RESETn)
	begin
	re_ff1 <= 1'b0;
	re_ff2 <= 1'b0;
	end
else
	begin
	re_ff1 <= data_req;
	re_ff2 <= re_ff1;
	end
end 
assign rdreq_w = !re_ff2 & re_ff1;

assign almost_full = (wrusedw > FIFO_SIZE-8) ? 1'b1 : 1'b0;


FIFO	#(.DATA_SIZE(DATA_SIZE), .ADDR_SIZE(ADDR_SIZE)) FIFO_inst (
	.data (data_i ),
	.rdclk (clk ),
	.rd_rst_n(RESETn),
	.rdreq (rdreq_w ),
	.wrclk (clk ),
	.wr_rst_n(RESETn),
	.wrreq (we ),
	.q (data_o ),
	.rdempty (empty ),
	.rdusedw (),
	.wrfull (full),
	.wrusedw (wrusedw)
	);


endmodule
