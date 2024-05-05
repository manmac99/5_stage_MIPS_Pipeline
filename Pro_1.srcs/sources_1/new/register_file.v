// `timescale 1ns / 1ps

// module register_file(
// 	input clk,				
// 	input rstn,
// 	input RegWrite,            //control signal 
// 	input [4:0] R_reg1,        //read register1
// 	input [4:0] R_reg2,	       //read register2
// 	input [4:0] W_reg,		   //write register	
// 	input [31:0] W_data,	   //write data
// 	output [31:0] R_data1, //read data1
// 	output [31:0] R_data2  //read data2
// );
// 	reg [31:0] reg_file [0:31];
// 	integer i;
// 	//initial $readmemb("reg.txt", reg_file); 
// 	assign R_data1 = reg_file[R_reg1];
// 	assign R_data2 = reg_file[R_reg2];
// 	always @(posedge clk, negedge rstn)
// 	begin
// 		if(!rstn)
// 		begin
// 			for(i=0; i<32; i=i+1)
// 				reg_file[i] <= i;
// 		end
// 		else
// 		begin
// 			//write operation
// 			if(RegWrite == 1'b1)
// 				reg_file[W_reg] <= W_data;
			
// 		end
// 	end
// endmodule

module register_file(
	input clk,				
	input rstn,
	input RegWrite,            //control signal 
	input [4:0] R_reg1,        //read register1
	input [4:0] R_reg2,	       //read register2
	input [4:0] W_reg,		   //write register	
	input [31:0] W_data,	   //write data
	output [31:0] R_data1, //read data1
	output [31:0] R_data2  //read data2
//	output reg [31:0] R_data1,
//	output reg [31:0] R_data2
);
    wire w_clk;
    assign w_clk = ~clk;
    
	reg [31:0] reg_file [0:31];
	integer i;
	//
	assign R_data1 = reg_file[R_reg1];
	assign R_data2 = reg_file[R_reg2];
	
	always @(posedge w_clk, negedge rstn)
	begin
		if(!rstn)
		begin
			// reg_file[0] <= 32'd0;
            // reg_file[1] <= 32'd5;   // 23
            // reg_file[2] <= 32'd8;
            // reg_file[3] <= 32'd10;  // 34
            // reg_file[4] <= 32'd11;
            // reg_file[5] <= 32'd20;  // 66
            // reg_file[6] <= 32'd43;   
            // reg_file[7] <= 32'd24;
            // reg_file[8] <= 32'd4;
            // reg_file[9] <= 32'd5;
            // reg_file[10] <= 32'd11;  
            // reg_file[11] <= 32'd17;
            // reg_file[12] <= 32'd21;
            // reg_file[13] <= 32'd10;
            // reg_file[14] <= 32'd22;
            // reg_file[15] <= 32'd1;
            // reg_file[16] <= 32'd2;
            // reg_file[17] <= 32'd2;
            // reg_file[18] <= 32'd3;
            // reg_file[19] <= 32'd3;
            // reg_file[20] <= 32'd6;
            // reg_file[21] <= 32'd7;
            // reg_file[22] <= 32'd9;
            // reg_file[23] <= 32'd0;
            // reg_file[24] <= 32'd154;
            // reg_file[25] <= 32'd145;
            // reg_file[26] <= 32'd111;
            // reg_file[27] <= 32'd100;
            // reg_file[28] <= 32'd101;
            // reg_file[29] <= 32'd98;
            // reg_file[30] <= 32'd87;
            // reg_file[31] <= 32'd76;
            for(i=0; i<32; i=i+1)
				reg_file[i] <= i;
		end
		
		else
		begin
//			write operation
			if(RegWrite)
				reg_file[W_reg] <= W_data;
//		    else
//		        reg_file[W_reg] <= reg_file[W_reg];
//	        reg_file <= reg_file;	  

		end
	end
//	always @(negedge clk, negedge rstn)
//	begin
//	    if(!rstn)
//	    begin
//	        R_data1 <= 32'd0;
//	        R_data2 <= 32'd0;
//	    end
//	    else
//	    begin
//	        R_data1 <= reg_file[R_reg1];
//	        R_data2 <= reg_file[R_reg2];
//	    end
//	end
endmodule




