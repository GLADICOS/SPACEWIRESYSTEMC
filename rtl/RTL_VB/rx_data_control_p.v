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
module rx_data_control_p(
				input posedge_clk,
				input rx_resetn,

				input bit_c_3,
				input bit_c_2,
				input bit_c_1,
				input bit_c_0,

				input bit_d_9,
				input bit_d_8,
				input bit_d_0,
				input bit_d_1,
				input bit_d_2,
				input bit_d_3,
				input bit_d_4,
				input bit_d_5,
				input bit_d_6,
				input bit_d_7,
	
				input last_is_control,
				input last_is_data,

				input is_control,

				input [5:0] counter_neg,

				output reg [8:0] dta_timec_p,
				output reg parity_rec_d,
				output reg parity_rec_d_gen,

				output reg [2:0] control_p_r,
				output reg [2:0] control_l_r,
				output reg parity_rec_c,
				output reg parity_rec_c_gen
			);


	
always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		parity_rec_d 	  	<= 1'b0;
		parity_rec_d_gen 	<= 1'b0;
		dta_timec_p	   	<= 9'd0;
	end
	else
	begin
		if(!is_control && counter_neg == 6'd32)
		begin
			dta_timec_p  <= {bit_d_8,bit_d_0,bit_d_1,bit_d_2,bit_d_3,bit_d_4,bit_d_5,bit_d_6,bit_d_7};
			parity_rec_d 	  <= bit_d_9;

			if(last_is_control)
			begin
				parity_rec_d_gen <= !(bit_d_8^control_p_r[0]^control_p_r[1]);
			end
			else if(last_is_data)
			begin
				parity_rec_d_gen <= !(bit_d_8^dta_timec_p[7]^dta_timec_p[6]^dta_timec_p[5]^dta_timec_p[4]^dta_timec_p[3]^dta_timec_p[2]^dta_timec_p[1]^dta_timec_p[0]);
			end
		end
		else
		begin
			dta_timec_p  		<= dta_timec_p;
			parity_rec_d 	  	<= parity_rec_d;
			parity_rec_d_gen 	<= parity_rec_d_gen;
		end

	end

end

always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		control_p_r  	<= 3'd0;
		control_l_r	<= 3'd0;
		parity_rec_c	<= 1'b0;
		parity_rec_c_gen<= 1'b0;
	end
	else
	begin

		if(is_control && counter_neg == 6'd4)
		begin
			control_p_r	  <= {bit_c_2,bit_c_1,bit_c_0};
			control_l_r	  <= control_p_r;
			parity_rec_c	  <= bit_c_3;

			if(last_is_control)
			begin
				parity_rec_c_gen <= !(bit_c_2^control_p_r[0]^control_p_r[1]);
			end
			else if(last_is_data)
			begin
				parity_rec_c_gen <= !(bit_c_2^dta_timec_p[7]^dta_timec_p[6]^dta_timec_p[5]^dta_timec_p[4]^dta_timec_p[3]^dta_timec_p[2]^dta_timec_p[1]^dta_timec_p[0]);
			end
		end
		else
		begin
			control_p_r	  	<= control_p_r; 
			parity_rec_c 	  	<= parity_rec_c;
			parity_rec_c_gen 	<= parity_rec_c_gen;
		end

	end

end

endmodule 
