`timescale 1ns / 1ps
module Control_Unit(
    input [5:0] op, 
    input [5:0] funct,
    output reg MemtoReg, 
    output reg Memwrite, 
    //output reg MemRead, 
    output reg Branch,
    output reg ALUSrc, 
    output reg RegDst, 
    output reg RegWrite, 
    output reg [2:0] ALUControl
);
always@(*) begin
    case(op)
        6'b000000: begin//R-type 
            RegWrite = 1'b1;
            RegDst = 1'b1;
            ALUSrc = 1'b0;
            Branch = 1'b0;
            Memwrite = 1'b0;
            //MemRead = 1'b0;
            MemtoReg = 1'b0;
            case(funct)
                    6'b100000: ALUControl = 3'b010; // Add for R-type
                    6'b100010: ALUControl = 3'b110; // Subtract for R-type
                    6'b100100: ALUControl = 3'b000; // AND for R-type
                    6'b100101: ALUControl = 3'b001; // OR for R-type
                    6'b101010: ALUControl = 3'b111; // Set Less Than for R-type
                    6'b101011: ALUControl = 3'b111; // Set Less Than Unsigned for R-type
                    default: ALUControl = 3'b000;   // Default operation
                endcase 
        end
        6'b100011: begin //lw
            RegWrite = 1'b1;
            RegDst = 1'b0;
            ALUSrc = 1'b1;
            Branch = 1'b0;
            Memwrite = 1'b0;
            //MemRead = 1'b1;
            MemtoReg = 1'b1;
            ALUControl = 3'b010;
        end
        // 6'b101011: begin //sw
        //     RegWrite = 1'b0;
        //     RegDst = 1'bx;
        //     ALUSrc = 1'b1;
        //     Branch = 1'b0;
        //     Memwrite = 1'b1;
        //     MemRead = 1'b0;
        //     MemtoReg = 1'bx;
        //     ALUOp = 2'b00;
        // end
        6'b101011: begin //sw
            RegWrite = 1'b0;
            RegDst = 1'b0;
            ALUSrc = 1'b1;
            Branch = 1'b0;
            Memwrite = 1'b1;
            //MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUControl = 3'b010;
        end
        6'b000100: begin //beq
            RegWrite = 1'b0;
            RegDst = 1'b0;
            ALUSrc = 1'b0;
            Branch = 1'b1;
            Memwrite = 1'b0;
            //MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUControl = 3'b110; 
        end
        6'b001000: begin // addi
        RegWrite = 1'b1;
        RegDst = 1'b0;
        ALUSrc = 1'b1;
        Branch = 1'b0;
        Memwrite = 1'b0;
        //MemRead = 1'b0;
        MemtoReg = 1'b0;
        ALUControl = 3'b010;
         end
        // 6'b000100: begin //beq
        //     RegWrite = 1'b0;
        //     RegDst = 1'bx;
        //     ALUSrc = 1'b0;
        //     Branch = 1'b1;
        //     Memwrite = 1'b0;
        //     MemRead = 1'b0;
        //     MemtoReg = 1'bx;
        //     ALUOp = 2'b01;
        // end
        default:begin
            RegWrite = 1'bx;
            RegDst = 1'bx;
            ALUSrc = 1'bx;
            Branch = 1'bx;
            Memwrite = 1'bx;
            //MemRead = 1'bx;
            MemtoReg = 1'bx;
            ALUControl = 3'b000;
        end
    endcase
end

endmodule

