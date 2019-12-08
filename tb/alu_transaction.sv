class alu_transaction extends uvm_sequence_item;
   // Entradas do DUT
   rand bit [15:0] data_in;
   rand bit [1:0]  reg_sel;
   rand bit [1:0]  instr;
   rand bit 	   valid_in;

   // Saídas do DUT
   bit [31:0] 	   data_out;
   bit 		   valid_out; 		   

   // Construtor
   function new (string name = "alu_transaction");
      super.new(name);
   endfunction // new

   // Macros
   `uvm_object_param_utils_begin(alu_transaction)
      `uvm_field_int(data_in, UVM_UNSIGNED)
      `uvm_field_int(reg_sel, UVM_UNSIGNED)
      `uvm_field_int(instr, UVM_UNSIGNED)
      `uvm_field_int(valid_in, UVM_BIN)
      `uvm_field_int(data_out, UVM_UNSIGNED)
      `uvm_field_int(valid_out, UVM_BIN)
   `uvm_object_utils_end

endclass // alu_transaction
