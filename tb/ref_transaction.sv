class ref_transaction extends uvm_sequence_item;

   bit [31:0] data_out;

   function new (string name = "ref_transaction");
      super.new(name);
   endfunction // new

   `uvm_object_param_utils_begin(ref_transaction)
      `uvm_field_int(data_out, UVM_UNSIGNED)
   `uvm_object_utils_end

endclass // ref_transaction
