class simple_test extends uvm_test;
   `uvm_component_utils(simple_test)

   environment	 env;
   alu_sequence	 alu_seq;
   reg_sequence	 reg_seq;

   function new(string name = "simple_test", uvm_component parent = null);​
      super.new(name, parent);​
   endfunction: new​

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = environment::type_id::create("env", this);
      alu_seq = alu_sequence::type_id::create("alu_seq", this);
      reg_seq = reg_sequence::type_id::create("reg_seq", this);
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      fork
  	 alu_seq.start(env.alu_agt.alu_sqr);
  	 reg_seq.start(env.reg_agt.reg_sqr);
      join      
   endtask : run_phase

endclass: simple_test
