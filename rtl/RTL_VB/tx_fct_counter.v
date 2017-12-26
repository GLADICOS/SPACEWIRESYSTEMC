module tx_fct_counter(
			input pclk_tx,
			input enable_tx,

			input gotfct_tx,
			input char_sent,

			output reg [5:0] fct_counter_p
		     );


	reg  [2:0] state_fct_receive/* synthesis dont_replicate */;
	reg  [2:0] next_state_fct_receive/* synthesis dont_replicate */;

	reg  [2:0] state_fct_p/* synthesis dont_replicate */;
	reg  [2:0] next_state_fct_p/* synthesis dont_replicate */;

	reg [5:0] fct_counter_receive;

	reg clear_reg;

always@(*)
begin
	next_state_fct_receive = state_fct_receive;

	case(state_fct_receive)
	3'd0:
	begin
		if(gotfct_tx)
		begin
			next_state_fct_receive = 3'd1;
		end
		else if(clear_reg)
		begin
			next_state_fct_receive = 3'd3;
		end
		else 
			next_state_fct_receive = 3'd0;
	end
	3'd1:
	begin

		next_state_fct_receive = 3'd2;
	end
	3'd2:
	begin
		if(gotfct_tx)
		begin
			next_state_fct_receive = 3'd2;
		end
		else 
		begin
			next_state_fct_receive = 3'd0;
		end
	end
	3'd3:
	begin
		next_state_fct_receive = 3'd4;
	end
	3'd4:
	begin
		if(clear_reg)
		begin
			next_state_fct_receive = 3'd4;
		end
		else 
		begin
			next_state_fct_receive = 3'd0;
		end
	end
	default:
	begin
		next_state_fct_receive = 3'd0;
	end
	endcase
end


always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin
		fct_counter_receive<= 6'd0;
		state_fct_receive <= 3'd0;
	end
	else
	begin

		state_fct_receive <= next_state_fct_receive;

		case(state_fct_receive)
		3'd0:
		begin
			fct_counter_receive <= fct_counter_receive;
		end
		3'd1:
		begin
			fct_counter_receive <= fct_counter_receive + 6'd8;
		end
		3'd2:
		begin
			fct_counter_receive <= fct_counter_receive;
		end
		3'd3:
		begin
			fct_counter_receive <= fct_counter_receive;
		end
		3'd4:
		begin
			fct_counter_receive <= 6'd0;
		end
		default:
		begin
			fct_counter_receive <= fct_counter_receive;
		end
		endcase
	end
end



always@(*)
begin
	next_state_fct_p = state_fct_p;

	case(state_fct_p)
	3'd0:
	begin
		if(fct_counter_receive == 6'd56)
		begin
			next_state_fct_p = 3'd1;
		end
		else 
			next_state_fct_p = 3'd0;
	end
	3'd1:
	begin
		next_state_fct_p = 3'd2;
	end
	3'd2:
	begin
		if(char_sent)
			next_state_fct_p = 3'd3;
		else
			next_state_fct_p = 3'd2;
	end
	3'd3:
	begin
		if(!char_sent)
			next_state_fct_p = 3'd4;
		else
			next_state_fct_p = 3'd3;
	end
	3'd4:
	begin
		if(fct_counter_p == 6'd0)
			next_state_fct_p = 3'd0;
		else if(fct_counter_p > 6'd0)
			next_state_fct_p = 3'd2;
		else
			next_state_fct_p = 3'd4;
	end
	default:
	begin
		next_state_fct_p = 3'd0;
	end
	endcase
end


always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin
		fct_counter_p<= 6'd0;
		state_fct_p  <= 3'd0;
		clear_reg <= 1'b0;
	end
	else
	begin

		state_fct_p <= next_state_fct_p;

		case(state_fct_p)
		3'd0:
		begin
			clear_reg <= 1'b0;
			fct_counter_p <= fct_counter_p;
		end
		3'd1:
		begin
			fct_counter_p <= fct_counter_receive;
			clear_reg <= 1'b1;
		end
		3'd2:
		begin
			clear_reg <= 1'b0;
			fct_counter_p <= fct_counter_p;
		end
		3'd3:
		begin
			clear_reg <= 1'b0;
			if(!char_sent)
			begin
				if(fct_counter_p == 6'd0)
					fct_counter_p <= fct_counter_p;
				else
					fct_counter_p <= fct_counter_p - 6'd1;
			end
			else
				fct_counter_p <= fct_counter_p;
		end
		3'd4:
		begin
			clear_reg <= 1'b0;
			fct_counter_p <= fct_counter_p;
		end
		default:
		begin
			fct_counter_p <= fct_counter_p;
		end
		endcase
	end
end
endmodule
