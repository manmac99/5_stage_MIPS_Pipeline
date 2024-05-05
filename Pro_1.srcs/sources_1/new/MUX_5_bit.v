`timescale 1ns / 1ps
module MUX_5_bit(
    input [4:0] a_mux,
    input [4:0] b_mux,
    input in,
    output [4:0] m_out
);
assign m_out = in ? b_mux : a_mux ;
endmodule 
