`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/31 20:17:51
// Design Name: 
// Module Name: CP0
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


module CP0(
    input clk,
    input rst,
    input [31:0]pc,
    input [4:0]Rd,          //CP0��Ŀ��Ĵ����ĵ�ַ
    input [31:0]wdata,      //��CPU����CP0�Ĵ����������
    input exception,        //�쳣�����ı�־
    // input eret,             //ָ��ERET(Except Return)
    input [4:0]cause,       //��cause�Ĵ����е�Extc���ݶ�
    input intr,             //��ʱ��������Ӳ���ж�
    input [5:0]op,          //��ǰָ������
    output [31:0]rdata,     //��CP0�д������ݵ�CPU��
    output [31:0]status,    //״̬����ʾ��ʲô�쳣
    output reg timer_int,
    output [31:0]exc_addr   //�͵���pcҪ�����ж�ָ���ĵ�ַ
);

    parameter ERET = 6'b10_1011;
    parameter MFC0 = 6'b10_1111;
    parameter MTC0 = 6'b11_0000;

    //�Ĵ����������ŵĶ�Ӧ
    parameter [4:0]STATUS=12,CAUSE=13,EPC=14;
    //status�Ĵ����й�����λ���Ķ�Ӧ����4:0����Ϊһ��32λ��
    parameter [4:0]ST_IE=0,ST_SYSCALL=1,ST_BREAK=2,ST_TEQ=3;
    //cause�Ĵ����й��ܵĶ�Ӧ
    parameter [3:0]C_SYSCALL=4'b1000,C_BREAK=4'b1001,C_TEQ=4'b1101,C_ERET=4'b0000;

    //CP0�Ĵ���
    reg [31:0]cp0_reg[31:0];

    assign exc_addr=cp0_reg[EPC];//��pcҪ�����ж�ָ���ĵ�ַ����
    assign status=cp0_reg[STATUS];//��ȡ�쳣������
    assign rdata=cp0_reg[Rd];

    always @(posedge clk or posedge rst)begin
        if(rst)begin
            cp0_reg[0]<=32'b0;
            cp0_reg[1]<=32'b0;
            cp0_reg[2]<=32'b0;
            cp0_reg[3]<=32'b0;
            cp0_reg[4]<=32'b0;
            cp0_reg[5]<=32'b0;
            cp0_reg[6]<=32'b0;
            cp0_reg[7]<=32'b0;
            cp0_reg[8]<=32'b0;
            cp0_reg[9]<=32'b0;
            cp0_reg[10]<=32'b0;
            cp0_reg[11]<=32'b0;
            cp0_reg[STATUS]<=32'hffff;
            cp0_reg[CAUSE]<=32'h0;
            cp0_reg[EPC]<=32'b0;
            cp0_reg[15]<=32'b0;
            cp0_reg[16]<=32'b0;
            cp0_reg[17]<=32'b0;
            cp0_reg[18]<=32'b0;
            cp0_reg[19]<=32'b0;
            cp0_reg[20]<=32'b0;
            cp0_reg[21]<=32'b0;
            cp0_reg[22]<=32'b0;
            cp0_reg[23]<=32'b0;
            cp0_reg[24]<=32'b0;
            cp0_reg[25]<=32'b0;
            cp0_reg[26]<=32'b0;
            cp0_reg[27]<=32'b0;
            cp0_reg[28]<=32'b0;
            cp0_reg[29]<=32'b0;
            cp0_reg[30]<=32'b0;
            cp0_reg[31]<=32'b0;
        end
        else begin
            //�жϽ������ظ��ֳ�
            if(op==ERET)begin
                cp0_reg[STATUS]<={5'b0,cp0_reg[STATUS][31:5]};
            end
            //д������
            else if(op==MTC0) begin
                cp0_reg[Rd]<=wdata[31:0];
            end
            //��ʼ�����쳣
            //���ǲ��ô����ն˵�Ƕ�ף���������û�лָ��жϵĿ���
            else if(exception && cp0_reg[STATUS][ST_IE] && cp0_reg[STATUS][4:1]!=4'b0000)begin
                cp0_reg[EPC]<=pc;
                //�ر��ж�
                cp0_reg[STATUS]<={cp0_reg[STATUS][26:0],5'b0};
                //�����쳣����
                cp0_reg[CAUSE]<={25'b0,cause[4:0],2'b0};
            end
            else ;
        end
    end

endmodule
