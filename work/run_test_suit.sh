
# export SC_SIGNAL_WRITE_CHECK=DISABLE 

SYSTEMC_HOME=/opt/systemc

#g++ -I. -I$SYSTEMC_HOME/include -L. -L$SYSTEMC_HOME/lib-linux64 -std=c++11 -fPIC -shared -fpermissive -lsystemc ../systemC/main.cc -o final_spw.so

g++ -I. -I$SYSTEMC_HOME/include -L. -L$SYSTEMC_HOME/lib64 -std=c++11 -fPIC -shared -fpermissive -lsystemc `pkg-config gtkmm-3.0 --cflags --libs` -lboost_thread -lboost_system  ../systemC/main.cc -o final_spw.so 

g++ -c -ldl -fpic ../vpi/vpi_test_suit/env_global_spw.cpp -std=c++11 -Wwrite-strings -fpermissive

g++ -shared  -oenv_global_spw.vpi env_global_spw.o -lvpi -std=c++11 -Wwrite-strings -fpermissive

iverilog -oenv_global_spw.vvp -g2012 -D VERILOG_A ../rtl/RTL_VA/*.sv ../testbench/module_tb.v 

vvp -M. -menv_global_spw env_global_spw.vvp
