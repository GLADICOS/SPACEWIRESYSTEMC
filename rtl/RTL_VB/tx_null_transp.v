module tx_null_transp(

			input [7:0] global_counter_transfer_null,
			input [5:0]  last_type_null,
			input [6:0]  state_tx_null,
			input 	     txdata_flagctrl_tx_last,
			input        last_timein_control_flag_tx,

			input last_tx_dout_null,
			input last_tx_sout_null,

			output reg tx_dout_null,
			output reg tx_sout_null
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

	tx_dout_null      = 1'b0;

	case(state_tx_null)
	tx_spw_start:
	begin
	end
	tx_spw_null,tx_spw_null_c:
	begin
		case(global_counter_transfer_null)
		8'd1:
		begin
			 if(last_type_null == NULL)
			 begin
				tx_dout_null = !(null_s[6]^null_s[0]^null_s[1]);
			 end
			 else if(last_type_null == FCT)
			 begin
				tx_dout_null = !(null_s[6]^fct_s[0]^fct_s[1]);
			 end
			 else if(last_type_null == EOP)
			 begin
				tx_dout_null = !(null_s[6]^fct_s[0]^fct_s[1]);
			 end
			 else if(last_type_null == EEP)
			 begin
				tx_dout_null = !(null_s[6]^eep_s[0]^eep_s[1]);
			 end
			 else if(last_type_null == DATA)
			 begin
				tx_dout_null  = !(null_s[6]^txdata_flagctrl_tx_last);
			 end
			 else if(last_type_null == TIMEC)
			 begin
				tx_dout_null  = !(null_s[6]^last_timein_control_flag_tx);
			 end
		end
		8'd2:
		begin
			tx_dout_null = null_s[6];
		end
		8'd4:
		begin
			tx_dout_null = null_s[5];
		end
		8'd8:
		begin
			tx_dout_null = null_s[4];
		end
		8'd16:
		begin
			tx_dout_null = null_s[3];
		end
		8'd32:
		begin
			tx_dout_null = null_s[2];
		end
		8'd64:
		begin
			tx_dout_null = null_s[1];
		end
		8'd128:
		begin	
			tx_dout_null = null_s[0];
		end
		endcase
		end
	tx_spw_fct,tx_spw_fct_c:
	begin
	end
	tx_spw_data_c:
	begin
	end
	tx_spw_data_c_0:
	begin
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
	tx_sout_null    = last_tx_sout_null;

	case(state_tx_null)
	tx_spw_start:
	begin
	end
	tx_spw_null,tx_spw_null_c:
	begin
		if(tx_dout_null == last_tx_dout_null)
		begin
			tx_sout_null = !last_tx_sout_null;
		end
		else if(tx_dout_null != last_tx_dout_null)
		begin
			tx_sout_null = last_tx_sout_null;	
		end
	end
	tx_spw_fct,tx_spw_fct_c:
	begin

	end
	tx_spw_data_c:
	begin
	end
	tx_spw_data_c_0:
	begin
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
