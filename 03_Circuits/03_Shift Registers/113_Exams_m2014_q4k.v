module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);

    reg [3:0] delay_in;
    always @(posedge clk) begin
        if (~resetn) begin
            delay_in <= '0;
        end else begin
            delay_in <= {delay_in[2:0], in};
        end
    end

    assign out = delay_in[3];

endmodule