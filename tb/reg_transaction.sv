class reg_transaction extends uvm_sequence_item;
   // Entradas do DUT
   rand bit [15:0] data_in;
   rand bit [1:0]  addr;
   rand bit 	   valid_reg;	   

   // Construtor
   function new (string name = "reg_transaction");
      super.new(name);
   endfunction // new

   // Macros
   `uvm_object_param_utils_begin(reg_transaction)
      `uvm_field_int(data_in, UVM_UNSIGNED)
      `uvm_field_int(addr, UVM_UNSIGNED)
      `uvm_field_int(valid_reg, UVM_BIN)
   `uvm_object_utils_end

endclass // alu_transaction
