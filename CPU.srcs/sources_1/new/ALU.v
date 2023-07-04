`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 15:22:17
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] a,
    input [31:0] b,
    input [5:0] aluc,
    output reg [31:0] r,
    output reg zero,
    output reg carry,
    output reg negative,
    output reg overflow
    );
    
    parameter WIDTH = 32;
    parameter MSB = WIDTH-1;
    reg extra;
    reg [32:0]tmp;
    wire signed [31:0]signed_a=a,signed_b=b;
    //wire zero_sub,carry_sub,negative_sub,overflow_sub;
    //wire [31:0] result [13:0];

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

    always@(*) begin
        case(aluc)
        //ADDU
            ADDU:begin
                {extra,r}<=a+b;
    
                zero<=r?0:1;
                carry<=extra;
                negative<=r[MSB];
                //无overflow
            end
        //LW SW
            LW,
            SW:begin
                {extra,r}<=signed_a+signed_b/4;
    
                zero<=r?0:1;
                //无carry
                negative<=r[MSB];
                overflow<=({extra,r[MSB]}==2'b01||{extra,r[MSB]}==2'b11);
            end
        //LB LBU SB
            LB,
            LBU,
            SB:begin
                {extra,r}<=signed_a+signed_b;
    
                zero<=r?0:1;
                //无carry
                negative<=r[MSB];
                overflow<=({extra,r[MSB]}==2'b01||{extra,r[MSB]}==2'b11);
            end
        //LH LHU SH
            LH,
            LHU,
            SH:begin
                {extra,r}<=signed_a+signed_b/2;
    
                zero<=r?0:1;
                //无carry
                negative<=r[MSB];
                overflow<=({extra,r[MSB]}==2'b01||{extra,r[MSB]}==2'b11);
            end
        //ADD ADDI ADDIU    
            ADD,
            ADDI,
            ADDIU:begin
                {extra,r}<=signed_a+signed_b;
    
                zero<=r?0:1;
                //无carry
                negative<=r[MSB];
                overflow<=({extra,r[MSB]}==2'b01||{extra,r[MSB]}==2'b11);
            end
        //SUBU
            SUBU:begin
                {extra,r}<=a-b;
    
                zero<=r?0:1;
                carry<=extra;
                negative<=r[MSB];
                //无overflow
            end
        //SUB BEQ BNE
            BEQ,
            BNE,
            SUB:begin
                {extra,r}<=signed_a-signed_b;
            
                zero<=r?1'b0:1'b1;
                //无carry
                negative<=r[MSB];
                overflow<=({extra,r[MSB]}==2'b01||{extra,r[MSB]}==2'b11);
            end
        //AND ANDI
            ANDI,
            AND:begin
                r<=a&b;
    
                zero<=r?0:1;
                //无carry
                negative<=r[MSB];
                //无overflow
            end
        //OR ORI
            ORI,
            OR:begin
                r<=a|b;
    
                zero<=r?0:1;
                //无carry
                negative<=r[MSB];
                //无overflow
            end
        //XOR XORI
            XORI,
            XOR:begin   
                r<=a^b;
    
                zero<=r?0:1;
                //无carry
                negative<=r[MSB];
                //无overflow
            end
        //NOR
            NOR:begin
                r<=~(a|b);
    
                zero<=r?0:1;
                //无carry
                negative<=r[MSB];
                //无overflow
            end
        //LUI
            LUI:begin
                r<={b[15:0],16'b0};
    
                zero<=r?0:1;
                //无carry
                negative<=r[MSB];
                //无overflow
            end
        //SLTIU SLTU
            SLTU,
            SLTIU:begin
                r<=(a<b)?32'b1:32'b0;
                zero<=(a==b)?0:1;
                negative<=r[0];
            end
        //SLT SLTI
            SLTI,
            SLT:begin
                if(a[MSB]==b[MSB]) begin
                    r<=(a<b)?32'b1:32'b0;
                end
                else begin
                    if(a[MSB]==0) begin
                        r<=32'b0;
                    end
                    else begin
                        r<=32'b1;
                    end
                end
            
                zero<=(a==b)?0:1;
                //无carry
                negative<=r[0];
                //无overflow
            end
        //SLTU
            SLTU:begin
                r<=(a<b)?1:0;
    
                zero<=(a==b)?0:1;
                carry<=r;
                negative<=r[MSB];
                //无overflow
            end
        //SRA
            SRA:begin
                r<=signed_b>>>signed_a;
    
                zero<=r?0:1;
                carry<=signed_b[signed_a-1];
                negative<=r[MSB];
                //无overflow
            end
        //SRAV
            SRAV:begin
                r<=signed_b>>>signed_a[4:0];
    
                zero<=r?0:1;
                carry<=signed_b[WIDTH-signed_a];
                negative<=r[MSB];
                //无overflow
            end
        //SLL
            SLL:begin
                r<=b<<a;
    
                zero<=r?0:1;
                carry<=b[WIDTH-a];
                negative<=r[MSB];
                //无overflow
            end
        //SLLV
            SLLV:begin
                r<=b<<a[4:0];
    
                zero<=r?0:1;
                carry<=b[WIDTH-a];
                negative<=r[MSB];
                //无overflow
            end
        //SRL
            SRL:begin
                r<=b>>a;
    
                zero<=r?0:1;
                carry<=b[a-1];
                negative<=r[MSB];
                //无overflow
            end
        //SRLV
            SRLV:begin
                r<=b>>a[4:0];
    
                zero<=r?0:1;
                carry<=b[a-1];
                negative<=r[MSB];
                //无overflow
            end
        //CLZ
            CLZ:begin
                if(a[31:0]==0)begin
                    r<=32'd32;
                end
                else if(a[31:1]==0)begin
                    r<=32'd31;
                end
                else if(a[31:2]==0)begin
                    r<=32'd30;
                end
                else if(a[31:3]==0)begin
                    r<=32'd29;
                end
                else if(a[31:4]==0)begin
                    r<=32'd28;
                end
                else if(a[31:5]==0)begin
                    r<=32'd27;
                end
                else if(a[31:6]==0)begin
                    r<=32'd26;
                end
                else if(a[31:7]==0)begin
                    r<=32'd25;
                end
                else if(a[31:8]==0)begin
                    r<=32'd24;
                end
                else if(a[31:9]==0)begin
                    r<=32'd23;
                end
                else if(a[31:10]==0)begin
                    r<=32'd22;
                end
                else if(a[31:11]==0)begin
                    r<=32'd21;
                end
                else if(a[31:12]==0)begin
                    r<=32'd20;
                end
                else if(a[31:13]==0)begin
                    r<=32'd19;
                end
                else if(a[31:14]==0)begin
                    r<=32'd18;
                end
                else if(a[31:15]==0)begin
                    r<=32'd17;
                end
                else if(a[31:16]==0)begin
                    r<=32'd16;
                end
                else if(a[31:17]==0)begin
                    r<=32'd15;
                end
                else if(a[31:18]==0)begin
                    r<=32'd14;
                end
                else if(a[31:19]==0)begin
                    r<=32'd13;
                end
                else if(a[31:20]==0)begin
                    r<=32'd12;
                end
                else if(a[31:21]==0)begin
                    r<=32'd11;
                end
                else if(a[31:22]==0)begin
                    r<=32'd10;
                end
                else if(a[31:23]==0)begin
                    r<=32'd9;
                end
                else if(a[31:24]==0)begin
                    r<=32'd8;
                end
                else if(a[31:25]==0)begin
                    r<=32'd7;
                end
                else if(a[31:26]==0)begin
                    r<=32'd6;
                end
                else if(a[31:27]==0)begin
                    r<=32'd5;
                end
                else if(a[31:28]==0)begin
                    r<=32'd4;
                end
                else if(a[31:29]==0)begin
                    r<=32'd3;
                end
                else if(a[31:30]==0)begin
                    r<=32'd2;
                end
                else if(a[31]==0)begin
                    r<=32'd1;
                end
                else begin
                    r<=32'd0;
                end
            end
        endcase
    end

    //assign r=result[aluc];
    
endmodule

