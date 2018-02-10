/*
//=================================================================//
//=
//= 	SpwTCR_RX_receiver
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: Detect character received and generates Gots
//=
//=	Version History:
//=	0.1: 17/08/2016 - First Version
//=
//=================================================================//
*/

module SpwTCR_RX_receiver(
Din, 
CLK_RX,
disconnect_in,
TICK_OUT,
TIME_OUT,
RX_DATA,
BUFFER_WRITE,
BUFFER_READY,
RESETn,
enableRx,
gotBit,
gotFCT, 
gotNChar, 
gotTimeCode, 
gotNULL,
gotData,
gotEEP,
gotEOP,
rxError
);

input 					Din;
input 					CLK_RX;
input						disconnect_in;
output logic 			TICK_OUT;
output logic [7:0] 	TIME_OUT;
output logic [8:0] 	RX_DATA;
output logic 			BUFFER_WRITE;
input 					BUFFER_READY;
input 					RESETn;
input 					enableRx;
output logic 			gotBit;
output logic 			gotFCT; 
output logic 			gotNChar; 
output logic 			gotTimeCode; 
output logic 			gotNULL;
output logic 			gotData;
output logic 			gotEEP;
output logic 			gotEOP;
output logic 			rxError;




logic [4:0] 	A;
logic [5:0] 	B;
logic [10:0] 	STORE_REG;
logic [9:0] 	BUFFER_DIN;
logic 			clock_edge;
logic 			parity_error;
logic [1:0] 	counter_cycle;
logic 			rx_ready;
logic 			rx_ready1;
logic 			gotNULL_r;
logic [3:0]		counter_start;
logic [7:0] 	last_time_out;
logic 			current_packet;

logic flag_data, flag_timecode, flag_eep, flag_eop, flag_null, flag_fct;

enum logic [3:0] {
	WAIT,
	FIND_NULL,
	START, 
	CONTROL_AQ, 
	DATA_AQ, 
	GOT_ESC, 
	PRE_NULL, 
	PRE_TIME, 
	DISCONNECT_ERR, 
	PARITY_ERR, 
	ESC_ERR
} state, nextState;

//Din Shif register MUX, clock_edge depends on detection of firt NULL
assign BUFFER_DIN = (clock_edge) ? STORE_REG[10:1] : STORE_REG[9:0];

