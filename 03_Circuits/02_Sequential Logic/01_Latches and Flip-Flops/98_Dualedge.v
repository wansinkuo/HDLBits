module top_module (
    input clk,
    input d,
    output q
);

    reg q_pos, q_neg;
    always @(posedge clk) begin
        q_pos <= d;
    end

    always @(negedge clk) begin
        q_neg <= d;
    end

    assign q = (clk)? q_pos : q_neg;

    //// answer on HDLBits
    //reg p, n;
	//
	//// A positive-edge triggered flip-flop
    //always @(posedge clk)
    //    p <= d ^ n;
    //    
    //// A negative-edge triggered flip-flop
    //always @(negedge clk)
    //    n <= d ^ p;
    //
    //// Why does this work? 
    //// After posedge clk, p changes to d^n. Thus q = (p^n) = (d^n^n) = d.
    //// After negedge clk, n changes to p^n. Thus q = (p^n) = (p^p^n) = d.
    //// At each (positive or negative) clock edge, p and n FFs alternately
    //// load a value that will cancel out the other and cause the new value of d to remain.
    //assign q = p ^ n;

endmodule