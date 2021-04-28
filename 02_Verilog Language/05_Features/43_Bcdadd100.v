module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
  
  wire [99:0] cout_tmp;
  
  genvar i;
  generate
    for (i=0; i<100; i=i+1) begin : GEN_100_BCDADD
      if (i==0) begin
          bcd_fadd bcd_fadd (
            .a    (a[i+:4]    ),
            .b    (b[i+:4]    ),
            .cin  (cin        ),
            .sum  (sum[i+:4]  ),
            .cout (cout_tmp[i]));
      end else begin
          bcd_fadd bcd_fadd (
            .a    (a[i*4+:4]    ),
            .b    (b[i*4+:4]    ),
            .cin  (cout_tmp[i-1]),
            .sum  (sum[i*4+:4]  ),
            .cout (cout_tmp[i]  ));
      end
    end
  endgenerate
  
  assign cout = cout_tmp[99];
  
endmodule
