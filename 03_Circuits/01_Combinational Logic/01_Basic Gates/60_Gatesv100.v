module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );

    integer i;
    always @(*) begin
        for(i=0; i<99; i=i+1)begin
            out_both[i]  = in[i] & in[i+1];
            out_any[i+1] = in[i] | in[i+1];
        end
    end

    integer j;
    always @(*) begin
        for(j=0; j<100; j=j+1)begin
            if(j == 99)begin
                out_different[j] = in[j] ^ in[0];
            end else begin
                out_different[j] = in[j] ^ in[j+1];
            end
        end
    end

    // answer on HDLBITS
    //assign out_both = in & in[99:1];
	//assign out_any = in[99:1] | in ;
	//assign out_different = in ^ {in[0], in[99:1]};

endmodule