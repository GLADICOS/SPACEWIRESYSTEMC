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
module mem_data
#(
	parameter integer DWIDTH = 9,
	parameter integer AWIDTH = 6
)

(
		input clock, 
		input reset, 

		input [DWIDTH-1:0] data_in,

		input [AWIDTH-1:0] wr_ptr,
		input [AWIDTH-1:0] rd_ptr,

		output reg [DWIDTH-1:0] data_out
);

	reg [DWIDTH-1:0] MEM [0:2**AWIDTH-1]/* synthesis syn_ramstyle = "M-RAM" */;

always@(posedge clock or negedge reset)
begin
	if (!reset)
	begin
		MEM[0]  <= {(DWIDTH){1'b0}};
		MEM[1]  <= {(DWIDTH){1'b0}};
		MEM[2]  <= {(DWIDTH){1'b0}};
		MEM[3]  <= {(DWIDTH){1'b0}};
		MEM[4]  <= {(DWIDTH){1'b0}};
		MEM[5]  <= {(DWIDTH){1'b0}};
		MEM[6]  <= {(DWIDTH){1'b0}};
		MEM[7]  <= {(DWIDTH){1'b0}};
		MEM[8]  <= {(DWIDTH){1'b0}};
		MEM[9]  <= {(DWIDTH){1'b0}};
		MEM[10] <= {(DWIDTH){1'b0}};

		MEM[11] <= {(DWIDTH){1'b0}};
		MEM[12] <= {(DWIDTH){1'b0}};
		MEM[13] <= {(DWIDTH){1'b0}};
		MEM[14] <= {(DWIDTH){1'b0}};
		MEM[15] <= {(DWIDTH){1'b0}};
		MEM[16] <= {(DWIDTH){1'b0}};
		MEM[17] <= {(DWIDTH){1'b0}};
		MEM[18] <= {(DWIDTH){1'b0}};
		MEM[19] <= {(DWIDTH){1'b0}};
		MEM[20] <= {(DWIDTH){1'b0}};
		MEM[21] <= {(DWIDTH){1'b0}};

		MEM[22] <= {(DWIDTH){1'b0}};
		MEM[23] <= {(DWIDTH){1'b0}};
		MEM[24] <= {(DWIDTH){1'b0}};
		MEM[25] <= {(DWIDTH){1'b0}};
		MEM[26] <= {(DWIDTH){1'b0}};
		MEM[27] <= {(DWIDTH){1'b0}};
		MEM[28] <= {(DWIDTH){1'b0}};
		MEM[29] <= {(DWIDTH){1'b0}};
		MEM[30] <= {(DWIDTH){1'b0}};
		MEM[31] <= {(DWIDTH){1'b0}};
		MEM[32] <= {(DWIDTH){1'b0}};

		MEM[33] <= {(DWIDTH){1'b0}};
		MEM[34] <= {(DWIDTH){1'b0}};
		MEM[35] <= {(DWIDTH){1'b0}};
		MEM[36] <= {(DWIDTH){1'b0}};
		MEM[37] <= {(DWIDTH){1'b0}};
		MEM[38] <= {(DWIDTH){1'b0}};
		MEM[39] <= {(DWIDTH){1'b0}};
		MEM[40] <= {(DWIDTH){1'b0}};
		MEM[41] <= {(DWIDTH){1'b0}};
		MEM[42] <= {(DWIDTH){1'b0}};
		MEM[43] <= {(DWIDTH){1'b0}};

		MEM[44] <= {(DWIDTH){1'b0}};
		MEM[45] <= {(DWIDTH){1'b0}};
		MEM[46] <= {(DWIDTH){1'b0}};
		MEM[47] <= {(DWIDTH){1'b0}};
		MEM[48] <= {(DWIDTH){1'b0}};
		MEM[49] <= {(DWIDTH){1'b0}};
		MEM[50] <= {(DWIDTH){1'b0}};
		MEM[51] <= {(DWIDTH){1'b0}};
		MEM[52] <= {(DWIDTH){1'b0}};
		MEM[53] <= {(DWIDTH){1'b0}};
		MEM[54] <= {(DWIDTH){1'b0}};
		MEM[55] <= {(DWIDTH){1'b0}};
		
		MEM[56] <= {(DWIDTH){1'b0}};
		MEM[57] <= {(DWIDTH){1'b0}};
		MEM[58] <= {(DWIDTH){1'b0}};
		MEM[59] <= {(DWIDTH){1'b0}};
		MEM[60] <= {(DWIDTH){1'b0}};
		MEM[61] <= {(DWIDTH){1'b0}};
		MEM[62] <= {(DWIDTH){1'b0}};
		MEM[63] <= {(DWIDTH){1'b0}};
		data_out  <= 9'd0;

	end
	else
	begin
		MEM[wr_ptr]<=data_in;
		data_out <= MEM[rd_ptr];	

	end
end
endmodule
