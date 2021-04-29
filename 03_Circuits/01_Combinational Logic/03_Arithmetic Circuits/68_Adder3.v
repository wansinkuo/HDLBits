module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );

    wire [2:0] cin_tmp = {cout[1:0], cin};
    
    fadd inst_fadd [2:0] (
        .a   (a),
        .b   (b),
        .cin (cin_tmp),
        .cout(cout),
        .sum (sum)
    );

endmodule

module fadd( 
    input a, b, cin,
    output cout, sum );

    assign cout = (a&b) | (a&cin) | (b&cin);
    assign sum  = ^{a , b, cin};

endmodule