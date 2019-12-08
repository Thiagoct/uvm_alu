interface reg_if
  (
   input logic clk,
   input logic rst_n
  );

   logic  [15:0] data_in;
   logic  [1:0]  addr;
   logic  valid_reg; 

endinterface
