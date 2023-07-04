`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 21:18:59
// Design Name: 
// Module Name: testbench
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


module testbench();
    reg clk, rst;
    wire [31:0] ins, pc;
    integer file_output;
    integer cnt = 0;

    wire [7:0] o_seg;
    wire [7:0] o_sel;

    initial begin
        file_output = $fopen("result.txt");
        clk = 0;
        rst = 1;

        #50;
        rst = 0;
    end

    always begin
        #50;
        clk = ~clk;
        if (clk == 1'b0) begin
            if (cnt == 12000) begin
                $fclose(file_output);
            end
            else begin
                cnt = cnt + 1;
                 $fdisplay(file_output, "pc: %h", pc);
                 $fdisplay(file_output, "instr: %h", ins);
                 $fdisplay(file_output, "regfile0: %h", sc.sccpu.cpu_ref.array_reg[0]);
                 $fdisplay(file_output, "regfile1: %h", sc.sccpu.cpu_ref.array_reg[1]);
                 $fdisplay(file_output, "regfile2: %h", sc.sccpu.cpu_ref.array_reg[2]);
                 $fdisplay(file_output, "regfile3: %h", sc.sccpu.cpu_ref.array_reg[3]);
                 $fdisplay(file_output, "regfile4: %h", sc.sccpu.cpu_ref.array_reg[4]);
                 $fdisplay(file_output, "regfile5: %h", sc.sccpu.cpu_ref.array_reg[5]);
                 $fdisplay(file_output, "regfile6: %h", sc.sccpu.cpu_ref.array_reg[6]);
                 $fdisplay(file_output, "regfile7: %h", sc.sccpu.cpu_ref.array_reg[7]);
                 $fdisplay(file_output, "regfile8: %h", sc.sccpu.cpu_ref.array_reg[8]);
                 $fdisplay(file_output, "regfile9: %h", sc.sccpu.cpu_ref.array_reg[9]);
                 $fdisplay(file_output, "regfile10: %h", sc.sccpu.cpu_ref.array_reg[10]);
                 $fdisplay(file_output, "regfile11: %h", sc.sccpu.cpu_ref.array_reg[11]);
                 $fdisplay(file_output, "regfile12: %h", sc.sccpu.cpu_ref.array_reg[12]);
                 $fdisplay(file_output, "regfile13: %h", sc.sccpu.cpu_ref.array_reg[13]);
                 $fdisplay(file_output, "regfile14: %h", sc.sccpu.cpu_ref.array_reg[14]);
                 $fdisplay(file_output, "regfile15: %h", sc.sccpu.cpu_ref.array_reg[15]);
                 $fdisplay(file_output, "regfile16: %h", sc.sccpu.cpu_ref.array_reg[16]);
                 $fdisplay(file_output, "regfile17: %h", sc.sccpu.cpu_ref.array_reg[17]);
                 $fdisplay(file_output, "regfile18: %h", sc.sccpu.cpu_ref.array_reg[18]);
                 $fdisplay(file_output, "regfile19: %h", sc.sccpu.cpu_ref.array_reg[19]);
                 $fdisplay(file_output, "regfile20: %h", sc.sccpu.cpu_ref.array_reg[20]);
                 $fdisplay(file_output, "regfile21: %h", sc.sccpu.cpu_ref.array_reg[21]);
                 $fdisplay(file_output, "regfile22: %h", sc.sccpu.cpu_ref.array_reg[22]);
                 $fdisplay(file_output, "regfile23: %h", sc.sccpu.cpu_ref.array_reg[23]);
                 $fdisplay(file_output, "regfile24: %h", sc.sccpu.cpu_ref.array_reg[24]);
                 $fdisplay(file_output, "regfile25: %h", sc.sccpu.cpu_ref.array_reg[25]);
                 $fdisplay(file_output, "regfile26: %h", sc.sccpu.cpu_ref.array_reg[26]);
                 $fdisplay(file_output, "regfile27: %h", sc.sccpu.cpu_ref.array_reg[27]);
                 $fdisplay(file_output, "regfile28: %h", sc.sccpu.cpu_ref.array_reg[28]);
                 $fdisplay(file_output, "regfile29: %h", sc.sccpu.cpu_ref.array_reg[29]);
                 $fdisplay(file_output, "regfile30: %h", sc.sccpu.cpu_ref.array_reg[30]);
                 $fdisplay(file_output, "regfile31: %h", sc.sccpu.cpu_ref.array_reg[31]);
            end
        end
    end

    sccomp_dataflow sc(
        .clk_in(clk), .reset(rst),
        .inst(ins), .pc(pc)
    );

endmodule
