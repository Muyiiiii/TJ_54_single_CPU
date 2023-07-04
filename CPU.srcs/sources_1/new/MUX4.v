`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 19:53:22
// Design Name: 
// Module Name: MUX4
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


module MUX4(
    input clk,
    input ena,
    input [31:0]in1,
    input [31:0]in2,
    input [31:0]in3,
    input [31:0]in4,
    input [31:0]in5,
    input [31:0]in6,
    input [31:0]in7,
    input [31:0]in8,
    input [2:0]choice,
    output reg [31:0]out
    );

    always @(*)begin
        if(ena)begin
            case(choice)
                3'd1:begin
                    out<=in1;
                end
                3'd2:begin
                    out<=in2;
                end
                3'd3:begin
                    out<=in3;
                end
                3'd4:begin
                    out<=in4;
                end
                3'd5:begin
                    out<=in5;
                end
                3'd6:begin
                    out<=in6;
                end
                3'd7:begin
                    out<=in7;
                end
                3'd0:begin
                    out<=in8;
                end
            endcase
        end
    end
endmodule
