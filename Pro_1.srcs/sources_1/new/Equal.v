`timescale 1ns / 1ps


module Equal(
    input [31:0] a,
    input [31:0] b,
    output out
    );
assign out = a==b ? 0:1;
endmodule
