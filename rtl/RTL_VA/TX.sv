/*
//=================================================================//
//=
//= 	SpwTCR_TX
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: Transmiter FSM and Serializer.
//=
//=	Version History:
//=	0.1: 17/08/2016 - First Version
//=
//=================================================================//
*/

module SpwTCR_TX(
CLOCK,
RESETn,
CLK_EN,
resetTx,
enableTx,
sendNULLs,
sendFCTs,
sendNChars,
sendTimeCodes,
creditErr,
TICK_IN,
TIME_IN,
sendFctReq,
sendFctAck,
spillEnable,
gotFCT,
data_ack,
data,
data_req,
Dout,
Sout
);

input 			CLOCK;
input				RESETn;
input 			CLK_EN;
input 			resetTx;
input 			enableTx;
input 			sendNULLs;
input 			sendFCTs;
input 			sendNChars;
input 			sendTimeCodes;
output logic    creditErr;
input 			TICK_IN;
input [7:0]		TIME_IN;
input 			sendFctReq;
output logic 	sendFctAck;
input 			spillEnable;
input 			gotFCT; 
input 			data_ack;
input [8:0] 	data;
output logic 			data_req;
output logic 			Dout;
output logic 			Sout;
		
enum logic [8:0] {
	CHAR_START 			= 9'b000000001, //State after reset
	CHAR_FCT 			= 9'b000000010, // FCT char
	CHAR_EOP 			= 9'b000000100, // EOP char
	CHAR_FCT_NULL 		= 9'b000001000, // FCT part of NULL (ESC+FCT)
	CHAR_EEP 			= 9'b000010000, // EOP char
	CHAR_ESC_TIME 		= 9'b000100000, // ESC part of Timecode (ESC+DATA)
	CHAR_ESC_NULL 		= 9'b001000000, // ESC part of NULL (ESC+FCT)
	CHAR_DATA 			= 9'b010000000, // DATA char
	CHAR_TIME 			= 9'b100000000  // DATA part of Timecode (ESC+DATA)
} State, NextState;

enum logic [2:0] {
	DATA_WAIT 			= 3'b001,
	DATA_READY 			= 3'b011,
	DATA_SPILL			= 3'b010,
	DATA_SPILL_OFF 	= 3'b000,
	DATA_STORE 			= 3'b100
	} DataSt, NextDataSt;

enum logic [1:0] {
	SPILL_CHECK 			= 2'b01,
	SPILL_RUN 			= 2'b11,
	SPILL_OFF			= 2'b10
	} SpillSt;
	
logic 			tick_in_w;
logic [8:0] 	data_reg;
logic [7:0] 	timecode_reg;
logic [3:0] 	counter_data;  //defines cycles of DATA
logic [1:0]		counter_s;		//defines cycles of "4" bits characters
logic [6:0] 	credit_tx;
logic 			first_cycle;
logic				second_cycle;
logic 		 	w_shif_reg;
logic [7:0] 	data_shif_reg;
logic [1:0]		control_shift_reg;
logic 			pre_parity;
logic [1:0] 	w_parity_control;
logic 			txEnabled;
logic 			firstFCT;
logic 			tick_in_rise;
logic 			tick_in_ff1;
logic 			tick_in_ff2;
logic 			current_packet;
logic				spill;
logic				resetTx_delay;	//reset delay only for Sout
enum logic [1:0] {
	FCT_WAIT 	= 2'b01,
	FCT_REQ 	= 2'b11,
	FCT_ACK 	= 2'b10
	} 	FctSt, NextFctSt;

logic gotFCT_1;
logic gotFCT_2;
logic gotFCT_rise;

assign txEnabled = enableTx & CLK_EN;

always @(posedge CLOCK)
begin
if(!resetTx)
	begin
	resetTx_delay <= 1'b0;
	end
else
	begin
	resetTx_delay <= 1'b1;
	end
end 


always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	DataSt <= DATA_WAIT;
	end
else if(enableTx)
	begin
	DataSt <= NextDataSt;
	end
end 

