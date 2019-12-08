class alu_monitor extends uvm_monitor;
   `uvm_component_utils(alu_monitor)

   alu_vif vif;
   alu_transaction alu_tr;
   ref_transaction ref_tr;
   
   uvm_analysis_port #(alu_transaction) alu_mon_port;
   uvm_analysis_port #(ref_transaction) ref_mon_port;

   function new(string name = "alu_monitor", uvm_component parent = null);
      super.new(name, parent);
      alu_mon_port = new("alu_mon_port", this);
      ref_mon_port = new("ref_mon_port", this);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(alu_vif)::get(this, "", "vif", vif))
	 `uvm_fatal("NOVIF", "failed to get virtual interface")
      alu_tr = alu_transaction::type_id::create("alu_tr", this);
      ref_tr = ref_transaction::type_id::create("ref_tr", this);
   endfunction // build_phase

   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
      fork
	 collect_alu_transaction(phase);
	 collect_ref_transaction(phase);
      join
   endtask // run_phase

   virtual task collect_alu_transaction(uvm_phase phase);
      forever begin
	 @(posedge vif.clk);
	 if(vif.rst_n) begin
	    begin_tr(alu_tr, "alu_tr");
	    alu_tr.data_in   = vif.data_A;
	    alu_tr.reg_sel   = vif.reg_sel;
	    alu_tr.instr     = vif.instr;
	    alu_tr.valid_in  = vif.valid_in;
	    alu_tr.data_out  = vif.data_out;
	    alu_tr.valid_out = vif.valid_out;
	    alu_mon_port.write(alu_tr);
	    @(negedge vif.clk);
	    end_tr(alu_tr);
	 end // if (vif.rst_n)
      end // forever begin
   endtask // collect_transaction

   virtual task collect_ref_transaction(uvm_phase phase);
      forever begin
	 @(posedge vif.clk);
	 if(vif.rst_n && vif.valid_out) begin
	    begin_tr(ref_tr, "ref_tr");
	    ref_tr.data_out = vif.data_out;
	    ref_mon_port.write(ref_tr);
	    @(negedge vif.clk);
	    end_tr(ref_tr);
	 end
      end
   endtask // collect_ref_transaction

endclass // alu_monitor
