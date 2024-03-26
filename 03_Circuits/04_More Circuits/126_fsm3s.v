module top_module(
    input clk,
    input in,
    input reset,
    output out); //

    typedef enum { A, B, C, D } state_t;
    state_t state, next_state;
  
    // State transition logic
    always @(*) begin
      case (state)
        A:
          if (in) begin
            next_state = B;
          end else begin
            next_state = state;
          end
        B:
          if (~in) begin
            next_state = C;
          end else begin
            next_state = state;
          end
        C:
          if (in) begin
            next_state = D;
          end else begin
            next_state = A;
          end
        D:
          if (in) begin
            next_state = B;
          end else begin
            next_state = C;
          end
        default:
          next_state = A;
      endcase
    end
  
    // State flip-flops with asynchronous reset
    always @(posedge clk) begin
      if (reset) begin
        state <= A;
      end else begin
        state <= next_state;
      end
    end
  
    // Output logic
    assign out = (state==D);
endmodule
