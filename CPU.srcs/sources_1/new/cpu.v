`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 10:49:21
// Design Name: 
// Module Name: cpu
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


module CPU(
    input clk,
    input rst,//整体的重置
    input ena,
    //IMEM
    input [31:0]ins,
    //DMEM
    output DM_worr,
    output [4:0]DM_addr,//操作的内存的地址
    output [31:0]DM_wdata,//写入的数据
    input [31:0]DM_rdata,//读取到的数据
    output DM_ena,
    //regfile
    //ALU
    //PC
    output [31:0]pc,//下一个指令的地址指针
    //Controller
    output [5:0]op
    );

    parameter ADD = 6'b000000;
    parameter ADDU = 6'b000001;
    parameter SUB = 6'b000010;
    parameter SUBU = 6'b000011;
    parameter AND = 6'b000100;
    parameter OR = 6'b000101;
    parameter XOR = 6'b000110;
    parameter NOR = 6'b000111;
    parameter SLT = 6'b001000;
    parameter SLTU = 6'b001001;
    parameter SLL = 6'b001010;
    parameter SRL = 6'b001011;
    parameter SRA = 6'b001100;
    parameter SLLV = 6'b001101;
    parameter SRLV = 6'b001110;
    parameter SRAV = 6'b001111;
    parameter JR = 6'b010000;

    parameter ADDI = 6'b010001;
    parameter ADDIU = 6'b010010;
    parameter ANDI = 6'b010011;
    parameter ORI = 6'b010100;
    parameter XORI = 6'b010101;
    parameter LW = 6'b010110;
    parameter SW = 6'b010111;
    parameter BEQ = 6'b011000;
    parameter BNE = 6'b011001;
    parameter SLTI = 6'b011010;
    parameter SLTIU = 6'b011011;
    parameter LUI = 6'b011100;

    parameter J = 6'b011101;
    parameter JAI = 6'b011110;


    parameter [31:0]ACCIDENT=32'h00400078;


    //regfile
    //寄存器
    wire RF_wena;//寄存器写入的使能端
    wire [4:0]Rdc;
    wire [4:0]Rsc;
    wire [4:0]Rtc;
    wire [31:0]Rd;
    wire [31:0]Rs;
    wire [31:0]Rt;
    //ALU
    wire [31:0]aluc_r;
    wire zero;
    wire carry;
    wire negative;
    wire overflow;

    //EXT
    wire [31:0]ext_out;
    //Connect
    wire [31:0]connect_out;
    //MUX
    wire ena_MUX1;
    wire [31:0]out_MUX1;
    wire [2:0]choice_MUX1;
    wire ena_MUX2;
    wire [31:0]out_MUX2;
    wire [2:0]choice_MUX2;
    wire ena_MUX3;
    wire [31:0]out_MUX3;
    wire [2:0]choice_MUX3;
    wire ena_MUX4;
    wire [31:0]out_MUX4;
    wire [2:0]choice_MUX4;
    wire ena_MUX5;
    wire [31:0]out_MUX5;
    wire [2:0]choice_MUX5;
    wire ena_MUX6;
    wire [31:0]out_MUX6;
    wire [2:0]choice_MUX6;
    //ADD
    wire [31:0]add1_out;
    wire [31:0]add2_out;
    //clk
    // wire clk_10;
    //NPC
    wire [31:0]NPC=pc+32'd4;
    //CP0
    wire [31:0]exc_addr;//pc的恢复地址
    wire mfc0;//读取CP0的标志符号
    wire mtc0;//写入CP0的标志符号
    wire eret;//CP0中断结束的符号
    wire [4:0]CP0_rd;
    wire [31:0]CP0_wdata;
    wire [31:0]CP0_rdata;
    wire [4:0]cause_extc;//cause寄存器中的Extc数据段
    wire exception;//异常发生的标记
    wire intr;//定时器产生的硬件中断
    wire status;//状态，表示是什么异常
    wire timer_int;
    //HI
    wire HI_wena;
        // wire [31:0]HI_wdata;
    wire [31:0]HI_rdata;
    //LO
    wire LO_wena;
        // wire [31:0]LO_wdata;
    wire [31:0]LO_rdata;
    //MUL
    wire MUL_sign;
    wire [63:0]MUL_res;
    wire [31:0]MUL_HI;
    wire [31:0]MUL_LO;
    //DIV
    wire DIV_sign;
    wire [31:0]DIV_q;
    wire [31:0]DIV_r;
    //DMEM
    assign DM_addr = aluc_r[4:0];

    //PcReg
    PC PC_inst(
        .clk(clk),
        .rst(rst),
        .ena(ena),
        .pc_in(out_MUX1),
        .pc_next(pc)
    );


    //regfile
    //寄存器
    // assign Rd = out_MUX4;
    regfile cpu_ref(
        .ena(ena),
        .rst(rst),
        .clk(clk),
        .write_ena(RF_wena),
        .Rdc(Rdc),
        .Rsc(Rsc),
        .Rtc(Rtc),
        .Rd(Rd),
        .Rs(Rs),
        .Rt(Rt)
    );

    //Controller
    //翻译指令??转成op(operation)
    Controller Controller_inst(
        .clk(clk),
        .ena(ena),
        .rst(rst),
        .zero(zero),
        .ins(ins),
        .op(op),
        .ena_MUX1(ena_MUX1),
        .choice_MUX1(choice_MUX1),
        .ena_MUX2(ena_MUX2),
        .choice_MUX2(choice_MUX2),
        .ena_MUX3(ena_MUX3),
        .choice_MUX3(choice_MUX3),
        .ena_MUX4(ena_MUX4),
        .choice_MUX4(choice_MUX4),
        .ena_MUX5(ena_MUX5),
        .choice_MUX5(choice_MUX5),
        .ena_MUX6(ena_MUX6),
        .choice_MUX6(choice_MUX6),
        .Rs(Rs),
        .Rt(Rt),
        .Rd(Rd),
        .out_MUX4(out_MUX4),
        .RF_wena(RF_wena),
        .Rdc(Rdc),
        .Rsc(Rsc),
        .Rtc(Rtc),
        .DM_ena(DM_ena),
        .DM_wdata(DM_wdata),
        .DM_worr(DM_worr),
        .MUL_sign(MUL_sign),
        .DIV_sign(DIV_sign),
        .HI_wena(HI_wena),
        .LO_wena(LO_wena),
        .CP0_rd(CP0_rd),
        .CP0_wdata(CP0_wdata),
        .CP0_rdata(CP0_rdata),
        .CP0_exception(exception),
        .CP0_cause_extc(cause_extc)
    );


    //ALU
    ALU ALU_inst(
        .a(out_MUX2),
        .b(out_MUX3),
        .aluc(op),
        .r(aluc_r),
        .zero(zero),
        .carry(carry),
        .negative(negative),
        .overflow(overflow)
    );


    //EXT
    EXT EXT_inst(
        .clk(clk),
        .ena(ena),
        .op(op),
        .ins(ins),
        .ext_out(ext_out)
    );


    //connect
    Connect Connect_inst(
        .clk(clk),
        .ena(ena),
        .pc(pc),//用当前的pc的应该不会出问题吧。。。
        .ins(ins),
        .connect_out(connect_out)
    );


    //ADD1
    ADD1 ADD1_inst(
        .NPC(NPC),
        .ext_out(ext_out),
        .add1_out(add1_out)
    );


    //ADD2
    ADD2 ADD2_inst(
        .pc(pc),
        .add2_out(add2_out)
    );


    //MUX1
    MUX1 MUX1_inst(
        .clk(clk),
        .ena(ena_MUX1),
        .in1(NPC),
        .in2(connect_out),
        .in3(Rs),
        .in4(add1_out),
        .in5(exc_addr),//cp0恢复回原先的指令地址
        .in6(ACCIDENT),//异常指令地址
        .in7(ext_out),//BEGZ指令的其中一个操作数
        .choice(choice_MUX1),
        .out(out_MUX1)
    );


    //MUX2
    MUX2 MUX2_inst(
        .clk(clk),
        .ena(ena_MUX2),
        .in1(Rs),
        .in2(ext_out),
        .choice(choice_MUX2),
        .out(out_MUX2)
    );


    //MUX3
    MUX3 MUX3_inst(
        .clk(clk),
        .ena(ena_MUX3),
        .in1(Rt),
        .in2(ext_out),
        .in3(32'b0),
        .choice(choice_MUX3),
        .out(out_MUX3)
    );


    //MUX4
    MUX4 MUX4_inst(
        .clk(clk),
        .ena(ena_MUX4),
        .in1({31'b0,negative}),
        .in2(DM_rdata),
        .in3(aluc_r),
        .in4(add2_out),
        .in5(HI_rdata),
        .in6(LO_rdata),
        .in7(CP0_rdata),
        .in8(out_MUX6),//乘除法的低位结果
        .choice(choice_MUX4),
        .out(out_MUX4)
    );


CP0 CP0_inst(
    .clk(clk),
    .rst(rst),
    .pc(pc),
    .Rd(CP0_rd),
    .wdata(CP0_wdata),
    .exception(exception),
    .cause(cause_extc),
    .intr(intr),
    .op(op),
    .rdata(CP0_rdata),
    .status(status),
    .timer_int(timer_int),
    .exc_addr(exc_addr)
);

HI_or_LO HI_inst(
    .clk(clk),
    .wena(HI_wena),
    .rst(rst),
    .wdata(out_MUX5),
    .rdata(HI_rdata)
);

HI_or_LO LO_inst(
    .clk(clk),
    .wena(LO_wena),
    .rst(rst),
    .wdata(out_MUX6),
    .rdata(LO_rdata)
);

MUX5 MUX5_inst(
    .clk(clk),
    .ena(ena_MUX5),
    .in1(MUL_HI),
    .in2(DIV_r),
    .in3(Rs),
    .choice(choice_MUX5),
    .out(out_MUX5)
);

MUX6 MUX6_inst(
    .clk(clk),
    .ena(ena_MUX6),
    .in1(MUL_LO),
    .in2(DIV_q),
    .in3(Rs),
    .choice(choice_MUX6),
    .out(out_MUX6)
);

MUL MUL_inst(
    .a(Rs),
    .b(Rt),
    .sign(MUL_sign),
    .res(MUL_res),
    .HI(MUL_HI),
    .LO(MUL_LO)
);

DIV DIV_inst(
    .a(Rs),
    .b(Rt),
    .sign(DIV_sign),
    .q(DIV_q),
    .r(DIV_r)
);
    
endmodule
