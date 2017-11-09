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
module fifo_rx
#(
	parameter integer DWIDTH = 9,
	parameter integer AWIDTH = 6
)

(
	input clock, reset, wr_en, rd_en,
	input [DWIDTH-1:0] data_in,
	output reg f_full,f_empty,
	output reg open_slot_fct,
	output reg overflow_credit_error,
	output reg [DWIDTH-1:0] data_out,
	output reg [AWIDTH-1:0] counter
);

	reg [DWIDTH-1:0] mem [0:2**AWIDTH-1];

	reg [AWIDTH-1:0] wr_ptr;
	reg [AWIDTH-1:0] rd_ptr;

	reg [AWIDTH-1:0] credit_counter;
	reg [AWIDTH-1:0] credit_counter_write;
	reg [AWIDTH-1:0] credit_counter_reader;

	reg  [1:0] state_data_write;
	reg  [1:0] next_state_data_write;

	reg  [1:0] state_data_read;
	reg  [1:0] next_state_data_read;

	reg  [1:0] state_open_slot;
	reg  [1:0] next_state_open_slot;

	reg [10:0] counter_wait;

	reg [AWIDTH-1:0] counter_writer;
	reg [AWIDTH-1:0] counter_reader;

/****************************************/

always@(*)
begin
	next_state_open_slot = state_open_slot;

	case(state_open_slot)
	2'd0:
	begin
		if(rd_ptr == 6'd7 || rd_ptr == 6'd15 || rd_ptr == 6'd23 || rd_ptr == 6'd31 || rd_ptr == 6'd39 || rd_ptr == 6'd47 || rd_ptr == 6'd55 || rd_ptr == 6'd63)
		begin
			next_state_open_slot = 2'd1;
		end
		else 
		begin
			next_state_open_slot = 2'd0;
		end
	end
	2'd1:
	begin
		if(counter_wait != 11'd300)
			next_state_open_slot = 2'd1;
		else
			next_state_open_slot = 2'd2;
	end
	2'd2:
	begin
		if(rd_ptr == 6'd7 || rd_ptr == 6'd15 || rd_ptr == 6'd23 || rd_ptr == 6'd31 || rd_ptr == 6'd39 || rd_ptr == 6'd47 || rd_ptr == 6'd55 || rd_ptr == 6'd63)
		begin
			next_state_open_slot = 2'd2;
		end
		else 
		begin
			next_state_open_slot = 2'd0;
		end
		
	end
	default:
	begin
		next_state_open_slot = 2'd0;
	end
	endcase
end

/****************************************/

always@(*)
begin
	next_state_data_write = state_data_write;

	case(state_data_write)
	2'd0:
	begin
		if(wr_en && !f_full)
		begin
			next_state_data_write = 2'd1;
		end
		else 
		begin
			next_state_data_write = 2'd0;
		end
	end
	2'd1:
	begin
		if(wr_en)
		begin
			next_state_data_write = 2'd1;
		end
		else 
		begin
			next_state_data_write = 2'd2;
		end
	end
	2'd2:
	begin
		next_state_data_write = 2'd0;
	end
	default:
	begin
		next_state_data_write = 2'd0;
	end
	endcase
end

/****************************************/

always@(*)
begin
	next_state_data_read = state_data_read;

	case(state_data_read)
	2'd0:
	begin
		if(rd_en && !f_empty)
		begin
			next_state_data_read = 2'd1;
		end
		else 
		begin
			next_state_data_read = 2'd0;
		end
	end
	2'd1:
	begin
		if(rd_en)
		begin
			next_state_data_read = 2'd1;
		end
		else 
		begin
			next_state_data_read = 2'd2;
		end
	end
	2'd2:
	begin
		next_state_data_read = 2'd0;
	end
	default:
	begin
		next_state_data_read = 2'd0;
	end
	endcase
end

always@(posedge clock or negedge reset)
begin
	if (!reset)
	begin
		state_open_slot <= 2'd0;
		open_slot_fct<= 1'b0;
		counter_wait <= 11'd0;
	end
	else
	begin
		state_open_slot <= next_state_open_slot;

		case(state_open_slot)
		2'd0:
		begin
			if(rd_ptr == 6'd7 || rd_ptr == 6'd15 || rd_ptr == 6'd23 || rd_ptr == 6'd31 || rd_ptr == 6'd39 || rd_ptr == 6'd47 || rd_ptr == 6'd55 || rd_ptr == 6'd63)
			begin
				open_slot_fct<= 1'b1;
				counter_wait <= counter_wait + 11'd1;
			end
			else 
			begin
				open_slot_fct<= 1'b0;
			end
		end
		2'd1:
		begin
			if(counter_wait != 11'd300)
				counter_wait <= counter_wait + 11'd1;
			else
				counter_wait <= counter_wait;
			
			open_slot_fct<= 1'b1;
		end
		2'd2:
		begin
			counter_wait <= 11'd0;
			open_slot_fct<= 1'b0;		
		end
		default:
		begin
			open_slot_fct<= open_slot_fct;
		end
		endcase		

	end
end
//Write pointer
	always@(posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			wr_ptr <= {(AWIDTH){1'b0}};
			mem[0] <= {(DWIDTH){1'b0}};
			mem[1] <= {(DWIDTH){1'b0}};
			mem[2] <= {(DWIDTH){1'b0}};
			mem[3] <= {(DWIDTH){1'b0}};
			mem[4] <= {(DWIDTH){1'b0}};
			mem[5] <= {(DWIDTH){1'b0}};
			mem[6] <= {(DWIDTH){1'b0}};
			mem[7] <= {(DWIDTH){1'b0}};
			mem[8] <= {(DWIDTH){1'b0}};
			mem[9] <= {(DWIDTH){1'b0}};
			mem[10] <= {(DWIDTH){1'b0}};

			mem[11] <= {(DWIDTH){1'b0}};
			mem[12] <= {(DWIDTH){1'b0}};
			mem[13] <= {(DWIDTH){1'b0}};
			mem[14] <= {(DWIDTH){1'b0}};
			mem[15] <= {(DWIDTH){1'b0}};
			mem[16] <= {(DWIDTH){1'b0}};
			mem[17] <= {(DWIDTH){1'b0}};
			mem[18] <= {(DWIDTH){1'b0}};
			mem[19] <= {(DWIDTH){1'b0}};
			mem[20] <= {(DWIDTH){1'b0}};
			mem[21] <= {(DWIDTH){1'b0}};

			mem[22] <= {(DWIDTH){1'b0}};
			mem[23] <= {(DWIDTH){1'b0}};
			mem[24] <= {(DWIDTH){1'b0}};
			mem[25] <= {(DWIDTH){1'b0}};
			mem[26] <= {(DWIDTH){1'b0}};
			mem[27] <= {(DWIDTH){1'b0}};
			mem[28] <= {(DWIDTH){1'b0}};
			mem[29] <= {(DWIDTH){1'b0}};
			mem[30] <= {(DWIDTH){1'b0}};
			mem[31] <= {(DWIDTH){1'b0}};
			mem[32] <= {(DWIDTH){1'b0}};


			mem[33] <= {(DWIDTH){1'b0}};
			mem[34] <= {(DWIDTH){1'b0}};
			mem[35] <= {(DWIDTH){1'b0}};
			mem[36] <= {(DWIDTH){1'b0}};
			mem[37] <= {(DWIDTH){1'b0}};
			mem[38] <= {(DWIDTH){1'b0}};
			mem[39] <= {(DWIDTH){1'b0}};
			mem[40] <= {(DWIDTH){1'b0}};
			mem[41] <= {(DWIDTH){1'b0}};
			mem[42] <= {(DWIDTH){1'b0}};
			mem[43] <= {(DWIDTH){1'b0}};

			mem[44] <= {(DWIDTH){1'b0}};
			mem[45] <= {(DWIDTH){1'b0}};
			mem[46] <= {(DWIDTH){1'b0}};
			mem[47] <= {(DWIDTH){1'b0}};
			mem[48] <= {(DWIDTH){1'b0}};
			mem[49] <= {(DWIDTH){1'b0}};
			mem[50] <= {(DWIDTH){1'b0}};
			mem[51] <= {(DWIDTH){1'b0}};
			mem[52] <= {(DWIDTH){1'b0}};
			mem[53] <= {(DWIDTH){1'b0}};
			mem[54] <= {(DWIDTH){1'b0}};

			mem[55] <= {(DWIDTH){1'b0}};
			mem[56] <= {(DWIDTH){1'b0}};
			mem[57] <= {(DWIDTH){1'b0}};
			mem[58] <= {(DWIDTH){1'b0}};
			mem[59] <= {(DWIDTH){1'b0}};
			mem[60] <= {(DWIDTH){1'b0}};
			mem[61] <= {(DWIDTH){1'b0}};
			mem[62] <= {(DWIDTH){1'b0}};
			mem[63] <= {(DWIDTH){1'b0}};

			state_data_write <= 2'd0;
		end
		else
		begin

			state_data_write <= next_state_data_write;

			case(state_data_write)
			2'd0:
			begin
				mem[wr_ptr]<=data_in;
			end
			2'd1:
			begin
				mem[wr_ptr]<=mem[wr_ptr];
			end
			2'd2:
			begin
				wr_ptr <= wr_ptr + 6'd1;
			end
			default:
			begin
				mem[wr_ptr]<=mem[wr_ptr];
				wr_ptr <= wr_ptr;
			end
			endcase
	
		end
	end

//FULL - EMPTY COUNTER

always@(posedge clock or negedge reset)
begin
		
	if (!reset)
	begin
		f_full  <= 1'b0;
		f_empty <= 1'b0;
		overflow_credit_error<=1'b0;
		counter <= {(AWIDTH){1'b0}};
		credit_counter <= 6'd0;
		credit_counter_write <= 6'd0;
		credit_counter_reader <= 6'd56;			
		counter_writer <= {(AWIDTH){1'b0}};
		counter_reader <= {(AWIDTH){1'b0}};
	end
	else
	begin

		if (state_data_write == 2'd2)
		begin
			credit_counter_write   <= credit_counter_write + 6'd1;
		end
		else
			credit_counter_write   <= credit_counter_write;
		
		if(state_data_read == 2'd1 && !rd_en)
		begin
			if(rd_ptr == 6'd7 || rd_ptr == 6'd15 || rd_ptr == 6'd23 || rd_ptr == 6'd31 || rd_ptr == 6'd39 || rd_ptr == 6'd47 || rd_ptr == 6'd55 || rd_ptr == 6'd63)
			begin		
				if(credit_counter < 6'd49)			
					credit_counter_reader <= credit_counter_reader + 6'd8;
				else
					credit_counter_reader <= credit_counter_reader + 6'd7;
			end
			else
				credit_counter_reader <= credit_counter_reader;	
			end
		else 
		begin
			credit_counter_reader <= credit_counter_reader;
		end
			
		credit_counter <=  credit_counter_reader - credit_counter_write;

		if(credit_counter > 6'd56)
		begin
			overflow_credit_error <= 1'b1;
		end
		else 
			overflow_credit_error <= 1'b0;

		if(state_data_write == 2'd2)
		begin
			counter_writer <= counter_writer + 6'd1;
		end
		else
		begin
			counter_writer <= counter_writer;
		end
		
		if(state_data_read == 2'd1 && !rd_en)
		begin
			counter_reader <= counter_reader + 6'd1;
		end
		else
		begin
			counter_reader <= counter_reader;
		end

		counter <= counter_writer - counter_reader;

		if(counter == 6'd63)
		begin
			f_full  <= 1'b1;
		end
		else
		begin
			f_full  <= 1'b0;
		end

		if(counter == 6'd0)
		begin
			f_empty <= 1'b1;
		end
		else
		begin
			f_empty <= 1'b0;
		end
	end
end


//Read pointer
	always@(posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			rd_ptr <= {(AWIDTH){1'b0}};
			data_out <= 9'd0;
			state_data_read <= 2'd0;
		end
		else
		begin

			state_data_read <= next_state_data_read;

			data_out   <= mem[rd_ptr];

			case(state_data_read)
			2'd0:
			begin
				if(rd_en)
				begin
					rd_ptr     <= rd_ptr+ 6'd1;
				end
				else
				begin
					rd_ptr     <= rd_ptr;
				end
			end
			2'd1:
			begin
				rd_ptr     <= rd_ptr;
			end
			2'd2:
			begin
				rd_ptr     <= rd_ptr;
			end
			default:
			begin
				rd_ptr     <= rd_ptr;

			end
			endcase


		end
	end

endmodule
