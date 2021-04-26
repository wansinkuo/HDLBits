module top_module (
	input clk,
	input [7:0] d,
	input [1:0] sel,
	output reg [7:0] q
);

  wire [7:0] q1, q2, q3;		// output of each my_dff8
	
	// Instantiate three my_dff8s
  my_dff8 d1 ( clk, d, q1 );
  my_dff8 d2 ( clk, q1, q2 );
  my_dff8 d3 ( clk, q2, q3 );

	// This is one way to make a 4-to-1 multiplexer
  always @(*)	begin	// Combinational always block
		case(sel)
			    2'h0: q = d;
			    2'h1: q = q1;
			    2'h2: q = q2;
			    2'h3: q = q3;
      default : q = d;
		endcase
  end

endmodule
