#ifndef SPW_RX_CLOCK_RECOVERY_H
#define SPW_RX_CLOCK_RECOVERY_H

class SPW_RX_CLOCK_RECOVERY_SC;

SC_MODULE(SPW_RX_CLOCK_RECOVERY_SC)
{
	sc_in<uint>  DIN_REC;
	sc_in<uint>  SIN_REC;

	sc_out<bool> RX_CLOCK_OUT;

	void RX_CLOCK_XOR()
	{
		RX_CLOCK_OUT = DIN_REC ^ SIN_REC;
	}

	SC_CTOR(SPW_RX_CLOCK_RECOVERY_SC)
	{
		SC_METHOD(RX_CLOCK_XOR);
		sensitive << DIN_REC << SIN_REC;
	}
};
#endif
