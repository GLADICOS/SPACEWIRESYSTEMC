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
module fifo_tx
#(
	parameter integer DWIDTH = 9,
	parameter integer AWIDTH = 6
)

(
	input clock, reset, wr_en, rd_en,
	input [DWIDTH-1:0] data_in,
	output reg f_full,write_tx,f_empty,
	output reg [DWIDTH-1:0] data_out,
	output reg [AWIDTH-1:0] counter
);

	reg [DWIDTH-1:0] mem [0:2**AWIDTH-1];

	reg [AWIDTH-1:0] wr_ptr;
	reg [AWIDTH-1:0] rd_ptr;

	reg  [1:0] state_data_write;
	reg  [1:0] next_state_data_write;

	reg  [1:0] state_data_read;
	reg  [1:0] next_state_data_read;
	
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

//Write pointer
	always@(posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			mem[0]  <= {(DWIDTH){1'b0}};
			mem[1]  <= {(DWIDTH){1'b0}};
			mem[2]  <= {(DWIDTH){1'b0}};
			mem[3]  <= {(DWIDTH){1'b0}};
			mem[4]  <= {(DWIDTH){1'b0}};
			mem[5]  <= {(DWIDTH){1'b0}};
			mem[6]  <= {(DWIDTH){1'b0}};
			mem[7]  <= {(DWIDTH){1'b0}};
			mem[8]  <= {(DWIDTH){1'b0}};
			mem[9]  <= {(DWIDTH){1'b0}};
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

			wr_ptr      <= {(AWIDTH){1'b0}};
			state_data_write <= 2'd0;
		end
		else
		begin

			state_data_write <= next_state_data_write;

			case(state_data_write)
			2'd0:
			begin
				mem[wr_ptr]<=mem[wr_ptr];
				wr_ptr <= wr_ptr;
			end
			2'd1:
			begin
				mem[wr_ptr]<=data_in;
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
		counter <= {(AWIDTH){1'b0}};
	end
	else
	begin

		if(state_data_write == 2'd2)
		begin
			if(counter == 6'd63)
				counter <= counter;
			else
				counter <= counter + 6'd1;
		end
		else if(state_data_read == 2'd2)
		begin
			if(counter == 6'd0)
				counter <= counter;
			else
				counter <= counter - 6'd1;
		end
		else
		begin
			counter <= counter;
		end

	end
end


always@(*)
begin

	f_full  = 1'b0;
	f_empty = 1'b0;

	if(counter == 6'd63)
	begin
		f_full  = 1'b1;
	end

	if(counter == 6'd0)
	begin
		f_empty = 1'b1;
	end

end

//Read pointer
always@(posedge clock or negedge reset)
begin
	if (!reset)
	begin
		rd_ptr     <= {(AWIDTH){1'b0}};
		data_out   <= 9'd0;
		write_tx   <= 1'b0;
		state_data_read <= 2'd0;
	end
	else
	begin
		state_data_read <= next_state_data_read;

		case(state_data_read)
		2'd0:
		begin
			if(rd_en)
			begin
				write_tx<= 1'b0;
				rd_ptr     <= rd_ptr + 6'd1;
			end
			else
			begin
				data_out   <= mem[rd_ptr];

				if(counter > 6'd0)
				begin
					write_tx<= 1'b1;
				end
				else
					write_tx<= 1'b0;
			end
		end
		2'd1:
		begin
			write_tx<= 1'b0;
			data_out   <= mem[rd_ptr];
		end
		2'd2:
		begin
			write_tx<= 1'b0;
			data_out   <= mem[rd_ptr];
		end
		default:
		begin
			rd_ptr     <= rd_ptr;
			data_out   <= data_out;
		end
		endcase
	end
end

endmodule
