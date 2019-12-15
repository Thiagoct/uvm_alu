typedef virtual alu_if alu_vif;

alu_vif vif;
alu_transaction tr;
class alu_driver extends uvm_driver #(alu_transaction);
    `uvm_component_utils(alu_driver)
    

// ------------------------------ Macro --------------------------------//
    function new(string name = "alu_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

// --------------------------- Build Phase -----------------------------//
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
         if(!uvm_config_db#(alu_vif)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "failed to get virtual interface")
        end
    endfunction

// ---------------------------- Run Phase ------------------------------//
    task run_phase (uvm_phase phase);
        fork
            reset_signals();
            get_and_drive(phase);
        join
    endtask


// 			Reset
/**/			virtual task reset_signals();    
/**/			    wait (vif.rst === 0);
/**/			    forever begin
/**/			        vif.valid_ula  <= '0;  
/**/			        @(negedge vif.rst);
/**/			    end
/**/			endtask : reset_signals
			

// 			Get and drive
/**/			virtual task get_and_drive(uvm_phase phase);
/**/			    wait (vif.rst === 0);
/**/			    @(posedge vif.rst);
/**/			    forever begin
/**/			        seq_item_port.get_next_item(tr);
/**/			        driver_transfer(tr);
/**/                    if(vif_valid_in) wait(vif.valid_out);       
/**/			        seq_item_port.item_done();
/**/			    end
/**/			endtask : get_and_drive
			

// 			Driver Transfer
/**/			virtual task driver_transfer(alu_transaction alu_tr);
/**/			    @(posedge vif.clk);
/**/                vif.A <= tr.A;
/**/                vif.instru <= tr.instru;    
/**/                vif.reg_sel <=  tr.reg_sel;   
/**/				vif.valid_ula  <=  '1;	
/**/			endtask : driver_transfer

endclass: alu_transaction