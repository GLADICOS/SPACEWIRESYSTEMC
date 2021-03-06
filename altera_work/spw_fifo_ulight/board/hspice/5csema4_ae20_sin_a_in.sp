************************************************************************
* Quartus HSPICE Writer I/O Simulation Deck
*
* This spice simulation deck was automatically generated by Quartus for
* the following IO settings:
*
*  Device:       5CSEMA4U23C6
*  Speed Grade:  C6
*  Pins:         AE20 (sin_a)
*                AD20 (sin_a(n))
*  Bank:         IO Bank 4A (Column I/O)
*  I/O Standard: LVDS
*  OCT:          Off
*
* Quartus' default I/O timing delays assume the following slow corner
* simulation conditions. 
*
*  Specified Test Conditions For Quartus Tco
*    Temperature:      85C (Slowest Temperature Corner)
*    Transistor Model: TT (Typical Transistor Corner)
*    Vccn:             2.325V (Vccn_min = Nominal - 5% - 50mV additional margin)
*    Vccpd:            2.325V (Vccpd_min = Nominal - 5% - 50mV additional margin)
*    Load:             100 ohm Termination Resistor
*    Vcc:              1.00V (Vcc_min = Nominal - 100mV additional margin)
*
* For C6 devices, the TT transistor corner provides an approximation 
* for worst case timing. However, for functionality simulations,
* it is recommended that the SS corner be simulated as well.
*
* Note: Actual production devices can be as fast as the FF corner.  
*       Any simulations for hold times should be conducted using the 
*       fast process corner with the following simulation conditions.
*         Temperature:      0C (Fastest Temperature Corner)
*         Transistor Model: FF (Fastest Transistor Corner)
*         Vccn:             2.750V (Vccn_hold = Nominal + 10%)
*         Vccpd:            2.750V
*         Vcc:              1.180V (Vcc_hold = Nominal + 7%)
*         Package Model:    Short-circuit from pad to pin (no parasitics)
*
*       For a detailed description of hold time analysis see 
*       the Quartus II HSPICE Writer AppNote.
*
* Usage:
*
*    1) Replace the sample board and termination circuit below with
*       your desired circuit.
*    2) Replace the sample driver circuit with a model of the actual
*       I/O driver that will be driving the FPGA input pin.
*    3) Replace the VccN and Vccpd voltages with your desired value or
*       leave them unchanged for a slow corner simulation.
*
* Warnings:
* - Cyclone V HSPICE Writer does not support input pins at this time
*
************************************************************************

************************************************************************
* Process Settings
************************************************************************
.options brief 
.inc 'lib/cv_tt.inc' * TT process corner

************************************************************************
* Simulation Options
************************************************************************
.options brief=0
.options badchr co=132 acct ingold=2 nomod dv=1.0
+        dcstep=1 absv=1e-2 absi=1e-7 probe captab csdf=2 accurate=1 post=2
.options dcon=1
.option converge=1
.temp 85

************************************************************************
* Constant Definition
************************************************************************
vlvdsoe    rlvdsoe   0     0  * Set to vc to enable buffer output
vdin       din          0     0

************************************************************************
* IO Buffer Netlist 
************************************************************************
.include 'cir/lvds_input_load.inc'
.include 'cir/io_buffer_load.inc'
.include 'cir/lvds_oct_load.inc'

************************************************************************
* I/O Buffer Instantiation
************************************************************************

* Supply Voltages Settings
.param vcn=2.325
.param vpd=2.325
.param vc=1.00

* Instantiate Power Supplies
vvcc       vcc       0     vc     * FPGA core voltage
vvss       vss       0     0      * FPGA core ground
vvccn      vccn      0     vcn    * IO supply voltage
vvssn      vssn      0     0     * IO ground
vvccpd     vccpd     0     vpd    * Pre-drive supply voltage

* Instantiate I/O Buffer
xlvds_input_load die dieb vccpd vcc lvds_input_load

* Internal Loading on Pad
* - These pads also have single-ended buffers connected to them. These
*   buffers are disabled but add parasitic loads that are modeled below:
xio_load  die  vccn vccpd vcpad0 vcc io_buffer_load
xio_loadb dieb vccn vccpd vcpad1 vcc io_buffer_load
* - This differential pair has Differential OCT disabled. The
*   loading introduced by this circuitry is found below:
xlvds_oct_load die dieb vccpd vcpad0 vcpad1 vcc lvds_oct_load

* I/O Buffer Package Model
* - Standard Column I/O package trace
* Positive end
.lib 'lib/package.lib' io  
xpkg die pin io_pkg
* Negative end
xpkgb dieb pinb io_pkg



* /////////////////////////////////////////////////////////////////// *
* I/O Board Trace And Termination Description                         *
*   - Replace this with your board trace and termination description  *
* /////////////////////////////////////////////////////////////////// *

* LVDS Termination
* (reference: Cyclone V Handbook Volume 1, I/O Features in Cyclone V Devices chapter)


wtline source vssn pin vssn N=1 L=1 RLGCMODEL=tlinemodel
wtlineb sourceb vssn pinb vssn N=1 L=1 RLGCMODEL=tlinemodel
.MODEL tlinemodel W MODELTYPE=RLGC N=1 Lo=7.13n Co=2.85p * Trace model (transmission lines)
rterm pin pinb 100                                       * Termination resistor

* /////////////////////////////////////////////////////////////////// *
* Sample source stimulus placeholder                                  *
*  - Replace this with your I/O driver model                          *
* /////////////////////////////////////////////////////////////////// *

vsource  source  0 pulse(0 vcn 0s 0.4ns 0.4ns 8.5ns 17.4ns)
vsourceb sourceb 0 pulse(vcn 0 0s 0.4ns 0.4ns 8.5ns 17.4ns)



************************************************************************
* Simulation Analysis Setup
************************************************************************

* Print out the voltage waveform at both the source and the FPGA pin
.print tran v(source) v(pin) v(sourceb) v(pinb)
.tran 0.020ns 17ns

* Measure the propagation delay from the source pin to the FPGA pin
* referenced against the voltage crossing point
.measure TRAN tpd_rise TRIG v(source) val='vcn*0.5' rise=1 TARG v(pin,pinb) val='0' rise=1
.measure TRAN tpd_fall TRIG v(source) val='vcn*0.5' td=8.7ns fall=1 TARG v(pin,pinb) val='0' td=8.7ns fall=1

.end
