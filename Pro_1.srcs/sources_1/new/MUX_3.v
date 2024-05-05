`timescale 1ns / 1ps
module MUX_3(
    input [4:0] a_mux,
    input [4:0] b_mux,
    input RegDst,
    output [4:0] m_out
);
assign m_out = RegDst ? b_mux : a_mux ;
endmodule 

