module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    // second[3:0] counter, count from 0-9
    always @(posedge clk) begin
        if (reset || (ss[3:0] == 4'd9 && ena)) begin
            ss[3:0] <= '0;
        end else begin
            ss[3:0] <= ss[3:0] + {3'b0, ena};
        end
    end

    // second[7:4] counter, count from 0-5
    always @(posedge clk) begin
        if (reset || (ss == {4'd5, 4'd9} && ena)) begin
            ss[7:4] <= '0;
        end else begin
            ss[7:4] <= ss[7:4] + {3'b0, (ss[3:0] == 4'd9 && ena)};
        end
    end

    // minute[3:0] counter, count from 0-9
    always @(posedge clk) begin
        if (reset || (mm[3:0] == 4'd9 && ss == {4'd5, 4'd9} && ena)) begin
            mm[3:0] <= '0;
        end else begin
            mm[3:0] <= mm[3:0] + {3'b0, (ss == {4'd5, 4'd9} && ena)};
        end
    end

    // minute[7:4] counter, count from 0-5
    always @(posedge clk) begin
        if (reset || (mm == {4'd5, 4'd9} && ss == {4'd5, 4'd9} && ena)) begin
            mm[7:4] <= '0;
        end else begin
            mm[7:4] <= mm[7:4] + {3'b0, (mm[3:0] == 4'd9 && ss == {4'd5, 4'd9} && ena)};
        end
    end

    // hour[3:0] counter, count from 0-9 when h[7:4] == 0, otherwise count from 0-2
    always @(posedge clk) begin
        if (reset) begin // hh reset to 12
            hh[3:0] <= 4'd2;
        end else begin
            if (hh[7:4] == 4'd1) begin
                if (hh[3:0] == 4'd2 && mm == {4'd5, 4'd9} && ss == {4'd5, 4'd9} && ena) begin
                    hh[3:0] <= 4'd1;
                end else begin
                    hh[3:0] <= hh[3:0] + {7'b0, (mm == {4'd5, 4'd9} && ss == {4'd5, 4'd9} && ena)};
                end
            end else begin
                if (hh[3:0] == 4'd9 && mm == {4'd5, 4'd9} && ss == {4'd5, 4'd9} && ena) begin
                    hh[3:0] <= 4'd0;
                end else begin
                    hh[3:0] <= hh[3:0] + {7'b0, (mm == {4'd5, 4'd9} && ss == {4'd5, 4'd9} && ena)};
                end
            end
        end
    end

    // hour[7:4] counter, count from 0-2
    always @(posedge clk) begin
        if (reset) begin
            hh[7:4] <= 4'd1;
        end else if (hh == {4'd1, 4'd2} && mm == {4'd5, 4'd9} && ss == {4'd5, 4'd9} && ena) begin
            hh[7:4] <= 4'd0;
        end else begin
            hh[7:4] <= hh[7:4] + {7'b0, (hh[3:0] == 4'd9 && mm == {4'd5, 4'd9} && ss == {4'd5, 4'd9} && ena)};
        end
    end

    // pm
    always @(posedge clk) begin
        if (reset) begin
            pm <= 'd0;
        end else if (hh == {4'd1, 4'd1} && mm == {4'd5, 4'd9} && ss == {4'd5, 4'd9} && ena) begin
            pm <= ~pm;
        end
    end

    // other solution
    //always @(posedge clk) begin
    //    if (reset) begin
    //        pm <= '0;
    //        hh <= 8'h12;
    //        mm <= '0;
    //        ss <= '0;
    //    end else if (ena) begin
    //        if (ss < 8'h59) begin
    //            if (ss[3:0] < 4'h9) begin
    //                ss[3:0] <= ss[3:0] + 4'h1;
    //            end else begin
    //                ss[3:0] <= 4'h0;
    //                ss[7:4] <= ss[7:4] + 4'h1;
    //            end
    //        end else begin
    //            ss <= 8'h0;
    //            if (mm < 8'h59) begin
    //                if (mm[3:0] < 4'h9) begin
    //                    mm[3:0] <= mm[3:0] + 4'h1;
    //                end else begin
    //                    mm[3:0] <= 4'h0;
    //                    mm[7:4] <= mm[7:4] + 4'h1;
    //                end
    //            end else begin
    //                mm <= 8'h0;
    //                if (hh < 8'h12) begin            
    //                    if (hh[3:0] < 4'h9) begin
    //                        hh[3:0] <= hh[3:0] + 4'h1;
    //                    end else begin
    //                        hh[3:0] <= 4'h0;
    //                        hh[7:4] <= hh[7:4] + 4'h1;
    //                    end
    //                end else begin
    //                    hh <= 8'h1;
    //                end
//
    //                if (hh == 8'h11) begin
    //                    pm <= ~pm;
    //                end
    //            end
    //        end
    //    end
    //end

endmodule