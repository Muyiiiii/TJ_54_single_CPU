`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 17:34:53
// Design Name: 
// Module Name: top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb();
    reg clk;
    reg rst;
    wire [7:0]o_seg;
    wire [7:0]o_sel;
    integer cnt = 0;

    initial begin
        clk = 0;
        rst = 1;

        #50;
        rst = 0;
    end

    always begin
        #50;
        clk = ~clk;
        if (clk == 1'b1) begin
            if (cnt == 1200) begin
            end
            else begin
                cnt = cnt + 1;
            end
        end
    end

    top top_inst(
        .clk(clk),
        .rst(rst),
        .o_seg(o_seg),
        .o_sel(o_sel)
    );

endmodule
