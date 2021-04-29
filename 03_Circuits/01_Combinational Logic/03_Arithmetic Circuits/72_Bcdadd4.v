module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    wire [3:0] cout_tmp;
    wire [3:0] cin_tmp = {cout_tmp[2:0], cin};

    genvar i;
    generate
        for (i=0; i<4; i++) begin : GEN_BCD_FADD
            bcd_fadd inst_bcd_fadd (
                .a   (a[(i*4)+:4]),
                .b   (b[(i*4)+:4]),
                .cin (cin_tmp[i]),
                .cout(cout_tmp[i]),
                .sum (sum[(i*4)+:4])
            );
        end
    endgenerate

    assign cout = cout_tmp[3];
endmodule