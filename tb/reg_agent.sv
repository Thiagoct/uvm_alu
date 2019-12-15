 typedef uvm_sequencer#(transaction_in) sequencer;

class agent extends uvm_agent;   
   
    reg_sequencer  reg_sqr;
    reg_driver   reg_drv;
    reg_monitor  reg_mon;
    uvm_analysis_port #(reg_transaction) reg_agt_port;
    `uvm_component_utils(reg_agent)

    function new(string name = "reg_agent", uvm_component parent = null);
        super.new(name, parent);
        reg_agt_port  = new("reg_agt_port", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        reg_mon = reg_monitor::type_id::create("reg_mon", this);
        reg_sqr = reg_sequencer::type_id::create("reg_sqr", this);
        reg_drv = reg_driver::type_id::create("reg_drv", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
         reg_mon.reg_port.connect(reg_agt_port);
         reg_drv.seq_item_port.connect(reg_sqr.seq_item_export);
    endfunction
endclass: reg_agent