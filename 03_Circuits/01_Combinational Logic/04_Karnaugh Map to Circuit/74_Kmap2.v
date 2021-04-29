module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    // SOP form
    assign out = (~a & ~c & ~d) |
                 (~a &  c & ~d) |
                 (~a &  b &  c) |
                 (     ~b & ~c) |
                 ( a &  c &  d);

    // POS form
    assign out = (~a | ~b |  c) &
                 (~b |  c | ~d) &
                 (~a | ~c |  d) &
                 ( a |  b | ~c | ~d);

endmodule