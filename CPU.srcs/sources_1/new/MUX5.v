`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/02 09:11:52
// Design Name: 
// Module Name: MUX5
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


module MUX5(
    input clk,
    input ena,
    input [31:0]in1,
    input [31:0]in2,
    input [31:0]in3,
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
            endcase
        end
    end

endmodule
