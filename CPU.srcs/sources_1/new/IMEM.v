`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 10:48:10
// Design Name: 
// Module Name: IMEM
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


module IMEM(
    input [10:0]addr,//ָ��ĵ�ַ
    output [31:0]ins//����ָ������(32λ01��)
    );

    dist_mem_gen_0 IMEM_IP_inst(
        .a(addr),
        .spo(ins)
    );

endmodule
