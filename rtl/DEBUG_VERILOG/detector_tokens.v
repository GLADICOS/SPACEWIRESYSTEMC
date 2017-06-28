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
//e.g.DATA_WIDTH	[32,16]	: width of the DATA : 32:
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
module detector_tokens(
								input  rx_din,
								input  rx_sin,
								input  rx_resetn,
								//input clock_sys,
								output reg rx_buffer_write,
								output reg [13:0] info
							 );
			
	reg rx_error;
	reg rx_got_bit;
	reg rx_got_null;
	reg rx_got_nchar;
	reg rx_got_time_code;
	reg rx_got_fct;
			
	reg  [5:0] counter_neg;
	//reg  [3:0] counter_control;
	//reg  [3:0] counter_data;
	//reg  [5:0] counter_bit_found;
	reg control_bit_found;

	wire posedge_clk;
	wire negedge_clk;

	reg bit_c_0;//N
	reg bit_c_1;//P
	reg bit_c_2;//N
	reg bit_c_3;//P
	reg bit_c_ex;//P

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
	//reg bit_d_ex;//P

	reg is_control;
	reg is_data;

	reg last_is_control;
	reg last_is_data;
	reg last_is_timec;

	reg last_was_control;
	reg last_was_data;
	reg last_was_timec;

	reg [3:0] control;
	reg [3:0] control_r;
	reg [3:0] control_p_r;
	reg [9:0] data;
	reg [9:0] timecode;

	reg [9:0] dta_timec;

	reg [3:0] control_l_r;
	reg [9:0] data_l_r;

	//reg parity_error;
	//wire check_c_d;

	reg rx_data_take;
	reg rx_data_take_0;

	reg ready_control;
	reg ready_data;

	reg ready_control_p;
	reg ready_data_p;

	reg ready_control_p_r;
	reg ready_data_p_r;


	reg posedge_p;
	
	//CLOCK RECOVERY
	assign posedge_clk 	= posedge_p;
	assign negedge_clk 	= !posedge_p;

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

	if((rx_din ^ rx_sin) == 1'b1)
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
		bit_d_1 <= 1'b0;
		bit_d_3 <= 1'b0;
		bit_d_5 <= 1'b0;
		bit_d_7 <= 1'b0;
		bit_d_9 <= 1'b0;
	end
	else
	begin
		bit_d_1    <= rx_din;
		bit_d_3    <= bit_d_1;
		bit_d_5    <= bit_d_3;
		bit_d_7    <= bit_d_5;
		bit_d_9    <= bit_d_7;
	end

end

always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_c_1   <= 1'b0;
		bit_c_3   <= 1'b0;
		bit_c_ex  <= 1'b0;
	end
	else
	begin
		bit_c_1 <= rx_din;
		bit_c_3 <= bit_c_1;
		bit_c_ex <= bit_c_3;
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


always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_c_0 <= 1'b0;
		bit_c_2 <= 1'b0;
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

always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		rx_error <= 1'b0;
	end	
	else
	begin
		if(last_is_control)
		begin
			if(last_was_control)
			begin
				if(!(control[2]^control_l_r[0]^control_l_r[1]) != control[3])
				begin
					rx_error <= 1'b1;
				end
				else
				begin
					rx_error <= 1'b0;
				end
			end
			else if(last_was_timec)
			begin
				if(!(control[2]^timecode[0]^timecode[1]^timecode[2]^timecode[3]^timecode[4]^timecode[5]^timecode[6]^timecode[7])  != control[3])
				begin
					rx_error <= 1'b1;
				end
				else
				begin
					rx_error <= 1'b0;
				end
			end
			else if(last_was_data)
			begin
				if(!(control[2]^data[0]^data[1]^data[2]^data[3]^data[4]^data[5]^data[6]^data[7]) != control[3])
				begin
						rx_error <= 1'b1;
				end
				else
				begin
					rx_error <= 1'b0;
				end
			end

			end
			else if(last_is_data)
			begin
				if(last_was_control)
				begin
					if(!(data[8]^control[1]^control[0]) != data[9])
					begin
						rx_error <= 1'b1;
					end
					else
					begin
						rx_error <= 1'b0;
					end
				end
				else if(last_was_timec)
				begin
					if(!(data[8]^timecode[0]^timecode[1]^timecode[2]^timecode[3]^timecode[4]^timecode[5]^timecode[6]^timecode[7])  != data[9])
					begin
						rx_error <= 1'b1;
					end
					else
					begin
						rx_error <= 1'b0;
					end
				end
				else if(last_was_data)
				begin
					if(!(data[8]^data[0]^data_l_r[1]^data_l_r[2]^data_l_r[3]^data_l_r[4]^data_l_r[5]^data_l_r[6]^data_l_r[7]) != data[9])
					begin
						rx_error <= 1'b1;
					end
					else
					begin
						rx_error <= 1'b0;
					end
				end
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
		rx_got_fct 	  <= 1'b0;
	end
	else
	begin
		if(control_l_r[2:0] != 3'd7 && control[2:0] == 3'd4 && last_is_control)
		begin
			rx_got_fct 	  <= 1'b1;
			rx_got_null 	  <= 1'b0;
			rx_got_nchar 	  <= 1'b0;
			rx_got_time_code  <= 1'b0;			
		end
		else if(control[2:0] != 3'd7 && last_is_data)
		begin
			rx_got_nchar 	  <= 1'b1;
			rx_got_null 	  <= 1'b0;
			rx_got_time_code  <= 1'b0;			
			rx_got_fct 	  <= 1'b0;
		end
		else if(control[2:0] == 3'd7 && last_is_data)
		begin
			rx_got_time_code  <= 1'b1;
			rx_got_null 	  <= 1'b0;
			rx_got_nchar 	  <= 1'b0;			
			rx_got_fct 	  <= 1'b0;
		end
		else if(control_l_r[2:0] == 3'd7 && control[2:0] == 3'd4 && last_is_control)
		begin
			rx_got_null 	  <= 1'b1;
			rx_got_nchar 	  <= 1'b0;
			rx_got_time_code  <= 1'b0;			
			rx_got_fct 	  <= 1'b0;
		end
		else
		begin
			rx_got_null 	  <= rx_got_null;
			rx_got_nchar 	  <= rx_got_nchar;
			rx_got_time_code  <= rx_got_time_code;			
			rx_got_fct 	  <= rx_got_fct;
		end
	end
end


always@(negedge_clk or rx_resetn or rx_data_take_0 or rx_data_take)
begin
	if(!rx_resetn)
	begin
		rx_buffer_write <=  1'b0;
		rx_data_take_0  <=  1'b0;
		ready_control_p_r <= 1'b0;
		ready_data_p_r  <=  1'b0;
	end
	else
	begin

		if(ready_control || ready_control_p)
		begin
			ready_control_p_r <= 1'b1;
		end
		else
		begin
			ready_control_p_r <= 1'b0;
		end

		if(ready_data || ready_data_p)
		begin
			ready_data_p_r <= 1'b1;
		end
		else
		begin
			ready_data_p_r <= 1'b0;
		end

		rx_data_take_0 <= rx_data_take;
		rx_buffer_write  <= rx_data_take_0;
	end
end

always@(posedge ready_control or negedge rx_resetn )
begin
	if(!rx_resetn)
	begin
		control_r	   	<= 4'd0;
	end
	else
	begin
		control_r	  <= {bit_c_3,bit_c_2,bit_c_1,bit_c_0};
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

always@(posedge ready_data_p or negedge rx_resetn )
begin
	if(!rx_resetn)
	begin
		dta_timec	   	<= 10'd0;
	end
	else
	begin
		dta_timec	  <= {bit_d_9,bit_d_8,bit_d_0,bit_d_1,bit_d_2,bit_d_3,bit_d_4,bit_d_5,bit_d_6,bit_d_7};
	end
end

always@(posedge posedge_clk or negedge rx_resetn )
begin

	if(!rx_resetn)
	begin
		control	    <= 4'd0;
		control_l_r <= 4'd0;

		data 	        <= 10'd0;
		data_l_r        <= 10'd0;
		//rx_data_flag    <= 9'd0; 
		//rx_buffer_write <= 1'b0;
		//rx_data_take    <= 1'b0;

		timecode    <= 10'd0;
	//	rx_time_out <= 8'd0;
	//	rx_tick_out <= 1'b0;

		last_is_control <=1'b0;
		last_is_data 	<=1'b0;
		last_is_timec 	<=1'b0;

		last_was_control <=1'b0;
		last_was_data    <=1'b0;
		last_was_timec   <=1'b0;
		
		info 		 <= 14'd0;
		//rx_error  	 <= 1'b0;
		//rx_got_null 	 <= 1'b0;
		//rx_got_nchar 	 <= 1'b0;
		//rx_got_time_code <= 1'b0;
		//rx_got_fct 	 <= 1'b0;
				
		//meta_hold_setup    <= 1'b0;
		//meta_hold_setup_n  <= 1'b0;
		//meta_hold_setup_n_n<= 1'b0;

	end
	else
	begin

		//meta_hold_setup_n_n <= meta_hold_setup;
		//meta_hold_setup_n   <= meta_hold_setup_n_n; 

		if(ready_control_p_r)
		begin
			control     	 <= control_r;
			control_l_r 	 <= control;
			rx_data_take <= 1'b0;
			last_is_control 	 <= 1'b1;
			last_is_data    	 <= 1'b0;
			last_is_timec   	 <= 1'b0;
			last_was_control	 <= last_is_control;
			last_was_data    	 <= last_is_data ;
			last_was_timec   	 <= last_is_timec;

			//info <= {control_l_r,control,rx_error,rx_got_bit,rx_got_null,rx_got_nchar,rx_got_time_code,rx_got_fct};

		end	
		else if(ready_data_p_r)
		begin
			rx_data_take <= 1'b0;
			if(control[2:0] != 3'd7)
			begin
				data        	<= dta_timec;
				last_is_control  	<=1'b0;
				last_is_data     	<=1'b1;
				last_is_timec    	<=1'b0;
				last_was_control 	<= last_is_control;
				last_was_data    	<= last_is_data ;
				last_was_timec 		<= last_is_timec;
			end
			else if(control[2:0] == 3'd7)
			begin
				timecode    	<= dta_timec;
				last_is_control  	<= 1'b0;
				last_is_data     	<= 1'b0;
				last_is_timec    	<= 1'b1;
				last_was_control 	<= last_is_control;
				last_was_data    	<= last_is_data ;
				last_was_timec   	<= last_is_timec;
			end

			//info <= {control_l_r,control,rx_error,rx_got_bit,rx_got_null,rx_got_nchar,rx_got_time_code,rx_got_fct};
		end
		else if(last_is_data)
		begin

			data_l_r    	 	<= data;
					
			info <= {control_l_r,control,rx_error,rx_got_bit,rx_got_null,rx_got_nchar,rx_got_time_code,rx_got_fct};		

			rx_data_take <= 1'b1;
			//rx_tick_out  <= 1'b0;
							
			//meta_hold_setup  <= 1'b0;
		end
		else if(last_is_timec)
		begin
			//rx_tick_out  <= 1'b1;
			rx_data_take <= 1'b1;

			info <= {control_l_r,control,rx_error,rx_got_bit,rx_got_null,rx_got_nchar,rx_got_time_code,rx_got_fct};							
			
			//meta_hold_setup  <= 1'b0;
		end
		else if(last_is_control)
		begin

			info <= {control_l_r,control,rx_error,rx_got_bit,rx_got_null,rx_got_nchar,rx_got_time_code,rx_got_fct};
			
			rx_data_take 	<= 1'b1;

			if((control[2:0] == 3'd6) == 1'b1 )
			begin
				data <= 10'b0100000001;
			end
			else if(  (control[2:0] == 3'd5 ) == 1'b1 )
			begin
				data <= 10'b0100000000;
			end

		end
		else
			info <= {control_l_r,control,rx_error,rx_got_bit,rx_got_null,rx_got_nchar,rx_got_time_code,rx_got_fct};
		
	end
end					 
							 
endmodule
