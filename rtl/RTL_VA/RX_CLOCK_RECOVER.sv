/*
//=================================================================//
//=
//= 	SpwTCR_RX_CLOCK_RECOVER
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: Recover receiver clock, Xoring Data and Strobe Inputs
//=
//=	Version History:
//=	0.1: 10/01/2016 - First Version
//=
//=================================================================//
*/

module SpwTCR_RX_CLOCK_RECOVER(
Din, 
Sin, 
clk_rx
);

input 	Din;
input 	Sin;
output logic 	clk_rx;

assign clk_rx = Din ^ Sin;

endmodule
