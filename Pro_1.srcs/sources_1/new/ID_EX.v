// `timescale 1ns / 1ps
// module ID_EX(
//     input i_clk, 
//     input i_rstn, 
//     input i_MemtoReg, 
//     input i_MemWrite, 
//     input i_MemRead, 
//     input i_Branch, 
//     input i_ALUSrc,
//     input i_RegDst, 
//     input i_RegWrite, 
//     input [1:0] i_ALUOp, 
//     input [31:0] i_PCplus4, 
//     input [31:0] i_Rdata1, 
//     input [31:0] i_Rdata2,
//     input [31:0] i_signextImmediate, 
//     input [4:0] i_RegDst1, 
//     input [4:0] i_RegDst2, 
//     output reg o_MemtoReg, 
//     output reg o_MemWrite,
//     output reg o_MemRead, 
//     output reg o_Branch, 
//     output reg o_ALUSrc, 
//     output reg o_RegDst, 
//     output reg o_RegWrite, 
//     output reg [1:0] o_ALUOp,
//     output reg [31:0] o_PCplus4, 
//     output reg [31:0] o_Rdata1, 
//     output reg [31:0] o_Rdata2, 
//     output reg [31:0] o_signextImmediate,
//     output reg [4:0] o_RegDst1, 
//     output reg [4:0] o_RegDst2
// );
// always @(posedge i_clk, negedge i_rstn) begin
//     if(!i_rstn) begin
//         o_MemtoReg <= 1'b0;
//         o_MemWrite <= 1'b0;
//         o_MemRead <= 1'b0;
//         o_Branch<= 1'b0;
//         o_ALUSrc<= 1'b0;
//         o_RegDst <= 1'b0;
//         o_RegWrite <= 1'b0;
//         o_ALUOp <= 2'b00;
//         o_PCplus4 <= 32'd0;
//         o_Rdata1 <= 32'd0;
//         o_Rdata2 <= 32'd0;
//         o_signextImmediate <= 32'd0;
//         o_RegDst1 <= 5'd0;
//         o_RegDst2 <= 5'd0;
//     end
//     else begin
//         o_MemtoReg <= i_MemtoReg;
//         o_MemWrite <= i_MemWrite;
//         o_MemRead <= i_MemRead;
//         o_Branch<= i_Branch;
//         o_ALUSrc<= i_ALUSrc;
//         o_RegDst <= i_RegDst;
//         o_RegWrite <= i_RegWrite;
//         o_ALUOp <= i_ALUOp;
//         o_PCplus4 <= i_PCplus4;
//         o_Rdata1 <= i_Rdata1;
//         o_Rdata2 <= i_Rdata2;
//         o_signextImmediate <= i_signextImmediate;
//         o_RegDst1 <= i_RegDst1;
//         o_RegDst2 <= i_RegDst2;
//     end
// end 
// endmodule
`timescale 1ns / 1ps
module ID_EX(
    input i_clk, 
    input i_rstn,
    input i_CLR, 
    input i_MemtoReg, 
    input i_MemWrite, 
    //input i_MemRead, 
    //input i_Branch, 
    input i_ALUSrc,
    input i_RegDst, 
    input i_RegWrite, 
    //input [1:0] i_ALUOp, 
    //input [31:0] i_PCplus4, 
    input [31:0] i_Rdata1, 
    input [31:0] i_Rdata2,
    input [4:0] RsD,
    input [4:0] RtD, 
    input [4:0] RdD, 
    input [31:0] i_signextImmediate,
    input [2:0] ALUct,
    output reg [2:0] o_ALUct,
    output reg [31:0] o_signextImmediate,
    output reg o_MemtoReg, 
    output reg o_MemWrite,
    //output reg o_MemRead, 
    //output reg o_Branch, 
    output reg o_ALUSrc, 
    output reg o_RegDst, 
    output reg o_RegWrite, 
    //output reg [1:0] o_ALUOp,
    //output reg [31:0] o_PCplus4, 
    output reg [31:0] o_Rdata1, 
    output reg [31:0] o_Rdata2,
    output reg [4:0] RsE,
    output reg [4:0] RtE, 
    output reg [4:0] RdE
);
always @(posedge i_clk, negedge i_rstn) begin
    if(!i_rstn) begin
        o_MemtoReg <= 1'b0;
        o_MemWrite <= 1'b0;
        //o_MemRead <= 1'b0;
        //o_Branch<= 1'b0;
        o_ALUSrc<= 1'b0;
        o_RegDst <= 1'b0;
        o_ALUct <= 3'b0;
        o_RegWrite <= 1'b0;
        //o_ALUOp <= 2'b00;
        //o_PCplus4 <= 32'd0;
        o_Rdata1 <= 32'd0;
        o_Rdata2 <= 32'd0;
        o_signextImmediate <= 32'd0;
        RsE <= 5'd0;
        RtE <= 5'd0;
        RdE<= 5'd0;
    end
    // else begin
        
    //         o_MemtoReg <= i_MemtoReg;
    //         o_MemWrite <= i_MemWrite;
    //         o_MemRead <= i_MemRead;
    //         o_Branch<= i_Branch;
    //         o_ALUSrc<= i_ALUSrc;
    //         o_RegDst <= i_RegDst;
    //         o_RegWrite <= i_RegWrite;
    //         o_ALUct <= ALUct;
    //         o_ALUOp <= i_ALUOp;
    //         o_PCplus4 <= i_PCplus4;
    //         o_Rdata1 <= i_Rdata1;
    //         o_Rdata2 <= i_Rdata2;
    //         o_signextImmediate <= i_signextImmediate;
    //         o_oo <= i_ii;
    //         o_RegDst1 <= i_RegDst1;
    //         o_RegDst2 <= i_RegDst2;
    //     end
    else begin
        if(!i_CLR) begin
            o_MemtoReg <= i_MemtoReg;
            o_MemWrite <= i_MemWrite;
            //o_MemRead <= i_MemRead;
            //o_Branch<= i_Branch;
            o_ALUSrc<= i_ALUSrc;
            o_RegDst <= i_RegDst;
            o_RegWrite <= i_RegWrite;
            o_ALUct <= ALUct;
            //o_ALUOp <= i_ALUOp;
            //o_PCplus4 <= i_PCplus4;
            o_Rdata1 <= i_Rdata1;
            o_Rdata2 <= i_Rdata2;
            o_signextImmediate <= i_signextImmediate;
            RsE <= RsD;
            RtE <= RtD;
            RdE <= RdD;
        end
        else begin
            o_MemtoReg <= 'd0;
            o_MemWrite <= 'd0;
            //o_MemRead <= 'd0;
            //o_Branch<= 'd0;
            o_ALUct<= 'd0;
            o_ALUSrc<= 'd0;
            o_RegDst <= 'd0;
            o_RegWrite <= 'd0;
            //o_ALUOp <= 'd0;
            //o_PCplus4 <= 'd0;
            o_Rdata1 <= 'd0;
            o_Rdata2 <= 'd0;
            o_signextImmediate <= 'd0;
            RsE <= 5'd0;
            RtE <= 5'd0;
            RdE<= 5'd0;
        end
    end
end 
endmodule
