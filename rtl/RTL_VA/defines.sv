/*
//=================================================================//
//=
//= 	defines
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: File to define global constants.
//=
//=	Version History:
//=	0.1: 17/08/2016 - First Version
//=
//=================================================================//
*/



//Define Parameters
//parameter DIV_64  = 12'd1280;
//parameter DIV_128 = 12'd2560;

//Parameters for CLOCK = 50Mhz
`define DIV_64  				12'd320
`define DIV_128 				12'd640

//`define COUNTER_LIMIT 189 // 950ns - 200Mhz (nominal 850ns, accept (727ns - 1000ns)
`define COUNTER_LIMIT		47
`define COUNTER_WIDTH		8