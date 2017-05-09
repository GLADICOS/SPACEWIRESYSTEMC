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
								output [13:0] info
							 );
			
	reg rx_error;
	wire rx_got_bit;
	reg rx_got_null;
	reg rx_got_nchar;
	reg rx_got_time_code;
	reg rx_got_fct;
			
	reg  [4:0] counter_neg;

	wire posedge_clk;
	wire negedge_clk;

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
	reg is_data;

	reg last_is_control;
	reg last_is_data;
	reg last_is_timec;

	reg last_was_control;
	reg last_was_data;
	reg last_was_timec;

	reg [3:0] control;
	reg [3:0] control_r;
	reg [9:0] data;
	reg [9:0] timecode;

	reg [9:0] dta_timec;

	reg [3:0] control_l_r;
	reg [9:0] data_l_r;

	//reg parity_error;
	//wire check_c_d;

	reg rx_data_take;

	reg first_time;

	reg ready_control;
	reg ready_data;

	//CLOCK RECOVERY
	assign posedge_clk 	= (rx_din ^ rx_sin)?1'b1:1'b0;
	assign negedge_clk 	= (!first_time)?1'b0:(!(rx_din ^ rx_sin))?1'b1:1'b0;

	assign rx_got_bit       = (posedge_clk)?1'b1:1'b0;
	
	assign info = {control_l_r,control,rx_error,rx_got_bit,rx_got_null,rx_got_nchar,rx_got_time_code,rx_got_fct}; 

always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_c_1 <= 1'b0;
		bit_c_3 <= 1'b0;

		bit_d_1 <= 1'b0;
		bit_d_3 <= 1'b0;
		bit_d_5 <= 1'b0;
		bit_d_7 <= 1'b0;
		bit_d_9 <= 1'b0;
		first_time <= 1'b0;
	end
	else
	begin
		bit_c_1 <= rx_din;
		bit_c_3 <= bit_c_1;

		bit_d_1 <= rx_din;
		bit_d_3 <= bit_d_1;
		bit_d_5 <= bit_d_3;
		bit_d_7 <= bit_d_5;
		bit_d_9 <= bit_d_7;
		first_time <= 1'b1;

	end

end

always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_c_0 <= 1'b0;
		bit_c_2 <= 1'b0;

		bit_d_0 <= 1'b0;
		bit_d_2 <= 1'b0;
		bit_d_4 <= 1'b0;
		bit_d_6 <= 1'b0;
		bit_d_8 <= 1'b0;
	end
	else
	begin
	
		if(!first_time)
		begin
		end
		else
		begin
			bit_c_0 <= rx_din;
			bit_c_2 <= bit_c_0;

			bit_d_0 <= rx_din;
			bit_d_2 <= bit_d_0;
			bit_d_4 <= bit_d_2;
			bit_d_6 <= bit_d_4;
			bit_d_8 <= bit_d_6;
		end
	end
end


