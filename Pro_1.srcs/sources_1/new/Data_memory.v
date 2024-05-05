`timescale 1ns / 1ps
module Data_memory(
    input i_clk, 
    input i_rstn, 
    input MemWrite,
    input [31:0] Memaddr, 
    input [31:0] MemWriteData, 
    output [31:0] MemReadData
);
integer  i;
reg [31:0] mem [0:127];
//initial $readmemb("dmem.txt", mem);
assign MemReadData =  mem[Memaddr] ;
always @(posedge i_clk, negedge i_rstn)begin
		if(!i_rstn)
		begin
			for(i=0; i<128; i=i+1)
			begin
				mem[i] <= i;
			end
		end
		else
		begin
			if(MemWrite)
				mem[Memaddr] <= MemWriteData;
		end
	end

endmodule
