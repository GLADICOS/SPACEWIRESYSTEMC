module tx_data_0_transp(
			input [9:0]  global_counter_transfer_data_0,
			input [5:0]  last_type_data_0,
			input [6:0]  state_tx_data_0,
			input        txdata_flagctrl_tx_last,
			input        last_timein_control_flag_tx,

			input [8:0] tx_data_in_0,

			input last_tx_dout_data_0,
			input last_tx_sout_data_0,

			output reg tx_dout_data_0,
			output reg tx_sout_data_0
		     );

localparam [6:0] tx_spw_start              = 7'b0000000,
	   	 tx_spw_null               = 7'b0000001,
	   	 tx_spw_fct                = 7'b0000010,
	   	 tx_spw_null_c             = 7'b0000100,
	   	 tx_spw_fct_c              = 7'b0001000,
	   	 tx_spw_data_c             = 7'b0010000,
	   	 tx_spw_data_c_0           = 7'b0100000,
	   	 tx_spw_time_code_c        = 7'b1000000/* synthesis dont_replicate */;

localparam [7:0] null_s = 8'b01110100;
localparam [2:0] fct_s  = 3'b100;
localparam [3:0] eop_s  = 4'b0101;
localparam [3:0] eep_s  = 4'b0110;
localparam [13:0] timecode_ss    = 14'b01110000000000/* synthesis dont_replicate */;

localparam [5:0] NULL     = 6'b000001,
		 FCT      = 6'b000010,
		 EOP      = 6'b000100,
		 EEP      = 6'b001000,
		 DATA     = 6'b010000,
		 TIMEC    = 6'b100000/* synthesis dont_replicate */;

