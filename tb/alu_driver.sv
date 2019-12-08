typedef virtual alu_if alu_vif;

class alu_driver extends uvm_driver #(alu_transaction);
   `uvm_component_utils(alu_driver)
   
   alu_vif vif;
   alu_transaction tr;
   
   function new(string name = "alu_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(alu_vif)::get(this, "", "vif", vif))
	`uvm_fatal("NOVIF", "failed to get virtual interface")
   endfunction // build_phase

   task run_phase(uvm_phase phase);
      fork
	 reset_signals();
	 get_and_drive(phase);
      join
   endtask // run_phase

   virtual task reset_signals();
      wait(vif.rst_n === 0);
      forever begin
	 vif.valid_in <= 0;
	 @(negedge vif.rst_n);
      end
   endtask // reset_signals

   virtual task get_and_drive(uvm_phase phase);
      wait (vif.rst_n === 0);
      @(posedge vif.rst_n);
      forever begin
	 seq_item_port.get_next_item(tr);
	 driver_transfer(tr);
	 if(vif.valid_in) wait(vif.valid_out); 
	 seq_item_port.item_done();
      end
   endtask // get_and_drive

   virtual task driver_transfer(alu_transaction tr);
      @(posedge vif.clk);
      vif.data_A   <= tr.data_in;
      vif.reg_sel  <= tr.reg_sel;
      vif.instr    <= tr.instr;
      vif.valid_in <= tr.valid_in;
   endtask // driver_transfer
   
endclass // alu_driver
