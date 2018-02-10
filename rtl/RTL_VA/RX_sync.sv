/*
//=================================================================//
//=
//= 	SpwTCR_RX
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: Syncronyze from CLK_RX (recovered) to CLK_SYS.
//=
//=	Version History:
//=	0.1: 17/08/2016 - First Version
//=
//=================================================================//
*/

module SpwTCR_RX_sync(
CLOCK,
RESETn,

TICK_OUT,
TIME_OUT,
RX_DATA,
BUFFER_WRITE,
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

TICK_OUT_sys,
TIME_OUT_sys,
RX_DATA_sys,
BUFFER_WRITE_sys,
gotBit_sys,
gotFCT_sys, 
gotNChar_sys, 
gotTimeCode_sys, 
gotNULL_sys,
gotData_sys,
gotEEP_sys,
gotEOP_sys,
creditErr_sys,
rxError_sys,
sendFctReq_sys

);


input 			CLOCK;
input 			RESETn;


input 			TICK_OUT;
input [7:0] 	TIME_OUT;
input [8:0] 	RX_DATA;
input 			BUFFER_WRITE;
input				gotBit;
input 			gotFCT; 
input 			gotNChar; 
input 			gotTimeCode; 
input 			gotNULL;
input 			gotData;
input 			gotEEP;
input 			gotEOP;
input				creditErr;
input 			rxError;
input				sendFctReq;

output logic			TICK_OUT_sys;
output logic [7:0]	TIME_OUT_sys;
output logic [8:0]	RX_DATA_sys;
output logic			BUFFER_WRITE_sys;
output logic			gotBit_sys;
output logic			gotFCT_sys; 
output logic			gotNChar_sys; 
output logic			gotTimeCode_sys; 
output logic			gotNULL_sys;
output logic			gotData_sys;
output logic			gotEEP_sys;
output logic			gotEOP_sys;
output logic			creditErr_sys;
output logic			rxError_sys;
output logic			sendFctReq_sys;


//registers

logic			BUFFER_WRITE_sync1;
logic			gotFCT_sync1;
logic			gotNChar_sync1; 
logic			gotTimeCode_sync1; 
logic			gotData_sync1;
logic			gotEEP_sync1;
logic			gotEOP_sync1;
logic			TICK_OUT_sync1;
logic	[7:0] TIME_OUT_sync1;
logic	[8:0] RX_DATA_sync1;
logic			gotBit_sync1;
logic			gotNULL_sync1;
logic			creditErr_sync1;
logic			rxError_sync1;
logic			sendFctReq_sync1;
logic			BUFFER_WRITE_sync2;
logic			gotFCT_sync2;
logic			gotNChar_sync2; 
logic			gotTimeCode_sync2; 
logic			gotData_sync2;
logic			gotEEP_sync2;
logic			gotEOP_sync2;


// Sync CLOCK_RX to CLOCK SYS
always @(posedge CLOCK, negedge RESETn)
begin
if(!RESETn)
	begin
	TICK_OUT_sys 			<= 1'b0;
	TIME_OUT_sys 			<= 8'd0;
	RX_DATA_sys 			<= 9'd0;
	BUFFER_WRITE_sys 		<= 1'b0;
	gotBit_sys 				<= 1'b0;
	gotFCT_sys 				<= 1'b0;
	gotNChar_sys 			<= 1'b0; 
	gotTimeCode_sys 		<= 1'b0; 
	gotNULL_sys 			<= 1'b0;
	gotData_sys 			<= 1'b0;
	gotEEP_sys 				<= 1'b0;
	gotEOP_sys 				<= 1'b0;
	creditErr_sys 			<= 1'b0;
	rxError_sys 			<= 1'b0;
	sendFctReq_sys 		<= 1'b0;
	TICK_OUT_sync1 		<= 1'b0;
	TIME_OUT_sync1 		<= 8'd0;
	RX_DATA_sync1 			<= 9'd0;
	BUFFER_WRITE_sync1 	<= 1'b0;
	gotBit_sync1 			<= 1'b0;
	gotFCT_sync1 			<= 1'b0;
	gotNChar_sync1 		<= 1'b0; 
	gotTimeCode_sync1 	<= 1'b0; 
	gotNULL_sync1 			<= 1'b0;
	gotData_sync1 			<= 1'b0;
	gotEEP_sync1 			<= 1'b0;
	gotEOP_sync1 			<= 1'b0;
	creditErr_sync1 		<= 1'b0;
	rxError_sync1 			<= 1'b0;
	sendFctReq_sync1 		<= 1'b0;
	
	BUFFER_WRITE_sync2 	<= 1'b0;
	gotFCT_sync2 			<= 1'b0;
	gotNChar_sync2 		<= 1'b0;
	gotTimeCode_sync2 	<= 1'b0;
	gotData_sync2 			<= 1'b0;
	gotEEP_sync2 			<= 1'b0;
	gotEOP_sync2 			<= 1'b0;
	end
else
	begin
	BUFFER_WRITE_sync1 	<= BUFFER_WRITE;	
	gotFCT_sync1 			<= gotFCT;
	gotNChar_sync1 		<= gotNChar; 
	gotTimeCode_sync1 	<= gotTimeCode; 
	gotData_sync1 			<= gotData;
	gotEEP_sync1 			<= gotEEP;
	gotEOP_sync1 			<= gotEOP;
	
	//sync2 to generate edge detection
	BUFFER_WRITE_sync2 	<= BUFFER_WRITE_sync1;
	gotFCT_sync2 			<= gotFCT_sync1;
	gotNChar_sync2 		<= gotNChar_sync1; 
	gotTimeCode_sync2 	<= gotTimeCode_sync1; 
	gotData_sync2 			<= gotData_sync1;
	gotEEP_sync2 			<= gotEEP_sync1;
	gotEOP_sync2 			<= gotEOP_sync1;
	
	//edge detection
	BUFFER_WRITE_sys 		<= BUFFER_WRITE_sync1 	& !BUFFER_WRITE_sync2;
	gotFCT_sys 				<= gotFCT_sync1 			& !gotFCT_sync2;
	gotNChar_sys 			<= gotNChar_sync1 		& !gotNChar_sync2; 
	gotTimeCode_sys 		<= gotTimeCode_sync1 	& !gotTimeCode_sync2; 
	gotData_sys 			<= gotData_sync1 			& !gotData_sync2;
	gotEEP_sys 				<= gotEEP_sync1 			& !gotEEP_sync2;
	gotEOP_sys 				<= gotEOP_sync1 			& !gotEOP_sync2;
	
	//avoid  metastability 
	TICK_OUT_sync1 		<= TICK_OUT;
	TIME_OUT_sync1 		<= TIME_OUT;
	RX_DATA_sync1 			<= RX_DATA;
	gotBit_sync1 			<= gotBit;
	gotNULL_sync1 			<= gotNULL;	
	creditErr_sync1 		<= creditErr;
	rxError_sync1 			<= rxError;
	sendFctReq_sync1 		<= sendFctReq;
	
	TICK_OUT_sys 			<= TICK_OUT_sync1;
	TIME_OUT_sys 			<= TIME_OUT_sync1;
	RX_DATA_sys 			<= RX_DATA_sync1;
	gotBit_sys 				<= gotBit_sync1;
	gotNULL_sys 			<= gotNULL_sync1;
	creditErr_sys 			<= creditErr_sync1;
	rxError_sys 			<= rxError_sync1;
	sendFctReq_sys 		<= sendFctReq_sync1;
	
	end

end
endmodule