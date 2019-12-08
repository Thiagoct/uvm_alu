interface reg_if
	(
		input logic clk,
		input logic rst
	);

	logic [1:0]     addr;
	logic [15:0] data_in;
	logic 	   valid_reg;

endinterface 