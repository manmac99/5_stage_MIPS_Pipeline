`timescale 1ns / 1ps
module ALU_Control(
input[1:0] ALUOp, 
input[5:0] funct, 
output reg [3:0] ALUControl
);
    always @(*) begin
        case(ALUOp)
            2'b00: ALUControl = 4'b0010; 
            2'b01: ALUControl = 4'b0110; 
            2'b10: begin
                case(funct)
                    6'b100000: ALUControl = 4'b0010; // Add for R-type
                    6'b100010: ALUControl = 4'b0110; // Subtract for R-type
                    6'b100100: ALUControl = 4'b0000; // AND for R-type
                    6'b100101: ALUControl = 4'b0001; // OR for R-type
                    6'b101010: ALUControl = 4'b0111; // Set Less Than for R-type
                    6'b101011: ALUControl = 4'b1111; // Set Less Than Unsigned for R-type
                    default: ALUControl = 4'b0000;   // Default operation
                endcase
            end
            2'b11: ALUControl = 4'b0000; // default operation
        endcase
    end
endmodule
