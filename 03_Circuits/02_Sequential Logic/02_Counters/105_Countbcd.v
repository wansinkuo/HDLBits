module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    // q[3:0]
    always @(posedge clk) begin
	    if (reset || q[3:0] == 4'd9) begin
	    	q[3:0] <= '0;
        end else begin
		    q[3:0] <= q[3:0] + 4'd1;
        end
    end

    // q[7:4]
    always @(posedge clk) begin
	    if (reset || ena[2]) begin
	    	q[7:4] <= '0;
        end else begin
		    q[7:4] <= q[7:4] + {3'd0, ena[1]};
        end
    end

    // q[11:8]
    always @(posedge clk) begin
	    if (reset || ena[3]) begin
	    	q[11:8] <= '0;
        end else begin
		    q[11:8] <= q[11:8] + {3'd0, ena[2]};
        end
    end

    // q[15:12]
    always @(posedge clk) begin
	    if (reset || (q[15:12] == 4'd9 && q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9)) begin
	    	q[15:12] <= '0;
        end else begin
		    q[15:12] <= q[15:12] + {3'd0, ena[3]};
        end
    end

    assign ena[3:1] = '{3:(q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9),
                        2:(q[ 7:4] == 4'd9 && q[3:0] == 4'd9), 
                        1:(q[ 3:0] == 4'd9)};

endmodule