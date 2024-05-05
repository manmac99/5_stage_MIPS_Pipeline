// `timescale 1ns / 1ps
module IF_ID(
    input i_clk, 
    input i_rstn, 
    input i_EN,
    input i_CLR,
    input [31:0] i_PCplus4, 
    input [31:0] i_instruction,
    output reg [31:0] o_PCplus4, 
    output reg [31:0] o_instruction
);
always @(posedge i_clk, negedge i_rstn) begin
    if(!i_rstn) begin
        o_PCplus4 <= 32'd0;
        o_instruction <= 32'd0;
        
    end
    else begin
        if(!i_EN && !i_CLR) begin
            o_PCplus4 <= i_PCplus4;
            o_instruction <= i_instruction;
         end
         else if(i_EN) begin
            //o_PCplus4 <= 32'd0;
            //o_instruction <= 32'd0;
            o_PCplus4 <= o_PCplus4;
            o_instruction <= o_instruction;
           
           
         end
         else begin
            //o_PCplus4 <= o_PCplus4;
            //o_instruction <= o_instruction;
             o_PCplus4 <= 32'd0;
            o_instruction <= 32'd0;
         end
       
    end
end
endmodule
