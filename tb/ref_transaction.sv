class ref_transaction extends uvm_sequence_item;
  rand bit [31:0] data_out;

  function new(string name = "");
    super.new(name);
  endfunction

  `uvm_object_param_utils_begin(transaction_in)
    `uvm_field_int(data, UVM_UNSIGNED)
  `uvm_object_utils_end

  function string convert2string();
    return $sformatf("{data_out = %d}",data_out);
  endfunction
endclass