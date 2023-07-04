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
    input [4:0]Rd,          //CP0中目标寄存器的地址
    input [31:0]wdata,      //从CPU传到CP0寄存器里的数据
    input exception,        //异常发生的标志
    // input eret,             //指令ERET(Except Return)
    input [4:0]cause,       //是cause寄存器中的Extc数据段
    input intr,             //定时器产生的硬件中断
    input [5:0]op,          //当前指令类型
    output [31:0]rdata,     //从CP0中传输数据到CPU中
    output [31:0]status,    //状态，表示是什么异常
    output reg timer_int,
    output [31:0]exc_addr   //送的是pc要到的中断指令块的地址
);

    parameter ERET = 6'b10_1011;
    parameter MFC0 = 6'b10_1111;
    parameter MTC0 = 6'b11_0000;

    //寄存器名字与编号的对应
    parameter [4:0]STATUS=12,CAUSE=13,EPC=14;
    //status寄存器中功能与位数的对应（用4:0是因为一共32位）
    parameter [4:0]ST_IE=0,ST_SYSCALL=1,ST_BREAK=2,ST_TEQ=3;
    //cause寄存器中功能的对应
    parameter [3:0]C_SYSCALL=4'b1000,C_BREAK=4'b1001,C_TEQ=4'b1101,C_ERET=4'b0000;

    //CP0寄存器
    reg [31:0]cp0_reg[31:0];

    assign exc_addr=cp0_reg[EPC];//将pc要到的中断指令块的地址返回
    assign status=cp0_reg[STATUS];//获取异常的名称
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
            //中断结束，回复现场
            if(op==ERET)begin
                cp0_reg[STATUS]<={5'b0,cp0_reg[STATUS][31:5]};
            end
            //写入数据
            else if(op==MTC0) begin
                cp0_reg[Rd]<=wdata[31:0];
            end
            //开始处理异常
            //我们不用处理终端的嵌套，故我这里没有恢复中断的开关
            else if(exception && cp0_reg[STATUS][ST_IE] && cp0_reg[STATUS][4:1]!=4'b0000)begin
                cp0_reg[EPC]<=pc;
                //关闭中断
                cp0_reg[STATUS]<={cp0_reg[STATUS][26:0],5'b0};
                //保存异常类型
                cp0_reg[CAUSE]<={25'b0,cause[4:0],2'b0};
            end
            else ;
        end
    end

endmodule
