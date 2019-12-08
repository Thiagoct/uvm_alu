typedef uvm_sequencer #(reg_transaction) reg_sequencer;

class reg_agent extends uvm_agent;
   `uvm_component_utils(reg_agent)
   
   reg_sequencer reg_sqr;
   reg_driver reg_drv;
   reg_monitor reg_mon;

   uvm_analysis_port #(reg_transaction) reg_agt_port;

   function new(string name = "reg_agent", uvm_component parent = null);
      super.new(name, parent);
      reg_agt_port = new("reg_agt_port", this);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      reg_sqr = reg_sequencer::type_id::create("reg_sqr", this);
      reg_drv = reg_driver::type_id::create("reg_drv", this);
      reg_mon = reg_monitor::type_id::create("reg_mon", this);
   endfunction : build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      reg_mon.reg_port.connect(reg_agt_port);
      reg_drv.seq_item_port.connect(reg_sqr.seq_item_export);
   endfunction : connect_phase

endclass : reg_agent

// class uvm_pkg::uvm_port_base#(.IF(class uvm_pkg::uvm_sqr_if_base#(
// .T1(class pkg::reg_transaction),.T2(class pkg::reg_transaction)))