module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

  logic [3:0] alive_neighbours; // maximum : 8
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      for (int i = 0; i < 256; i++) begin: DETECT_NEIGHBOURS        
         if (i == 0) begin
           alive_neighbours = q[255] + q[240] + q[241] + q[15] + q[1] + q[31] + q[16] + q[17];
         end 
         else if (i == 15) begin
           alive_neighbours = q[254] + q[255] + q[240] + q[14] + q[0] + q[30] + q[31] + q[16];
         end 
         else if (i == 240) begin
           alive_neighbours = q[239] + q[224] + q[225] + q[255] + q[241] + q[15] + q[0] + q[1];
         end 
         else if (i == 255) begin
           alive_neighbours = q[238] + q[239] + q[224] + q[254] + q[240] + q[14] + q[15] + q[0];
         end
         else if (i < 16) begin // row0, first row
           alive_neighbours = q[239+i] + q[240+i] + q[241+i] + q[i-1] + q[i+1] + q[i+15] + q[i+16] + q[i+17];
         end 
         else if (i <= 255 && i >= 240) begin // row15, last row
           alive_neighbours = q[i-17] + q[i-16] + q[i-15] + q[i-1] + q[i+1] + q[i-241] + q[i-240] + q[i-239];
         end 
         else if (i%16 == 0) begin // first column
           alive_neighbours = q[i-1] + q[i-16] + q[i-15] + q[i+15] + q[i+1] + q[i+31] + q[i+16] + q[i+17];
         end 
        else if (i%16 == 15) begin // last column
           alive_neighbours = q[i-17] + q[i-16] + q[i-31] + q[i-1] + q[i-15] + q[i+15] + q[i+16] + q[i+1];
         end 
         else begin // other internal rows
           alive_neighbours = q[i-17] + q[i-16] + q[i-15] + q[i-1] + q[i+1] + q[i+15] + q[i+16] + q[i+17];
         end

        if ((alive_neighbours == 0 || alive_neighbours == 1) || alive_neighbours >= 4) begin
          q[i] <= 1'b0;
        end
        else if (alive_neighbours == 3) begin
          q[i] <= 1'b1;
        end
        
       end
    end
  end
endmodule
