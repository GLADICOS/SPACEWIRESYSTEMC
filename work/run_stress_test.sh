
g++ -c -ldl -fpic ../vpi/vpi_test_stress/env_global_spw.cpp  -std=c++11 -Wwrite-strings -fpermissive

g++ -shared  -oenv_global_spw.vpi env_global_spw.o -lvpi -std=c++11 -Wwrite-strings -fpermissive

iverilog -oenv_global_spw.vvp ../rtl/RTL_VB/*.v ../testbench/module_tb.v 

vvp -M. -menv_global_spw env_global_spw.vvp
