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
module tx_data_send(
			input pclk_tx,
			input enable_tx,

			input [6:0] state_tx,
			input [13:0] global_counter_transfer,

			input [7:0] timecode_tx_i,
			input tickin_tx,

			input [8:0] data_tx_i,
			input txwrite_tx,
			
			input [5:0] fct_counter_p,

			output reg [8:0]  tx_data_in,
			output reg [8:0]  tx_data_in_0,

			output reg process_data,
			output reg process_data_0,

			output reg [7:0]  tx_tcode_in,
			output reg tcode_rdy_trnsp

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
		tx_data_in <= 9'd0;
		tx_data_in_0 <= 9'd0;

		process_data   <= 1'b0;
		process_data_0 <= 1'b0;

		tx_tcode_in     <= 8'd0;
		tcode_rdy_trnsp <= 1'b0;
	end
	else
	begin
		case(state_tx)
		tx_spw_start,tx_spw_null,tx_spw_fct:
		begin
			tx_data_in      <= 9'd0;
			tx_data_in_0    <= 9'd0;
			process_data    <= 1'b0;
			process_data_0  <= 1'b0;
			tx_tcode_in     <= 8'd0;
			tcode_rdy_trnsp <= 1'b0;
		end
		tx_spw_null_c:
		begin

			if(global_counter_transfer == 14'd128)
			begin
				process_data_0  <= process_data_0;
				process_data    <= process_data;
				tcode_rdy_trnsp <= tcode_rdy_trnsp;

				tx_tcode_in    <= tx_tcode_in;
				tx_data_in     <= tx_data_in;
				tx_data_in_0   <= tx_data_in_0;
			end
			else if(global_counter_transfer == 14'd16)
			begin
				process_data_0  <= 1'b0;
				tx_data_in_0    <= 9'd0;
				tx_tcode_in     <= timecode_tx_i;
				tx_data_in      <= data_tx_i;

				if(txwrite_tx && fct_counter_p > 6'd0)
				begin
					process_data   <= 1'b1;
				end
				else
				begin
					process_data   <= 1'b0;
				end
			end
			else
			begin

				tx_tcode_in    <= tx_tcode_in;
				tx_data_in     <= tx_data_in;
				tx_data_in_0   <= tx_data_in_0;
				
				if(tickin_tx)
				begin
					tcode_rdy_trnsp <= 1'b1;
				end
				else
				begin
					tcode_rdy_trnsp <= 1'b0;
				end
			end

		end
		tx_spw_fct_c:
		begin
			tx_data_in     <= tx_data_in;
			tx_data_in_0   <= tx_data_in_0;
			process_data   <= process_data;
			process_data_0 <= process_data_0;
			tx_tcode_in    <= tx_tcode_in;
		end
		tx_spw_data_c:
		begin

			if(global_counter_transfer == 14'd512)
			begin
				process_data_0  <= process_data_0;
				process_data    <= process_data;
				tcode_rdy_trnsp <= tcode_rdy_trnsp;

				tx_data_in      <= tx_data_in;
				tx_data_in_0    <= tx_data_in_0;
				tx_tcode_in     <= tx_tcode_in;
			end
			else if(global_counter_transfer == 14'd1)
			begin	

				tx_data_in      <= tx_data_in;
				tx_data_in_0    <= tx_data_in_0;
				tx_tcode_in     <= tx_tcode_in;

				process_data   <= 1'b0;
				process_data_0 <= 1'b0;
			end
			else if(global_counter_transfer == 14'd32)
			begin	
				tx_data_in <= tx_data_in;
				tx_data_in_0 <= data_tx_i;
				tx_tcode_in <= timecode_tx_i;
	
				process_data   <= process_data;			

				if(txwrite_tx && fct_counter_p > 6'd0)
				begin
					process_data_0 <= 1'b1;
				end
				else
				begin
					process_data_0 <= 1'b0;
				end
			end
			else
			begin


				tx_data_in      <= tx_data_in;
				tx_data_in_0    <= tx_data_in_0;
				tx_tcode_in     <= tx_tcode_in;

				process_data   <= process_data;	
				process_data_0   <= process_data_0;
	
				if(tickin_tx && global_counter_transfer > 14'd8)
				begin
					tcode_rdy_trnsp <= 1'b1;
				end
				else
				begin
					tcode_rdy_trnsp <= 1'b0;
				end
			end

		end
		tx_spw_data_c_0:
		begin


			if(global_counter_transfer == 14'd512)
			begin
				process_data    <= process_data;
				process_data_0  <= process_data_0;
				tcode_rdy_trnsp <= tcode_rdy_trnsp;

				tx_data_in_0    <= tx_data_in_0;
				tx_data_in      <= tx_data_in;
				tx_tcode_in     <= tx_tcode_in;
			end
			else if(global_counter_transfer == 14'd1)
			begin
				tx_data_in_0   <= tx_data_in_0;
				tx_data_in     <= tx_data_in;
				tx_tcode_in    <= timecode_tx_i;

				process_data   <= 1'b0;
				process_data_0 <= 1'b0;
			end
			else if(global_counter_transfer == 14'd32)
			begin
				tx_data_in_0   <= tx_data_in_0;
				tx_data_in     <= data_tx_i;
				tx_tcode_in    <= timecode_tx_i;

				process_data_0 <= process_data_0;

				if(txwrite_tx && fct_counter_p > 6'd0)
				begin	
					process_data   <= 1'b1;
				end
				else
				begin
					process_data   <= 1'b0;
				end
			end
			else
			begin

				tx_data_in_0    <= tx_data_in_0;
				tx_data_in      <= tx_data_in;
				tx_tcode_in     <= tx_tcode_in;
					
				process_data   <= process_data;
				process_data_0 <= process_data_0;

				if(tickin_tx && global_counter_transfer > 14'd8)
				begin
					tcode_rdy_trnsp <= 1'b1;
				end
				else
				begin
					tcode_rdy_trnsp <= 1'b0;
				end
			end
		end
		tx_spw_time_code_c:
		begin

			if(global_counter_transfer == 14'd8192)
			begin
				process_data   <= process_data;
				process_data_0 <= process_data_0;
				tx_data_in     <= tx_data_in;
				tx_data_in_0   <= tx_data_in_0;
			end
			else if(global_counter_transfer == 14'd16)
			begin
				tx_data_in      <= data_tx_i;
				tx_data_in_0    <= 9'd0;
				process_data_0  <= 1'b0;

				if(txwrite_tx && fct_counter_p > 6'd0)
				begin
					process_data   <= 1'b1;
				end
				else
				begin
					process_data   <= 1'b0;
				end
			end
			else 
			begin
				process_data   <= process_data;
				tx_data_in     <= tx_data_in;
				tx_data_in_0    <= 9'd0;
				process_data_0  <= 1'b0;
			end

		end
		default:
		begin
			tx_data_in     <= 9'd0;
			tx_data_in_0   <= 9'd0;
			process_data   <= 1'b0;
			process_data_0 <= 1'b0;
		end
		endcase
	end
end


endmodule
