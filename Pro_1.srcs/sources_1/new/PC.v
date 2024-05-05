// `timescale 1ns / 1ps
module PC(
    input i_clk,
    input i_rstn,
    input i_EN,
    input[31:0] i_PC,
    output reg [31:0] o_PC
    );
    always @(posedge i_clk , negedge i_rstn)
    begin
        if(!i_rstn)
            o_PC <= 32'd0;
        else begin
        if (!i_EN) 
                o_PC<=i_PC;
        else
                o_PC<=o_PC;
                end
        end
endmodule