always @ (*)
begin
case (DataSt)
	DATA_WAIT:
		begin
		if(data_ack & !spill)
			NextDataSt = DATA_STORE;
		else if(data_ack & spill)
			NextDataSt = DATA_SPILL;
		else
			NextDataSt = DATA_WAIT;
		end
	DATA_SPILL:
		begin
		if(data[8]==1'b1 & (data[0]==1'b1 | data[0]==1'b0))
			NextDataSt = DATA_SPILL_OFF;
		else
			NextDataSt = DATA_WAIT;
		end
	DATA_SPILL_OFF:
		begin
		NextDataSt = DATA_WAIT;
		end
	DATA_STORE:
		begin
		NextDataSt = DATA_READY;
		end
	DATA_READY:
		begin
		if((State == CHAR_DATA | State == CHAR_EOP | State == CHAR_EEP) & first_cycle)
			NextDataSt = DATA_WAIT;
		else
			NextDataSt = DataSt;
		end
	default:
		NextDataSt = DataSt;
endcase
end

assign data_req = (DataSt == DATA_WAIT) ? 1'b1 : 1'b0;

always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	data_reg 			<= 9'd0;
	end
else if(enableTx)
	begin
	case (DataSt)
	DATA_STORE:
		begin
		data_reg 	<= data;
		end
	default:
		begin
		data_reg		<= data_reg;
		end
endcase
	end
end

//====================================================
// timecode_reg store timecode from input port in the rise of tick_in signal
always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
   timecode_reg 	<= 8'd0;
	end
else if(enableTx)
	begin
	if(tick_in_rise)	
		timecode_reg 	<= TIME_IN;
	else
		timecode_reg 	<= timecode_reg;
	end
end

//====================================================
// timecode_reg store timecode from input port in the rise of tick_in signal
always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	counter_data 	<= 4'd0;
	counter_s 		<= 2'd0;
	second_cycle 	<= 1'b0;
	end
else if(txEnabled)
	begin
	second_cycle 	<= first_cycle;
	case (State)
		CHAR_DATA, CHAR_TIME:
			begin
			if(counter_data == 4'd9)
				counter_data 	<= 4'd0;
			else	
				counter_data 	<= counter_data + 1'b1;
			counter_s 		<= 2'd0;
			end
			
		CHAR_START:
			begin
			counter_data 	<= 4'd0;
			counter_s 		<= 2'd0;
			end
		default:
			begin
			counter_data 	<= 4'd0;
			counter_s 		<= counter_s + 1'b1;
			end
	endcase
	end
end


always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	data_shif_reg <= 8'd0;
	end
else if(txEnabled)
	begin
	case (State)
		CHAR_ESC_TIME:
			begin
			data_shif_reg <= timecode_reg;
			end
		CHAR_DATA:
			if(counter_data == 4'd0)
				data_shif_reg <= data_reg[7:0];
			else if (counter_data > 4'd1)
				data_shif_reg <= data_shif_reg >> 1;
			else
				data_shif_reg <= data_shif_reg;
		CHAR_TIME:
			if (counter_data > 4'd1)
				data_shif_reg <= data_shif_reg >> 1;
			else
				data_shif_reg <= data_shif_reg;
		default:
				data_shif_reg <= data_reg[7:0];
	endcase
	end
end

always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	pre_parity <= 1'b0;
	end
else if(txEnabled)
	begin
	if(second_cycle)
		begin
		case (State)
			CHAR_DATA, CHAR_TIME:
				begin
				pre_parity <= ^data_shif_reg;
				end
			CHAR_EEP, CHAR_EOP:
				begin
				pre_parity <= 1'b1;
				end
			default: //ESC or FCT
				pre_parity <= 1'b0;
		endcase
		end
	end
end


always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	control_shift_reg <= 2'b00;
	end
else if(txEnabled)
	begin
		if(counter_s == 2'd0)
		begin
			case (State)
				CHAR_ESC_NULL, CHAR_ESC_TIME:
					control_shift_reg <= 2'b11;
				CHAR_FCT, CHAR_FCT_NULL:
					control_shift_reg <= 2'b00;
				CHAR_EEP:
					control_shift_reg <= 2'b10;
				CHAR_EOP:
					control_shift_reg <= 2'b01;
				default: //	CHAR_ESC_NULL, CHAR_ESC_TIME;
					control_shift_reg <= control_shift_reg;
			endcase
		end
		else if (counter_s == 2'd2)
		begin
			control_shift_reg <= control_shift_reg << 1;
		end
		else
		begin
			control_shift_reg <= control_shift_reg;
		end
	end
end

always @ (*)
begin
case (State)
	CHAR_DATA, CHAR_TIME:
		w_shif_reg = data_shif_reg[0];
	default: //	CHAR_ESC_NULL, CHAR_ESC_TIME;
		w_shif_reg = control_shift_reg[1];
endcase
end

always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	State <= CHAR_START;
	end
else if(txEnabled)
	begin
	State <= NextState;
	end
end

always @ (*)
begin
	case (State)
		CHAR_START:
			if(sendNULLs)
				NextState = CHAR_ESC_NULL;
			else
				NextState = CHAR_START;
		CHAR_FCT_NULL:
			if(counter_s < 2'd3)
				NextState = CHAR_FCT_NULL;
			else if(tick_in_w & sendTimeCodes & firstFCT) 
				NextState = CHAR_ESC_TIME;
			else if (sendFCTs &  (FctSt == FCT_REQ))
				NextState = CHAR_FCT;
			else if(!firstFCT)
				NextState = CHAR_ESC_NULL;
			else if (sendNChars & data_reg[8]==1'b0 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_DATA;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b10 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EOP;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b11 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EEP;	
			else if (sendNULLs)
				NextState = CHAR_ESC_NULL;
			else
				NextState = CHAR_START;
		CHAR_EOP, CHAR_EEP, CHAR_FCT:
			if(counter_s < 2'd3)
				NextState = State;
			else if(tick_in_w & sendTimeCodes) 
				NextState = CHAR_ESC_TIME;
			else if (sendFCTs &  (FctSt == FCT_REQ))
				NextState = CHAR_FCT;
			else if (sendNChars & data_reg[8]==1'b0 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_DATA;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b10 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EOP;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b11 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EEP;	
			else if (sendNULLs)
				NextState = CHAR_ESC_NULL;
			else
				NextState = CHAR_START;
		CHAR_DATA, CHAR_TIME:
			if(counter_data < 4'd9)
				NextState = State;
			else if(tick_in_w)
				NextState = CHAR_ESC_TIME;
			else if (sendFCTs &  (FctSt == FCT_REQ))
				NextState = CHAR_FCT;
			else if (sendNChars & data_reg[8]==1'b0 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_DATA;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b10 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EOP;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b11 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EEP;	
			else if (sendNULLs)
				NextState = CHAR_ESC_NULL;
			else
				NextState = CHAR_START;
		CHAR_ESC_TIME:
			if(counter_s == 2'd3)
				NextState = CHAR_TIME;
			else
				NextState = CHAR_ESC_TIME;
		CHAR_ESC_NULL:
			if(counter_s ==  2'd3)
				NextState = CHAR_FCT_NULL;
			else
				NextState = CHAR_ESC_NULL;
		default:
				NextState = State;
			
	endcase
end

always @ (*)
begin
case (State)
	CHAR_DATA, CHAR_TIME:
		w_parity_control = {1'b0, ~(pre_parity ^ 1'b0)};
	default: //	CHAR_ESC_NULL, CHAR_ESC_TIME;
		w_parity_control = {1'b1, ~(pre_parity ^ 1'b1)};
endcase
end

always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
		Dout <= 1'b0;
	end
else if(txEnabled)	
begin
		case (State)
			CHAR_START:
				begin
				Dout <= 1'b0;
				end
			default:
				begin
				if(first_cycle)
					begin
					Dout <= w_parity_control[0];
					end
				else if (second_cycle)
					begin
					Dout <= w_parity_control[1];
					end
				else
					begin
					Dout <= w_shif_reg;
					end
				end
		endcase	
end
end

always @(posedge CLOCK)
begin
if(!resetTx_delay)
	begin
		Sout <= 1'b0;
	end
else if(txEnabled)	
begin
		case (State)
			CHAR_START:
				begin
				Sout <= 1'b0;
				end
			default:
				begin
				if(first_cycle)
					begin
					if(Dout == w_parity_control[0])
						Sout <= ~Sout;
					else
						Sout <= Sout;
					end
				else if (second_cycle)
					begin
					if(Dout == w_parity_control[1])
						Sout <= ~Sout;
					else
						Sout <= Sout;
					end
				else
					begin
					if(Dout == w_shif_reg)
						Sout <= ~Sout;
					else
						Sout <= Sout;
					end
				end
		endcase	
end
end


assign first_cycle = ((counter_s == 0 & (State !=	CHAR_TIME & State != CHAR_DATA)) | (counter_data==0 & (State ==	CHAR_TIME | State == CHAR_DATA))) ? 1'b1 : 1'b0;

always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		FctSt 		<= FCT_WAIT;
		end
	else if (enableTx)
		begin
		FctSt 		<= NextFctSt;
		end
end

always @ (*)
begin
	case (FctSt)
		FCT_WAIT:
			begin
			if(sendFctReq)
				NextFctSt = FCT_REQ;
			else
				NextFctSt = FCT_WAIT;
			end
		FCT_REQ:
			begin
			if((State == CHAR_FCT) & first_cycle)
				NextFctSt = FCT_ACK;
			else
				NextFctSt = FCT_REQ;
			end
		FCT_ACK:
			begin
			if(!sendFctReq)
				NextFctSt = FCT_WAIT;
			else
				NextFctSt = FCT_ACK;
			end
		default:
			begin
			NextFctSt = FctSt;
			end
	endcase
end

assign sendFctAck = (FctSt == FCT_ACK) ? 1'b1: 1'b0;


//credit Tx
always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		gotFCT_1 		<= 1'b0;
        gotFCT_2 		<= 1'b0;
        gotFCT_rise 	<= 1'b0;
		end
	else if (enableTx)
		begin
        gotFCT_1 		<= gotFCT;
        gotFCT_2 		<= gotFCT_1 ;
        gotFCT_rise 	<= !gotFCT_2 & gotFCT_1;
		end
end

always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		credit_tx 		<= 7'd0;
		end
	else if (enableTx)
		begin
        if(((State == CHAR_DATA | State == CHAR_EOP | State == CHAR_EEP)& first_cycle) & !gotFCT_rise)
		    credit_tx 		<= credit_tx - 1'b1;
        else if(((State == CHAR_DATA | State == CHAR_EOP | State == CHAR_EEP)& first_cycle) & gotFCT_rise)
            credit_tx 		<= credit_tx + 7'd7;
        else if(!((State == CHAR_DATA | State == CHAR_EOP | State == CHAR_EEP)& first_cycle) & gotFCT_rise)
            credit_tx 		<= credit_tx + 7'd8;
        else
            credit_tx 		<= credit_tx;
		end
end

assign creditErr = (credit_tx > 7'd56) ? 1'b1: 1'b0;



always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		firstFCT <= 1'b0;
		end
	else if (enableTx)
	begin
		if(!firstFCT & (State == CHAR_FCT))
			firstFCT <= 1'b1;
		else
			firstFCT <= firstFCT;
	end
end

always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		  tick_in_ff1 		<= 1'b0;
        tick_in_ff2 		<= 1'b0;
		end
	else if (enableTx)
		begin
        tick_in_ff1 		<= TICK_IN;
        tick_in_ff2 		<= tick_in_ff1;
		end
end

assign tick_in_rise = tick_in_ff1 & !tick_in_ff2;

always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		  tick_in_w <= 1'b0;
		end
	else if (enableTx)
		begin
			if(tick_in_rise)
				tick_in_w <= 1'b1;
			else if((State == CHAR_ESC_TIME) & first_cycle)
				tick_in_w <= 1'b0;
			else
				tick_in_w <= tick_in_w;	

		end
end

always @(posedge CLOCK, negedge RESETn)
begin
	if(!RESETn)
		begin
		current_packet <= 1'b0;
		end
	else if (enableTx)
	begin
		if((State == CHAR_DATA) & first_cycle) //First CHAR_DATA sent
			current_packet <= 1'b1;
		else if((State == CHAR_EOP | State == CHAR_EEP)& (counter_s == 2'd3)) //last cycle of EOP/EEP
			current_packet <= 1'b0;
		else
			current_packet <= current_packet;
	end
end

always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		  SpillSt <= SPILL_CHECK;
		end
	else if (enableTx)
		begin
		case (SpillSt)
		  SPILL_CHECK:
		  begin
		    if(spillEnable & current_packet)
		      SpillSt <= SPILL_RUN;
		    else
		      SpillSt <= SPILL_OFF;
		    end
		   SPILL_RUN:
		   begin
		     if(DataSt == DATA_SPILL_OFF)
		       SpillSt <= SPILL_OFF;
		    else
		      SpillSt <= SPILL_RUN;
		    end
		  default:
		    begin
		    SpillSt <= SPILL_OFF;
		    end
		   endcase
		end
end
assign spill = (SpillSt == SPILL_RUN) ? 1'b1 : 1'b0;

endmodule
