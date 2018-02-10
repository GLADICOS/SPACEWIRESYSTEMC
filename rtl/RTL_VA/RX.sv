/*
//=================================================================//
//=
//= 	SpwTCR_RX
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: Module that instantiate Receiver sub-modules.
//=
//=	Version History:
//=	0.1: 17/08/2016 - First Version
//=
//=================================================================//
*/

module SpwTCR_RX(
Din, 
Sin,
CLK_RX,
CLOCK,
RESETn,
TICK_OUT,
TIME_OUT,
RX_DATA,
BUFFER_WRITE,
BUFFER_READY,
almost_full,
enableRx,
gotBit,
gotFCT, 
gotNChar, 
gotTimeCode, 
gotNULL,
gotData,
gotEEP,
gotEOP,
creditErr,
rxError,
sendFctReq,
sendFctAck
);

input 					Din;
input 					Sin;
input 					CLK_RX;
input 					CLOCK;
input						RESETn;
output logic 			TICK_OUT;
output logic [7:0] 	TIME_OUT;
output logic [8:0] 	RX_DATA;
output logic 			BUFFER_WRITE;
input 					BUFFER_READY;
input						almost_full;
input 					enableRx;
output logic 			gotBit;
output logic 			gotFCT; 
output logic 			gotNChar; 
output logic 			gotTimeCode; 
output logic 			gotNULL;
output logic 			gotData;
output logic 			gotEEP;
output logic 			gotEOP;
output logic			creditErr;
output logic 			rxError;
output logic			sendFctReq;
input 					sendFctAck;

logic 			tick_out_w;
logic [7:0] 	time_out_w;
logic [8:0] 	rx_data_w;
logic 			buffer_write_w;
logic 			gotBit_w;
logic 			gotFCT_w; 
logic 			gotNChar_w;
logic 			gotNChar_sys_w; 
logic 			gotTimeCode_w;
logic 			gotNULL_w;
logic 			gotData_w;
logic				gotEEP_w;
logic 			gotEOP_w;
logic 			creditErr_w;
logic 			rxError_w;
logic				rxError_fsm_w;
logic 			sendFctReq_w;
logic 			clk_rx_w;
logic 			disconnect_w;
/*
ALTIOBUF_iobuf_in_p4i CLK_BUFF ( 
	.datain(CLK_RX),
	.dataout(clk_rx_w)
) ;
*/
assign clk_rx_w = CLK_RX;
assign gotNChar = gotNChar_sys_w;

assign rxError_fsm_w = (rxError_w | disconnect_w);

SpwTCR_RX_sync RX_sync(
.CLOCK(CLOCK),
.RESETn(RESETn),
.TICK_OUT(tick_out_w),
.TIME_OUT(time_out_w),
.RX_DATA(rx_data_w),
.BUFFER_WRITE(buffer_write_w),
.gotBit(gotBit_w),
.gotFCT(gotFCT_w), 
.gotNChar(gotNChar_w), 
.gotTimeCode(gotTimeCode_w), 
.gotNULL(gotNULL_w),
.gotData(gotData_w),
.gotEEP(gotEEP_w),
.gotEOP(gotEOP_w),
.creditErr(creditErr_w),
.rxError(rxError_fsm_w),
.sendFctReq(sendFctReq_w),

.TICK_OUT_sys(TICK_OUT),
.TIME_OUT_sys(TIME_OUT),
.RX_DATA_sys(RX_DATA),
.BUFFER_WRITE_sys(BUFFER_WRITE),
.gotBit_sys(gotBit),
.gotFCT_sys(gotFCT), 
.gotNChar_sys(gotNChar_sys_w), 
.gotTimeCode_sys(gotTimeCode), 
.gotNULL_sys(gotNULL),
.gotData_sys(gotData),
.gotEEP_sys(gotEEP),
.gotEOP_sys(gotEOP),
.creditErr_sys(creditErr),
.rxError_sys(rxError),
.sendFctReq_sys(sendFctReq)

);

SpwTCR_RX_receiver RX_receiver(
.Din(Din),
.CLK_RX(clk_rx_w),
.disconnect_in(disconnect_w),
.TICK_OUT(tick_out_w),
.TIME_OUT(time_out_w),
.RX_DATA(rx_data_w),
.BUFFER_WRITE(buffer_write_w),
.BUFFER_READY(BUFFER_READY),
.RESETn(RESETn),
.enableRx(enableRx),
.gotBit(gotBit_w),
.gotFCT(gotFCT_w), 
.gotNChar(gotNChar_w), 
.gotTimeCode(gotTimeCode_w), 
.gotNULL(gotNULL_w),
.gotData(gotData_w),
.gotEEP(gotEEP_w),
.gotEOP(gotEOP_w),
.rxError(rxError_w)
);

SpwTCR_RXTX_credit RX_credit(
.CLOCK(CLOCK),
.RESETn(RESETn),
.enableRx(enableRx),
.gotNChar(gotNChar_sys_w),
.almost_full(almost_full),
.fifo_ready(BUFFER_READY),
.sendFctReq(sendFctReq_w),
.sendFctAck(sendFctAck),
.creditErr(creditErr_w)
);

SpwTCR_RX_TIMEOUT RX_TIMEOUT(
.CLOCK(CLOCK), 
.RESETn(RESETn),
.enable(gotBit_w), 
.Din(Din), 
.Sin(Sin), 
.disconnect(disconnect_w)
);

endmodule
