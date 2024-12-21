module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

  typedef enum {IDLE, ONE, TWO, THREE, FOUR, FIVE, SIX, DISCARD, FLAG, ERR} state_t;
  state_t state, next_state;

  always @(*) begin
    case (state)
      IDLE: next_state = in? ONE : IDLE;          
      ONE: next_state = in? TWO : IDLE;
      TWO: next_state = in? THREE : IDLE;
      THREE: next_state = in? FOUR : IDLE;
      FOUR: next_state = in? FIVE : IDLE;
      FIVE: next_state = in? SIX : DISCARD;
      SIX: next_state = in? ERR : FLAG;
      DISCARD: next_state = in? ONE : IDLE;
      FLAG: next_state = in? ONE : IDLE;
      ERR: next_state = in? ERR : IDLE;
      default: next_state = IDLE;
    endcase
  end

  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  assign disc = (state == DISCARD);
  assign flag = (state == FLAG);
  assign err = (state == ERR);
        
endmodule
