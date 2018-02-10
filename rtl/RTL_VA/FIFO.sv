/*
//=================================================================//
//=
//= 	FIFO
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: FIFO Model using Registers.
//=
//=	Version History:
//=	0.1: 17/08/2016 - First Version
//=
//=================================================================//
*/
module FIFO (
	data,
	rdclk,
	rd_rst_n,
	rdreq,
	wrclk,
	wr_rst_n,
	wrreq,
	q,
	rdempty,
	rdusedw,
	wrfull,
	wrusedw);

parameter DATA_SIZE = 9;
parameter ADDR_SIZE = 7;

input	 			[DATA_SIZE-1:0]  	data;
input	  									rdclk;
input										rd_rst_n;
input	  									rdreq;
input	  									wrclk;
input										wr_rst_n;
input	  									wrreq;
output logic 	[DATA_SIZE-1:0]  	q;
output logic 	  						rdempty;
output logic 	[ADDR_SIZE:0]  	rdusedw;
output logic 	  						wrfull;
output logic 	[ADDR_SIZE:0]  	wrusedw;

logic [ADDR_SIZE:0] waddr, raddr;
logic [DATA_SIZE-1:0] MEM [(2**ADDR_SIZE)-1:0];

assign wrusedw = waddr-raddr;
assign rdusedw = raddr;

always @(posedge wrclk) 
begin
	if (!wr_rst_n) begin
		waddr <={(ADDR_SIZE+1){1'b0}};
		end
	else begin
		if(wrreq && !wrfull)
			waddr <= waddr + 1'b1;
		else			waddr <= waddr;
	end
end

always @(posedge wrclk) 
begin
		if(wrreq && !wrfull)
			MEM[waddr[ADDR_SIZE-1:0]] <= data;
		else
			MEM[waddr[ADDR_SIZE-1:0]] <= MEM[waddr[ADDR_SIZE-1:0]];
end




always @(posedge rdclk) begin
if (!rd_rst_n) begin
	raddr <= {(ADDR_SIZE+1){1'b0}};
	end
else begin
	if(rdreq && !rdempty)
		raddr <= raddr + 1'b1;
	else
		raddr <= raddr;
	end
end

always @(posedge rdclk) begin
if (!rd_rst_n) begin
	q <= {(DATA_SIZE){1'b0}};
	end
else begin
	if(rdreq && !rdempty)
		q <= MEM[raddr[ADDR_SIZE-1:0]] ;
	else
		q <= q;
	end
end

assign wrfull = (((waddr[ADDR_SIZE-1:0] == raddr[ADDR_SIZE-1:0]) & (waddr[ADDR_SIZE] != raddr[ADDR_SIZE])));
assign rdempty = (waddr == raddr);


endmodule
