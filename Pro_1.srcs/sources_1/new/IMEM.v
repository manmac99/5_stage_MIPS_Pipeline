`timescale 1ns / 1ps
module iMEM #(
    parameter MEM_DEPTH = 32
    )(
    input i_rstn,
    input  [31:0] i_PC,
    output reg [31:0] o_instruction
    );
    reg [31:0] instruction_mem [0:MEM_DEPTH-1];
    integer i;
   //initial $readmemb("imem.txt", instruction_mem); 
	always @(*) begin
	if(!i_rstn) begin
	   o_instruction <= 32'd0;
	   
	   instruction_mem[0] <= 32'b10001100010000010000000000000100;
	   instruction_mem[1]<= 32'b0;
	   instruction_mem[2]<= 32'b0;
	   instruction_mem[3]<= 32'b0;
	   instruction_mem[4] <= 32'b00000000001000100010000000100000;
	   instruction_mem[5]<= 32'b0;
	   instruction_mem[6]<= 32'b0;
	   instruction_mem[7]<= 32'b0;
	   instruction_mem[8] <= 32'b00000000001010010100000000100101;
	   instruction_mem[9]<= 32'b0;
	   instruction_mem[10]<= 32'b0;
	   instruction_mem[11]<= 32'b0;
	   instruction_mem[12] <= 32'b00010001010010000000000000000010;
	   instruction_mem[13]<= 32'b0;
	   instruction_mem[14]<= 32'b0;
	   instruction_mem[15]<= 32'b0;
	   instruction_mem[16] <= 32'b00000000001000100010000000100000;
	   instruction_mem[17]<= 32'b0;
	   instruction_mem[18]<= 32'b0;
	   instruction_mem[19]<= 32'b0;
	   instruction_mem[20] <= 32'b00000000001010010100000000100101;
	   instruction_mem[21]<= 32'b0;
	   instruction_mem[22]<= 32'b0;
	   instruction_mem[23]<= 32'b0;
	   instruction_mem[24] <= 32'b00000000001000100010000000100000;
	   instruction_mem[25]<= 32'b0;
	   instruction_mem[26]<= 32'b0;
	   instruction_mem[27]<= 32'b0;
	   instruction_mem[28]<= 32'bb00000000001010010100000000100101;
	   instruction_mem[29]<= 32'b0;
	   instruction_mem[30]<= 32'b0;
	   instruction_mem[31]<= 32'b0;
	end else begin
	o_instruction <= instruction_mem[i_PC]; 
	end
	end

endmodule

  