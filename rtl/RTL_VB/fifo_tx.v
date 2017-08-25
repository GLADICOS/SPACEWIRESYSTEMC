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

	reg block_read;
	reg block_write;

	wire [AWIDTH-1:0] wr;
	wire [AWIDTH-1:0] rd;

//Write pointer
	always@(posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			wr_ptr <= {(AWIDTH){1'b0}};
			block_write <= 1'b0;
		end
		else if(block_write)
		begin
			if(!wr_en)
				block_write <= 1'b0;	
		end
		else if (wr_en && !f_full)
		begin
			block_write <= 1'b1;
			mem[wr_ptr]<=data_in;
			wr_ptr <= wr;
		end
	end

//FULL - EMPTY COUNTER

	always@(posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			f_full <= 1'b0;
			f_empty<= 1'b1;
			counter <= {(AWIDTH){1'b0}};
		end
		else
		begin

			if (wr_en && !f_full && !block_write)
			begin
				if(rd_en && !f_empty && !block_read)
				begin
					counter <= counter;
				end
				else
				begin
					counter <= counter + 6'd1;
				end
			end
			else if(rd_en && !f_empty && !block_read)
			begin
				counter <= counter - 6'd1;
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
			rd_ptr   <= {(AWIDTH){1'b0}};
			data_out <= 9'd0;
			write_tx <= 1'b0;
			block_read <= 1'b0;
		end
		else
		begin

			if(block_read == 1)
			begin
				if(!rd_en)
					block_read<= 1'b0;

				data_out  <= mem[rd_ptr];
			end	
			else if(rd_en && !f_empty)
			begin
				rd_ptr <= rd;
				block_read<= 1'b1;
			end
			else
			begin
				data_out  <= mem[rd_ptr];
			end

			if(rd_en == 1'b1)
			begin
				write_tx<= 1'b0;
			end
			else if(counter > 6'd0)
			begin
				write_tx<= 1'b1;
			end
			else
				write_tx<= write_tx;

		end
	end

	//assign f_empty   = ((wr_ptr - rd_ptr) == 6'd0)?1'b1:1'b0;
	assign wr        = (wr_en && !f_full)?wr_ptr + 6'd1:wr_ptr + 6'd0;
	assign rd        = (rd_en && !f_empty)?rd_ptr+ 6'd1:rd_ptr + 6'd0;

endmodule
