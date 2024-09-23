module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

  typedef enum {NO_S, U_S1_S2, D_S1_S2, U_S2_S3, D_S2_S3, ABOVE_S3} state_t;
  state_t state, next_state;
  
  // State transition logic
  always @(*) begin
    case(state)
      NO_S:    next_state = s[1]? U_S1_S2 : state;
      U_S1_S2: next_state = s[2]? U_S2_S3 : (s[1]? state : NO_S);
      D_S1_S2: next_state = s[2]? U_S2_S3 : (s[1]? state : NO_S);
      U_S2_S3: next_state = s[3]? ABOVE_S3 : (s[2]? state : D_S1_S2);
      D_S2_S3: next_state = s[3]? ABOVE_S3 : (s[2]? state : D_S1_S2);
      ABOVE_S3: next_state = s[3]? state : D_S2_S3;
      default: next_state = NO_S;
    endcase
  end  
  
  always @(*) begin
    case(state)
      NO_S:     {fr3, fr2, fr1, dfr} = 4'b1111;
      U_S1_S2:  {fr3, fr2, fr1, dfr} = 4'b0110;
      D_S1_S2:  {fr3, fr2, fr1, dfr} = 4'b0111;
      U_S2_S3:  {fr3, fr2, fr1, dfr} = 4'b0010;
      D_S2_S3:  {fr3, fr2, fr1, dfr} = 4'b0011;
      ABOVE_S3: {fr3, fr2, fr1, dfr} = 4'b0000;
      default:  {fr3, fr2, fr1, dfr} = 4'b1111;
    endcase
  end  
  
  // State flip-flops with synchronous reset
  always @(posedge clk) begin
    if (reset) begin
      state <= NO_S;
    end else begin
      state <= next_state;
    end
  end
endmodule
