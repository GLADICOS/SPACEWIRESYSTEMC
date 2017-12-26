module rx_control_data_rdy(
				input posedge_clk,
				input rx_resetn,

				input rx_error_c,
				input rx_error_d,

				input [2:0] control,
				input [2:0] control_l_r,

				input is_control,
				input [5:0] counter_neg,
				input last_is_control,

				output reg rx_error,
				output reg ready_control_p_r,
				output reg ready_data_p_r,
				output reg rx_got_fct_fsm
			  );

always@(posedge posedge_clk or negedge rx_resetn)
begin
	if(!rx_resetn)
	begin
		rx_got_fct_fsm  <=  1'b0;
		ready_control_p_r <= 1'b0;
		ready_data_p_r  <=  1'b0;
		rx_error <= 1'b0;
	end
	else
	begin

		rx_error <= rx_error_c | rx_error_d;

		if(counter_neg == 6'd4 && is_control)
		begin
			ready_control_p_r <= 1'b1;
			ready_data_p_r <= 1'b0;
		end
		else if(counter_neg  == 6'd32)
		begin
			ready_control_p_r <= 1'b0;
			ready_data_p_r <= 1'b1;
		end
		else
		begin
			ready_control_p_r <= 1'b0;
			ready_data_p_r <= 1'b0;
		end

		if((control_l_r[2:0] != 3'd7 && control[2:0] == 3'd4 && last_is_control == 1'b1 ) == 1'b1)
			rx_got_fct_fsm <= 1'b1;
		else
			rx_got_fct_fsm <= rx_got_fct_fsm;
	end
end

endmodule
