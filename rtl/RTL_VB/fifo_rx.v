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

	reg block_read;
	reg block_write;

	reg [AWIDTH-1:0] credit_counter;

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
			block_write <= 1'b0;
			overflow_credit_error<=1'b0;
		end
		else
		begin
			if(block_write)
			begin
				if(!wr_en)
				begin
					block_write <= 1'b0;
					wr_ptr <= wr_ptr + 6'd1;	
				end				
				//mem[wr_ptr-6'd1]<=data_in;
			end
			else if (wr_en && !f_full)
			begin
				block_write <= 1'b1;
				mem[wr_ptr]<=data_in;

			end

			if(wr_en && credit_counter > 6'd55)
			begin
				
				overflow_credit_error<=1'b1;
			end
		end
	end

//FULL - EMPTY COUNTER

	always@(posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			f_full  <= 1'b0;
			f_empty <= 1'b1;
			counter <= {(AWIDTH){1'b0}};
			credit_counter <= 6'd55;
		end
		else
		begin

			if((wr_en && !f_full && !block_write) && (rd_en && !f_empty && !block_read))
			begin
				if(rd_ptr == 6'd8 || rd_ptr == 6'd16 || rd_ptr == 6'd24 || rd_ptr == 6'd32 || rd_ptr == 6'd40 || rd_ptr == 6'd48 || rd_ptr == 6'd56 || rd_ptr == 6'd63)
					credit_counter   <= credit_counter - 6'd1 + 6'd8;
				else
					credit_counter   <= credit_counter - 6'd1;
			end
			else if (wr_en && !f_full && !block_write)
			begin
				credit_counter   <= credit_counter - 6'd1;
			end
			else if(rd_en && !f_empty && !block_read)
			begin
				if(rd_ptr == 6'd8 || rd_ptr == 6'd16 || rd_ptr == 6'd24 || rd_ptr == 6'd32 || rd_ptr == 6'd40 || rd_ptr == 6'd48 || rd_ptr == 6'd56 || rd_ptr == 6'd63)
				begin					
					credit_counter <= credit_counter + 6'd8;
				end
			end
			else 
				credit_counter <= credit_counter;

			if((wr_en && !f_full && !block_write) && (rd_en && !f_empty && !block_read))
			begin
				counter <= counter;
			end
			else if (wr_en && !f_full && !block_write)
			begin
				counter <= counter + 6'd1;
			end
			else if(rd_en && !f_empty && !block_read)
			begin
				counter <= counter - 6'd1;
			end
			else
			begin
				counter <= counter;
			end

			if(counter == 6'd63)
			begin
				f_full <= 1'b1;
			end
			else
			begin
				f_full <= 1'b0;
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
			open_slot_fct<= 1'b0;
			block_read <= 1'b0;
		end
		else
		begin

			if(rd_ptr == 6'd8 || rd_ptr == 6'd16 || rd_ptr == 6'd24 || rd_ptr == 6'd32 || rd_ptr == 6'd40 || rd_ptr == 6'd48 || rd_ptr == 6'd56 || rd_ptr == 6'd63)
			begin
				open_slot_fct<= 1'b1;
			end
			else
			begin
				open_slot_fct<= 1'b0;
			end

			if(block_read)
			begin
				if(!rd_en)
				begin
					block_read<= 1'b0;
				end
			end	
			else 
			if(rd_en && !f_empty)
			begin
				block_read<= 1'b1;
				rd_ptr <= rd_ptr+ 6'd1;
			end
				
			data_out  <= mem[rd_ptr];

		end
	end

	//assign f_empty   = ((wr_ptr - rd_ptr) == 6'd0)?1'b1:1'b0;
	//assign wr        = (wr_en && !f_full)?wr_ptr + 6'd1:wr_ptr + 6'd0;
	//assign rd        = (rd_en && !f_empty)?rd_ptr+ 6'd1:rd_ptr + 6'd0;

endmodule
