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
module counter_neg(
			input negedge_clk,
			input rx_resetn,
			
			input rx_din,
			
			output reg is_control,
			output reg [5:0] counter_neg
		  );

	reg control_bit_found;

always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		is_control <= 1'b0;
		control_bit_found <= 1'b0;
		counter_neg <= 6'd1;
	end
	else
	begin
		control_bit_found <= rx_din;

		case(counter_neg)
		6'd1:
		begin
			counter_neg <= 6'd2;
		end
		6'd2:
		begin
			if(control_bit_found)
			begin
				is_control  <= 1'b1;	
			end
			else 
			begin
				is_control  <= 1'b0;
			end

			counter_neg <= 6'd4;
		end
		6'd4:
		begin

			is_control <= 1'b0;

			if(is_control)
			begin	
				counter_neg <= 6'd2;
			end
			else
			begin
				counter_neg <= 6'd8;
			end
		end
		6'd8:
		begin
			is_control    <= 1'b0;
			counter_neg <= 6'd16;
		end
		6'd16:
		begin
			is_control    <= 1'b1;
			counter_neg <= 6'd32;
		end
		6'd32:
		begin
			is_control    <= 1'b0;
			counter_neg <= 6'd2;
		end
		endcase
	end
end

endmodule
