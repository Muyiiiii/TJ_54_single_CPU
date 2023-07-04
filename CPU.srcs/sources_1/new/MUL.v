`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/01 22:21:01
// Design Name: 
// Module Name: MUL
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


module MUL(
    input [31:0] a,
    input [31:0] b,
    input sign,
    output [63:0] res,
    output [31:0] HI,
    output [31:0] LO
    );

//无符号
wire [63:0] unsigned_a,unsigned_b,unsigned_res;
assign unsigned_a ={ 32'b0 , a };
assign unsigned_b ={ 32'b0 , b };
assign unsigned_res = unsigned_a * unsigned_b;

//有符号
wire signed [63:0] signed_a ,signed_b,signed_res;
assign signed_a = { {32{a[31]}} , a };
assign signed_b = { {32{b[31]}} , b };
assign signed_res = signed_a * signed_b;

//最终结果
assign res = sign ? signed_res : unsigned_res;
assign HI = res[63:32];
assign LO = res[31:0];

endmodule
