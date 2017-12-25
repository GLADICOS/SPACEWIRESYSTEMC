module bit_capture_control(
			input negedge_clk,
			input posedge_clk,
			input rx_resetn,
			
			input rx_din,
			
			output reg bit_c_0,
			output reg bit_c_1,
			output reg bit_c_2,
			output reg bit_c_3
		  );


always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_c_1      	<= 1'b0;
		bit_c_3      	<= 1'b0;
	end
	else
	begin
		bit_c_1 <= rx_din;
		bit_c_3 <= bit_c_1;
	end

end

always@(posedge negedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		bit_c_0   <= 1'b0;
		bit_c_2   <= 1'b0;
	end
	else
	begin
		bit_c_0 <= rx_din;
		bit_c_2 <= bit_c_0;
	end
end


endmodule
