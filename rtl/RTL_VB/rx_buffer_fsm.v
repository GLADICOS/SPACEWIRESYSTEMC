module rx_buffer_fsm (
			input posedge_clk,
			input rx_resetn,
			
			input last_is_data,
			input last_is_timec,
			input last_is_control,

			output reg rx_got_null,
			output reg rx_got_nchar,
			output reg rx_got_time_code
		     );

always@(posedge posedge_clk or negedge rx_resetn)
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
			rx_got_null 	  <= 1'b0;
			rx_got_nchar 	  <= 1'b1;
			rx_got_time_code  <= 1'b0;
		end
		else if(last_is_timec  == 1'b1)
		begin
			rx_got_null 	  <= 1'b0;
			rx_got_nchar 	  <= 1'b0;
			rx_got_time_code  <= 1'b1;
		end
		else if(last_is_control == 1'b1)
		begin
			rx_got_null 	  <= 1'b1;
			rx_got_nchar 	  <= 1'b0;
			rx_got_time_code  <= 1'b0;
		end
		else
		begin
			rx_got_null 	  <= 1'b0;
			rx_got_nchar 	  <= 1'b0;
			rx_got_time_code  <= 1'b0;
		end
	end
end

endmodule
