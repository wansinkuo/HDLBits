module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

  typedef enum {IDLE, START, DATA, STOP, ERR} state_t;
  state_t state, next_state;
  
  always @(*) begin
    case (state)
      IDLE:
        if (~in) begin
          next_state = DATA;
        end else begin
          next_state = state;
        end
      DATA:
        if (data_cnt == 4'd8) begin
          if (in) begin
            next_state = STOP;
          end else begin
            next_state = ERR;
          end
        end else begin
          next_state = state;
        end
      STOP:
        if (~in) begin
          next_state = DATA;
        end else begin
          next_state = IDLE;
        end
      ERR:
        if (in) begin
          next_state = IDLE;
        end else begin
          next_state = state;
        end
      default:
        next_state = IDLE;
    endcase
  end

  logic [3:0] data_cnt;
  always @(posedge clk) begin
    if (state == DATA) begin
      data_cnt <= data_cnt + 4'd1;
    end else begin
      data_cnt <= '0;
    end
  end
  
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end

  assign done = (state == STOP);
  
endmodule
