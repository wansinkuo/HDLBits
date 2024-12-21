module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 

  typedef enum {IDLE, DATA, CHECK, STOP, ERR} state_t;
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
          next_state = CHECK;
        end else begin
          next_state = state;
        end
      CHECK:
        if (in) begin
          next_state = STOP;
        end else begin
          next_state = ERR;
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
    if (state == DATA && data_cnt <= 4'd7) begin
      out_byte <= {in,out_byte[7:1]};
    end
  end

  logic odd;
  logic rst;
  assign rst = reset || (state == DATA && data_cnt == 4'd0);
  parity u_parity(clk, rst, in , odd);
  
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
    end else begin
      state <= next_state;
    end
  end
  
  assign done = (state == STOP) && (~odd);
  
endmodule
