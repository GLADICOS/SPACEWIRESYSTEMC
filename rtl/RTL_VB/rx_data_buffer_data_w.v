module rx_data_buffer_data_w (
				input negedge_clk,
				input rx_resetn,

				input [1:0] state_data_process,
				input [2:0] control, 
				input last_is_timec,
				input last_is_data,
				input last_is_control,

				output reg rx_buffer_write,
				output reg rx_tick_out
			     );

always@(posedge negedge_clk or negedge rx_resetn)
begin
	
	if(!rx_resetn)
	begin
		rx_buffer_write <= 1'b0;
		rx_tick_out 	<= 1'b0;
	end
	else
	begin

		if(state_data_process == 2'd1)
		begin	
			if(last_is_timec == 1'b1)
			begin
				rx_tick_out  <= 1'b1;
				rx_buffer_write <= 1'b0;
			end
			else if(last_is_data == 1'b1)
			begin
				rx_buffer_write <= 1'b1;
				rx_tick_out 	<= 1'b0;
			end
			else if(last_is_control == 1'b1)
			begin
				if(control[2:0] == 3'd6)
				begin
					rx_buffer_write <= 1'b1;
					rx_tick_out 	<= 1'b0;
				end
				else if(control[2:0] == 3'd5)
				begin
					rx_buffer_write <= 1'b1;
					rx_tick_out 	<= 1'b0;
				end	
				else
				begin
					rx_buffer_write <= 1'b0;
					rx_tick_out 	<= 1'b0;
				end			
			end
			else
			begin
				rx_buffer_write <= 1'b0;
				rx_tick_out 	<= 1'b0;
			end
		end
		else
		begin
			rx_buffer_write <= 1'b0;
			rx_tick_out 	<= 1'b0;
		end
	end
end

endmodule
