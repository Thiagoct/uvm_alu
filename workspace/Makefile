IFS = ../tb/alu_if.sv \
	  ../tb/reg_if.sv

PKGS = ../tb/pkg.sv

RTL = ../src/datapath.sv \
../src/mux.sv \
../src/rb.sv \
../src/ula.sv

RUN_ARGS_COMMON = -access +r -input ./shm.tcl \

sim: clean
	g++ -g -fPIC -Wall -std=c++0x ../tb/refmod.cpp -shared -o test.so
	xrun -64bit -uvm $(PKGS) $(IFS) $(RTL) ../tb/top.sv -sv_lib test.so \
		+UVM_TESTNAME=simple_test -covtest simple_test $(RUN_ARGS_COMMON)

clean:
	@rm -rf INCA_libs waves.shm cov_work/ *.history *.log *.key mdv.log imc.log imc.key ncvlog_*.err *.trn *.dsn .simvision/ simvision* xcelium.d simv.daidir *.so *.o *.err

view_waves:
	simvision waves.shm &