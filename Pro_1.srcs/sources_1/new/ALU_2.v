`timescale 1ns / 1ps
module ALU_2(
input signed [31:0] a_in, 
input signed [31:0] b_in, 
input[2:0] ALUctrl, 
output reg signed [31:0] result
 );
    always @(*) begin
        case(ALUctrl)
            3'b000: result = a_in & b_in; // AND operation
            3'b001: result = a_in | b_in; // OR operation
            3'b010: result = a_in + b_in; // Add operation
            3'b110: result = a_in - b_in; // Subtract operation
            3'b111: result = (a_in < b_in) ? 1 : 0; // Set Less Than operation
            default: result = 0; // Default case
        endcase
    end
//assign zero = (result == 0) ? 1 : 0; 
endmodule
