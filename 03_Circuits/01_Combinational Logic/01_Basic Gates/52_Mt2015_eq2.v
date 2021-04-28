module top_module ( input [1:0] A, input [1:0] B, output z ); 

    assign z = ~(|(A^B));
    // assign z = (A==B); // it can also work.

endmodule