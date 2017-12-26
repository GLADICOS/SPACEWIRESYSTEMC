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
//e.g.DATA_WIDTH	[32,16]	: width of the data : 32:
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
module counter_transfer(
			input pclk_tx,
			input enable_tx,
			input send_null_tx,

			input [6:0] state_tx,

			input tx_data_in,
			input tx_data_in_0,

			output reg [13:0] global_counter_transfer /* synthesis syn_replicate = 1 */
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
		global_counter_transfer <= 14'd1;
	end
	else
	begin

		case(state_tx)
		tx_spw_start:
		begin
			if(send_null_tx && enable_tx)
			begin
				global_counter_transfer <= global_counter_transfer << 14'd1;
			end
			else
			begin
				global_counter_transfer   <= 14'd1;
			end	
		end
		tx_spw_null:
		begin


			if(global_counter_transfer == 14'd128)
			begin
				global_counter_transfer<= 14'd1;
			end
			else 
			begin		
				global_counter_transfer <= global_counter_transfer << 14'd1;
			end

		end
		tx_spw_fct:
		begin
			if(global_counter_transfer == 14'd8)
			begin		
				global_counter_transfer <= 14'd1;
			end
			else
			begin
				global_counter_transfer <= global_counter_transfer << 14'd1;
			end

		end
		tx_spw_null_c:
		begin

			if(global_counter_transfer == 14'd128)
			begin
				global_counter_transfer <= 14'd1;
			end
			else
			begin
				global_counter_transfer <= global_counter_transfer << 14'd1;
			end

		end
		tx_spw_fct_c:
		begin
			
			if(global_counter_transfer == 14'd8)
			begin
				global_counter_transfer <= 14'd1;
			end
			else
			begin
				global_counter_transfer <= global_counter_transfer << 14'd1;
			end

		end
		tx_spw_data_c:
		begin

			if(!tx_data_in)
			begin

				if(global_counter_transfer == 14'd512)
				begin
					global_counter_transfer <= 14'd1;
				end
				else
				begin
					global_counter_transfer <= global_counter_transfer << 14'd1;
				end

			end
			else
			begin

				if(global_counter_transfer == 14'd8)
				begin
					global_counter_transfer <= 14'd1;
				end
				else
				begin
					global_counter_transfer <= global_counter_transfer << 14'd1;
				end
			end

		end
		tx_spw_data_c_0:
		begin

			if(!tx_data_in_0)
			begin

				if(global_counter_transfer == 14'd512)
				begin
					global_counter_transfer <= 14'd1;
				end
				else
				begin
					global_counter_transfer <= global_counter_transfer << 14'd1;
				end

			end
			else
			begin

				if(global_counter_transfer == 14'd8)
				begin
					global_counter_transfer <= 14'd1;
				end
				else
				begin
					global_counter_transfer <= global_counter_transfer << 14'd1;
				end
			end

		end
		tx_spw_time_code_c:
		begin

			if(global_counter_transfer == 14'd8192)
			begin
				global_counter_transfer <= 14'd1;
			end
			else
			begin
				global_counter_transfer <= global_counter_transfer << 14'd1;
			end

		end
		default:
		begin
			global_counter_transfer <= global_counter_transfer;
		end
		endcase
	end
end

endmodule
