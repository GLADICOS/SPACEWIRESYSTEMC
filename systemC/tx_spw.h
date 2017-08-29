#ifndef SPW_TX_T_H
#define SPW_TX_T_H

#define START  		                0
#define SEND_NULL 		        1
#define SEND_FCT_NULL                   2
#define SEND_TIME_CODE_FCT_NCHAR_NULL   3

#define TYPE_TIMECODE      4
#define TYPE_FCT           5
#define TYPE_NCHAR_EOP_EEP 6
#define TYPE_NULL 	   7

class SPW_TX_SC;

SC_MODULE(SPW_TX_SC)
{
	//SIGNALS
	sc_in<bool> CLOCK_TX;
	sc_in<bool> RESET_TX;

	sc_in<bool> CLOCK_SYS;

	sc_in<bool> TICKIN_TX;
	sc_in<sc_uint<8> > TIMEIN_CONTROL_FLAG_TX;

	sc_in<bool> TXWRITE_TX;
	sc_in<sc_uint<9> > TXDATA_FLAGCTRL_TX;

	sc_in<bool> SEND_FCT_NOW;

	sc_in<bool> ENABLE_TX;
	sc_in<bool> SEND_NULL_TX;
	sc_in<bool> SEND_FCT_TX;
	sc_in<bool> SEND_NCHAR_TX;
	sc_in<bool> SEND_TIME_CODE_TX;
	sc_in<bool> GOTFCT_TX;

	sc_out<bool> READY_TX;
	sc_out<bool> READY_TICK;
	sc_out<uint> DOUT;
	sc_out<uint> SOUT;
	sc_out<sc_uint<4> > FSM_TX;

	//INTERNAL
	sc_uint<9> TXDATA_FLAGCTRL_TX_AUX;
	sc_uint<9> TXDATA_FLAGCTRL_TX_LAST;

	sc_uint<8> LAST_TIMEIN_CONTROL_FLAG_TX;

	sc_uint<4> state_tx;
	
	bool first_time;
	bool working;
	
	unsigned int last_type;	
	unsigned int COUNTER;
	unsigned int counter_first_time;

	uint FCT_COUNTER;

	uint FCT_SEND = 0;

	sc_uint<4> ESC;
	sc_uint<4> EOP;
	sc_uint<4> EEP;
	sc_uint<4> FCT;

	sc_uint<8> NULL_S;
	sc_uint<14> TIME_CODE;

	uint DOUT_LAST;
	uint SOUT_LAST;

	//STATE MACHINE CONTROL
	void TYPE_DATA_STATE()
	{
		//cout << "TYPE_DATA_STATE" << endl;
			
			if(RESET_TX)
			{
				//cout << "RESETED" << " " << RESET_TX << endl;
				state_tx = START;
				DOUT_LAST = 0;
				COUNTER = 0;
				FCT_COUNTER = 0;
				counter_first_time = 0;
				//FCT_SEND = 0;

				last_type = TYPE_NULL;
				NULL_S[7] = 0;
				NULL_S[6] = 1;
				NULL_S[5] = 1;
				NULL_S[4] = 1;
				NULL_S[3] = 0;
				NULL_S[2] = 1;
				NULL_S[1] = 0;
				NULL_S[0] = 0;

				FCT[3] = 0;
				FCT[2] = 1;
				FCT[1] = 0;
				FCT[0] = 0;

				TIME_CODE[13] = 0;
				TIME_CODE[12] = 1;
				TIME_CODE[11] = 1;
				TIME_CODE[10] = 1;
				TIME_CODE[9]  = 1;
				TIME_CODE[8]  = 0;
				TIME_CODE[7]  = 0;
				TIME_CODE[6]  = 0;
				TIME_CODE[5]  = 0;
				TIME_CODE[4]  = 0;
				TIME_CODE[3]  = 0;
				TIME_CODE[2]  = 0;
				TIME_CODE[1]  = 0;
				TIME_CODE[0]  = 0;

				EOP[3] = 0;
				EOP[2] = 1;
				EOP[1] = 0;
				EOP[0] = 1;

				EEP[3] = 0;
				EEP[2] = 1;
				EEP[1] = 1;
				EEP[0] = 0;

				first_time       = true;
				enable_null	 = false;
				enable_fct	 = false;
				enable_time_code = false;
				enable_n_char	 = false;
			}
			else
			{
				FSM_TX = state_tx;
				//cout << "STATE TX: " << state_tx << endl;
				switch(state_tx)
				{
					case START:

						if(SEND_NULL_TX && ENABLE_TX)
						{
							state_tx = SEND_NULL;
						}
					break;
					case SEND_NULL:
						enable_null = true;
						enable_fct = false;
						state_tx = SEND_NULL;
						last_type = TYPE_NULL;
						if(SEND_NULL_TX && SEND_FCT_TX && ENABLE_TX && counter_first_time > 0)
						{
							state_tx = SEND_FCT_NULL;
							//cout << enable_fct << endl;
						}
					break;
					case SEND_FCT_NULL:
						
						state_tx = SEND_FCT_NULL;

						if(SEND_FCT_TX && FCT_COUNTER -1 > 0)
						{
							state_tx =  SEND_TIME_CODE_FCT_NCHAR_NULL;
						}else if(SEND_FCT_TX && FCT_SEND > 0 && enable_null == false)
						{
							enable_fct = true;
						}else if(SEND_FCT_TX && enable_fct == false && FCT_SEND == 0)
						{
							enable_null = true;
						}
						  //cout << enable_null << " " << enable_fct << endl;
					break;
					case SEND_TIME_CODE_FCT_NCHAR_NULL:
						if(TICKIN_TX && enable_n_char == false && enable_fct == false && enable_null == false)
						{
							enable_time_code = true;
						}else if(FCT_SEND > 0 && enable_n_char == false && enable_time_code == false && enable_null == false)
						{
							enable_fct = true;
						}else if(TXWRITE_TX && FCT_COUNTER-1 > 0 &&  enable_fct == false && enable_time_code == false && enable_null == false)
						{
							enable_n_char = true;
						}else if(enable_fct == false && enable_time_code == false && enable_n_char == false)
						{
							enable_null = true;
						}
					break;
				}
			}
	}

	/*SLOTS OPEN IN OTHER SIDE*/
	void FCT_COUNTER_M()
	{
		if(RESET_TX)
		{
			FCT_COUNTER = 0;
		}
		else
		{
			 if(SEND_FCT_TX && GOTFCT_TX)
			 {
				FCT_COUNTER = FCT_COUNTER +8;
				//cout << "DATA TO SEND" << " " << FCT_COUNTER <<endl;
			 }
		}
	}

	/*TAKE  FCT SEND FASE */
	void FCT_COUNTER_SEND()
	{
			if(RESET_TX)
				FCT_SEND=7;
			else 
			{
				if(SEND_FCT_NOW)
				{
					FCT_SEND = FCT_SEND + 1;
					//cout << "DATA RECEIVED" <<endl;
				}
			}
	}

	void ALL_HERE()
	{
		if(RESET_TX)
		{
			DOUT = 0;
			SOUT = 0;
		}
		else
		{
			READY_TX   = false;
			READY_TICK = false;
			EEP_EOP    = false;
			if(enable_null)//
			{
				if(COUNTER == 0)
				{
					if(first_time)
					{
						DOUT_LAST=DOUT = NULL_S[7];
						SOUT=!SOUT;
					}else if(last_type == TYPE_NULL)
					{
						if(DOUT == !(NULL_S[6]^NULL_S[0]^NULL_S[1]))
						{
							DOUT = !(NULL_S[6]^NULL_S[0]^NULL_S[1]);
							SOUT=!SOUT;
						}else
						{
							DOUT = !(NULL_S[6]^NULL_S[0]^NULL_S[1]);
							SOUT=SOUT;
						}

					}else if(last_type == TYPE_FCT)
					{
						if(DOUT == !(NULL_S[6]^FCT[0]^FCT[1]))
						{
							DOUT = !(NULL_S[6]^FCT[0]^FCT[1]);
							SOUT=!SOUT;
						}else
						{
							DOUT = !(NULL_S[6]^FCT[0]^FCT[1]);
							SOUT=SOUT;
						}

					}else if(last_type == TYPE_NCHAR_EOP_EEP)
					{
						if(TXDATA_FLAGCTRL_TX_LAST[8] == 1)
						{
							EEP_EOP = true;
							if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 0)
							{
								if(DOUT == !(NULL_S[6]^EOP[0]^EOP[1]))
								{
									SOUT=!SOUT;
								}
								else
								{
									SOUT=SOUT;
								}
								DOUT =  !(NULL_S[6]^EOP[0]^EOP[1]);
							}else if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 1)
							{
								if(DOUT == !(NULL_S[6]^EEP[0]^EEP[1]))
								{
									SOUT=!SOUT;
								}
								else
								{
									SOUT=SOUT;
								}
								DOUT =  !(NULL_S[6]^EEP[0]^EEP[1]);
							}
						}
						else
						{
							if(DOUT == !(NULL_S[6]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]))
							{
								DOUT = !(NULL_S[6]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]);
								SOUT=!SOUT;
							}else
							{
								DOUT = !(NULL_S[6]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]);
								SOUT=SOUT;
							}
						}
					}else if(last_type == TYPE_TIMECODE)
					{
						if(DOUT ==  !(NULL_S[6]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]))
							SOUT=!SOUT;
						else
							SOUT=SOUT;

						DOUT =  !(NULL_S[6]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]);
					}
				}
				else if(COUNTER == 1)
				{
					if(DOUT == NULL_S[6])
					{
						SOUT=!SOUT;
						DOUT = NULL_S[6];
					}else
					{
						SOUT=SOUT;
						DOUT = NULL_S[6];
					}
				}
				else if(COUNTER == 2)
				{
					if(DOUT == NULL_S[5])
					{
						SOUT=!SOUT;
						DOUT = NULL_S[5];
					}else
					{
						SOUT=SOUT;
						DOUT = NULL_S[5];
					}
				}
				else if(COUNTER == 3)
				{
					if(DOUT == NULL_S[4])
					{
						SOUT=!SOUT;
						DOUT = NULL_S[4];
					}else
					{
						SOUT=SOUT;
						DOUT = NULL_S[4];
					}
				}
				else if(COUNTER == 4)
				{
					if(DOUT == NULL_S[3])
					{
						SOUT=!SOUT;
						DOUT = NULL_S[3];
					}else
					{
						SOUT=SOUT;
						DOUT = NULL_S[3];
					}
				}
				else if(COUNTER == 5)
				{
					if(DOUT == NULL_S[2])
					{
						SOUT=!SOUT;
						DOUT = NULL_S[2];
					}else
					{
						SOUT=SOUT;
						DOUT = NULL_S[2];
					}
				}
				else if(COUNTER == 6)
				{
					if(DOUT == NULL_S[1])
					{
						SOUT=!SOUT;
						DOUT = NULL_S[1];
					}else
					{
						SOUT=SOUT;
						DOUT = NULL_S[1];
					}
				}
				else if(COUNTER == 7)
				{
					if(DOUT == NULL_S[0])
					{
						SOUT=!SOUT;
						DOUT = NULL_S[0];
					}else
					{
						SOUT=SOUT;
						DOUT = NULL_S[0];
					}
				}

				first_time = false;
				COUNTER++;

				if(COUNTER == 8)
				{
					COUNTER = 0;
					enable_null = false;
					last_type = TYPE_NULL;
					
					if(state_tx == SEND_NULL)
						counter_first_time = counter_first_time + 1;
				}

			}else if(enable_fct)//
			{

				if(COUNTER == 0)
				{
					if(last_type == TYPE_NULL)
					{
						if(DOUT == !(FCT[2]^NULL_S[0]^NULL_S[1]))
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = !(FCT[2]^NULL_S[0]^NULL_S[1]);
					}else if(last_type == TYPE_FCT)
					{
						if(DOUT == !(FCT[2]^FCT[0]^FCT[1]))
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = !(FCT[2]^FCT[0]^FCT[1]);
					}else if(last_type == TYPE_NCHAR_EOP_EEP)
					{
							if(TXDATA_FLAGCTRL_TX_LAST[8] == 1)
							{
								EEP_EOP = true;
								if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 0)
								{
									if(DOUT == !(FCT[2]^EOP[0]^EOP[1]))
									{
										SOUT=!SOUT;
									}
									else
									{
										SOUT=SOUT;
									}
									DOUT =  !(FCT[2]^EOP[0]^EOP[1]);
								}else if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 1)
								{
									if(DOUT == !(FCT[2]^EEP[0]^EEP[1]))
									{
										SOUT=!SOUT;
									}
									else
									{
										SOUT=SOUT;
									}
									DOUT =  !(FCT[2]^EEP[0]^EEP[1]);
								}
							}
							else
							{
								if(DOUT == !(FCT[2]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]))
								{
									SOUT=!SOUT;
								}
								else
								{
									SOUT=SOUT;
								}
								DOUT =  !(FCT[2]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]);
							}
					}else if(last_type == TYPE_TIMECODE)
					{
							if(DOUT ==  !(FCT[2]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]))
							{
								SOUT=!SOUT;
							}else
							{
								SOUT=SOUT;
							}
							DOUT =  !(FCT[2]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]);
					}
				}
				else if(COUNTER == 1)
				{
					if(DOUT == FCT[2])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = FCT[2];
				}
				else if(COUNTER == 2)
				{
					if(DOUT == FCT[1])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = FCT[1];
				}
				else if(COUNTER == 3)
				{
					if(DOUT == FCT[0])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = FCT[0];
				}

				COUNTER++;

				if(COUNTER == 4)
				{
					COUNTER = 0;
					FCT_SEND = FCT_SEND - 1;
					enable_fct = false;
					last_type = TYPE_FCT;
				}
		
			}else if(enable_time_code)//
			{

				TIME_CODE(7,0) = TIMEIN_CONTROL_FLAG_TX;

				if(COUNTER == 0)
				{
					if(last_type == TYPE_NULL)
					{
						if(DOUT == !(TIME_CODE[12]^NULL_S[0]^NULL_S[1]))
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = !(TIME_CODE[12]^NULL_S[0]^NULL_S[1]);
					}else if(last_type == TYPE_FCT)
					{
						if(DOUT == !(TIME_CODE[12]^FCT[0]^FCT[1]))
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = !(TIME_CODE[12]^FCT[0]^FCT[1]);
					}else if(last_type == TYPE_NCHAR_EOP_EEP)
					{
							if(TXDATA_FLAGCTRL_TX_LAST[8] == 1)
							{
								EEP_EOP = true;
								if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 0)
								{
									if(DOUT == !(TIME_CODE[12]^EOP[0]^EOP[1]))
									{
										SOUT=!SOUT;
									}
									else
									{
										SOUT=SOUT;
									}
									DOUT =  !(TIME_CODE[12]^EOP[0]^EOP[1]);
								}else if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 1)
								{
									if(DOUT == !(TIME_CODE[12]^EEP[0]^EEP[1]))
									{
										SOUT=!SOUT;
									}
									else
									{
										SOUT=SOUT;
									}
									DOUT =  !(TIME_CODE[12]^EEP[0]^EEP[1]);
								}
							}
							else
							{
								if(DOUT == !(TIME_CODE[12]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]))
								{
									SOUT=!SOUT;
								}
								else
								{
									SOUT=SOUT;
								}
								DOUT =  !(TIME_CODE[12]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]);
							}
					}else if(last_type == TYPE_TIMECODE)
					{
							if( DOUT ==  !(TIME_CODE[12]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]))
							{
								SOUT=!SOUT;
							}
							else
							{
								SOUT=SOUT;
							}
							DOUT = !(TIME_CODE[12]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]);
					}
				}else if(COUNTER == 1)
				{
					if(DOUT == TIME_CODE[12])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[12];
				}
				else if(COUNTER == 2)
				{
					if(DOUT == TIME_CODE[11])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[11];
				}
				else if(COUNTER == 3)
				{
					if(DOUT == TIME_CODE[10])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[10];
				}
				else if(COUNTER == 4)
				{
					if(DOUT == TIME_CODE[9])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[9];
				}
				else if(COUNTER == 5)
				{
					if(DOUT == TIME_CODE[8])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[8];
				}
				else if(COUNTER == 6)
				{
					if(DOUT == TIME_CODE[0])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[0];
				}
				else if(COUNTER == 7)
				{
					if(DOUT == TIME_CODE[1])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[1];
				}
				else if(COUNTER == 8)
				{
					if(DOUT == TIME_CODE[2])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[2];
				}
				else if(COUNTER == 9)
				{
					if(DOUT == TIME_CODE[3])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[3];
				}
				else if(COUNTER == 10)
				{
					if(DOUT == TIME_CODE[4])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[4];
				}
				else if(COUNTER == 11)
				{
					if(DOUT == TIME_CODE[5])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[5];
				}
				else if(COUNTER == 12)
				{
					if(DOUT == TIME_CODE[6])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[6];
				}
				else if(COUNTER == 13)
				{
					if(DOUT == TIME_CODE[7])
					{
						SOUT=!SOUT;
					}
					else
					{
						SOUT=SOUT;
					}
					DOUT = TIME_CODE[7];
				}


				COUNTER++;

				if(COUNTER == 14)
				{
					COUNTER = 0;
					READY_TICK = true;
					enable_time_code = false;
					last_type = TYPE_TIMECODE;
					LAST_TIMEIN_CONTROL_FLAG_TX = TIMEIN_CONTROL_FLAG_TX;
				}

			}else if(enable_n_char)//
			{

				TXDATA_FLAGCTRL_TX_AUX = TXDATA_FLAGCTRL_TX;

				if(TXDATA_FLAGCTRL_TX_AUX[8])//EOP-EEP
				{

					if(TXDATA_FLAGCTRL_TX_AUX(1,0) == 0) //EOP
					{
						if(COUNTER == 0)
						{
							if(last_type == TYPE_NULL)
							{
								if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^NULL_S[0]^NULL_S[1]))
								{
									SOUT=!SOUT;
								}
								else
								{
									SOUT=SOUT;
								}
								DOUT = !(TXDATA_FLAGCTRL_TX_AUX[8]^NULL_S[0]^NULL_S[1]);
							}else if(last_type == TYPE_FCT)
							{
								if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^FCT[0]^FCT[1]))
								{
									SOUT=!SOUT;
								}
								else
								{
									SOUT=SOUT;
								}
								DOUT = !(TXDATA_FLAGCTRL_TX_AUX[8]^FCT[0]^FCT[1]);
							}else if(last_type == TYPE_NCHAR_EOP_EEP)
							{
									if(TXDATA_FLAGCTRL_TX_LAST[8] == 1)
									{
										EEP_EOP = true;
										if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 0)
										{
											if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^EOP[0]^EOP[1]))
											{
												SOUT=!SOUT;
											}
											else
											{
												SOUT=SOUT;
											}
											DOUT =  !(TXDATA_FLAGCTRL_TX_AUX[8]^EOP[0]^EOP[1]);
										}else if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 1)
										{
											if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^EEP[0]^EEP[1]))
											{
												SOUT=!SOUT;
											}
											else
											{
												SOUT=SOUT;
											}
											DOUT =  !(TXDATA_FLAGCTRL_TX_AUX[8]^EEP[0]^EEP[1]);
										}
									}
									else
									{
										if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]))
										{
											SOUT=!SOUT;
										}
										else
										{
											SOUT=SOUT;
										}
										DOUT = !(TXDATA_FLAGCTRL_TX_AUX[8]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]);
									}
							}else if(last_type == TYPE_TIMECODE)
							{
								if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]))
								{
									SOUT=!SOUT;
								}
								else
								{
									SOUT=SOUT;
								}
								DOUT =  !(TXDATA_FLAGCTRL_TX_AUX[8]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]);
							}
						}
						else if(COUNTER == 1)
						{
							if(DOUT == EOP[2])
							{
								SOUT=!SOUT;
							}
							else
							{
								SOUT=SOUT;
							}
							DOUT = EOP[2];
						}
						else if(COUNTER == 2)
						{
							if(DOUT == EOP[1])
							{
								SOUT=!SOUT;
							}
							else
							{
								SOUT=SOUT;
							}
							DOUT = EOP[1];
						}
						else if(COUNTER == 3)
						{
							if(DOUT == EOP[0])
							{
								SOUT=!SOUT;
							}
							else
							{
								SOUT=SOUT;
							}
							DOUT = EOP[0];
						}

						COUNTER++;

						if(COUNTER == 4)
						{
							COUNTER = 0;
							READY_TX = true;
							TXDATA_FLAGCTRL_TX_LAST = TXDATA_FLAGCTRL_TX_AUX;
							FCT_COUNTER = FCT_COUNTER - 1;
							enable_n_char = false;
							last_type = TYPE_NCHAR_EOP_EEP;
						}
					}
					else if(TXDATA_FLAGCTRL_TX_AUX(1,0) == 1)//EEP
					{
						if(COUNTER == 0)
						{
							if(last_type == TYPE_NULL)
							{
								if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^NULL_S[0]^NULL_S[1]))
								{
									SOUT=!SOUT;
								}
								else
								{
									SOUT=SOUT;
								}
								DOUT = !(TXDATA_FLAGCTRL_TX_AUX[8]^NULL_S[0]^NULL_S[1]);
							}else if(last_type == TYPE_FCT)
							{
								if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^FCT[0]^FCT[1]))
								{
									SOUT=!SOUT;
								}
								else
								{
									SOUT=SOUT;
								}
								DOUT = !(TXDATA_FLAGCTRL_TX_AUX[8]^FCT[0]^FCT[1]);
							}else if(last_type == TYPE_NCHAR_EOP_EEP)
							{
									if(TXDATA_FLAGCTRL_TX_LAST[8] == 1)
									{
										EEP_EOP = true;
										if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 0)
										{
											if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^EOP[0]^EOP[1]))
											{
												SOUT=!SOUT;
											}
											else
											{
												SOUT=SOUT;
											}
											DOUT =  !(TXDATA_FLAGCTRL_TX_AUX[8]^EOP[0]^EOP[1]);
										}else if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 1)
										{
											if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^EEP[0]^EEP[1]))
											{
												SOUT=!SOUT;
											}
											else
											{
												SOUT=SOUT;
											}
											DOUT =  !(TXDATA_FLAGCTRL_TX_AUX[8]^EEP[0]^EEP[1]);
										}
									}
									else
									{
										if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]))
										{
											SOUT=!SOUT;
										}
										else
										{
											SOUT=SOUT;
										}
										DOUT = !(TXDATA_FLAGCTRL_TX_AUX[8]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]);
									}
							}else if(last_type == TYPE_TIMECODE)
							{
								if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]))
								{
									SOUT=!SOUT;
								}
								else
								{
									SOUT=SOUT;
								}
								DOUT =  !(TXDATA_FLAGCTRL_TX_AUX[8]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]);
							}
						}
						else if(COUNTER == 1)
						{
							if(DOUT == EEP[2])
							{
								SOUT=!SOUT;
							}
							else
							{
								SOUT=SOUT;
							}
							DOUT = EEP[2];
						}
						else if(COUNTER == 2)
						{
							if(DOUT == EEP[1])
							{
								SOUT=!SOUT;
							}
							else
							{
								SOUT=SOUT;
							}
							DOUT = EEP[1];
						}
						else if(COUNTER == 3)
						{
							if(DOUT == EOP[0])
							{
								SOUT=!SOUT;
							}
							else
							{
								SOUT=SOUT;
							}
							DOUT = EOP[0];
						}

						COUNTER++;

						if(COUNTER == 4)
						{
							COUNTER = 0;
							READY_TX = true;
							TXDATA_FLAGCTRL_TX_LAST = TXDATA_FLAGCTRL_TX_AUX;
							FCT_COUNTER = FCT_COUNTER - 1;
							enable_n_char = false;
							last_type = TYPE_NCHAR_EOP_EEP;
						}
					}

				}
				else //DATA
				{
					if(COUNTER == 0)
					{
						if(last_type == TYPE_NULL)
						{
							if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^NULL_S[0]^NULL_S[1]))
							{
								SOUT=!SOUT;
							}
							else
							{
								SOUT=SOUT;
							}
							DOUT = !(TXDATA_FLAGCTRL_TX_AUX[8]^NULL_S[0]^NULL_S[1]);
						}else if(last_type == TYPE_FCT)
						{
							if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^FCT[0]^FCT[1]))
							{
								SOUT=!SOUT;
							}
							else
							{
								SOUT=SOUT;
							}
							DOUT = !(TXDATA_FLAGCTRL_TX_AUX[8]^FCT[0]^FCT[1]);
						}else if(last_type == TYPE_NCHAR_EOP_EEP)
						{
								if(TXDATA_FLAGCTRL_TX_LAST[8] == 1)
								{
									EEP_EOP = true;
									if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 0)
									{
										if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^EOP[0]^EOP[1]))
										{
											SOUT=!SOUT;
										}
										else
										{
											SOUT=SOUT;
										}
										DOUT =  !(TXDATA_FLAGCTRL_TX_AUX[8]^EOP[0]^EOP[1]);
									}else if(TXDATA_FLAGCTRL_TX_LAST(1,0) == 1)
									{
										if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^EEP[0]^EEP[1]))
										{
											SOUT=!SOUT;
										}
										else
										{
											SOUT=SOUT;
										}
										DOUT =  !(TXDATA_FLAGCTRL_TX_AUX[8]^EEP[0]^EEP[1]);
									}
								}
								else
								{
									if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]))
									{
										SOUT=!SOUT;
									}
									else
									{
										SOUT=SOUT;
									}
									DOUT = !(TXDATA_FLAGCTRL_TX_AUX[8]^TXDATA_FLAGCTRL_TX_LAST[0]^TXDATA_FLAGCTRL_TX_LAST[1]^TXDATA_FLAGCTRL_TX_LAST[2]^TXDATA_FLAGCTRL_TX_LAST[3]^ TXDATA_FLAGCTRL_TX_LAST[4]^TXDATA_FLAGCTRL_TX_LAST[5]^TXDATA_FLAGCTRL_TX_LAST[6]^TXDATA_FLAGCTRL_TX_LAST[7]);
								}
						}else if(last_type == TYPE_TIMECODE)
						{
							if(DOUT == !(TXDATA_FLAGCTRL_TX_AUX[8]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]))
							{
								SOUT=!SOUT;
							}
							else
							{
								SOUT=SOUT;
							}
							DOUT =  !(TXDATA_FLAGCTRL_TX_AUX[8]^LAST_TIMEIN_CONTROL_FLAG_TX[7]^LAST_TIMEIN_CONTROL_FLAG_TX[6]^LAST_TIMEIN_CONTROL_FLAG_TX[5]^LAST_TIMEIN_CONTROL_FLAG_TX[4]^LAST_TIMEIN_CONTROL_FLAG_TX[3]^LAST_TIMEIN_CONTROL_FLAG_TX[2]^LAST_TIMEIN_CONTROL_FLAG_TX[1]^LAST_TIMEIN_CONTROL_FLAG_TX[0]);
						}
					}
					else if(COUNTER == 1)
					{
						if(DOUT == TXDATA_FLAGCTRL_TX_AUX[8])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = TXDATA_FLAGCTRL_TX_AUX[8];
					}
					else if(COUNTER == 2)
					{
						if(DOUT == TXDATA_FLAGCTRL_TX_AUX[0])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = TXDATA_FLAGCTRL_TX_AUX[0];
					}
					else if(COUNTER == 3)
					{
						if(DOUT == TXDATA_FLAGCTRL_TX_AUX[1])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = TXDATA_FLAGCTRL_TX_AUX[1];
					}
					else if(COUNTER == 4)
					{
						if(DOUT == TXDATA_FLAGCTRL_TX_AUX[2])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = TXDATA_FLAGCTRL_TX_AUX[2];
					}
					else if(COUNTER == 5)
					{
						if(DOUT == TXDATA_FLAGCTRL_TX_AUX[3])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = TXDATA_FLAGCTRL_TX_AUX[3];
					}
					else if(COUNTER == 6)
					{
						if(DOUT == TXDATA_FLAGCTRL_TX_AUX[4])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = TXDATA_FLAGCTRL_TX_AUX[4];
					}
					else if(COUNTER == 7)
					{
						if(DOUT == TXDATA_FLAGCTRL_TX_AUX[5])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = TXDATA_FLAGCTRL_TX_AUX[5];
					}
					else if(COUNTER == 8)
					{
						if(DOUT == TXDATA_FLAGCTRL_TX_AUX[6])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = TXDATA_FLAGCTRL_TX_AUX[6];
					}
					else if(COUNTER == 9)
					{
						if(DOUT == TXDATA_FLAGCTRL_TX_AUX[7])
						{
							SOUT=!SOUT;
						}
						else
						{
							SOUT=SOUT;
						}
						DOUT = TXDATA_FLAGCTRL_TX_AUX[7];
					}

					COUNTER++;

					if(COUNTER == 10)
					{
						COUNTER = 0;
						READY_TX = true;
						TXDATA_FLAGCTRL_TX_LAST = TXDATA_FLAGCTRL_TX_AUX;
						FCT_COUNTER = FCT_COUNTER - 1;
						enable_n_char = false;
						last_type = TYPE_NCHAR_EOP_EEP;
					}
				}

			}

		}
	}//END METHOD


	SC_CTOR(SPW_TX_SC)
	{
		SC_METHOD(FCT_COUNTER_SEND);
		sensitive << CLOCK_SYS.pos();

		SC_METHOD(FCT_COUNTER_M);
		sensitive << CLOCK_SYS.pos();

		SC_METHOD(ALL_HERE);
		sensitive << CLOCK_TX.pos();

		SC_METHOD(TYPE_DATA_STATE);
		sensitive << CLOCK_TX.pos();
	}	
};
#endif
