`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 10:49:06
// Design Name: 
// Module Name: DMEM
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


module DMEM(
    input clk,//ʱ��
    input ena,
    input [5:0]op,
    input worr,//write_or_read дΪ1����Ϊ0
    input [4:0]addr,//�������ڴ�ĵ�ַ
    input [31:0]wdata,//д�������
    output [31:0]rdata//��ȡ��������
    );

    parameter SB = 6'b10_0101;
    parameter SH = 6'b10_0110;
    parameter SW = 6'b010111;

    reg [31:0]mem[0:31];//�������,��32λ�ĵ�ַ����ɵ�32���ݴ洢��

    always @(posedge clk)begin 
        if(worr && ena) begin
            case(op)
                SW:begin
                    mem[addr]<=wdata;
                end
                SH:begin
                    mem[addr][15:0]<=wdata[15:0];
                end
                SB:begin
                    mem[addr][7:0]<=wdata[7:0];
                end
                default begin
                    mem[addr]<=wdata;
                end
            endcase
        end
    end

    assign rdata=(worr==1'b0&&ena)?mem[addr]:32'dz;

endmodule
