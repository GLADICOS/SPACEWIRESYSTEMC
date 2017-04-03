//+FHDR------------------------------------------------------------------------
//Copyright (c) 2013 Latin Group American Integhrated Circuit, Inc. All rights reserved
//GLADIC Open Source RTL
//-----------------------------------------------------------------------------
//FILE NAME	 :
//DEPARTMENT	 : IC Design / Verification
//AUTHOR	 : Felipe Fernandes da Costa
//AUTHOR’S EMAIL :
//-----------------------------------------------------------------------------
//RELEASE HISTORY
//VERSION DATE AUTHOR DESCRIPTION
//1.0 YYYY-MM-DD name
//-----------------------------------------------------------------------------
//KEYWORDS : General file searching keywords, leave blank if none.
//-----------------------------------------------------------------------------
//PURPOSE  : ECSS_E_ST_50_12C_31_july_2008
//-----------------------------------------------------------------------------
//PARAMETERS
//PARAM NAME		RANGE	: DESCRIPTION : DEFAULT : UNITS
//e.g.DATA_WIDTH	[32,16]	: width of the data : 32:
//-----------------------------------------------------------------------------
//REUSE ISSUES
//Reset Strategy	:
//Clock Domains		:
//Critical Timing	:
//Test Features		:
//Asynchronous I/F	:
//Scan Methodology	:
//Instantiations	:
//Synthesizable (y/n)	:
//Other			:
//-FHDR------------------------------------------------------------------------

`timescale 1ns/1ns

module FSM_SPW (
		input  pclk,
		input  resetn,

		//fsm status control
		input  auto_start,
		input  link_start,
		input  link_disable,

		//rx status input control
		input  rx_error,
		input  rx_credit_error,
		input  rx_got_bit,
		input  rx_got_null,
		input  rx_got_nchar,
		input  rx_got_time_code,
		input  rx_got_fct,
		output rx_resetn,

		//tx status control
		output enable_tx,
		output send_null_tx,
		output send_fct_tx,

		output [5:0] fsm_state

	      );

localparam [5:0]  error_reset   = 6'b00_0000,
		  error_wait    = 6'b00_0001,
		  ready         = 6'b00_0010,
		  started       = 6'b00_0100,
		  connecting    = 6'b00_1000,
		  run           = 6'b01_0000;

	reg [5:0] state_fsm;
	reg [5:0] next_state_fsm;

	reg [11:0] after128us;
	reg [11:0] after64us;
	reg [11:0] after850ns;

//
assign enable_tx    = (!resetn | state_fsm == error_reset | state_fsm == error_wait)?1'b0:1'b1;

//
assign rx_resetn    = (state_fsm == error_reset)?1'b0:1'b1;

//
assign send_null_tx = (state_fsm == started | state_fsm == connecting | state_fsm == run)?1'b1:1'b0;

//
assign send_fct_tx  = (state_fsm == connecting | state_fsm == run)?1'b1:1'b0;

//
assign fsm_state    = state_fsm;

always@(*)
begin

	next_state_fsm = state_fsm;

	case(state_fsm)
	error_reset:
	begin

		if(after64us == 12'd639)
		begin
			next_state_fsm = error_wait;
		end
		else
		begin
			next_state_fsm = error_reset;
		end

	end
	error_wait:
	begin

		if(after128us == 12'd1279)
		begin
			next_state_fsm = ready;
		end
		else if(rx_error | rx_got_fct | rx_got_nchar | rx_got_time_code)
		begin
			next_state_fsm = error_reset;
		end

	end
	ready:
	begin

		if(rx_error | rx_got_fct | rx_got_nchar | rx_got_time_code)
		begin
			next_state_fsm = error_reset;
		end
		else if((!link_disable) && (link_start |(auto_start && rx_got_null)))
		begin
			next_state_fsm = started;
		end

	end
	started:
	begin

		if(rx_error | rx_got_fct | rx_got_nchar | rx_got_time_code | after128us == 12'd1279 )
		begin
			next_state_fsm = error_reset;
		end
		else if(rx_got_null && rx_got_bit)
		begin
			next_state_fsm = connecting;
		end

	end
	connecting:
	begin

		if(rx_error | rx_got_nchar | rx_got_time_code | after128us == 12'd1279 )
		begin
			next_state_fsm = error_reset;
		end
		else if(rx_got_fct)
		begin
			next_state_fsm = run;
		end

	end
	run:
	begin

		if(rx_error | rx_credit_error | link_disable  | after850ns == 12'd85)
		begin
			next_state_fsm = error_reset;
		end
		else
		begin
			next_state_fsm = run;
		end

	end
	endcase
end

always@(posedge pclk)
begin
	if(!resetn)
	begin
		state_fsm <= error_reset;
	end
	else
	begin

		state_fsm <= next_state_fsm;

		case(state_fsm)
		error_reset:
		begin
		end
		error_wait:
		begin
		end
		ready:
		begin
		end
		started:
		begin
		end
		connecting:
		begin
		end
		run:
		begin
		end
		endcase
	end
end

always@(posedge pclk)
begin

	if(!resetn)
	begin
		after128us <= 12'd0;
	end
	else
	begin
		if(state_fsm == error_wait | state_fsm == started | state_fsm == connecting)
		begin
			if(after128us < 12'd1279)
				after128us <= after128us + 12'd1;
			else
				after128us <= 12'd0;
		end
		else
		begin
				after128us <= 12'd0;
		end
	end

end

always@(posedge pclk)
begin

	if(!resetn)
	begin
		after64us <= 12'd0;
	end
	else
	begin
		if(state_fsm == error_reset && (auto_start | link_start))
		begin
			if(after64us < 12'd639)
				after64us <= after64us + 12'd1;
			else
				after64us <= 12'd0;
		end
		else
		begin
			after64us <= 12'd0;
		end
	end

end

always@(posedge pclk)
begin

	if(!resetn)
	begin
		after850ns <= 12'd0;
	end
	else
	begin
		if(rx_got_bit)
		begin
			after850ns <= 12'd0;
		end
		else
		begin
			if(after850ns < 12'd85 && state_fsm == run)
				after850ns <= after850ns + 12'd1;
			else
				after850ns <= 12'd0;
		end
	end

end

endmodule