always@(*)
begin

	tx_dout_data_0      = 1'b0;

		case(state_tx_data_0)
		tx_spw_start:
		begin
		end
		tx_spw_null,tx_spw_null_c:
		begin
		end
		tx_spw_fct,tx_spw_fct_c:
		begin
		end
	   	tx_spw_data_c:
		begin
		end
	   	tx_spw_data_c_0:
		begin

			case(tx_data_in_0[8])
			1'b0:
			begin
				case(global_counter_transfer_data_0)
				10'd1:
				begin
					if(last_type_data_0 == NULL)
					 begin
						tx_dout_data_0 = !(tx_data_in_0[8]^null_s[0]^null_s[1]);
					 end
					 else if(last_type_data_0 == FCT)
					 begin
						tx_dout_data_0 = !(tx_data_in_0[8]^fct_s[0]^fct_s[1]);
					 end
					 else if(last_type_data_0 == EOP)
					 begin
						tx_dout_data_0 = !(tx_data_in_0[8]^eop_s[0]^eop_s[1]);
					 end
					 else if(last_type_data_0 == EEP)
					 begin
						tx_dout_data_0 = !(tx_data_in_0[8]^eep_s[0]^eep_s[1]);
					 end
					 else if(last_type_data_0 == DATA)
					 begin
						tx_dout_data_0 = !(tx_data_in_0[8]^txdata_flagctrl_tx_last);
					 end
					 else if(last_type_data_0 == TIMEC)
					 begin
						tx_dout_data_0 = !(tx_data_in_0[8]^last_timein_control_flag_tx);
					 end
				end
				10'd2:
				begin
					tx_dout_data_0 = tx_data_in_0[8];
				end
				10'd4:
				begin
					tx_dout_data_0 = tx_data_in_0[0];
				end
				10'd8:
				begin
					tx_dout_data_0 = tx_data_in_0[1];
				end
				10'd16:
				begin
					tx_dout_data_0 = tx_data_in_0[2];
				end
				10'd32:
				begin
					tx_dout_data_0 = tx_data_in_0[3];
				end
				10'd64:
				begin
					tx_dout_data_0 = tx_data_in_0[4];
				end
				10'd128:
				begin
					tx_dout_data_0 = tx_data_in_0[5];
				end
				10'd256:
				begin
					tx_dout_data_0 = tx_data_in_0[6];
				end
				10'd512:
				begin
					tx_dout_data_0 = tx_data_in_0[7];
				end
				endcase
			end
			1'b1:
			begin
				case(tx_data_in_0[1:0])
				2'd0:
				begin
					case(global_counter_transfer_data_0[3:0])
					4'd1:
					begin
						 if(last_type_data_0 == NULL)
						 begin
							tx_dout_data_0 = !(eop_s[2]^null_s[0]^null_s[1]);
						 end
						 else if(last_type_data_0 == FCT)
						 begin
							tx_dout_data_0 = !(eop_s[2]^fct_s[0]^fct_s[1]);
						 end
						 else if(last_type_data_0 == EOP)
						 begin
							tx_dout_data_0 = !(eop_s[2]^eop_s[0]^eop_s[1]);
						 end
						 else if(last_type_data_0 == EEP)
						 begin
							tx_dout_data_0 = !(eop_s[2]^eep_s[0]^eep_s[1]);
						 end
						 else if(last_type_data_0 == DATA)
						 begin
							tx_dout_data_0 = !(eop_s[2]^txdata_flagctrl_tx_last);
						 end
						 else if(last_type_data_0 == TIMEC)
						 begin
							tx_dout_data_0 = !(eop_s[2]^last_timein_control_flag_tx);
						 end
					end
					4'd2:
					begin
						tx_dout_data_0 = eop_s[2];
					end
					4'd4:
					begin
						tx_dout_data_0 = eop_s[1];
					end
					4'd8:
					begin
						tx_dout_data_0 = eop_s[0];
					end
					endcase
				end
				2'd1:
				begin

					case(global_counter_transfer_data_0[3:0])
					4'd1:
					begin
						 if(last_type_data_0 == NULL)
						 begin
							tx_dout_data_0 = !(eep_s[2]^null_s[0]^null_s[1]);
						 end
						 else if(last_type_data_0 == FCT)
						 begin
							tx_dout_data_0 = !(eep_s[2]^fct_s[0]^fct_s[1]);
						 end
						 else if(last_type_data_0 == EOP)
						 begin
							tx_dout_data_0 = !(eep_s[2]^eop_s[0]^eop_s[1]);
						 end
						 else if(last_type_data_0 == EEP)
						 begin
							tx_dout_data_0 = !(eep_s[2]^eep_s[0]^eep_s[1]);
						 end
						 else if(last_type_data_0 == DATA)
						 begin
							tx_dout_data_0 = !(eep_s[2]^txdata_flagctrl_tx_last);
						 end
						 else if(last_type_data_0 == TIMEC)
						 begin
							tx_dout_data_0 = !(eep_s[2]^last_timein_control_flag_tx);
						 end
					end
					4'd2:
					begin
						tx_dout_data_0 = eep_s[2];
					end
					4'd4:
					begin
						tx_dout_data_0 = eep_s[1];
					end
					4'd8:
					begin
						tx_dout_data_0 = eep_s[0];
					end
					endcase
				end
				endcase
			end
			endcase
		end
		tx_spw_time_code_c:
		begin

		end
		default:
		begin
		end
		endcase
end

always@(*)
begin

	tx_sout_data_0  = last_tx_sout_data_0;

	case(state_tx_data_0)
	tx_spw_start:
	begin
	end
	tx_spw_null,tx_spw_null_c:
	begin
	end
	tx_spw_fct,tx_spw_fct_c:
	begin
	end
	tx_spw_data_c:
	begin
	end
	tx_spw_data_c_0:
	begin
		if(tx_dout_data_0  == last_tx_dout_data_0 )
		begin
			tx_sout_data_0  = !last_tx_sout_data_0 ;
		end
		else if(tx_dout_data_0  != last_tx_dout_data_0 )
		begin
			tx_sout_data_0  = last_tx_sout_data_0 ;	
		end
	end
	tx_spw_time_code_c:
	begin
	end
	default:
	begin
	end
	endcase
end

endmodule
