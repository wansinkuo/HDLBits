module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//

  wire lsb_cout;
  wire [15:0] msb_sum_cin0, msb_sum_cin1, lsb_sum;

  add16 add_lsb (
    .a(a[15:0]),
    .b(b[15:0]),
    .cin(1'b0),
    .sum(lsb_sum),
    .cout(lsb_cout)
  );
  
  add16 add_msb_cin0 (
    .a(a[31:16]),
    .b(b[31:16]),
    .cin(1'b0),
    .sum(msb_sum_cin0),
    .cout()
  );
   
  add16 add_msb_cin1 (
    .a(a[31:16]),
    .b(b[31:16]),
    .cin(1'b1),
    .sum(msb_sum_cin1),
    .cout()
  );
  assign sum = {(lsb_cout? msb_sum_cin1 : msb_sum_cin0), lsb_sum};
  
endmodule
