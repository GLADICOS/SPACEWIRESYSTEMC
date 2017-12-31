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
module tx_transport(

			input pclk_tx,
			input enable_tx,

			input [6:0] state_tx,
			input [5:0]  last_type,
			input [13:0] global_counter_transfer,

			input [8:0]  tx_data_in,
			input [8:0]  tx_data_in_0,
			input [8:0]  txdata_flagctrl_tx_last,
			input [7:0]  last_timein_control_flag_tx,
			input [13:0] timecode_s,

			output reg tx_dout_e,
			output reg tx_sout_e
);

	reg last_tx_dout_null;
	reg last_tx_sout_null;

	reg last_tx_dout;
	reg last_tx_sout;

	wire tx_dout_null/* synthesis syn_replicate = 1 */;
	wire tx_sout_null/* synthesis syn_replicate = 1 */;

	reg [7:0] global_counter_transfer_null;
	reg [5:0]  last_type_null;
	reg [6:0] state_tx_null;


	reg last_tx_dout_fct;
	reg last_tx_sout_fct;

	wire tx_dout_fct/* synthesis syn_replicate = 1 */;
	wire tx_sout_fct/* synthesis syn_replicate = 1 */;

	reg [3:0] global_counter_transfer_fct;
	reg [5:0]  last_type_fct;
	reg [6:0] state_tx_fct;

	reg last_tx_dout_data;
	reg last_tx_sout_data;

	wire tx_dout_data/* synthesis syn_replicate = 1 */;
	wire tx_sout_data/* synthesis syn_replicate = 1 */;

	reg [9:0] global_counter_transfer_data;
	reg [5:0]  last_type_data;	
	reg [6:0] state_tx_data;

	reg last_tx_dout_data_0;
	reg last_tx_sout_data_0;

	wire tx_dout_data_0/* synthesis syn_replicate = 1 */;
	wire tx_sout_data_0/* synthesis syn_replicate = 1 */;

	reg [9:0] global_counter_transfer_data_0;
	
	reg [6:0] state_tx_data_0;
	reg [5:0]  last_type_data_0;

	reg last_tx_dout_timec;
	reg last_tx_sout_timec;

	wire tx_dout_timec/* synthesis syn_replicate = 1 */;
	wire tx_sout_timec/* synthesis syn_replicate = 1 */;
	reg [6:0] state_tx_time;
	reg [13:0] global_counter_transfer_time;
	reg [5:0]  last_type_time;

	//reg [8:0]  tx_data_in;
	//reg [8:0]  tx_data_in_0;
	//reg [8:0]  txdata_flagctrl_tx_last;
	//reg [7:0]  last_timein_control_flag_tx;
	//reg [13:0] timecode_s;

	wire result_data;

	wire result_timec;

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

	assign result_data = txdata_flagctrl_tx_last[0]^txdata_flagctrl_tx_last[1]^txdata_flagctrl_tx_last[2]^txdata_flagctrl_tx_last[3]^ txdata_flagctrl_tx_last[4]^txdata_flagctrl_tx_last[5]^txdata_flagctrl_tx_last[6]^txdata_flagctrl_tx_last[7];

	assign result_timec = last_timein_control_flag_tx[7]^last_timein_control_flag_tx[6]^last_timein_control_flag_tx[5]^last_timein_control_flag_tx[4]^last_timein_control_flag_tx[3]^last_timein_control_flag_tx[2]^last_timein_control_flag_tx[1]^last_timein_control_flag_tx[0];

