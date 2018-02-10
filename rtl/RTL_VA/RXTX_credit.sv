/*
//=================================================================//
//=
//= 	SpwTCR_RXTX_credit
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: Controls Receiver credit and Send FCT request.
//=
//=	Version History:
//=	0.1: 17/08/2016 - First Version
//=
//=================================================================//
*/
module SpwTCR_RXTX_credit(
CLOCK,
RESETn,
enableRx,
gotNChar,
almost_full,
fifo_ready,
sendFctReq,
sendFctAck,
creditErr
);

input 			CLOCK;
input				RESETn;
input 			enableRx;
input 			gotNChar;
input 			almost_full;
input 			fifo_ready;
output reg 	sendFctReq;
input 			sendFctAck;
output reg 	creditErr;

reg [6:0]		credit_rx;

wire enableRx_fall;
reg enableRx_delay;
localparam [1:0]	FCT_WAIT 	= 2'b01,
						FCT_REQ 	= 2'b11,
						FCT_ACK 	= 2'b10;
reg [1:0] FctSt, NextFctSt;

always @(posedge CLOCK, negedge RESETn)
begin
	if(!RESETn)
		begin
		FctSt 		<= FCT_WAIT;
		end
	else
		begin
		if (enableRx_fall)
			begin
			FctSt 		<= FCT_WAIT;
			end
		else
			begin
			FctSt 		<= NextFctSt;
			end
		end
end

always @ (*)
begin
	case (FctSt)
		FCT_WAIT:
			begin
			if(credit_rx <= 7'd48 & !almost_full & fifo_ready & !sendFctAck)
				NextFctSt = FCT_REQ;
			else
				NextFctSt = FCT_WAIT;
			end
		FCT_REQ:
			begin
			if(sendFctAck)
				NextFctSt = FCT_ACK;
			else
				NextFctSt = FCT_REQ;
			end
		FCT_ACK:
			begin
			NextFctSt = FCT_WAIT;
			end
		default:
			begin
			NextFctSt = FctSt;
			end
	endcase
end

assign sendFctReq = (FctSt == FCT_REQ) ? 1'b1: 1'b0;

always @(posedge CLOCK, negedge RESETn)
begin
	if(!RESETn)
		begin
		credit_rx <= 7'd0;
		end
	else
		begin
		if (enableRx_fall)
			begin
			credit_rx <= 7'd0;
			end
		else
			begin
			if(gotNChar & (credit_rx != 7'd0))
				credit_rx <= credit_rx-1'b1;
			else if(!gotNChar & (FctSt == FCT_ACK))
				credit_rx <= credit_rx+7'd8;
			else if(gotNChar & (FctSt == FCT_ACK))
				credit_rx <= credit_rx+7'd7;
			else
				credit_rx <= credit_rx;
			end
		end
end

assign creditErr = (((gotNChar & credit_rx == 7'd0)) | (credit_rx > 7'd56));

always @(posedge CLOCK, negedge RESETn)
begin
	if(!RESETn)
		begin
		enableRx_delay 		<= 1'b0;
		end
	else
		begin
		enableRx_delay 		<= enableRx;
		end
end

assign enableRx_fall = !enableRx & enableRx_delay;
	
endmodule
