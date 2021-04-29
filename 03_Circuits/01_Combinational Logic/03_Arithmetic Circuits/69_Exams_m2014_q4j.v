module top_module( 
    input [3:0] x, y,
    output [4:0] sum );

    wire [3:0] cout;
    wire [3:0] cin = {cout[2:0], 1'b0};
    
    fadd inst_fadd [3:0] (
        .a   (x),
        .b   (y),
        .cin (cin),
        .cout(cout),
        .sum (sum[3:0])
    );

    assign sum[4] = cout[3];

endmodule

module fadd( 
    input a, b, cin,
    output cout, sum );

    assign cout = (a&b) | (a&cin) | (b&cin);
    assign sum  = ^{a , b, cin};

endmodule

// answer on HDLBits
//module top_module (
//	input [3:0] x,
//	input [3:0] y,
//	output [4:0] sum
//);
//
//	// This circuit is a 4-bit ripple-carry adder with carry-out.
//	assign sum = x+y;	// Verilog addition automatically produces the carry-out bit.
//
//	// Verilog quirk: Even though the value of (x+y) includes the carry-out, (x+y) is still considered to be a 4-bit number (The max width of the two operands).
//	// This is correct:
//	// assign sum = (x+y);
//	// But this is incorrect:
//	// assign sum = {x+y};	// Concatenation operator: This discards the carry-out
//endmodule