always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		is_control <= 1'b0;
		is_data    <= 1'b0;

		counter_neg <= 5'd0;
	end
	else
	begin
		if(!first_time)
		begin
		end
		else
		begin
			if(counter_neg == 5'd1)
			begin
				if(bit_c_0)
				begin
					is_control <= 1'b1;
					is_data    <= 1'b0;
				end
				else
				begin
					is_control <= 1'b0;
					is_data    <= 1'b1;
				end

				counter_neg <= counter_neg + 5'd1;

			end
			else
			begin
				if(is_control)
				begin
					if(counter_neg == 5'd2)
					begin
						counter_neg <= 5'd1;
						is_control  <= 1'b0;
					end
					else
						counter_neg <= counter_neg + 5'd1;
				end
				else if(is_data)
				begin
					if(counter_neg == 5'd5)
					begin
						counter_neg <= 5'd1;
						is_data     <= 1'b0;
					end
					else
						counter_neg <= counter_neg + 5'd1;
				end
				else
				begin
					counter_neg <= counter_neg + 5'd1;
				end
			end	
		end
	end
end


always@(*)
begin

	rx_got_fct = 1'b0;

	if(control_l_r[2:0] != 3'd7 && control[2:0] == 3'd4 && ready_control)
	begin
		rx_got_fct = 1'b1;
	end
	else
	begin
		rx_got_fct = 1'b0;
	end

end

always@(*)
begin

	rx_got_null = 1'b0;

	if(control_l_r[2:0] == 3'd7 && control[2:0] == 3'd4 && ready_control)
	begin
		rx_got_null = 1'b1;
	end
end

always@(*)
begin

	rx_got_time_code = 1'b0;
	rx_got_nchar = 1'b0;

 	if(control[2:0] != 3'd7 && is_data )
	begin
		rx_got_nchar = 1'b1;
	end
	
	if(control[2:0] == 3'd7 && is_data)
	begin
		rx_got_time_code = 1'b1;
	end
	
end

always@(counter_neg)
begin

	dta_timec     = 10'd0;
	control_r     = 4'd0;
	ready_control = 1'b0;
	ready_data    = 1'b0;

	if(negedge_clk)
		begin
		if(counter_neg == 5'd2 && bit_c_2)
		begin
			control_r     = {bit_c_3,bit_c_2,bit_c_1,bit_c_0};
			ready_control = 1'b1;
			ready_data    = 1'b0;
		end
		else if(counter_neg == 5'd5)
		begin
			dta_timec     = {bit_d_9,bit_d_8,bit_d_0,bit_d_1,bit_d_2,bit_d_3,bit_d_4,bit_d_5,bit_d_6,bit_d_7};
			ready_control = 1'b0;
			ready_data    = 1'b1;
		end
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
		
		//rx_error  	 <= 1'b0;
		//rx_got_null 	 <= 1'b0;
		//rx_got_nchar 	 <= 1'b0;
		//rx_got_time_code <= 1'b0;
		//rx_got_fct 	 <= 1'b0;

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
			end
			else if(last_was_timec)
			begin
				if(!(control[2]^timecode[0]^timecode[1]^timecode[2]^timecode[3]^timecode[4]^timecode[5]^timecode[6]^timecode[7])  != control[3])
				begin
					rx_error <= 1'b1;
				end
			end
			else if(last_was_data)
			begin
				if(!(control[2]^data[0]^data[1]^data[2]^data[3]^data[4]^data[5]^data[6]^data[7]) != control[3])
				begin
					rx_error <= 1'b1;
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
			end
			else if(last_was_timec)
			begin
				if(!(data[8]^timecode[0]^timecode[1]^timecode[2]^timecode[3]^timecode[4]^timecode[5]^timecode[6]^timecode[7])  != data[9])
				begin
					rx_error <= 1'b1;
				end
			end
			else if(last_was_data)
			begin
				if(!(data[8]^data[0]^data_l_r[1]^data_l_r[2]^data_l_r[3]^data_l_r[4]^data_l_r[5]^data_l_r[6]^data_l_r[7]) != data[9])
				begin
					rx_error <= 1'b1;
				end
			end
		end

		if((control_r[2:0] != 3'd7 && is_data) == 1'b1)
		begin

			data        	 	<= dta_timec;
			data_l_r    	 	<= data;
			
			//rx_data_take <= 1'b1;
			//rx_tick_out  <= 1'b0;

			last_is_control  	<=1'b0;
			last_is_data     	<=1'b1;
			last_is_timec    	<=1'b0;
			last_was_control 	<= last_is_control;
			last_was_data    	<= last_is_data ;
			last_was_timec 		<= last_is_timec;
		end
		else if((control_r[2:0] == 3'd7 && is_data) == 1'b1)
		begin

			timecode    		 <= dta_timec;
			//rx_tick_out  <= 1'b1;
			//rx_data_take <= 1'b0;

			last_is_control  	<= 1'b0;
			last_is_data     	<= 1'b0;
			last_is_timec    	<= 1'b1;
			last_was_control 	<= last_is_control;
			last_was_data    	<= last_is_data ;
			last_was_timec   	<= last_is_timec;
		end
		else if((control_r == 4'd6 || control_r == 4'd13 || control_r == 4'd5 || control_r == 4'd15 || control_r == 4'd7 || control_r == 4'd4 || control_r == 4'd12) && ready_control)
		begin

			control     	 <= control_r;
			control_l_r 	 <= control[3:0];

			if((control[2:0] == 3'd6) == 1'b1 )
			begin
				data <= 10'b0100000001;
				//rx_data_take <= 1'b1;
			end
			else if(  (control[2:0] == 3'd5 ) == 1'b1 )
			begin
				data <= 10'b0100000000;
			//	rx_data_take <= 1'b1;
			end
			else
			begin
			//	rx_data_take 	<= 1'b0;
			end

			//rx_tick_out  <= 1'b0;

			last_is_control 	 <= 1'b1;
			last_is_data    	 <= 1'b0;
			last_is_timec   	 <= 1'b0;
			last_was_control	 <= last_is_control;
			last_was_data    	 <= last_is_data ;
			last_was_timec   	 <= last_is_timec;
		end
	end
end					 
							 
endmodule
