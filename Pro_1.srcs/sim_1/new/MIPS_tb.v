`timescale 1ns / 1ps
module MIPS_tb;
    reg clk;
    reg rstn;
    wire [31:0] ALUresult;
    wire [31:0] Instruction;
    wire [31:0] Read_data1;
    wire [31:0] Read_data2;
    wire [4:0] Reg_Dst;
    wire stall;
    //wire [31:0] o_oo;
    //wire [31:0] m1;
    //wire [1:0] op;
    //wire [3:0] ALU_CTRR;
    //wire [31:0] MUX_OUT;
   
    MIPS_pipeline uut (
        .i_clk(clk),
        .i_rstn(rstn),
        .ALUresult(ALUresult),
        .Instruction(Instruction),
        .Read_data1(Read_data1),
        .Read_data2(Read_data2),
        .Reg_Dst(Reg_Dst),
        .stall(stall)
        //.o_oo(o_oo),
        //.m1(m1),
        //.op(op),
        //.ALU_CTRR(ALU_CTRR),
        //.MUX_OUT(MUX_OUT)
    );

    initial begin
        clk = 0;
        rstn = 0;    
        #4 rstn = 1;
        #120;
        $finish;
    end
    always #5 clk = ~clk;

endmodule

