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


	reg [DWIDTH-1:0] mem [0:2**AWIDTH-1]/* synthesis syn_ramstyle = "M-RAM" */;


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
	end
	else
	begin
		mem[wr_ptr]<=data_in;
	end
end

//Read pointer
always@(posedge clock or negedge reset)
begin
	if (!reset)
	begin
		data_out   <= 9'd0;
	end
	else
	begin
		data_out   <= mem[rd_ptr];
	end
end

endmodule
