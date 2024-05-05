`timescale 1ns / 1ps


module DDL(
    input BranchD,
    input [4:0] RsD,
    input [4:0] RtD,
    input [4:0] RsE,
    input [4:0] RtE,
    input [4:0] WriteRegE,
    input MemtoRegE,
    input RegWriteE,
    input [4:0] WriteRegM,
    input MemtoRegM,
    input RegWriteM,
    input [4:0] WriteRegW,
    input RegWriteW,
    output stallIF,
    output stallID,
    output ForwardAD,
    output ForwardBD,
    output FlushE,
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE
    );

    always @(*)
    begin
    if ((RegWriteW == 1) && (WriteRegW != 0) && (WriteRegW == RsE))
        ForwardAE <= 2'b01;
    else if ((RegWriteM == 1) && (WriteRegM != 0) && (WriteRegM == RsE))
        ForwardAE <= 2'b10;
    else
        ForwardAE <= 2'b00;
    end    
    always @(*)
    begin
    if ((RegWriteW == 1) && (WriteRegW != 0) && (WriteRegW == RtE))
        ForwardBE <= 2'b01;
    else if ((RegWriteM == 1)&& (WriteRegM != 0) && (WriteRegM == RtE))
        ForwardBE <= 2'b10;
    else
        ForwardBE <= 2'b00;
   end 
    assign stallIF = (((MemtoRegE == 1) && ((RsD == RtE) || (RtD == RtE))) || (((BranchD == 1) && (RegWriteE == 1) && ((WriteRegE == RsD) || (WriteRegE == RtD))) || ((BranchD == 1) && (MemtoRegM == 1) && ((WriteRegM == RsD) || (WriteRegM == RtD))))) ? 1 : 0;
    assign stallID = (((MemtoRegE == 1) && ((RsD == RtE) || (RtD == RtE))) || (((BranchD == 1) && (RegWriteE == 1) && ((WriteRegE == RsD) || (WriteRegE == RtD))) || ((BranchD == 1) && (MemtoRegM == 1) && ((WriteRegM == RsD) || (WriteRegM == RtD))))) ? 1 : 0;
    assign FlushE = stallIF ? 1 : 0;
    assign ForwardAD = (((RegWriteM == 1) && (RsD != 0)) && (RsD == WriteRegM)) ? 1 : 0;
    assign ForwardBD = (((RegWriteM == 1) && (RtD != 0)) && (RtD == WriteRegM)) ? 1 : 0;
    
    endmodule
