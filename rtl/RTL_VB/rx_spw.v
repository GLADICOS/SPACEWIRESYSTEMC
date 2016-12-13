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

module RX_SPW (
			input  rx_din,
			input  rx_sin,

			input  rx_resetn,

			output rx_error,

			output rx_got_bit,
			output rx_got_null,
			output rx_got_nchar,
			output rx_got_time_code,
			output rx_got_fct,

			output [8:0] rx_data_flag,
			output rx_buffer_write,

			output [7:0] rx_time_out,
			output rx_tick_out
		 );

	wire [4:0] counter;

	reg  [4:0] counter_pos;
	reg  [4:0] counter_neg;

	wire posedge_clk;
	wire negedge_clk;

	wire [3:0] control;
	wire [9:0] data;
	wire [9:0] timecode;

	reg [3:0] control_l_a;
	reg [9:0] data_l_a;
	reg [9:0] timecode_l_a;

	reg [2:0] control_l_r;
	reg [9:0] data_l_r;
	reg [9:0] timecode_l_r;

	reg parity_error;

	reg control_found;
	reg data_found;
	reg time_code_found;

	reg last_was_control;
	reg last_was_data;
	reg last_was_time_code;
	
	wire data_control_up;

	assign data_control_up = (counter == 5'd3 & control[2:2])?1'b1:
			         (last_was_data)?1'b1: 
			         (last_was_time_code)?1'b1:1'b0;

	assign posedge_clk = (rx_din ^ rx_sin)?1'b1:1'b0;
	assign negedge_clk = (!(rx_din ^ rx_sin))?1'b1:1'b0;

/*
	assign  counter = (!rx_resetn)?5'd0:
			  (counter == 5'd3 & control[2:2])? 5'd0:
			  (counter == 5'd9 )?5'd0:
			  ((rx_din ^ rx_sin) | !(rx_din ^ rx_sin))?counter + 5'd1:counter;
*/

	//assign counter_pos = (!rx_resetn)?5'd0:(counter == 5'd3 & control[2:2])?5'd0:(counter == 5'd9)?5'd0:(posedge_clk)?counter_pos+5'd1:counter_pos;
	//assign counter_neg = (!rx_resetn)?5'd0:(counter == 5'd3 & control[2:2])?5'd0:(counter == 5'd9)?5'd0:(negedge_clk)?counter_neg+5'd1:counter_neg;

	assign  counter = counter_pos + counter_neg;

	assign data[9:9] = (!rx_resetn)?1'b0:(counter == 5'd0)?rx_din:data[9:9];
	assign data[8:8] = (!rx_resetn)?1'b0:(counter == 5'd1)?rx_din:data[8:8];
	assign data[0:0] = (!rx_resetn)?1'b0:(counter == 5'd2)?rx_din:data[0:0];
	assign data[1:1] = (!rx_resetn)?1'b0:(counter == 5'd3)?rx_din:data[1:1];
	assign data[2:2] = (!rx_resetn)?1'b0:(counter == 5'd4)?rx_din:data[2:2];
	assign data[3:3] = (!rx_resetn)?1'b0:(counter == 5'd5)?rx_din:data[3:3];
	assign data[4:4] = (!rx_resetn)?1'b0:(counter == 5'd6)?rx_din:data[4:4];
	assign data[5:5] = (!rx_resetn)?1'b0:(counter == 5'd7)?rx_din:data[5:5];
	assign data[6:6] = (!rx_resetn)?1'b0:(counter == 5'd8)?rx_din:data[6:6];
	assign data[7:7] = (!rx_resetn)?1'b0:(counter == 5'd9)?rx_din:data[7:7];

	assign timecode[0:0] = (!rx_resetn)?1'b0:(counter == 5'd0)?rx_din:timecode[0:0];
	assign timecode[1:1] = (!rx_resetn)?1'b0:(counter == 5'd1)?rx_din:timecode[1:1];
	assign timecode[2:2] = (!rx_resetn)?1'b0:(counter == 5'd2)?rx_din:timecode[2:2];
	assign timecode[3:3] = (!rx_resetn)?1'b0:(counter == 5'd3)?rx_din:timecode[3:3];
	assign timecode[4:4] = (!rx_resetn)?1'b0:(counter == 5'd4)?rx_din:timecode[4:4];
	assign timecode[5:5] = (!rx_resetn)?1'b0:(counter == 5'd5)?rx_din:timecode[5:5];
	assign timecode[6:6] = (!rx_resetn)?1'b0:(counter == 5'd6)?rx_din:timecode[6:6];
	assign timecode[7:7] = (!rx_resetn)?1'b0:(counter == 5'd7)?rx_din:timecode[7:7];
	assign timecode[8:8] = (!rx_resetn)?1'b0:(counter == 5'd8)?rx_din:timecode[8:8];
	assign timecode[9:9] = (!rx_resetn)?1'b0:(counter == 5'd9)?rx_din:timecode[9:9];

	assign control[0:0]  = (!rx_resetn)?1'b0:(counter == 5'd3)?rx_din:control[0:0];
	assign control[1:1]  = (!rx_resetn)?1'b0:(counter == 5'd2)?rx_din:control[1:1];
	assign control[2:2]  = (!rx_resetn)?1'b0:(counter == 5'd1)?rx_din:control[2:2];
	assign control[3:3]  = (!rx_resetn)?1'b0:(counter == 5'd0)?rx_din:control[3:3];

	assign rx_got_fct       = (counter == 5'd3   & control_l_a[2:0] != 3'd7 & control[2:2] & control[2:0] == 3'd4)?1'b1:1'b0;
	assign rx_got_nchar     = (!control_l_a[2:2] & data_l_a[2:0] != 3'd7)?1'b1:1'b0;
	assign rx_got_time_code = (counter == 5'd9   & control_l_a[2:0] == 3'd7)? 1'b1:1'b0;
	assign rx_got_null      = (counter == 5'd3   & control_l_r[2:0] == 3'd7 & control_l_a[2:0] == 3'd4)? 1'b1:1'b0;
	assign rx_got_bit       = (posedge_clk | negedge_clk)?1'b1:1'b0;

	assign rx_error         = (parity_error)?1'b1: 
				  ((counter == 5'd9 | counter == 5'd4) & !rx_got_fct & !rx_got_nchar & !rx_got_time_code & !rx_got_null & !last_was_control)?1'b1:1'b0;

	assign rx_data_flag	= (rx_got_nchar)?data[8:0]:data_l_a[8:0];
	assign rx_buffer_write	= (rx_got_nchar & data_control_up)?1'b1:1'b0;

	assign rx_time_out	= (rx_got_time_code)?timecode[7:0]:timecode_l_a[7:0];
	assign rx_tick_out	= (rx_got_time_code & data_control_up)?1'b1:1'b0; 


always@(posedge posedge_clk or negedge rx_resetn  or posedge last_was_control)
begin
	if(!rx_resetn | last_was_control)
	begin
		counter_pos <= 5'd0;	
	end
	else
	begin
		if(counter == 5'd4 & control[2:2])
		begin
			counter_pos <= 5'd0;
		end
		else if(counter == 5'd9)
		begin
			counter_pos <= 5'd0;
		end
		else
		begin
			counter_pos <= counter_pos + 5'd1;			
		end
	end
end

//
always@(posedge negedge_clk or negedge rx_resetn or posedge last_was_control)
begin
	if(!rx_resetn | last_was_control )
	begin
		counter_neg <= 5'd0;	
	end
	else
	begin
		if(counter == 5'd4 & control[2:2])
		begin
			counter_neg <= 5'd0;
		end
		else if(counter == 5'd9)
		begin
			counter_neg <= 5'd0;
		end
		else
		begin
			counter_neg <= counter_neg + 5'd1;			
		end
	end
end

//parity error
always@(*)
begin

	parity_error = 1'b0;

	if(control_found && last_was_control)
	begin
		if(!(control_l_a[2]^control_l_r[0]^control_l_r[1]) != control_l_a[3])
		begin
			parity_error = 1'b1;
		end
	end
	else if(control_found && last_was_data)
	begin
		if(!(data_l_a[8]^control_l_r[0]^control_l_r[1])  != data_l_a[9])
		begin
			parity_error = 1'b1;
		end
	end
	else if(control_found && last_was_time_code)
	begin
		if(!(timecode_l_a[8]^control_l_r[0]^control_l_r[1]) != timecode_l_a[9])
		begin
			parity_error = 1'b1;
		end
	end
	else if(data_found && last_was_control)
	begin
		if(!(control_l_a[2]^data_l_r[0]^data_l_r[1]^data_l_r[2]^data_l_r[3]^data_l_r[4])^data_l_r[5]^data_l_r[6]^data_l_r[7] != control_l_a[3])
		begin
			parity_error = 1'b1;
		end
	end
	else if(data_found && last_was_data)
	begin
		if(!(data_l_a[8]^data_l_r[0]^data_l_r[1]^data_l_r[2]^data_l_r[3]^data_l_r[4])^data_l_r[5]^data_l_r[6]^data_l_r[7] != data_l_a[9])
		begin
			parity_error = 1'b1;
		end
	end
	else if(data_found && last_was_time_code)
	begin
		if(!(data_l_r[8]^timecode_l_a[0]^timecode_l_a[1]^timecode_l_a[2]^timecode_l_a[3]^timecode_l_a[4]^timecode_l_a[5]^timecode_l_a[6]^timecode_l_a[7])  != data_l_r[9])
		begin
			parity_error = 1'b1;
		end
	end
	else if(time_code_found && last_was_data)
	begin
		if(!(timecode_l_r[8]^data_l_a[0]^data_l_a[1]^data_l_a[2]^data_l_a[3]^data_l_a[4])^data_l_a[5]^data_l_a[6]^data_l_a[7] != timecode_l_r[9])
		begin
			parity_error = 1'b1;
		end
	end
	else if(time_code_found && last_was_control)
	begin
		if(!(control_l_a[2]^timecode_l_r[0]^timecode_l_r[1]^timecode_l_r[2]^timecode_l_r[3]^timecode_l_r[4]^timecode_l_r[5]^timecode_l_r[6]^timecode_l_r[7])  != control_l_a[3])
		begin
			parity_error = 1'b1;
		end
	end
end

//
always@(*)
begin

	last_was_control  = 1'b0;
	last_was_data     = 1'b0;
	last_was_time_code= 1'b0;

	if(counter == 5'd4 & control[2:2])
	begin
		last_was_control  = 1'b1;
	end
	else if(counter == 5'd9 && !control_l_a[2:2] && data_l_a[2:0] != 3'd7)
	begin
		last_was_data     = 1'b1;
	end
	else if(counter == 5'd9 && control_l_a[2:0] == 3'd7)
	begin
		last_was_time_code= 1'b1;
	end

end

//
always@(posedge data_control_up or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		control_found   <= 1'b0;
		data_found      <= 1'b0;
		time_code_found <= 1'b0;
	end
	else
	begin
		control_found   <= last_was_control;
		data_found      <= last_was_data;
		time_code_found <= last_was_time_code;
	end

end

//
always@(posedge last_was_control or negedge rx_resetn)
begin
	if(!rx_resetn)
	begin
		control_l_a <= 4'd4;
		control_l_r <= 3'd4;
	end
	else
	begin
		control_l_a <= control;
		control_l_r <= control_l_a[2:0];
	end
end

always@(posedge last_was_data or negedge rx_resetn)
begin
	if(!rx_resetn)
	begin
		data_l_a <= 10'd0;
		data_l_r <= 10'd0;
	end
	else
	begin
		data_l_a <= data;
		data_l_r <= data_l_a;
	end
end

always@(posedge last_was_time_code or negedge rx_resetn)
begin
	if(!rx_resetn)
	begin
		timecode_l_a <= 10'd0;
		timecode_l_r <= 10'd0;
	end
	else
	begin
		timecode_l_a <= timecode;
		timecode_l_r <= timecode_l_a;
	end
end


endmodule
