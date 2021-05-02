module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //

    always @(posedge clk) begin
        if (reset || (Q == 4'd12 && enable)) begin
            Q <= 4'd1;
        end else if (enable) begin
            Q <= Q + 4'd1;
        end
    end

    assign c_enable = enable;
    assign c_load = reset || (Q == 4'd12 && enable);
    assign c_d = c_load? 4'd1 : 4'd0;
    count4 the_counter (clk, c_enable, c_load, c_d);

endmodule