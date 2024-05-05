`timescale 1ns / 1ps
module MUX_2(
    input [31:0] a_mux,
    input [31:0] b_mux,
    input ALUSrc,
    output [31:0] m_out
);
assign m_out = ALUSrc ? b_mux : a_mux ;
endmodule 
