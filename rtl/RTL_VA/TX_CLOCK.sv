/*
//=================================================================//
//=
//= 	SpwTCR_TX_CLOCK
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: Generates a pulse enable that define Transmiter Rate.
//=
//=	Version History:
//=	0.1: 10/01/2016 - First Version
//=
//=================================================================//
*/


module SpwTCR_TX_CLOCK (
CLOCK,
RESETn,
TX_CLK_DIV,
startupRate,
CLK_EN
);

parameter STARTUP_DIV = 7'd19; //Divider that define 10mbps Initial Rate CLOCK /(STARTUP_DIV+1)=10
//parameter STARTUP_DIV = 7'd4;


input 			CLOCK;
input 			RESETn;
input [6:0] 	TX_CLK_DIV; //Clock Divider CLK_TX = CLOCK/(TX_CLK_DIV+1)
input				startupRate; // Enable Startup Rate of 10Mbps
output logic 			CLK_EN; // Pulse enable the goes to TX module and defines TX rate

logic [6:0] 	counter; // aux counter that defines divider, start from max value and decrement until zero

always @(posedge CLOCK, negedge RESETn)
begin
	if (!RESETn)
		begin
		counter <= 7'd0;
		CLK_EN  <= 1'b0;
		end
  else
		begin
		if(counter == 7'd0) //when counter is zero, update values of counter
			begin
			if(startupRate) // 10Mps startup rate
				begin
				counter <= STARTUP_DIV; //Initial counter Startup Rate
				end
			else
				begin
				counter <= TX_CLK_DIV; //Initial counter on Run State
				//counter <= STARTUP_DIV;
				end
			CLK_EN  <= 1'b1; // Generate a Pulse
			end
		else
			begin
			counter <= counter - 1'b1; // Decrements Counter
			CLK_EN  <= 1'b0;				// Pulse is disable until counter decrements, only in zero value CLK_EN = 1
			end
		end
end
endmodule
