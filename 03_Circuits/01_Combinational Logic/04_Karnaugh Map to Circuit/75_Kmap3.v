module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    // SOP form
    assign out = a | (~b & c);

    // POS form
    assign out = (a | ~b) & (c | ~d) & (a | c);

endmodule