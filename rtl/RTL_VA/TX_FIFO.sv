/*
//=================================================================//
//=
//= 	SpwTCR_RX_FIFO
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: FIFO Controller for Transmitter.
//=
//=	Version History:
//=	0.1: 17/08/2016 - First Version
//=
//=================================================================//
*/

module SpwTCR_TX_FIFO(
input CLOCK, RESETn, data_req, we, 
input [8:0] data_i, 
output logic [8:0] data_o, 
output logic data_ack, full, empty
);

logic read_fifo;
logic write_fifo;
logic we_ff1;
logic we_ff2;
logic [8:0] data_i_sync;
enum logic [1:0] {
	DATA_WAIT 	= 2'b01,
	READ_DATA 	= 2'b11,
	DATA_READY 	= 2'b10
	} DataSt, NextDataSt;
always @(posedge CLOCK, negedge RESETn)
begin
if(!RESETn)
	begin
	DataSt <= DATA_WAIT;
	end
else
	begin
	DataSt <= NextDataSt;
	end
end 

always @ (*)
begin
case (DataSt)
	DATA_WAIT:
		begin
		if(data_req & !empty)
			NextDataSt = READ_DATA;
		else
			NextDataSt = DATA_WAIT;
		end
	READ_DATA:
		begin
			NextDataSt = DATA_READY;
		end
	DATA_READY:
		begin
		if(!data_req)
			NextDataSt = DATA_WAIT;
		else
			NextDataSt = DATA_READY;
		end
	default:
		NextDataSt = DataSt;
endcase
end

assign data_ack  = (DataSt == DATA_READY) ? 1'b1 : 1'b0;
assign read_fifo = (DataSt == READ_DATA)  ? 1'b1 : 1'b0;
	
always @(posedge CLOCK, negedge RESETn)
begin
if(!RESETn)
	begin
	we_ff1 <= 1'b0;
	we_ff2 <= 1'b0;
	data_i_sync <= 9'd0;
	end
else
	begin
	we_ff1 <= we;
	we_ff2 <= we_ff1;
	data_i_sync <= data_i;
	end
end 
assign write_fifo = !we_ff2 & we_ff1;
/*	
FIFO	FIFO_inst (
	.data (data_i_sync),
	.rdclk (CLOCK ),
	.rdreq (read_fifo ),
	.wrclk (CLOCK ),
	.wrreq (write_fifo),
	.q (data_o ),
	.rdempty (empty ),
	.rdusedw (  ),
	.wrfull (full ),
	.wrusedw (  )
	);
*/
FIFO	FIFO_inst (
	.data (data_i_sync),
	.rdclk (CLOCK ),
	.rd_rst_n(RESETn),
	.rdreq (read_fifo ),
	.wrclk (CLOCK ),
	.wr_rst_n(RESETn),
	.wrreq (write_fifo),
	.q (data_o ),
	.rdempty (empty),
	.rdusedw (  ),
	.wrfull (full),
	.wrusedw (  )
	);
endmodule
