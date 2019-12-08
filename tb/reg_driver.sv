typedef virtual reg_if reg_vif;

class reg_driver extends uvm_driver #(reg_transaction);
   `uvm_component_utils(reg_driver)
   
   reg_vif vif;
   reg_transaction tr;
   
   function new(string name = "reg_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(reg_vif)::get(this, "", "vif", vif))
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
	 vif.valid_reg <= 0;
	 @(negedge vif.rst_n);
      end
   endtask // reset_signals

   virtual task get_and_drive(uvm_phase phase);
      wait (vif.rst_n === 0);
      @(posedge vif.rst_n);
      forever begin
	 seq_item_port.get_next_item(tr);
	 driver_transfer(tr);
	 seq_item_port.item_done();
      end
   endtask // get_and_drive

   virtual task driver_transfer(reg_transaction tr);
      @(posedge vif.clk);
      vif.data_in   <= tr.data_in;
      vif.addr  <= tr.addr;
      vif.valid_reg    <= tr.valid_reg;
   endtask // driver_transfer
   
endclass // reg_driver
