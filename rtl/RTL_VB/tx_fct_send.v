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
module tx_fct_send(
			input pclk_tx,
			input enable_tx,

			input send_fct_now,
			input fct_sent,
			output reg [2:0] fct_flag_p
		  );

	reg [2:0] fct_flag;
	reg clear_reg_fct_flag;

	reg  [2:0] state_fct_send/* synthesis dont_replicate */;
	reg  [2:0] next_state_fct_send/* synthesis dont_replicate */;

	reg  [2:0] state_fct_send_p/* synthesis dont_replicate */;
	reg  [2:0] next_state_fct_send_p/* synthesis dont_replicate */;
always@(*)
begin
	next_state_fct_send = state_fct_send;

	case(state_fct_send)
	3'd0:
	begin
		if(send_fct_now)
		begin
			next_state_fct_send = 3'd1;
		end
		else 
			next_state_fct_send = 3'd0;
	end
	3'd1:
	begin
		if(send_fct_now)
		begin
			next_state_fct_send = 3'd1;
		end
		else 
		begin
			next_state_fct_send = 3'd0;
		end
	end
	default:
	begin
		next_state_fct_send = 3'd0;
	end
	endcase
end

always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin
		fct_flag <= 3'd0;
		state_fct_send<= 3'd0;
	end
	else
	begin
		state_fct_send <= next_state_fct_send;

		case(state_fct_send)
		3'd0:
		begin
			if(clear_reg_fct_flag)
			begin
				fct_flag <= 3'd0;
			end
			else if(send_fct_now)
			begin
				if(fct_flag < 3'd7)
					fct_flag <= fct_flag + 3'd1;
				else
					fct_flag <= fct_flag;
			end
			else 
			begin
				fct_flag <= fct_flag;
			end
		end
		3'd1:
		begin
			fct_flag <= fct_flag;
		end
		default:
		begin
			fct_flag <= fct_flag;
		end
		endcase
	end
end




always@(*)
begin
	next_state_fct_send_p = state_fct_send_p;

	case(state_fct_send_p)
	3'd0:
	begin
		if(send_fct_now)
		begin
			next_state_fct_send_p = 3'd0;
		end
		else if(fct_flag == 3'd7)
		begin
			next_state_fct_send_p = 3'd1;
		end
		else 
			next_state_fct_send_p = 3'd0;
	end
	3'd1:
	begin
		if(fct_sent)
		begin
			next_state_fct_send_p = 3'd2;
		end
		else 
			next_state_fct_send_p = 3'd1;
	end
	3'd2:
	begin
		if(fct_flag_p > 3'd0 && !fct_sent)
		begin
			next_state_fct_send_p = 3'd1;
		end
		else if(fct_flag_p == 3'd0 && !fct_sent)
		begin
			next_state_fct_send_p = 3'd0;
		end
		else
		begin
			next_state_fct_send_p = 3'd2;
		end
	end
	default:
	begin
		next_state_fct_send_p = 3'd0;
	end
	endcase
end

always@(posedge pclk_tx or negedge enable_tx)
begin
	if(!enable_tx)
	begin
		fct_flag_p <= 3'd7;
		state_fct_send_p<= 3'd1;
		clear_reg_fct_flag <=1'b0;
	end
	else
	begin
		state_fct_send_p <= next_state_fct_send_p;

		case(state_fct_send_p)
		3'd0:
		begin
			if(send_fct_now)
			begin
				fct_flag_p <= 3'd0;
				clear_reg_fct_flag <=1'b0;	
			end
			else if(fct_flag < 3'd7)
			begin
				clear_reg_fct_flag <=1'b0;
				fct_flag_p <= 3'd0;
			end
			else 
			begin
				clear_reg_fct_flag <=1'b1;
				fct_flag_p <= fct_flag;				
			end
		end
		3'd1:
		begin
			clear_reg_fct_flag <=1'b0;
			if(fct_sent)
			begin
				if(fct_flag_p > 3'd0)
					fct_flag_p <= fct_flag_p - 3'd1;
				else
					fct_flag_p <= fct_flag_p;
			end
			else 
			begin
				fct_flag_p <= fct_flag_p;
			end
		end
		3'd2:
		begin
			clear_reg_fct_flag <=1'b0;
			fct_flag_p <= fct_flag_p;
		end
		default:
		begin
			fct_flag_p <= fct_flag_p;
		end
		endcase
	end
end


endmodule
