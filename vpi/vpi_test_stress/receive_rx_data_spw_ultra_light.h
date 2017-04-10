static int receive_rx_data_spw_ultra_light_calltf(char*user_data)
{
	vpiHandle CREDIT_ERROR_RX  = vpi_handle_by_name("module_tb.CREDIT_ERROR_RX",NULL);
	vpiHandle SEND_FCT_NOW 	   = vpi_handle_by_name("module_tb.TOP_SEND_FCT_NOW",NULL);

	vpiHandle DATARX_FLAG      = vpi_handle_by_name("module_tb.DATARX_FLAG",NULL);
	vpiHandle BUFFER_WRITE     = vpi_handle_by_name("module_tb.BUFFER_WRITE",NULL);

	value_to_rx.format = vpiIntVal;
	
	if(SC_TOP->reset_set())
	{
		
		value_to_rx.value.integer = 0;
		vpi_put_value(SEND_FCT_NOW, &value_to_rx, NULL, vpiNoDelay);

		vpi_get_value(DATARX_FLAG, &value_to_rx);
		SC_TOP->data_o(value_to_rx.value.integer,data_rx_received_cnt);
			
		data_rx_received_cnt++;

		if(data_rx_received_cnt == 100)
			data_rx_received_cnt = 0;

		fct_send_cnt++;

		if(fct_send_cnt == 7)
		{								
			value_to_rx.value.integer = 1;
			vpi_put_value(SEND_FCT_NOW, &value_to_rx, NULL, vpiNoDelay);
			fct_send_cnt = 0;
		}

	}

	return 0;
}
