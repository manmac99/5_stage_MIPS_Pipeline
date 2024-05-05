`timescale 1ns / 1ps
module sign_extend(
    input [15:0] imm_value,
    output [31:0] result
);
assign result = { {16{imm_value[15]}}, imm_value };
endmodule
