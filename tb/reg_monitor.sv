class reg_monitor extends uvm_monitor;
   `uvm_component_utils(reg_monitor)

   reg_vif vif;
   reg_transaction tr;
   
   uvm_analysis_port #(reg_transaction) reg_port;

   function new(string name = "reg_monitor", uvm_component parent = null);
      super.new(name, parent);
      reg_port = new("reg_port", this);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(reg_vif)::get(this, "", "vif", vif))
	 `uvm_fatal("NOVIF", "failed to get virtual interface")
      tr = reg_transaction::type_id::create("reg_tr", this);

   endfunction // build_phase

   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
      fork
	 collect_transaction(phase);
      join
   endtask // run_phase

   virtual task collect_transaction(uvm_phase phase);
      forever begin
	 @(posedge vif.clk);
	 if(vif.rst_n) begin
	    begin_tr(tr, "reg_tr");
	    tr.data_in   = vif.data_in;
	    tr.addr      = vif.addr;
	    tr.valid_reg  = vif.valid_reg;
	    reg_port.write(tr);
	    @(negedge vif.clk);
	    end_tr(tr);
	 end // if (vif.rst_n)
      end // forever begin
   endtask // collect_transaction

endclass // reg_monitor