// B: store data input (Din) on negedge CLOCK RX
always @(negedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
			B <= 6'd0;
		end
	else
		begin
			if (!enableRx)
				B <= 6'd0;
			else
				B <={B[4:0],Din}; //Shift Regiter with Data received on negedge CLOCK RX
		end
end


//Din detection on rising edge of clock RX
// A: store data input on rising edge
// STORE_REG: store A and B reg from posedge reg A and negedge reg B
always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		A 				<= 5'd0;
		STORE_REG 	<= 11'd0;
		end
	else 
		begin
			if (!enableRx)
				begin
					A 				<= 5'd0;
					STORE_REG 	<= 11'd0;
				end
			else
				begin
					A <= {A[3:0],Din}; //Shift Regiter with Data received on posedge CLOCK RX
					STORE_REG <= {B[5],A[4],B[4],A[3],B[3],A[2],B[2],A[1],B[1],A[0],B[0]}; //merge posedge end negedge Data Received
				end
		end
end

// RX_FSM that detect chars that was received
always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		state <= WAIT;
		end
	else 
		begin
		if (!enableRx)
			begin
			state <= WAIT;
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
	WAIT: //Wait 8 bits arrives than will search Fist Null
		if(counter_start==4'd3)
			nextState = FIND_NULL;
		else
			nextState = WAIT;
	//ECSS-ST-50-12C: 8.5.3.2.e	
	//Search the 9'b011101000 sequence	
	FIND_NULL:	
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (STORE_REG[9:1] == 9'b011101000)
			begin
			if (STORE_REG[0] == 1'b1 & rx_ready) 
				nextState = CONTROL_AQ;
			else
				nextState = ESC_ERR;				
			end
		else if (STORE_REG[10:2] == 9'b011101000)
			begin
			if (STORE_REG[1] == 1'b1 & rx_ready)
				nextState = CONTROL_AQ;
			else
				nextState = ESC_ERR;				
			end
		else
			nextState = FIND_NULL;	
	START: //Fist stage after each character is detected, define if a NChar or a Control char is arriving
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (BUFFER_DIN[0] == 1'b1 & rx_ready)
			nextState = CONTROL_AQ;
		else if (BUFFER_DIN[0] == 1'b0 & rx_ready)
			nextState = DATA_AQ;
		else
			nextState = START;
	CONTROL_AQ:
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (parity_error)
			nextState = PARITY_ERR;
		else if (BUFFER_DIN[1:0] == 2'b11)
			nextState = GOT_ESC;
		else
			nextState = START;
	GOT_ESC:
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (BUFFER_DIN[1:0] == 2'b01)
			nextState = PRE_NULL;
		else if (BUFFER_DIN[1:0] == 2'b10)
			nextState = PRE_TIME;
		else
			nextState = ESC_ERR;
	PRE_NULL:
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (BUFFER_DIN[1:0] == 2'b00)
			nextState = START;
		else
			nextState = ESC_ERR;
	PRE_TIME:
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if ((counter_cycle == 2'b00) & parity_error)
			nextState = PARITY_ERR;
		else if (counter_cycle == 2'b11)
			nextState = START;
		else
			nextState = PRE_TIME;
	DATA_AQ:
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (counter_cycle == 2'b11)
			nextState = START;
		else
			nextState = DATA_AQ;
	default:
		nextState = state;
endcase
end

always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		counter_start 	<= 4'd0;
		end
	else
		begin
		if(!enableRx)
			begin
			counter_start 	<= 4'd0;
			end
		else
			begin
			case(state)
				WAIT:
					if(gotBit)
						counter_start <= counter_start + 1'b1;
					else
						counter_start <= 4'd0;
				default:
					counter_start <= 4'd0;
			endcase
			end
		end
end

always @(negedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		flag_data 		<= 1'b0;
		flag_timecode	<= 1'b0;
		flag_eep			<= 1'b0;
		flag_eop			<= 1'b0;
		flag_null		<= 1'b0;
		flag_fct			<= 1'b0;
		end
	else
		begin
		if(!enableRx)
			begin
			flag_data 		<= 1'b0;
			flag_timecode	<= 1'b0;
			flag_eep			<= 1'b0;
			flag_eop			<= 1'b0;
			flag_null		<= 1'b0;
			flag_fct			<= 1'b0;
			end
		else
			begin
			case (state)
				FIND_NULL:
					begin
						flag_data 		<= 1'b0;
						flag_timecode	<= 1'b0;
						flag_eep			<= 1'b0;
						flag_eop			<= 1'b0;
						flag_fct			<= 1'b0;
						if (STORE_REG[9:2] == 8'b01110100 | STORE_REG[10:3] == 8'b01110100)
							flag_null		<= 1'b1;
						else
							flag_null		<= 1'b0;
					end	
				PRE_TIME:
					begin
					flag_data 		<= 1'b0;
					flag_timecode	<= 1'b1;
					flag_eep			<= 1'b0;
					flag_eop			<= 1'b0;
					flag_null		<= 1'b0;
					flag_fct			<= 1'b0;
					end
				DATA_AQ:
					begin
					flag_data 		<= 1'b1;
					flag_timecode	<= 1'b0;
					flag_eep			<= 1'b0;
					flag_eop			<= 1'b0;
					flag_null		<= 1'b0;
					flag_fct			<= 1'b0;
					end
				PRE_NULL:
					begin
					flag_data 		<= 1'b0;
					flag_timecode	<= 1'b0;
					flag_eep			<= 1'b0;
					flag_eop			<= 1'b0;
					flag_null		<= 1'b1;
					flag_fct			<= 1'b0;
					end
				CONTROL_AQ:
					begin
					flag_data 		<= 1'b0;
					flag_null		<= 1'b0;
					flag_timecode	<= 1'b0;
					if(BUFFER_DIN[1:0] == 2'b00)
						begin
						flag_eep			<= 1'b0;
						flag_eop			<= 1'b0;
						flag_fct			<= 1'b1;
						end
					else if(BUFFER_DIN[1:0] == 2'b01)
						begin
						flag_eep			<= 1'b0;
						flag_eop			<= 1'b1;
						flag_fct			<= 1'b0;
						end
					else if(BUFFER_DIN[1:0] == 2'b10)
						begin
						flag_eep			<= 1'b1;
						flag_eop			<= 1'b0;
						flag_fct			<= 1'b0;
						end
					else
						begin
						flag_eep			<= 1'b0;
						flag_eop			<= 1'b0;
						flag_fct			<= 1'b0;
						end
					end
				default:
					begin
					flag_data 		<= flag_data;
					flag_timecode	<= flag_timecode;
					flag_eep			<= flag_eep;
					flag_eop			<= flag_eop;
					flag_null		<= flag_null;
					flag_fct			<= flag_fct;
					end
			endcase
		end
	end
end

always @(negedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		parity_error <= 1'b0;
		end
	else 
		begin
		if (!enableRx)
			begin
			parity_error <= 1'b0;
			end
		else
			begin
			case(state)
				START:
				if(gotNULL)
					begin
						if(flag_null | flag_eep | flag_eop | flag_fct)
							parity_error <= !(^BUFFER_DIN[3:0]);
						else if(flag_data | flag_timecode)
							parity_error <= !(^BUFFER_DIN[9:0]);
						else
							parity_error <= 1'b0;
					end
				else
					parity_error <= 1'b0;
				default:
					parity_error <= 1'b0;
			endcase
			end
		end
end

always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		counter_cycle 	<= 2'b00;
		rx_ready			<= 1'b0;
		rx_ready1 		<= 1'b0;
		end
	else
	begin
		if(!enableRx)
			begin
			counter_cycle 	<= 2'b00;
			rx_ready			<= 1'b0;
			rx_ready1 		<= 1'b0;
			end
		else
			begin
			rx_ready1			<= gotBit;
			rx_ready 		<= rx_ready1;
			case(state)
				PRE_TIME, DATA_AQ:
					counter_cycle <= counter_cycle + 1'b1;
				default:
					counter_cycle <= counter_cycle;
			endcase
			end
		end
end

always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		gotData	<= 1'b0;
		gotEEP	<= 1'b0;
		gotEOP	<= 1'b0;
		gotFCT	<= 1'b0;
		gotTimeCode 	<= 1'b0;
		gotBit	<= 1'b0;
		end
	else
		begin
		if (!enableRx)
			begin
			gotData	<= 1'b0;
			gotEEP	<= 1'b0;
			gotEOP	<= 1'b0;
			gotFCT	<= 1'b0;
			gotTimeCode 	<= 1'b0;
			gotBit	<= 1'b0;
			end
		else
			begin
			case(state)
				START:
					begin
					if(flag_null | flag_eep | flag_eop | flag_fct)
						begin
						gotData	<= 1'b0;
						gotEEP	<= flag_eep & (^BUFFER_DIN[3:0]);
						gotEOP	<= flag_eop & (^BUFFER_DIN[3:0]);
						gotFCT	<= gotNULL & flag_fct & (^BUFFER_DIN[3:0]);
						gotTimeCode 	<= 1'b0;
						end
					else if(flag_data | flag_timecode)
						begin
						gotData	<= flag_data & (^BUFFER_DIN[9:0]);
						gotEEP	<= 1'b0;
						gotEOP	<= 1'b0;
						gotFCT	<= 1'b0;
						gotTimeCode 	<= gotNULL & flag_timecode & (^BUFFER_DIN[9:0]);
						end
					else
						begin
						gotData	<= 1'b0;
						gotEEP	<= 1'b0;
						gotEOP	<= 1'b0;
						gotFCT	<= 1'b0;
						gotTimeCode 	<= 1'b0;
						end
					end
				default:
					begin
					gotData	<= 1'b0;
					gotEEP	<= 1'b0;
					gotEOP	<= 1'b0;
					gotFCT	<= 1'b0;
					gotTimeCode 	<= 1'b0;
					end
			endcase
			
			gotBit <= 1'b1;
			end
		end
end

always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		gotNULL_r	<= 1'b0;
		clock_edge  <= 1'b0;
		end
	else
		begin
		if (!enableRx)
			begin
			gotNULL_r	<= 1'b0;
			clock_edge  <= 1'b0;
			end
		else
			begin
			case(state)
			FIND_NULL:
					begin
					if (STORE_REG[9:1] == 9'b011101000)
						begin
						clock_edge <= 1'b0;
						gotNULL_r  <= 1'b1;
						end
					else if (STORE_REG[10:2] == 9'b011101000)
						begin
						clock_edge <= 1'b1;
						gotNULL_r  <= 1'b1;
						end
					else
						begin
						gotNULL_r  <= gotNULL_r;
						clock_edge <= clock_edge;
						end					
					end
				START:
					begin
					clock_edge <= clock_edge;
					
					if(flag_null | flag_eep | flag_eop | flag_fct)
						begin
						gotNULL_r	<= flag_null & (^BUFFER_DIN[3:0]);
						end
					else
						begin
						gotNULL_r	<= 1'b0;
						end
					end
				default:
					begin
					gotNULL_r	<= 1'b0;
					clock_edge <= clock_edge;
					end
			endcase
			end
		end	
end


always @(negedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		RX_DATA 			<= 9'd0;
		TIME_OUT 		<= 8'd0;
		last_time_out 	<= 8'd0;
		end	
	else 
	begin
		if (!enableRx)
			begin
			RX_DATA 			<= 9'd0;
			TIME_OUT 		<= 8'd0;
			last_time_out 	<= 8'd0;
			end	
		else
			begin
			case(state)
				PRE_TIME:
					begin
					RX_DATA 		<= RX_DATA;
					if(counter_cycle == 2'd3)
						begin
						last_time_out <= TIME_OUT;
						
						TIME_OUT[0] 	<= BUFFER_DIN[7];
						TIME_OUT[1] 	<= BUFFER_DIN[6];
						TIME_OUT[2] 	<= BUFFER_DIN[5];
						TIME_OUT[3] 	<= BUFFER_DIN[4];
						TIME_OUT[4] 	<= BUFFER_DIN[3];
						TIME_OUT[5] 	<= BUFFER_DIN[2];
						TIME_OUT[6] 	<= BUFFER_DIN[1];
						TIME_OUT[7] 	<= BUFFER_DIN[0];
						end
					else
						begin
						TIME_OUT 	<= TIME_OUT;
						last_time_out <= last_time_out;
						end
					end
					
				DATA_AQ:
					begin
					TIME_OUT 		<= TIME_OUT;
					last_time_out  <= last_time_out;
					if(counter_cycle == 2'd3)
						begin
						RX_DATA[0] 	<= BUFFER_DIN[7];
						RX_DATA[1] 	<= BUFFER_DIN[6];
						RX_DATA[2] 	<= BUFFER_DIN[5];
						RX_DATA[3] 	<= BUFFER_DIN[4];
						RX_DATA[4] 	<= BUFFER_DIN[3];
						RX_DATA[5] 	<= BUFFER_DIN[2];
						RX_DATA[6] 	<= BUFFER_DIN[1];
						RX_DATA[7] 	<= BUFFER_DIN[0];
						RX_DATA[8] 	<= 1'b0;
						end		
					else
						RX_DATA 	<= RX_DATA;
					end
				CONTROL_AQ:
					begin
					TIME_OUT 		<= TIME_OUT;
					last_time_out <= last_time_out;
					if(BUFFER_DIN[1:0] == 2'b01) //EOP
						begin
						RX_DATA 	<= 9'b1_00000000;
						end		
					else if(BUFFER_DIN[1:0] == 2'b10) //EEP
						begin
						RX_DATA 	<= 9'b1_00000001;
						end	
					else
						RX_DATA 	<= RX_DATA;
					end
				DISCONNECT_ERR, PARITY_ERR, ESC_ERR:
					begin
						RX_DATA 	<= 9'b1_00000001; //EEP
					end
				default:
					begin
					RX_DATA 			<= RX_DATA;
					TIME_OUT 		<= TIME_OUT;
					last_time_out	<= last_time_out;
					end
			endcase
			end
		end
end

always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		gotNULL <= 1'b0;
		end
	else 
		begin
		if (!enableRx)
			begin
			gotNULL <= 1'b0;
			end
		else
			begin
			if(!gotNULL)
				gotNULL <= gotNULL_r;
			else
				gotNULL <= gotNULL;
		end
	end
end


always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		current_packet <= 1'b0;
		end
	else
	begin
	if (!enableRx)
		begin
		current_packet <= 1'b0;
		end
	else
		begin
			if(gotData)
				current_packet <= 1'b1;
			else if(gotEEP | gotEOP )
				current_packet <= 1'b0;
			else
				current_packet <= current_packet;
		end
	end
end

		

assign gotNChar = gotNULL & (gotData | gotEEP | gotEOP);
assign rxError = ((state == DISCONNECT_ERR) | (state == ESC_ERR) | (state == PARITY_ERR));
assign BUFFER_WRITE = (BUFFER_READY & (gotData | ((gotEEP | gotEOP | rxError)& current_packet)));


always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		TICK_OUT <= 1'b0;
		end
	else 
	begin
		if (!enableRx)
			begin
			TICK_OUT <= 1'b0;
			end
		else	
			begin
				if(TIME_OUT[5:0] == (last_time_out[5:0]+1'b1))
					TICK_OUT <= gotTimeCode;
				else
					TICK_OUT <= 1'b0;
			end
		end
			
end
		
endmodule
