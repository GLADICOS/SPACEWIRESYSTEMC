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

			output reg rx_got_bit,
			output reg rx_got_null,
			output reg rx_got_nchar,
			output reg rx_got_time_code,
			output reg rx_got_fct,
			output reg rx_got_fct_fsm,

			output reg [8:0] rx_data_flag,
			output reg rx_buffer_write,

			output [7:0] rx_time_out,
			output reg rx_tick_out
		 );


	reg  [5:0] counter_neg;
	reg control_bit_found;
	reg data_bit_found;

	wire posedge_clk;
	wire negedge_clk;

	reg  [1:0] state_data_process;
	reg  [1:0] next_state_data_process;

	reg bit_c_0;//N
	reg bit_c_1;//P
	reg bit_c_2;//N
	reg bit_c_3;//P

	reg bit_d_0;//N
	reg bit_d_1;//P
	reg bit_d_2;//N
	reg bit_d_3;//P
	reg bit_d_4;//N
	reg bit_d_5;//P
	reg bit_d_6;//N
	reg bit_d_7;//P
	reg bit_d_8;//N
	reg bit_d_9;//P

	reg is_control;
	reg parity_received;

	reg last_is_control;
	reg last_is_data;
	reg last_is_timec;

	reg [3:0] control;
	reg [3:0] control_r;
	reg [3:0] control_p_r;
	reg [9:0] data;
	reg [9:0] timecode;

	reg [3:0] control_l_r;

	reg [9:0] dta_timec;
	reg [9:0] dta_timec_p;

	reg ready_control;
	reg ready_data;

	reg ready_control_p;
	reg ready_data_p;

	reg ready_control_p_r;
	reg ready_data_p_r;

	reg parity_rec_c;
	reg parity_rec_d;

	reg rx_error_c;
	reg rx_error_d;

	reg posedge_p;
	
	//CLOCK RECOVERY
	assign posedge_clk 	= posedge_p;
	assign negedge_clk 	= !posedge_p;

	assign rx_time_out 	= timecode[7:0];

	assign rx_error		= rx_error_c | rx_error_d;

always@(*)
begin

	rx_got_bit = 1'b0;

	if(rx_din | rx_sin)
	begin
		rx_got_bit = 1'b1;
	end
end

