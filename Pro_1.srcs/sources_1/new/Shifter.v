`timescale 1ns / 1ps


module Shifter(
    input [31:0] a,
    output [31:0] b
     );
assign b = a*4;
endmodule
