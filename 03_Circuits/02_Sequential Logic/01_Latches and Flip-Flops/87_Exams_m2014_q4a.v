module top_module (
    input d, 
    input ena,
    output q);

    assign q = (ena)? d : q;

    //// other solution
    //always @(*) begin
    //    if (ena) begin
    //        q = d;
    //    end
    //end

endmodule