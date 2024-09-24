module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    // parameter LEFT=0, RIGHT=1, ...
  typedef enum {LEFT, RIGHT, NG_L, NG_R, DIG_L, DIG_R} state_t;
    state_t state, next_state;

    always @(*) begin
        // State transition logic
      case (state)
        LEFT:
          if (~ground) begin
            next_state = NG_L;
          end else if (dig) begin
            next_state = DIG_L;
          end else if (bump_left) begin
            next_state = RIGHT;
          end else begin
            next_state = state;
          end
        RIGHT:
          if (~ground) begin
            next_state = NG_R;
          end else if (dig) begin
            next_state = DIG_R;
          end else if (bump_right) begin
            next_state = LEFT;
          end else begin
            next_state = state;
          end
        NG_L:
          if (ground) begin
            next_state = LEFT;
          end else begin
            next_state = state;
          end
        NG_R:
          if (ground) begin
            next_state = RIGHT;
          end else begin
            next_state = state;
          end
        DIG_L:
          if (~ground) begin
            next_state = NG_L;
          end else begin
            next_state = state;
          end
        DIG_R:
          if (~ground) begin
            next_state = NG_R;
          end else begin
            next_state = state;
          end
        default:
          next_state = LEFT;
      endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
      if (areset) begin
        state <= LEFT;
      end else begin
        state <= next_state;
      end
    end

    // Output logic
  assign walk_left = (state == LEFT);
  assign walk_right = (state == RIGHT);
  assign aaah = (state == NG_L || state == NG_R);
  assign digging = (state == DIG_L || state == DIG_R);
endmodule
