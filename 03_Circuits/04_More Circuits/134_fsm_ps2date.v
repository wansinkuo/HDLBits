module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    
  typedef enum {IDLE, BYTE2, BYTE3, DONE} state_t;
  state_t state, next_state;
  
    // State transition logic (combinational)
  always @(*) begin
    case (state) 
      IDLE:
        if (in[3]) begin
          next_state = BYTE2;
        end else begin
          next_state = state;
        end
      BYTE2:
        next_state = BYTE3;
      BYTE3:
        next_state = DONE;
      DONE:
        if (in[3]) begin
          next_state = BYTE2;
        end else begin
          next_state = IDLE;
        end
      default: 
        next_state = IDLE;
    endcase
  end
  
    // State flip-flops (sequential)
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      out_bytes <= '0;
    end else begin
      state <= next_state;
      out_bytes <= {out_bytes[15:0],in};
    end
  end
 
    // Output logic
  assign done = (state == DONE);
    
endmodule
