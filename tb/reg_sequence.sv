class reg_sequence extends uvm_sequence #(reg_transaction);
    `uvm_object_utils(reg_sequence)

    function new(string name="reg_sequence");
        super.new(name);
    endfunction: new

    task body();
        reg_transaction tr;

        forever begin
            tr = transaction_in::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize());
            finish_item(tr);
        end
    endtask: body
endclass: sequence_in