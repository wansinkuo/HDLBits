module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 'd0;
        end else if (q < 4'd9) begin
            q <= q+1;
        end else begin
            q <= 'd0;
        end
    end

    // answer on HDLBits
    //always @(posedge clk)
	//if (reset || q == 9)	// Count to 10 requires rolling over 9->0 instead of the more natural 15->0
	//	q <= 0;
	//else
	//	q <= q+1;
    
endmodule