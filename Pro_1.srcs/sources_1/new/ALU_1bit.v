`timescale 1ns / 1ps
module ALU_1bit(
 input a_in,
 input b_in,
 input Ainverter_in,
 input Binverter_in,
 input carry_in,
 input less_in,
 input [1:0] op_in,
 output reg result_out,
 output carry_out
 );
 wire w_a;
 wire w_b;
 assign w_a = Ainverter_in ? ~a_in : a_in ;
 assign w_b = Binverter_in ? ~b_in : b_in;

 always@(*)begin
 case(op_in)
 2'b00: result_out = w_a & w_b;
 2'b01: result_out = w_a | w_b;
 2'b10: result_out = w_a + w_b + carry_in;
 2'b11: result_out = less_in;
 endcase
 end

 assign carry_out =(((w_a ^ w_b) & carry_in) | (w_a & w_b));
endmodule
