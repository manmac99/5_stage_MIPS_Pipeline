`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/01 01:28:59
// Design Name: 
// Module Name: TOP
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


module TOP(
    input i_clk,
    input i_rstn,
    output reg [15:0] LED
    );
    wire [31:0] ALUresult;
    wire [31:0] Instruction;
    wire [31:0] Read_data1;
    wire [31:0] Read_data2;
    wire [4:0] Reg_Dst;
    reg [24:0] counter;
    reg [31:0] r_ALUresult;
    
    always @(posedge i_clk, negedge i_rstn)
    begin
        if(!i_rstn)
        begin
            counter <= 0;
        end
        else
        begin
            counter <= counter +1;
        end
    end
    
    always @(posedge i_clk, negedge i_rstn)
    begin
        if(!i_rstn)
        begin
            r_ALUresult <= 0;
        end
        else
        begin
            if(ALUresult == 32'h00000005)
                r_ALUresult <= ALUresult;
            else if(ALUresult == 32'h0000000a)
                r_ALUresult <= ALUresult;
            else if(ALUresult == 32'hffffffff)
                r_ALUresult <= ALUresult;
            else if(ALUresult == 32'h0000000e)
                r_ALUresult <= ALUresult;
            else if(ALUresult == 32'h00000010)
                r_ALUresult <= ALUresult;
        end
    end
    
    always @(posedge counter[24], negedge i_rstn)
    begin
        if(!i_rstn)
        begin
            LED <=0;
        end
        else
        begin
            LED <= r_ALUresult[15:0];
        end
    end
    
   MIPS_pipeline MIPS_pipeline(
   .i_clk(counter[24]),
   .i_rstn(i_rstn),
   .ALUresult(ALUresult),
   .Instruction(Instruction),
   .Read_data1(Read_data1),
   .Read_data2(Read_data2),
   .Reg_Dst(Reg_Dst)
   );
   
endmodule
