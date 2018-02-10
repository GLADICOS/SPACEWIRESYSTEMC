/*
//=================================================================//
//=
//= 	SpwTCR_RX_TIMEOUT
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: Analyze Data/Strobe and start/reset 850ns time-out.
//=
//=	Version History:
//=	0.1: 17/08/2016 - First Version
//=
//=================================================================//
*/
module SpwTCR_RX_TIMEOUT (
CLOCK, 
RESETn,
enable, 
Din, 
Sin, 
disconnect
);

//parameter COUNTER_LIMIT = 189; // 950ns - 200Mhz (nominal 850ns, accept (727ns - 1000ns)
parameter COUNTER_LIMIT = 9'd179;
parameter COUNTER_WIDTH = 9;

input           CLOCK; 
input           RESETn; 
input           enable;
input           Din; 
input           Sin; 
output logic    disconnect;

logic [COUNTER_WIDTH-1:0] 	counter;

enum logic [1:0] {
	RESET 		= 2'b01,
	COUNT 		= 2'b11,
	DISCONNECT 	= 2'b10
	} 	state, nextState;
	

logic di_1, di_2;
logic si_1, si_2;

logic ds_edge;

always @(posedge CLOCK, negedge RESETn)
begin
	if (!RESETn)
		begin
		di_1 <= 1'b0;
    di_2 <= 1'b0;
    si_1 <= 1'b0;
    si_2 <= 1'b0;
		end
	else
		begin
		if(!enable)
			begin
			di_1 <= 1'b0;
			di_2 <= 1'b0;
			si_1 <= 1'b0;
			si_2 <= 1'b0;
			end
		else
			begin
			di_1 <= Din;
			di_2 <= di_1;

			si_1 <= Sin;
			si_2 <= si_1;
			end
		end
end
		
//assign ds_edge = (rx_clk_ff2 & !rx_clk_ff1) | (!rx_clk_ff2 & rx_clk_ff1) ;
assign ds_edge = (di_1 != di_2) | (si_1 != si_2);

always @(posedge CLOCK, negedge RESETn)
begin
	if (!RESETn)
		begin
		state <= RESET;
		end
	else
		begin
		if(!enable)
			begin
			state <= RESET;
			end
		else
			begin
			state <= nextState;
			end
		end
end

always @ (*)
begin
case (state)
	RESET:
		if(enable)
			nextState = COUNT;
		else
			nextState = RESET;
	COUNT:
		if(ds_edge | !enable)
			nextState = RESET;
		else if(counter == COUNTER_LIMIT)
			nextState = DISCONNECT;
		else
			nextState = COUNT;
	default:
		nextState = state;
endcase
end


always @(posedge CLOCK, negedge RESETn)
begin
	if (!RESETn)
		begin
		counter 		<= {COUNTER_WIDTH{1'b0}};
		end
  else
		begin
		if(!enable)
			begin
			counter 		<= {COUNTER_WIDTH{1'b0}};
			end
		else
			begin
			case (state)
				COUNT:
					counter 	<= counter + 1'b1;
				default:
					counter 	<= {COUNTER_WIDTH{1'b0}};
			endcase
			end
		end
end

assign disconnect = (state == DISCONNECT) ? 1'b1 : 1'b0;

endmodule
