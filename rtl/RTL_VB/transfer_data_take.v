module transfer_data_take(
				input pclk_tx,
				input enable_tx,
				input send_null_tx,

				input [6:0] state_tx,

				input tx_data_in,
				input tx_data_in_0,

				output reg [13:0] global_counter_transfer_data_take /* synthesis syn_replicate = 1 */
			 );


localparam [6:0] tx_spw_start              = 7'b0000000,
	   	 tx_spw_null               = 7'b0000001,
	   	 tx_spw_fct                = 7'b0000010,
	   	 tx_spw_null_c             = 7'b0000100,
	   	 tx_spw_fct_c              = 7'b0001000,
	   	 tx_spw_data_c             = 7'b0010000,
	   	 tx_spw_data_c_0           = 7'b0100000,
	   	 tx_spw_time_code_c        = 7'b1000000/* synthesis dont_replicate */;

always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin
		global_counter_transfer_data_take <= 14'd1;
	end
	else
	begin

		case(state_tx)
		tx_spw_start:
		begin
			if(send_null_tx && enable_tx)
			begin
				global_counter_transfer_data_take <= global_counter_transfer_data_take << 14'd1;
			end
			else
			begin
				global_counter_transfer_data_take   <= 14'd1;
			end	
		end
		tx_spw_null:
		begin


			if(global_counter_transfer_data_take == 14'd128)
			begin
				global_counter_transfer_data_take<= 14'd1;
			end
			else 
			begin		
				global_counter_transfer_data_take <= global_counter_transfer_data_take << 14'd1;
			end

		end
		tx_spw_fct:
		begin
			if(global_counter_transfer_data_take == 14'd8)
			begin		
				global_counter_transfer_data_take <= 14'd1;
			end
			else
			begin
				global_counter_transfer_data_take <= global_counter_transfer_data_take << 14'd1;
			end

		end
		tx_spw_null_c:
		begin

			if(global_counter_transfer_data_take == 14'd128)
			begin
				global_counter_transfer_data_take <= 14'd1;
			end
			else
			begin
				global_counter_transfer_data_take <= global_counter_transfer_data_take << 14'd1;
			end

		end
		tx_spw_fct_c:
		begin
			
			if(global_counter_transfer_data_take == 14'd8)
			begin
				global_counter_transfer_data_take <= 14'd1;
			end
			else
			begin
				global_counter_transfer_data_take <= global_counter_transfer_data_take << 14'd1;
			end

		end
		tx_spw_data_c:
		begin

			if(!tx_data_in)
			begin

				if(global_counter_transfer_data_take == 14'd512)
				begin
					global_counter_transfer_data_take <= 14'd1;
				end
				else
				begin
					global_counter_transfer_data_take <= global_counter_transfer_data_take << 14'd1;
				end

			end
			else
			begin

				if(global_counter_transfer_data_take == 14'd8)
				begin
					global_counter_transfer_data_take <= 14'd1;
				end
				else
				begin
					global_counter_transfer_data_take <= global_counter_transfer_data_take << 14'd1;
				end
			end

		end
		tx_spw_data_c_0:
		begin

			if(!tx_data_in_0)
			begin

				if(global_counter_transfer_data_take == 14'd512)
				begin
					global_counter_transfer_data_take <= 14'd1;
				end
				else
				begin
					global_counter_transfer_data_take <= global_counter_transfer_data_take << 14'd1;
				end

			end
			else
			begin

				if(global_counter_transfer_data_take == 14'd8)
				begin
					global_counter_transfer_data_take <= 14'd1;
				end
				else
				begin
					global_counter_transfer_data_take <= global_counter_transfer_data_take << 14'd1;
				end
			end

		end
		tx_spw_time_code_c:
		begin

			if(global_counter_transfer_data_take == 14'd8192)
			begin
				global_counter_transfer_data_take <= 14'd1;
			end
			else
			begin
				global_counter_transfer_data_take <= global_counter_transfer_data_take << 14'd1;
			end

		end
		default:
		begin
			global_counter_transfer_data_take <= global_counter_transfer_data_take;
		end
		endcase
	end
end


endmodule
