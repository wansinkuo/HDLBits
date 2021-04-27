module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
  
    genvar i;
    generate
      for (i=0; i<100; i=i+1) begin : GEN_100_FA
        if(i == 0) begin
          add1 fadd(
            .a    (a[i]   ),
            .b    (b[i]   ),
            .cin  (cin    ),
            .sum  (sum[i] ),
            .cout (cout[i]));
         end else begin
          add1 fadd(
            .a    (a[i]     ),
            .b    (b[i]     ),
            .cin  (cout[i-1]),
            .sum  (sum[i]   ),
            .cout (cout[i]  ));
        end
      end
    endgenerate
    
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

  assign cout = (a&b) | (b&cin) | (a&cin);
  assign sum = a^b^cin;

endmodule
