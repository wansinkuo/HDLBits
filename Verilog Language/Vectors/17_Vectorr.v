module top_module( 
    input [7:0] in,
    output [7:0] out
);
    integer i;
    always @(*) begin
        for (i=0; i<8; i++) begin
            out[i] = in[8-i-1];
        end
    end
endmodule
