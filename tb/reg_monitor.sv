class monitor extends uvm_monitor;

    reg_vif vif;
    reg_transaction tr;

    uvm_analysis_port #(reg_transaction) req_port;
    `uvm_component_utils(reg_monitor)
   
    function new(string name = reg_monitor, uvm_component parent = null);
        super.new(name, parent);
        req_port = new("req_port", this);
    endfunction // new
____________________________________________________________
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
         if(!uvm_config_db#(interface_vif)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NOVIF", "failed to get virtual interface")
        end
        tr = reg_transaction::type_id::create("reg_tr", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        fork
            collect_transactions(phase);
        join
    endtask

    virtual task collect_transactions(uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            if(vif.rst) begin
            begin_tr(tr, "reg_tr")
            tr.data_in = vir.data_in;
            tr.addr = vif.addr;
            tr.valid_reg = '1;
            @(negedge vif.clk);
            end_tr(tr);
            end
        end
    endtask
endclass
