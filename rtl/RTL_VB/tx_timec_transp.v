module tx_timec_transp(
			input [13:0] global_counter_transfer_time,
			input [5:0]  last_type_time,
			input [6:0]  state_tx_time,
			input 	     txdata_flagctrl_tx_last,
			input        last_timein_control_flag_tx,

			input [13:0] timecode_s,

			input last_tx_dout_timec,
			input last_tx_sout_timec,

			output reg tx_dout_timec,
			output reg tx_sout_timec
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

	tx_dout_timec      = 1'b0;

	case(state_tx_time)
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
	end
   	tx_spw_time_code_c:
	begin
		case(global_counter_transfer_time)
		14'd1:
		begin
			 if(last_type_time == NULL)
			 begin
				tx_dout_timec = !(timecode_s[12]^null_s[0]^null_s[1]);
			 end
			 else if(last_type_time == FCT)
			 begin
				tx_dout_timec = !(timecode_s[12]^fct_s[0]^fct_s[1]);
			 end
			 else if (last_type_time == EOP)
			 begin
				tx_dout_timec = !(timecode_s[12]^eop_s[0]^eop_s[1]);
			 end
			 else if( last_type_time == EEP)
			 begin
				tx_dout_timec = !(timecode_s[12]^eep_s[0]^eep_s[1]);
			 end
			 else if( last_type_time == DATA)
			 begin
				tx_dout_timec = !(timecode_s[12]^txdata_flagctrl_tx_last);
			 end
			 else if( last_type_time == TIMEC)
			 begin
				tx_dout_timec = !(timecode_s[12]^last_timein_control_flag_tx);
			 end
		end
		14'd2:
		begin
			tx_dout_timec = timecode_s[12];
		end
		14'd4:
		begin
			tx_dout_timec = timecode_s[11];
		end
		14'd8:
		begin
			tx_dout_timec = timecode_s[10];
		end
		14'd16:
		begin
			tx_dout_timec = timecode_s[9];
		end
		14'd32:
		begin
			tx_dout_timec = timecode_s[8];
		end
		14'd64:
		begin
			tx_dout_timec = timecode_s[0];
		end
		14'd128:
		begin
			tx_dout_timec = timecode_s[1];
		end
		14'd256:
		begin
			tx_dout_timec = timecode_s[2];
		end
		14'd512:
		begin
			tx_dout_timec = timecode_s[3];
		end
		14'd1024:
		begin
			tx_dout_timec = timecode_s[4];
		end
		14'd2048:
		begin
			tx_dout_timec = timecode_s[5];
		end
		14'd4096:
		begin
			tx_dout_timec = timecode_s[6];
		end
		14'd8192:
		begin
			tx_dout_timec = timecode_s[7];
		end
		endcase
	end
	default:
	begin
	end
	endcase
end

always@(*)
begin
	tx_sout_timec   = last_tx_sout_timec;

	case(state_tx_time)
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
	end
	tx_spw_time_code_c:
	begin
		if(tx_dout_timec  == last_tx_dout_timec )
		begin
			tx_sout_timec  = !last_tx_sout_timec ;
		end
		else if(tx_dout_timec  != last_tx_dout_timec )
		begin
			tx_sout_timec  = last_tx_sout_timec ;	
		end
	end
	default:
	begin
	end
	endcase
end

endmodule
