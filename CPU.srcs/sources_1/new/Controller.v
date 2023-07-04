`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 15:19:38
// Design Name: 
// Module Name: Controller
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


module Controller(
    input clk,
    input ena,
    input rst,
    input zero,
    input [31:0]ins,
    output reg [5:0]op,
    output reg ena_MUX1,
    output reg [2:0]choice_MUX1,
    output reg ena_MUX2,
    output reg [2:0]choice_MUX2,
    output reg ena_MUX3,
    output reg [2:0]choice_MUX3,
    output reg ena_MUX4,
    output reg [2:0]choice_MUX4,
    output reg ena_MUX5,
    output reg [2:0]choice_MUX5,
    output reg ena_MUX6,
    output reg [2:0]choice_MUX6,
    //Regfile
    input [31:0]Rs,
    input [31:0]Rt,
    output reg [31:0]Rd,
    input [31:0]out_MUX4,
    output reg RF_wena,
    output reg [4:0]Rdc,
    output reg [4:0]Rsc,
    output reg [4:0]Rtc,
    //DMEM
    output reg DM_ena,
    output reg [31:0]DM_wdata,
    //好像没用
    output reg DM_worr,
    //MUL
    output reg MUL_sign,
    //DIV
    output reg DIV_sign,
    //HI和LO
    output reg HI_wena,
    output reg LO_wena,
    //CP0
    output reg [4:0]CP0_rd,
    output reg [31:0]CP0_wdata,
    input [31:0]CP0_rdata,
    output reg CP0_exception,
    output reg [4:0]CP0_cause_extc
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

    parameter CLZ = 6'b011111;
    parameter JALR = 6'b10_0000;
    parameter MTHI = 6'b10_0001;
    parameter MFHI = 6'b10_0010;
    parameter MTLO = 6'b10_0011;
    parameter MFLO = 6'b10_0100;
    parameter SB = 6'b10_0101;
    parameter SH = 6'b10_0110;
    parameter LB = 6'b10_0111;
    parameter LH = 6'b10_1000;
    parameter LBU = 6'b10_1001;
    parameter LHU = 6'b10_1010;
    parameter ERET = 6'b10_1011;
    parameter BREAK = 6'b10_1100;
    parameter SYSCALL = 6'b10_1101;
    parameter TEQ = 6'b10_1110;
    parameter MFC0 = 6'b10_1111;
    parameter MTC0 = 6'b11_0000;
    parameter MUL = 6'b11_0001;
    parameter MULTU = 6'b11_0010;
    parameter DIV = 6'b11_0011;
    parameter DIVU = 6'b11_0100;
    parameter BGEZ = 6'b11_0101;


    always @(*)begin
        if(ena)begin
            if(ins[31:26]==6'b00_0000)begin
                case(ins[5:0])
                    6'b10_0000:begin
                        op=ADD;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b10_0001:begin
                        op=ADDU;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];
                        
                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b10_0010:begin
                        op=SUB;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b10_0011:begin
                        op=SUBU;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b10_0100:begin
                        op=AND;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b10_0101:begin
                        op=OR;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b10_0110:begin
                        op=XOR;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b10_0111:begin
                        op=NOR;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b10_1010:begin
                        op=SLT;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b10_1011:begin
                        op=SLTU;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_0000:begin
                        op=SLL;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd2;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b00_0010:begin
                        op=SRL;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd2;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_0011:begin
                        op=SRA;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd2;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_0100:begin
                        op=SLLV;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_0110:begin
                        op=SRLV;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_0111:begin
                        op=SRAV;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_1000:begin
                        op=JR;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd3;
                        
                        RF_wena<=1'b0;
                        Rsc<=ins[25:21];

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;
                        ena_MUX4<=1'b0;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b01_1010:begin
                        op<=DIV;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        RF_wena<=1'b0;
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;
                        
                        ena_MUX5<=1'b1;
                        choice_MUX5<=3'd2;
                        ena_MUX6<=1'b1;
                        choice_MUX6<=3'd2;

                        DM_ena=1'b0;
                        HI_wena<=1'b1;
                        LO_wena<=1'b1;

                        DIV_sign<=1'b1;
                    end
                    6'b01_1011:begin
                        op<=DIVU;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        RF_wena<=1'b0;
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;
                        
                        ena_MUX5<=1'b1;
                        choice_MUX5<=3'd2;
                        ena_MUX6<=1'b1;
                        choice_MUX6<=3'd2;

                        DM_ena=1'b0;
                        HI_wena<=1'b1;
                        LO_wena<=1'b1;

                        DIV_sign<=1'b0;
                    end
                    6'b01_1001:begin
                        op<=MULTU;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        RF_wena<=1'b0;
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;
                        
                        ena_MUX5<=1'b1;
                        choice_MUX5<=3'd1;
                        ena_MUX6<=1'b1;
                        choice_MUX6<=3'd1;

                        DM_ena=1'b0;
                        HI_wena<=1'b1;
                        LO_wena<=1'b1;

                        MUL_sign<=1'b0;
                    end
                    6'b01_0000:begin
                        op<=MFHI;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];

                        Rd <= out_MUX4;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd5;

                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b01_0010:begin
                        op<=MFLO;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];

                        Rd <= out_MUX4;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd6;

                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_1001:begin
                        op<=JALR;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd3;

                        RF_wena<=1'd1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd4;

                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b01_0001:begin
                        op<=MTHI;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        RF_wena<=1'b0;
                        Rsc<=ins[25:21];

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;
                        ena_MUX4<=1'b0;

                        ena_MUX5<=1'b1;
                        choice_MUX5<=3'd3;

                        DM_ena=1'b0;
                        HI_wena<=1'b1;
                        LO_wena<=1'b0;
                    end
                    6'b01_0000:begin
                        op<=MFHI;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];

                        Rd<=out_MUX4;

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd5;

                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b01_0011:begin
                        op<=MTLO;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        RF_wena<=1'b0;
                        Rsc<=ins[25:21];

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;
                        ena_MUX4<=1'b0;

                        ena_MUX6<=1'b1;
                        choice_MUX6<=3'd3;

                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b1;
                    end
                    6'b01_0010:begin
                        op<=MFLO;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];

                        Rd<=out_MUX4;

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd6;

                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_1100:begin
                        op<=SYSCALL;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd6;

                        CP0_exception<=1'b1;
                        CP0_cause_extc<=5'b0_1000;

                        RF_wena<=1'b0;
                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_1101:begin
                        op<=BREAK;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd6;

                        CP0_exception<=1'b1;
                        CP0_cause_extc<=5'b0_1001;

                        RF_wena<=1'b0;
                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b11_0100:begin
                        op<=TEQ;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd6;

                        CP0_exception<=1'b1;
                        CP0_cause_extc<=5'b0_1101;

                        RF_wena<=1'b0;
                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                endcase
            end
            else if(ins[31:26]==6'b01_1100)begin
                case(ins[5:0])
                    6'b10_0000:begin
                        op<=CLZ;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        RF_wena<=1'b1;
                        Rdc<=ins[15:11];
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];
                        
                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b0;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena<=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_0010:begin
                        op<=MUL;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        RF_wena<=1'b1;
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];
                        Rdc<=ins[15:11];

                        Rd<=out_MUX4;

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd0;
                        
                        ena_MUX5<=1'b0;

                        ena_MUX6<=1'b1;
                        choice_MUX6<=3'd1;

                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                        MUL_sign<=1'b1;
                    end
                endcase
            end
            else if(ins[31:26]==6'b01_0000)begin
                case(ins[25:21])
                    5'b0_0000:begin
                        op<=MFC0;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        CP0_rd<=ins[15:11];

                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];

                        Rd<=out_MUX4;

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd7;

                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    5'b0_0100:begin
                        op<=MTC0;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;

                        CP0_rd<=ins[15:11];
                        CP0_wdata<=Rt;

                        RF_wena<=1'b0;
                        Rtc<=ins[20:16];

                        DM_ena=1'b0;
                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    default begin
                        case(ins[5:0])
                            6'b01_1000:begin
                                op<=ERET;

                                ena_MUX1<=1'b1;
                                choice_MUX1<=3'd5;

                                CP0_exception<=1'b0;
                                CP0_cause_extc<=5'd0;
                                

                                RF_wena<=1'b0;
                                DM_ena=1'b0;
                                HI_wena<=1'b0;
                                LO_wena<=1'b0;
                            end
                        endcase
                    end
                endcase
            end
            else if(ins[31:26]==6'b00_0001)begin
                case(ins[20:16])
                    5'b0_0001:begin
                        op<=BGEZ;

                        ena_MUX1<=1'b1;
                        if(Rs[31]==1'b1)begin
                            choice_MUX1<=3'd1;
                        end
                        else begin
                            choice_MUX1<=3'd4;
                        end
                        
                        RF_wena<=1'b0;
                        Rsc<=ins[25:21];

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;

                        ena_MUX4<=1'b0;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                endcase
            end
            else begin
                case(ins[31:26])
                    6'b00_1000:begin
                        op=ADDI;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b00_1001:begin
                        op=ADDIU;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_1100:begin
                        op=ANDI;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b00_1101:begin
                        op=ORI;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_1110:begin
                        op=XORI;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b10_0011:begin
                        op=LW;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd2;

                        DM_ena=1'b1;
                        DM_worr=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b10_1011:begin
                        op=SW;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b0;
                        Rtc<=ins[20:16];
                        Rsc<=ins[25:21];

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b0;

                        DM_ena=1'b1;
                        DM_worr=1'b1;
                        DM_wdata<=Rt;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_0100:begin
                        op=BEQ;

                        ena_MUX1<=1'b1;
                        // choice_MUX1<=zero?3'd4:3'd1;
                        if(zero==1'b1) begin
                            choice_MUX1<=3'd4;
                        end
                        else begin
                            choice_MUX1<=3'd1;
                        end
                        
                        RF_wena<=1'b0;
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b0;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_0101:begin
                        op=BNE;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=zero?3'd1:3'd4;
                        
                        RF_wena<=1'b0;
                        Rsc<=ins[25:21];
                        Rtc<=ins[20:16];

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd1;

                        ena_MUX4<=1'b0;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_1010:begin
                        op=SLTI;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_1011:begin
                        op=SLTIU;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_1111:begin
                        op=LUI;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd3;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b00_0010:begin
                        op=J;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd2;
                        
                        RF_wena<=1'b0;

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;
                        ena_MUX4<=1'b0;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b00_0011:begin
                        op=JAI;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd2;
                        
                        RF_wena<=1'b1;
                        Rdc<=5'd31;//这是ra寄存器的位置

                        Rd <= out_MUX4;

                        ena_MUX2<=1'b0;
                        ena_MUX3<=1'b0;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd4;

                        DM_ena=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b10_1000:begin
                        op<=SB;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=1'b1;

                        RF_wena<=1'b0;
                        Rtc<=ins[20:16];
                        Rsc<=ins[25:21];

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b0;

                        DM_ena<=1'b1;
                        DM_worr<=1'b1;
                        DM_wdata<=$signed(Rt[7:0]);

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b10_1001:begin
                        op<=SH;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=1'b1;

                        RF_wena<=1'b0;
                        Rtc<=ins[20:16];
                        Rsc<=ins[25:21];

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b0;

                        DM_ena<=1'b1;
                        DM_worr<=1'b1;
                        DM_wdata<=$signed(Rt[15:0]);

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;
                    end
                    6'b10_0000:begin
                        op<=LB;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= $signed(out_MUX4[7:0]);

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd2;

                        DM_ena=1'b1;
                        DM_worr=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b10_0001:begin
                        op<=LH;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= $signed(out_MUX4[15:0]);

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd2;

                        DM_ena=1'b1;
                        DM_worr=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b10_0100:begin
                        op<=LBU;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= $unsigned(out_MUX4[7:0]);

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd2;

                        DM_ena=1'b1;
                        DM_worr=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                    6'b10_0101:begin
                        op<=LHU;

                        ena_MUX1<=1'b1;
                        choice_MUX1<=3'd1;
                        
                        RF_wena<=1'b1;
                        Rdc<=ins[20:16];
                        Rsc<=ins[25:21];

                        Rd <= $unsigned(out_MUX4[15:0]);

                        ena_MUX2<=1'b1;
                        choice_MUX2<=3'd1;
                        ena_MUX3<=1'b1;
                        choice_MUX3<=3'd2;

                        ena_MUX4<=1'b1;
                        choice_MUX4<=3'd2;

                        DM_ena=1'b1;
                        DM_worr=1'b0;

                        HI_wena<=1'b0;
                        LO_wena<=1'b0;

                    end
                endcase
            end
        end
    end
endmodule

