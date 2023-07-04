`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/01 13:56:42
// Design Name: 
// Module Name: HI_or_LO
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


module HI_or_LO(
    input clk,
    input wena,//Ð´µÄÊ¹ÄÜ¶Ë
    input rst,
    input [31:0]wdata,
    output [31:0]rdata
    );

    reg [31:0]data;

    assign rdata=data;

    always@(posedge clk or posedge rst) begin
        if(rst) begin
            data<=32'b0;
        end
        else if(wena) begin
            data<=wdata;
        end
        else ;
    end

endmodule