always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin
		//tx_dout_e <=  1'b0;
		//tx_sout_e <=  1'b0;

		last_tx_dout <=  1'b0;
		last_tx_sout <=  1'b0;

		//last_tx_dout_null <=  1'b0;
		//last_tx_sout_null <=  1'b0;

		//last_tx_dout_fct <=  1'b0;
		//last_tx_sout_fct <=  1'b0;

		//last_tx_dout_data <=  1'b0;
		//last_tx_sout_data <=  1'b0;

		//last_tx_dout_data_0 <=  1'b0;
		//last_tx_sout_data_0 <=  1'b0;

		//last_tx_dout_timec <=  1'b0;
		//last_tx_sout_timec <=  1'b0;

		//last_type_null   <= NULL;
		//last_type_fct    <= NULL;
		//last_type_data   <= NULL;
		//last_type_data_0 <= NULL;
		//last_type_time   <= NULL;

		//global_counter_transfer_null <= 8'd0;
		//global_counter_transfer_fct <= 4'd0;
		//global_counter_transfer_data <= 10'd0;
		//global_counter_transfer_data_0 <= 10'd0;
		//global_counter_transfer_time <= 14'd0;

		//state_tx_null <= tx_spw_start;
		//state_tx_fct  <= tx_spw_start;
		//state_tx_data <= tx_spw_start;
		//state_tx_data_0 <= tx_spw_start;
		//state_tx_time <= tx_spw_start;

		//tx_data_in <= 9'd0;
		//tx_data_in_0 <= 9'd0;
		//txdata_flagctrl_tx_last <= 9'd0;
		//last_timein_control_flag_tx <= 8'd0;
		//timecode_s <= 14'd0;
	end
	else
	begin
		/*
		last_type_null   <= last_type;
		last_type_fct    <= last_type;
		last_type_data   <= last_type;
		last_type_data_0 <= last_type;
		last_type_time   <= last_type;

		state_tx_null <= state_tx;
		state_tx_fct  <= state_tx;
		state_tx_data <= state_tx;
		state_tx_data_0 <= state_tx;
		state_tx_time <= state_tx;

		global_counter_transfer_null <= global_counter_transfer[7:0];
		global_counter_transfer_fct <= global_counter_transfer[3:0];
		global_counter_transfer_data <= global_counter_transfer[9:0];
		global_counter_transfer_data_0 <= global_counter_transfer[9:0];
		global_counter_transfer_time <= global_counter_transfer;

		tx_data_in <= tx_data_in_in;
		tx_data_in_0 <= tx_data_in_0_in;
		txdata_flagctrl_tx_last <= txdata_flagctrl_tx_last_in;
		last_timein_control_flag_tx <= last_timein_control_flag_tx_in;
		timecode_s <= timecode_s_in;
		*/
		case(state_tx)
		tx_spw_start:
		begin
			if(enable_tx)
			begin
				last_tx_dout <= tx_dout_null;
				last_tx_sout <= tx_sout_null;

				//last_tx_dout_fct <= tx_dout_null;
				//last_tx_sout_fct <= tx_sout_null;

				//last_tx_dout_data <= tx_dout_null;
				//last_tx_sout_data <= tx_sout_null;

				//last_tx_dout_data_0 <= tx_dout_null;
				//last_tx_sout_data_0 <= tx_sout_null;

				//last_tx_dout_timec <= tx_dout_null;
				//last_tx_sout_timec <= tx_sout_null;

				//tx_dout_e <= tx_dout_null;
				//tx_sout_e <= tx_sout_null;
			end
			else
			begin
				//tx_dout_e <= tx_dout_e;
				//tx_sout_e <= tx_sout_e;
			end
		end
		tx_spw_null,tx_spw_null_c:
		begin
			last_tx_dout <= tx_dout_null;
			last_tx_sout <= tx_sout_null;

			//last_tx_dout_fct <= tx_dout_null;
			//last_tx_sout_fct <= tx_sout_null;

			//last_tx_dout_data_0 <= tx_dout_null;
			//last_tx_sout_data_0 <= tx_sout_null;

			//last_tx_dout_timec <= tx_dout_null;
			//last_tx_sout_timec <= tx_sout_null;

			//last_tx_dout_data <= tx_dout_null;
			//last_tx_sout_data <= tx_sout_null;

			//tx_dout_e <= tx_dout_null;
			//tx_sout_e <= tx_sout_null;
		end
		tx_spw_fct,tx_spw_fct_c:
		begin
			//last_tx_dout_null <= tx_dout_fct;
			//last_tx_sout_null <= tx_sout_fct;

			last_tx_dout <= tx_dout_fct;
			last_tx_sout <= tx_sout_fct;

			//last_tx_dout_data <= tx_dout_fct;
			//last_tx_sout_data <= tx_sout_fct;

			//last_tx_dout_data_0 <= tx_dout_fct;
			//last_tx_sout_data_0 <= tx_sout_fct;

			//last_tx_dout_timec <= tx_dout_fct;
			//last_tx_sout_timec <= tx_sout_fct;

			//tx_dout_e <= tx_dout_fct;
			//tx_sout_e <= tx_sout_fct;

		end
	   	tx_spw_data_c:
		begin
			last_tx_dout <= tx_dout_data;
			last_tx_sout <= tx_sout_data;

			//last_tx_dout_fct <= tx_dout_data;
			//last_tx_sout_fct <= tx_sout_data;

			//last_tx_dout_data_0 <= tx_dout_data;
			//last_tx_sout_data_0 <= tx_sout_data;

			//last_tx_dout_data <= tx_dout_data;
			//last_tx_sout_data <= tx_sout_data;

			//last_tx_dout_timec <= tx_dout_data;
			//last_tx_sout_timec <= tx_sout_data;

			//tx_dout_e <= tx_dout_data;
			//tx_sout_e <= tx_sout_data;
		end
	   	tx_spw_data_c_0:
		begin
			last_tx_dout <= tx_dout_data_0;
			last_tx_sout <= tx_sout_data_0;

			//last_tx_dout_timec <= tx_dout_data_0;
			//last_tx_sout_timec <= tx_sout_data_0;

			//last_tx_dout_fct <= tx_dout_data_0;
			//last_tx_sout_fct <= tx_sout_data_0;

			//last_tx_dout_data <= tx_dout_data_0;
			//last_tx_sout_data <= tx_sout_data_0;

			//last_tx_dout_data_0 <= tx_dout_data_0;
			//last_tx_sout_data_0 <= tx_sout_data_0;

			//tx_dout_e <= tx_dout_data_0;
			//tx_sout_e <= tx_sout_data_0;
		end
	   	tx_spw_time_code_c:
		begin
			last_tx_dout <= tx_dout_timec;
			last_tx_sout <= tx_sout_timec;

			//last_tx_dout_data_0 <= tx_dout_timec;
			//last_tx_sout_data_0 <= tx_sout_timec;

			//last_tx_dout_data <= tx_dout_timec;
			//last_tx_sout_data <= tx_sout_timec;

			//last_tx_dout_timec <= tx_dout_timec;
			//last_tx_sout_timec <= tx_sout_timec;

			//last_tx_dout_fct <= tx_dout_timec;
			//last_tx_sout_fct <= tx_sout_timec;

			//tx_dout_e <= tx_dout_timec;
			//tx_sout_e <= tx_sout_timec;
		end
		default:
		begin
		end
		endcase
	end
