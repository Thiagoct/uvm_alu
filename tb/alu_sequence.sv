class alu_sequence extends uvm_sequence #(alu_transaction);
   `uvm_object_utils(alu_sequence)

   function new(string name = "alu_sequence");
      super.new(name);
   endfunction // new

   task body();
      alu_transaction tr;
      forever begin
	 tr = alu_transaction::type_id::create("tr");
	 start_item(tr);
	 assert(tr.randomize());
	 finish_item(tr);
      end
   endtask // body

endclass: alu_sequence
