module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    always @(posedge clk) begin
        if (reset || (q == 4'd9 && slowena)) begin
            q <= 'd0;
        end else if (slowena) begin
            q <= q+1;
        end
    end

endmodule