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

			input get_data,
			input get_data_0,

			input [7:0] timecode_tx_i,
			input tickin_tx,

			input [8:0] data_tx_i,
			input txwrite_tx,
			
			input fct_counter_p,

			output reg [8:0]  tx_data_in,
			output reg [8:0]  tx_data_in_0,

			output reg process_data,
			output reg process_data_0,

			output reg [7:0]  tx_tcode_in,
			output reg tcode_rdy_trnsp

		   );

	wire process_data_en;

	assign process_data_en = (txwrite_tx & fct_counter_p)?1'b1:1'b0;

always@(posedge pclk_tx or negedge enable_tx)
begin

	if(!enable_tx)
	begin
		process_data   <= 1'b0;
		process_data_0 <= 1'b0;
	
		tcode_rdy_trnsp <= 1'b0;

		tx_data_in      <= 9'd0;
		tx_data_in_0    <= 9'd0;
		tx_tcode_in     <= 8'd0;
	end
	else
	begin

		if(tickin_tx)
		begin
			tx_tcode_in    <= timecode_tx_i;
			tcode_rdy_trnsp <= 1'b1;
		end
		else
		begin
			tx_tcode_in    <= tx_tcode_in;
			tcode_rdy_trnsp <= 1'b0;
		end

		if(!txwrite_tx)
		begin
			process_data   <= 1'b0;	
			process_data_0 <= 1'b0;	
		end
		else if(get_data && process_data_en)
		begin
			process_data   <= 1'b1;	
			process_data_0 <= 1'b0;		
		end
		else if(get_data_0 && process_data_en)
		begin
			process_data   <= 1'b0;	
			process_data_0 <= 1'b1;
		end
		else
		begin
			process_data   <= process_data;	
			process_data_0 <= process_data_0;
		end


		if(get_data)
		begin
			tx_data_in     <= data_tx_i;	
		end
		else
		begin
			tx_data_in     <= tx_data_in;
		end

		if(get_data_0)
		begin
			tx_data_in_0 <= data_tx_i;
		end
		else
		begin
			tx_data_in_0 <= tx_data_in_0;
		end
	end
end

endmodule
