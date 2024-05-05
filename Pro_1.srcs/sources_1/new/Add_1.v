`timescale 1ns / 1ps
module Add_1(
    input [31:0] a_add,
    output [31:0]  a_out
);
assign a_out = a_add +4;
endmodule