always@(*)
begin
	ready_control    = 1'b0;
	ready_data       = 1'b0;

	if(counter_neg[5:0] == 6'd4 && !posedge_p)
	begin
		ready_control = 1'b1;
	end
	else if(counter_neg[5:0] == 6'd32 && !posedge_p)
	begin
		ready_data       = 1'b1;
	end
end


always@(*)
begin
	ready_control_p    = 1'b0;
	ready_data_p       = 1'b0;

	if(counter_neg[5:0] == 6'd4 && posedge_p)
	begin
		ready_control_p = 1'b1;
	end
	else if(counter_neg[5:0] == 6'd32 && posedge_p)
	begin
		ready_data_p       = 1'b1;
	end
end

always@(*)
begin
	posedge_p = 1'b0;

	if(rx_din ^ rx_sin)
	begin
		posedge_p = 1'b1;
	end
	else
	begin
		posedge_p = 1'b0;
	end
end

always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_d_1  <= 1'b0;
		bit_d_3  <= 1'b0;
		bit_d_5  <= 1'b0;
		bit_d_7  <= 1'b0;
		bit_d_9  <= 1'b0;
	end
	else
	begin
		bit_d_1  <= rx_din;
		bit_d_3  <= bit_d_1;
		bit_d_5  <= bit_d_3;
		bit_d_7  <= bit_d_5;
		bit_d_9  <= bit_d_7;
	end

end

always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_d_0 <= 1'b0;
		bit_d_2 <= 1'b0;
		bit_d_4 <= 1'b0;
		bit_d_6 <= 1'b0;
		bit_d_8 <= 1'b0;

	end
	else
	begin
		bit_d_0 <= rx_din;
		bit_d_2 <= bit_d_0;
		bit_d_4 <= bit_d_2;
		bit_d_6 <= bit_d_4;
		bit_d_8 <= bit_d_6;
	end
end

always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_c_1   <= 1'b0;
		bit_c_3   <= 1'b0;
	end
	else
	begin
		bit_c_1 <= rx_din;
		bit_c_3 <= bit_c_1;
	end

end

always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_c_0   <= 1'b0;
		bit_c_2   <= 1'b0;
	end
	else
	begin
		bit_c_0 <= rx_din;
		bit_c_2 <= bit_c_0;
	end
end

always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		rx_got_fct        <= 1'b0;
	end
	else
	begin	
		if(control_l_r[2:0] != 3'd7 && control[2:0] == 3'd4 && (ready_control_p_r))
		begin
			rx_got_fct        <= 1'b1;
		end
		else
		begin
			rx_got_fct        <= 1'b0;
		end
	end
end

always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		rx_got_null 	  <= 1'b0;
		rx_got_nchar 	  <= 1'b0;
		rx_got_time_code  <= 1'b0;
	end
	else
	begin
		if(last_is_data == 1'b1 )
		begin
			rx_got_nchar 	  <= 1'b1;
		end
		else if(last_is_timec  == 1'b1)
		begin
			rx_got_time_code  <= 1'b1;
		end
		else if(last_is_control == 1'b1)
		begin
			rx_got_null 	  <= 1'b1;
		end
		else
		begin
			rx_got_null 	  <= 1'b0;
			rx_got_nchar 	  <= 1'b0;
			rx_got_time_code  <= 1'b0;
		end
	end
end

always@(posedge negedge_clk or negedge rx_resetn)
begin
	if(!rx_resetn)
	begin
		rx_got_fct_fsm  <=  1'b0;
		ready_control_p_r <= 1'b0;
		ready_data_p_r  <=  1'b0;

	end
	else
	begin

		if(ready_control || ready_control_p)
		begin
			if(is_control)
				ready_control_p_r <= 1'b1;
			else
				ready_control_p_r <= 1'b0;
		end
		else
		begin
			ready_control_p_r <= 1'b0;
		end

		if(ready_data || ready_data_p)
		begin
			if(!is_control)
				ready_data_p_r <= 1'b1;
			else
				ready_data_p_r <= 1'b0;
		end
		else
		begin
			ready_data_p_r <= 1'b0;
		end

		if((control_l_r[2:0] != 3'd7 && control[2:0] == 3'd4 && last_is_control == 1'b1 ) == 1'b1)
			rx_got_fct_fsm <= 1'b1;
		else
			rx_got_fct_fsm <= rx_got_fct_fsm;
	end
end

always@(posedge ready_control or negedge rx_resetn )
begin
	if(!rx_resetn)
	begin
		control_r	   	<= 4'd0;
		parity_rec_c 	  	<= 1'b0;
	end
	else
	begin
		control_r	  <= {bit_c_3,bit_c_2,bit_c_1,bit_c_0};
		parity_rec_c	  <= bit_c_3;
	end
end

always@(posedge ready_control_p or negedge rx_resetn )
begin
	if(!rx_resetn)
	begin
		control_p_r	   	<= 4'd0;
		
	end
	else
	begin
		control_p_r	  <= control_r;
	end
end



always@(posedge ready_data or negedge rx_resetn )
begin
	if(!rx_resetn)
	begin
		dta_timec	   	<= 10'd0;
		parity_rec_d 	  	<= 1'b0;
	end
	else
	begin
		dta_timec	  <= {bit_d_9,bit_d_8,bit_d_0,bit_d_1,bit_d_2,bit_d_3,bit_d_4,bit_d_5,bit_d_6,bit_d_7};
		parity_rec_d 	  <= bit_d_9;
	end
end


always@(posedge ready_data_p or negedge rx_resetn )
begin
	if(!rx_resetn)
	begin
		dta_timec_p	   	<= 10'd0;
	end
	else
	begin
		dta_timec_p  <= dta_timec;
	end
end

always@(posedge ready_data_p or negedge rx_resetn )
begin

	if(!rx_resetn)
	begin
		rx_error_d <= 1'b0;
	end
	else
	begin
		if(last_is_control)
		begin
			if(!(dta_timec[8]^control[0]^control[1]) != parity_rec_d)
			begin
				rx_error_d <= 1'b1;
			end
		end
		else if(last_is_data)
		begin
			if(!(dta_timec[8]^data[7]^data[6]^data[5]^data[4]^data[3]^data[2]^data[1]^data[0]) != parity_rec_d)
			begin
				rx_error_d <= 1'b1;
			end
		end
	end
end

always@(posedge ready_control_p or negedge rx_resetn )
begin

	if(!rx_resetn)
	begin
		rx_error_c <= 1'b0;
		
	end
	else
	begin
		if(last_is_control)
		begin
			if(!(control_r[2]^control[0]^control[1]) != parity_rec_c)
			begin
				rx_error_c <= 1'b1;
			end
		end
		else if(last_is_data)
		begin
			if(!(control_r[2]^data[7]^data[6]^data[5]^data[4]^data[3]^data[2]^data[1]^data[0]) != parity_rec_c)
			begin
				rx_error_c <= 1'b1;
			end
		end
	end
	
end

always@(posedge negedge_clk or negedge rx_resetn)
begin
	
	if(!rx_resetn)
	begin
		rx_buffer_write <= 1'b0;
		rx_tick_out 	<= 1'b0;
	end
	else
	begin

		if(!ready_control_p_r && !ready_data_p_r && !ready_control && !ready_data)
		begin	
			if(last_is_timec == 1'b1)
			begin
				rx_tick_out  <= 1'b1;
			end
			else if(last_is_data == 1'b1)
			begin
				rx_buffer_write <= 1'b1;
			end
			else if(last_is_control == 1'b1)
			begin
				if(control[2:0] == 3'd6)
				begin
					rx_buffer_write <= 1'b1;
				end
				else if(control[2:0] == 3'd5)
				begin
					rx_buffer_write <= 1'b1;
				end				
			end
		end
		else
		begin
			rx_buffer_write <= 1'b0;
			rx_tick_out 	<= 1'b0;
		end
	end
end


always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		is_control <= 1'b0;
		control_bit_found <= 1'b0;
		counter_neg[5:0]  <= 6'd1;
	end
	else
	begin

		control_bit_found <= rx_din;

		case(counter_neg)
		6'd1:
		begin
			counter_neg[5:0]  <=  6'd2;
		end
		6'd2:
		begin
			if(control_bit_found == 1'b1)
			begin
				is_control  <= 1'b1;	
			end
			else 
			begin
				is_control  <= 1'b0;
			end

			counter_neg[5:0] <= 6'd4;
		end
		6'd4:
		begin
			if(is_control == 1'b1)
			begin		
				counter_neg[5:0] <= 6'd2;
				is_control <= 1'b0;
			end
			else
			begin
				counter_neg[5:0] <= 6'd8;
			end
		end
		6'd8:
		begin
			counter_neg[5:0] <= 6'd16;
		end
		6'd16:
		begin
			counter_neg[5:0] <= 6'd32;
		end 
		6'd32:
		begin
			is_control <= 1'b0;
			counter_neg[5:0] <= 6'd2;
		end
		default:
		begin
			is_control <= is_control;
			counter_neg[5:0] <= counter_neg[5:0];	
		end
		endcase

	end
end

always@(*)
begin

	next_state_data_process = state_data_process;

	case(state_data_process)
	2'd0:
	begin
		if(ready_control_p_r || ready_data_p_r)
		begin
			next_state_data_process = 2'd1;
		end
		else 
		begin
			next_state_data_process = 2'd0;
		end
	end
	2'd1:
	begin
		next_state_data_process = 2'd0;
	end
	default:
	begin
		next_state_data_process = 2'd0;
	end
	endcase
end


always@(posedge negedge_clk or negedge rx_resetn )
begin

	if(!rx_resetn)
	begin
		control_l_r      <= 4'd0;
		control	   	 <= 4'd0;
		data 	         <=  10'd0;

		last_is_control  <=  1'b0;
		last_is_data 	 <=  1'b0;
		last_is_timec 	 <=  1'b0;

		rx_data_flag     <=  9'd0; 
		timecode    	 <=  10'd0;

		state_data_process <= 2'd0;
	end
	else
	begin

		state_data_process <= next_state_data_process;

		case(state_data_process)
		2'd0:
		begin

			if(ready_control_p_r)
			begin
				control 	 <= control_p_r;
				control_l_r 	 <= control;

				if(control_p_r[2:0] == 3'd6)
				begin
					rx_data_flag <= 9'd257;
				end
				else if(control_p_r[2:0] == 3'd5)
				begin
					rx_data_flag <= 9'd256;
				end
				else
				begin
					rx_data_flag <= rx_data_flag;
				end

				last_is_control 	 <= 1'b1;
				last_is_data    	 <= 1'b0;
				last_is_timec   	 <= 1'b0;

			end
			else if(ready_data_p_r)
			begin
				if(control[2:0] != 3'd7)
				begin
					data        	<= {dta_timec_p[9],dta_timec_p[8],dta_timec_p[7],dta_timec_p[6],dta_timec_p[5],dta_timec_p[4],dta_timec_p[3],dta_timec_p[2],dta_timec_p[1],dta_timec_p[0]};
					rx_data_flag	<= {dta_timec_p[8],dta_timec_p[7],dta_timec_p[6],dta_timec_p[5],dta_timec_p[4],dta_timec_p[3],dta_timec_p[2],dta_timec_p[1],dta_timec_p[0]};					
					last_is_control  	<=1'b0;
					last_is_data     	<=1'b1;
					last_is_timec    	<=1'b0;
				end
				else if(control[2:0] == 3'd7)
				begin
					timecode     <=  {dta_timec_p[9],dta_timec_p[8],dta_timec_p[7],dta_timec_p[6],dta_timec_p[5],dta_timec_p[4],dta_timec_p[3],dta_timec_p[2],dta_timec_p[1],dta_timec_p[0]};
					last_is_control  	<= 1'b0;
					last_is_data     	<= 1'b0;
					last_is_timec    	<= 1'b1;
				end
			end
			else
			begin
				timecode    	<= timecode;
			end
			
		end
		2'd1:
		begin
				rx_data_flag	<= rx_data_flag;
				timecode    	<= timecode;
		end
		default:
		begin
				rx_data_flag	<= rx_data_flag;
				timecode    	<= timecode;
			
		end
		endcase	
	end
end

endmodule
