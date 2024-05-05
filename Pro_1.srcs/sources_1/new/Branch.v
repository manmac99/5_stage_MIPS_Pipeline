`timescale 1ns / 1ps

module Branch(
    input o_Branch, input zero, output PCSrc
    );
assign PCSrc = o_Branch & zero;
endmodule