end

always@(*)
begin

		tx_dout_e =  1'b0;
		tx_sout_e =  1'b0;

		case(state_tx)
		tx_spw_start:
		begin
			if(enable_tx)
			begin
				tx_dout_e = tx_dout_null;
				tx_sout_e = tx_sout_null;
			end

		end
		tx_spw_null,tx_spw_null_c:
		begin

			tx_dout_e = tx_dout_null;
			tx_sout_e = tx_sout_null;
		end
		tx_spw_fct,tx_spw_fct_c:
		begin

			tx_dout_e = tx_dout_fct;
			tx_sout_e = tx_sout_fct;

		end
	   	tx_spw_data_c:
		begin
			tx_dout_e = tx_dout_data;
			tx_sout_e = tx_sout_data;
		end
	   	tx_spw_data_c_0:
		begin

			tx_dout_e = tx_dout_data_0;
			tx_sout_e = tx_sout_data_0;
		end
	   	tx_spw_time_code_c:
		begin

			tx_dout_e = tx_dout_timec;
			tx_sout_e = tx_sout_timec;
		end
		default:
		begin
		end
		endcase
end

tx_null_transp null_transp(
			.global_counter_transfer_null(global_counter_transfer[7:0]),
			.last_type_null(last_type),
			.state_tx_null(state_tx),

			.last_tx_dout_null(last_tx_dout),
			.last_tx_sout_null(last_tx_sout),

			.txdata_flagctrl_tx_last(result_data),
			.last_timein_control_flag_tx(result_timec),
			.tx_dout_null(tx_dout_null),
			.tx_sout_null(tx_sout_null)
		     );

tx_fct_transp fct_transp(
			.global_counter_transfer_fct(global_counter_transfer[3:0]),
			.last_type_fct(last_type),
			.state_tx_fct(state_tx),
			.txdata_flagctrl_tx_last(result_data),
			.last_timein_control_flag_tx(result_timec),

			.last_tx_dout_fct(last_tx_dout),
			.last_tx_sout_fct(last_tx_sout),

			.tx_dout_fct(tx_dout_fct),
			.tx_sout_fct(tx_sout_fct)
		    );

tx_data_transp data_transp(
			.global_counter_transfer_data(global_counter_transfer[9:0]),
			.last_type_data(last_type),
			.state_tx_data(state_tx),
			.txdata_flagctrl_tx_last(result_data),
			.last_timein_control_flag_tx(result_timec),

			.tx_data_in(tx_data_in),

			.last_tx_dout_data(last_tx_dout),
			.last_tx_sout_data(last_tx_sout),

			.tx_dout_data(tx_dout_data),
			.tx_sout_data(tx_sout_data)
		     );

tx_data_0_transp data_0_transp(
			.global_counter_transfer_data_0(global_counter_transfer[9:0]),
			.last_type_data_0(last_type),
			.state_tx_data_0(state_tx),
			.txdata_flagctrl_tx_last(result_data),
			.last_timein_control_flag_tx(result_timec),

			.tx_data_in_0(tx_data_in_0),

			.last_tx_dout_data_0(last_tx_dout),
			.last_tx_sout_data_0(last_tx_sout),

			.tx_dout_data_0(tx_dout_data_0),
			.tx_sout_data_0(tx_sout_data_0)
		     );

tx_timec_transp timec_transp(
			.global_counter_transfer_time(global_counter_transfer),
			.last_type_time(last_type),
			.state_tx_time(state_tx),
			.txdata_flagctrl_tx_last(result_data),
			.last_timein_control_flag_tx(result_timec),

			.timecode_s(timecode_s),

			.last_tx_dout_timec(last_tx_dout),
			.last_tx_sout_timec(last_tx_sout),

			.tx_dout_timec(tx_dout_timec),
			.tx_sout_timec(tx_sout_timec)
		      );

endmodule
