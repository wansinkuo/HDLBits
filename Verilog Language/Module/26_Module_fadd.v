module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//

  wire lsb_cout;
  wire [15:0] msb_sum, lsb_sum;

  add16 add_lsb (
    .a(a[15:0]),
    .b(b[15:0]),
    .cin(1'b0),
    .sum(lsb_sum),
    .cout(lsb_cout)
  );
  
  add16 add_msb (
    .a(a[31:16]),
    .b(b[31:16]),
    .cin(lsb_cout),
    .sum(msb_sum),
    .cout()
  );
  
  assign sum = {msb_sum, lsb_sum};
  
  
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

// Full adder module here
  assign cout = (a&b) | (b&cin) | (a&cin);
  assign sum = a^b^cin;

endmodule
