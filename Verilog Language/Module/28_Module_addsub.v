module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
  wire [31:0] b_xor = b^{32{sub}};
  
  wire lsb_cout;
  wire [15:0] msb_sum, lsb_sum;

  add16 add_lsb (
    .a   (a[15:0]),
    .b   (b_xor[15:0]),
    .cin (sub),
    .sum (lsb_sum),
    .cout(lsb_cout)
  );
  
  add16 add_msb (
    .a   (a[31:16]),
    .b   (b_xor[31:16]),
    .cin (lsb_cout),
    .sum (msb_sum),
    .cout()
  );
  
  assign sum = {msb_sum, lsb_sum};
  
endmodule
