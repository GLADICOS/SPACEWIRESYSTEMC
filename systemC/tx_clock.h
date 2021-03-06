#ifndef SPW_TX_CLOCK_H
#define SPW_TX_CLOCK_H

class CLOCK_WIRE_SC;

SC_MODULE(CLOCK_WIRE_SC)
{
	sc_in<bool> CLOCK_TX;
	sc_in<bool> ENABLE;
	sc_out<bool> CLOCK_TX_OUT;

	void TX_CLOCK_M()
	{
		if(ENABLE)
			CLOCK_TX_OUT = CLOCK_TX;
	}
	SC_CTOR(CLOCK_WIRE_SC)
	{
		SC_METHOD(TX_CLOCK_M);
		sensitive << CLOCK_TX << ENABLE.pos();
	}
};

class SPW_TX_CLOCK_SC;

SC_MODULE(SPW_TX_CLOCK_SC)
{

	sc_clock CLOCK_2MHZ;
	sc_clock CLOCK_10MHZ;
	sc_clock CLOCK_20MHZ;
	sc_clock CLOCK_50MHZ;
	sc_clock CLOCK_100MHZ;
	sc_clock CLOCK_150MHZ;
	sc_clock CLOCK_200MHZ;
	sc_clock CLOCK_201MHZ;
	sc_clock CLOCK_250MHZ;
	sc_clock CLOCK_280MHZ;
	sc_clock CLOCK_500MHZ;

	sc_in<sc_uint<10> > CLOCK_GEN;
	sc_in<bool> RESET;
	sc_out<bool> CLOCK_TX_OUT;

	CLOCK_WIRE_SC DUT_2MHZ;
	sc_signal<bool> CLOCK_TX_OUT_2MHZ_ENABLE;
	sc_signal<bool> CLOCK_TX_OUT_2MHZ;

	CLOCK_WIRE_SC DUT_10MHZ;
	sc_signal<bool> CLOCK_TX_OUT_10MHZ_ENABLE;
	sc_signal<bool> CLOCK_TX_OUT_10MHZ;

	CLOCK_WIRE_SC DUT_20MHZ;
	sc_signal<bool> CLOCK_TX_OUT_20MHZ_ENABLE;
	sc_signal<bool> CLOCK_TX_OUT_20MHZ;

	CLOCK_WIRE_SC DUT_50MHZ;
	sc_signal<bool> CLOCK_TX_OUT_50MHZ_ENABLE;
	sc_signal<bool> CLOCK_TX_OUT_50MHZ;

	CLOCK_WIRE_SC DUT_100MHZ;
	sc_signal<bool> CLOCK_TX_OUT_100MHZ_ENABLE;
	sc_signal<bool> CLOCK_TX_OUT_100MHZ;

	CLOCK_WIRE_SC DUT_150MHZ;
	sc_signal<bool> CLOCK_TX_OUT_150MHZ_ENABLE;
	sc_signal<bool> CLOCK_TX_OUT_150MHZ;

	CLOCK_WIRE_SC DUT_200MHZ;
	sc_signal<bool> CLOCK_TX_OUT_200MHZ_ENABLE;
	sc_signal<bool> CLOCK_TX_OUT_200MHZ;

	CLOCK_WIRE_SC DUT_201MHZ;
	sc_signal<bool> CLOCK_TX_OUT_201MHZ_ENABLE;
	sc_signal<bool> CLOCK_TX_OUT_201MHZ;

	CLOCK_WIRE_SC DUT_250MHZ;
	sc_signal<bool> CLOCK_TX_OUT_250MHZ_ENABLE;
	sc_signal<bool> CLOCK_TX_OUT_250MHZ;

	CLOCK_WIRE_SC DUT_280MHZ;
	sc_signal<bool> CLOCK_TX_OUT_280MHZ_ENABLE;
	sc_signal<bool> CLOCK_TX_OUT_280MHZ;

	void ENABLE()
	{
		//cout << CLOCK_GEN.read() << endl;
		switch(CLOCK_GEN.read())
		{
			case 1:
				CLOCK_TX_OUT_2MHZ_ENABLE   = true;
				CLOCK_TX_OUT_10MHZ_ENABLE  = false;
				CLOCK_TX_OUT_20MHZ_ENABLE  = false;
				CLOCK_TX_OUT_50MHZ_ENABLE  = false;
				CLOCK_TX_OUT_100MHZ_ENABLE = false;
				CLOCK_TX_OUT_150MHZ_ENABLE = false;
				CLOCK_TX_OUT_200MHZ_ENABLE = false;
				CLOCK_TX_OUT_201MHZ_ENABLE = false;
				CLOCK_TX_OUT_250MHZ_ENABLE = false;
				CLOCK_TX_OUT_280MHZ_ENABLE = false;
			break;
			case 2:
				CLOCK_TX_OUT_2MHZ_ENABLE   = false;
				CLOCK_TX_OUT_10MHZ_ENABLE  = true;
				CLOCK_TX_OUT_20MHZ_ENABLE  = false;
				CLOCK_TX_OUT_50MHZ_ENABLE  = false;
				CLOCK_TX_OUT_100MHZ_ENABLE = false;
				CLOCK_TX_OUT_150MHZ_ENABLE = false;
				CLOCK_TX_OUT_200MHZ_ENABLE = false;
				CLOCK_TX_OUT_201MHZ_ENABLE = false;
				CLOCK_TX_OUT_250MHZ_ENABLE = false;
				CLOCK_TX_OUT_280MHZ_ENABLE = false;
			break;
			case 4:
				CLOCK_TX_OUT_2MHZ_ENABLE   = false;
				CLOCK_TX_OUT_10MHZ_ENABLE  = false;
				CLOCK_TX_OUT_20MHZ_ENABLE  = true;
				CLOCK_TX_OUT_50MHZ_ENABLE  = false;
				CLOCK_TX_OUT_100MHZ_ENABLE = false;
				CLOCK_TX_OUT_150MHZ_ENABLE = false;
				CLOCK_TX_OUT_200MHZ_ENABLE = false;
				CLOCK_TX_OUT_201MHZ_ENABLE = false;
				CLOCK_TX_OUT_250MHZ_ENABLE = false;
				CLOCK_TX_OUT_280MHZ_ENABLE = false;
			break;
			case 8:
				CLOCK_TX_OUT_2MHZ_ENABLE   = false;
				CLOCK_TX_OUT_10MHZ_ENABLE  = false;
				CLOCK_TX_OUT_20MHZ_ENABLE  = false;
				CLOCK_TX_OUT_50MHZ_ENABLE  = true;
				CLOCK_TX_OUT_100MHZ_ENABLE = false;
				CLOCK_TX_OUT_150MHZ_ENABLE = false;
				CLOCK_TX_OUT_200MHZ_ENABLE = false;
				CLOCK_TX_OUT_201MHZ_ENABLE = false;
				CLOCK_TX_OUT_250MHZ_ENABLE = false;
				CLOCK_TX_OUT_280MHZ_ENABLE = false;
			break;
			case 16:
				CLOCK_TX_OUT_2MHZ_ENABLE   = false;
				CLOCK_TX_OUT_10MHZ_ENABLE  = false;
				CLOCK_TX_OUT_20MHZ_ENABLE  = false;
				CLOCK_TX_OUT_50MHZ_ENABLE  = false;
				CLOCK_TX_OUT_100MHZ_ENABLE = true;
				CLOCK_TX_OUT_150MHZ_ENABLE = false;
				CLOCK_TX_OUT_200MHZ_ENABLE = false;
				CLOCK_TX_OUT_201MHZ_ENABLE = false;
				CLOCK_TX_OUT_250MHZ_ENABLE = false;
				CLOCK_TX_OUT_280MHZ_ENABLE = false;
			break;
			case 32:
				CLOCK_TX_OUT_2MHZ_ENABLE   = false;
				CLOCK_TX_OUT_10MHZ_ENABLE  = false;
				CLOCK_TX_OUT_20MHZ_ENABLE  = false;
				CLOCK_TX_OUT_50MHZ_ENABLE  = false;
				CLOCK_TX_OUT_100MHZ_ENABLE = false;
				CLOCK_TX_OUT_150MHZ_ENABLE = true;
				CLOCK_TX_OUT_200MHZ_ENABLE = false;
				CLOCK_TX_OUT_201MHZ_ENABLE = false;
				CLOCK_TX_OUT_250MHZ_ENABLE = false;
				CLOCK_TX_OUT_280MHZ_ENABLE = false;
			break;
			case 64:
				CLOCK_TX_OUT_2MHZ_ENABLE   = false;
				CLOCK_TX_OUT_10MHZ_ENABLE  = false;
				CLOCK_TX_OUT_20MHZ_ENABLE  = false;
				CLOCK_TX_OUT_50MHZ_ENABLE  = false;
				CLOCK_TX_OUT_100MHZ_ENABLE = false;
				CLOCK_TX_OUT_150MHZ_ENABLE = false;
				CLOCK_TX_OUT_200MHZ_ENABLE = true;
				CLOCK_TX_OUT_201MHZ_ENABLE = false;
				CLOCK_TX_OUT_250MHZ_ENABLE = false;
				CLOCK_TX_OUT_280MHZ_ENABLE = false;
			break;
			case 128:
				CLOCK_TX_OUT_2MHZ_ENABLE   = false;
				CLOCK_TX_OUT_10MHZ_ENABLE  = false;
				CLOCK_TX_OUT_20MHZ_ENABLE  = false;
				CLOCK_TX_OUT_50MHZ_ENABLE  = false;
				CLOCK_TX_OUT_100MHZ_ENABLE = false;
				CLOCK_TX_OUT_150MHZ_ENABLE = false;
				CLOCK_TX_OUT_200MHZ_ENABLE = false;
				CLOCK_TX_OUT_201MHZ_ENABLE = true;
				CLOCK_TX_OUT_250MHZ_ENABLE = false;
				CLOCK_TX_OUT_280MHZ_ENABLE = false;
			break;
			case 256:
				CLOCK_TX_OUT_2MHZ_ENABLE   = false;
				CLOCK_TX_OUT_10MHZ_ENABLE  = false;
				CLOCK_TX_OUT_20MHZ_ENABLE  = false;
				CLOCK_TX_OUT_50MHZ_ENABLE  = false;
				CLOCK_TX_OUT_100MHZ_ENABLE = false;
				CLOCK_TX_OUT_150MHZ_ENABLE = false;
				CLOCK_TX_OUT_200MHZ_ENABLE = false;
				CLOCK_TX_OUT_201MHZ_ENABLE = false;
				CLOCK_TX_OUT_250MHZ_ENABLE = true;
				CLOCK_TX_OUT_280MHZ_ENABLE = false;
			break;
			case 512:
				CLOCK_TX_OUT_2MHZ_ENABLE   = false;
				CLOCK_TX_OUT_10MHZ_ENABLE  = false;
				CLOCK_TX_OUT_20MHZ_ENABLE  = false;
				CLOCK_TX_OUT_50MHZ_ENABLE  = false;
				CLOCK_TX_OUT_100MHZ_ENABLE = false;
				CLOCK_TX_OUT_150MHZ_ENABLE = false;
				CLOCK_TX_OUT_200MHZ_ENABLE = false;
				CLOCK_TX_OUT_201MHZ_ENABLE = false;
				CLOCK_TX_OUT_250MHZ_ENABLE = false;
				CLOCK_TX_OUT_280MHZ_ENABLE = true;
			break;
			default:
				CLOCK_TX_OUT_2MHZ_ENABLE   = false;
				CLOCK_TX_OUT_10MHZ_ENABLE  = true;
				CLOCK_TX_OUT_20MHZ_ENABLE  = false;
				CLOCK_TX_OUT_50MHZ_ENABLE  = false;
				CLOCK_TX_OUT_100MHZ_ENABLE = false;
				CLOCK_TX_OUT_150MHZ_ENABLE = false;
				CLOCK_TX_OUT_200MHZ_ENABLE = false;
				CLOCK_TX_OUT_201MHZ_ENABLE = false;
				CLOCK_TX_OUT_250MHZ_ENABLE = false;
				CLOCK_TX_OUT_280MHZ_ENABLE = false;
			break;
		}
	}

	void CLK_GEN()
	{
		if(!RESET)
		{
			CLOCK_TX_OUT = CLOCK_TX_OUT_2MHZ;
		}
		else
		{
			if(CLOCK_TX_OUT_2MHZ_ENABLE)
				CLOCK_TX_OUT = CLOCK_TX_OUT_2MHZ;
			else if(CLOCK_TX_OUT_10MHZ_ENABLE)
				CLOCK_TX_OUT = CLOCK_TX_OUT_10MHZ;
			else if(CLOCK_TX_OUT_20MHZ_ENABLE)
				CLOCK_TX_OUT = CLOCK_TX_OUT_20MHZ;
			else if(CLOCK_TX_OUT_50MHZ_ENABLE)
				CLOCK_TX_OUT = CLOCK_TX_OUT_50MHZ;
			else if(CLOCK_TX_OUT_100MHZ_ENABLE)
				CLOCK_TX_OUT = CLOCK_TX_OUT_100MHZ;
			else if(CLOCK_TX_OUT_150MHZ_ENABLE)
				CLOCK_TX_OUT = CLOCK_TX_OUT_150MHZ;
			else if(CLOCK_TX_OUT_200MHZ_ENABLE)
				CLOCK_TX_OUT = CLOCK_TX_OUT_200MHZ;
			else if(CLOCK_TX_OUT_201MHZ_ENABLE)
				CLOCK_TX_OUT = CLOCK_TX_OUT_201MHZ;
			else if(CLOCK_TX_OUT_250MHZ_ENABLE)
				CLOCK_TX_OUT = CLOCK_TX_OUT_250MHZ;
			else if(CLOCK_TX_OUT_280MHZ_ENABLE)
				CLOCK_TX_OUT = CLOCK_TX_OUT_280MHZ;
		}
		#ifdef TESTE
		cout << "2MHZ"   << " " << CLOCK_TX_OUT_2MHZ_ENABLE   <<endl;
		cout << "10MHZ"  << " " << CLOCK_TX_OUT_10MHZ_ENABLE  <<endl;
		cout << "20MHZ"  << " " << CLOCK_TX_OUT_20MHZ_ENABLE  <<endl;
		cout << "50MHZ"  << " " << CLOCK_TX_OUT_50MHZ_ENABLE  <<endl;
		cout << "100MHZ" << " " << CLOCK_TX_OUT_100MHZ_ENABLE <<endl;
		cout << "150MHZ" << " " << CLOCK_TX_OUT_150MHZ_ENABLE <<endl;
		cout << "200MHZ" << " " << CLOCK_TX_OUT_200MHZ_ENABLE <<endl;
		cout << "201MHZ" << " " << CLOCK_TX_OUT_201MHZ_ENABLE <<endl;
		cout << "250MHZ" << " " << CLOCK_TX_OUT_250MHZ_ENABLE <<endl;
		cout << "280MHZ" << " " << CLOCK_TX_OUT_280MHZ_ENABLE <<endl;
		#endif
	}

	SC_CTOR(SPW_TX_CLOCK_SC):CLOCK_2MHZ("CLOCK_2MHZ",500,SC_NS),
				 CLOCK_10MHZ("CLOCK_10MHZ",100,SC_NS),
				 CLOCK_20MHZ("CLOCK_20MHZ",50,SC_NS),
				 CLOCK_50MHZ("CLOCK_50MHZ",20,SC_NS),
				 CLOCK_100MHZ("CLOCK_100MHZ",10,SC_NS),
				 CLOCK_150MHZ("CLOCK_150MHZ",6.667,SC_NS),
				 CLOCK_200MHZ("CLOCK_200MHZ",5,SC_NS),
				 CLOCK_201MHZ("CLOCK_201MHZ",4.975,SC_NS),
				 CLOCK_250MHZ("CLOCK_250MHZ",4,SC_NS),
				 CLOCK_280MHZ("CLOCK_280MHZ",3.571,SC_NS),
				 DUT_2MHZ("DUT_2MHZ"),
				 DUT_10MHZ("DUT_10MHZ"),
				 DUT_20MHZ("DUT_20MHZ"),
				 DUT_50MHZ("DUT_50MHZ"),
				 DUT_100MHZ("DUT_100MHZ"),
				 DUT_150MHZ("DUT_150MHZ"),
				 DUT_200MHZ("DUT_200MHZ"),
				 DUT_201MHZ("DUT_201MHZ"),
				 DUT_250MHZ("DUT_250MHZ"),
				 DUT_280MHZ("DUT_280MHZ")
	{
		SC_METHOD(ENABLE);
		sensitive << CLOCK_GEN << RESET;

		SC_METHOD(CLK_GEN);
		sensitive << CLOCK_500MHZ; 

		DUT_2MHZ.CLOCK_TX(CLOCK_2MHZ);
		DUT_2MHZ.ENABLE(CLOCK_TX_OUT_2MHZ_ENABLE);
		DUT_2MHZ.CLOCK_TX_OUT(CLOCK_TX_OUT_2MHZ);

		DUT_10MHZ.CLOCK_TX(CLOCK_10MHZ);
		DUT_10MHZ.ENABLE(CLOCK_TX_OUT_10MHZ_ENABLE);
		DUT_10MHZ.CLOCK_TX_OUT(CLOCK_TX_OUT_10MHZ);

		DUT_20MHZ.CLOCK_TX(CLOCK_20MHZ);
		DUT_20MHZ.ENABLE(CLOCK_TX_OUT_20MHZ_ENABLE);
		DUT_20MHZ.CLOCK_TX_OUT(CLOCK_TX_OUT_20MHZ);

		DUT_50MHZ.CLOCK_TX(CLOCK_50MHZ);
		DUT_50MHZ.ENABLE(CLOCK_TX_OUT_50MHZ_ENABLE);
		DUT_50MHZ.CLOCK_TX_OUT(CLOCK_TX_OUT_50MHZ);

		DUT_100MHZ.CLOCK_TX(CLOCK_100MHZ);
		DUT_100MHZ.ENABLE(CLOCK_TX_OUT_100MHZ_ENABLE);
		DUT_100MHZ.CLOCK_TX_OUT(CLOCK_TX_OUT_100MHZ);

		DUT_150MHZ.CLOCK_TX(CLOCK_150MHZ);
		DUT_150MHZ.ENABLE(CLOCK_TX_OUT_150MHZ_ENABLE);
		DUT_150MHZ.CLOCK_TX_OUT(CLOCK_TX_OUT_150MHZ);

		DUT_200MHZ.CLOCK_TX(CLOCK_200MHZ);
		DUT_200MHZ.ENABLE(CLOCK_TX_OUT_200MHZ_ENABLE);
		DUT_200MHZ.CLOCK_TX_OUT(CLOCK_TX_OUT_200MHZ);

		DUT_201MHZ.CLOCK_TX(CLOCK_201MHZ);
		DUT_201MHZ.ENABLE(CLOCK_TX_OUT_201MHZ_ENABLE);
		DUT_201MHZ.CLOCK_TX_OUT(CLOCK_TX_OUT_201MHZ);

		DUT_250MHZ.CLOCK_TX(CLOCK_250MHZ);
		DUT_250MHZ.ENABLE(CLOCK_TX_OUT_250MHZ_ENABLE);
		DUT_250MHZ.CLOCK_TX_OUT(CLOCK_TX_OUT_250MHZ);

		DUT_280MHZ.CLOCK_TX(CLOCK_280MHZ);
		DUT_280MHZ.ENABLE(CLOCK_TX_OUT_280MHZ_ENABLE);
		DUT_280MHZ.CLOCK_TX_OUT(CLOCK_TX_OUT_280MHZ);
	}
};
#endif
