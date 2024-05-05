`timescale 1ns / 1ps



module  MUX_2bit_in(
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [1:0] sel,
    output reg [31:0] o_out
     );
always @(*)begin
case(sel)
    2'b00: o_out <= a;
    2'b01: o_out <= b;
    2'b10: o_out <= c;
    2'b11: o_out <= 32'b0;
endcase
end
endmodule


