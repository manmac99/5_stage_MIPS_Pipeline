`timescale 1ns / 1ps
module MIPS_pipeline(
    input i_clk, 
    input i_rstn, 
    output [31:0] ALUresult, 
    output [31:0] Instruction, 
    output [31:0] Read_data1,   
    output [31:0] Read_data2, 
    output [4:0] Reg_Dst, 
    output stall

);
wire RegWriteW;
wire [31:0] To_Adder;
wire[31:0] ResultW;
wire[31:0] PC_;
wire StallF;
wire StallD;
wire PCsrcD;
wire [31:0] PC_plus4_A;
wire [31:0] InstructionI;
wire [31:0] PCF;
wire [31:0] InstrD;
wire [31:0] PCPlus4D;
wire [31:0] PCBranchD;
//Control Unit
wire RegWriteD;
wire MemtoRegD;
wire MemWriteD;
wire [2:0] ALUControlD;
wire ALUSrcD;
wire RegDstD;
wire BranchD;

//register file
wire [31:0] RD1;
wire [31:0] RD2;
wire [4:0] WriteRegW;
wire [31:0] ALUOutM;
wire ForwardAD;
wire ForwardBD;

//sign_extend
wire[31:0] SignImmD;

//Equal
wire [31:0] Equal_mux1;
wire [31:0] Equal_mux2;
wire EqualD;

//ID_EX
wire FlushE;
wire MemtoRegE;
wire RegWriteE;
wire MemWriteE;
wire [2:0] ALUControlE;
wire ALUSrcE;
wire RegDstE;
wire [31:0] Data1;
wire [31:0] Data2;
wire [31:0] SignImmE;
wire [4:0] RsE;
wire [4:0] RtE;
wire [4:0] RdE; 
wire [4:0] WriteRegE;
wire [31:0] ALUOutE;

//mux 2bit
wire [1:0] ForwardAE;
wire [1:0] ForwardBE;
wire [31:0] SrcAE;
wire [31:0] SrcBE;
wire [31:0] WriteDataE;

//EX_MEM
wire RegWriteM;
wire MemtoRegM;
wire MemWriteM;
wire [31:0] WriteDataM;
wire [4:0] WriteRegM;
wire [31:0] DM_out_MEMWB;

//MEMWB
wire MemtoRegW;
wire[31:0] ReadDataW;
wire[31:0] ALUOutW;

assign ALUresult = ALUOutE;
assign Instruction = InstrD;
assign Read_data1 = SrcAE;
assign Read_data2 = SrcBE;
assign Reg_Dst = WriteRegE;
assign stall = StallD;

MUX_1 MUX1_MIPS(
    .a_mux(PC_plus4_A),
    .b_mux(PCBranchD),
    .in(PCsrcD),
    .m_out(PC_)
);

PC PC_MIPS(
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_EN(StallF),
    .i_PC(PC_),
    .o_PC(PCF)
);

Add_1 Add_1_MIPS(
    .a_add(PCF),
    .a_out(PC_plus4_A)
);
iMEM iMEM_MIPS(
    .i_rstn(i_rstn),
    .i_PC(PCF),
    .o_instruction(InstructionI)
);
IF_ID IF_ID_MIPS(
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_EN(StallF),
    .i_CLR(PCsrcD),
    .i_PCplus4(PC_plus4_A),
    .i_instruction(InstructionI),
    .o_PCplus4(PCPlus4D),
    .o_instruction(InstrD)
);
Control_Unit Control_Unit_MIPS( 
    .op(InstrD[31:26]),
    .funct(InstrD[5:0]),
    .MemtoReg(MemtoRegD),
    .Memwrite(MemWriteD),
    //.MemRead(),
    .Branch(BranchD),
    .ALUSrc(ALUSrcD),
    .RegDst(RegDstD),
    .RegWrite(RegWriteD),
    .ALUControl(ALUControlD)
);

register_file register_file_MIPS(
    .clk(i_clk),
    .rstn(i_rstn),
    .RegWrite(RegWriteW),
    .R_reg1(InstrD[25:21]),
    .R_reg2(InstrD[20:16]),
    .W_reg(WriteRegW),
    .W_data(ResultW),
    .R_data1(RD1),
    .R_data2(RD2)
);
sign_extend sign_extend_MIPS(
    .imm_value(InstrD[15:0]),
    .result(SignImmD)
);
Shifter Shifter_MIPS(
    .a(SignImmD), 
    .b(To_Adder)
);
ALU_1 ALU_1_MIPS(
    .a_in(To_Adder),
    .b_in(PCPlus4D),
    .Add_result(PCBranchD)
);
MUX_1 MUX1_MIPS_ID1(
    .a_mux(RD1),
    .b_mux(ALUOutM),
    .in(ForwardAD),
    .m_out(Equal_mux1)
);
MUX_1 MUX1_MIPS_ID2(
    .a_mux(RD2),
    .b_mux(ALUOutM),
    .in(ForwardBD),
    .m_out(Equal_mux2)
);

Equal Equal_MIPS(
    .a(Equal_mux1),
    .b(Equal_mux2),
    .out(EqualD)
);
Branch Branch_MIPS(
    .o_Branch(BranchD),
    .zero(EqualD),
    .PCSrc(PCsrcD)
);

ID_EX ID_EX_MIPS(
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_CLR(FlushE),
    .i_MemtoReg(MemtoRegD),
    .i_MemWrite(MemWriteD),
    .i_ALUSrc(ALUSrcD),
    .i_RegDst(RegDstD),
    .i_RegWrite(RegWriteD),
    .i_Rdata1(RD1),
    .i_Rdata2(RD2),
    .RsD(InstrD[25:21]),
    .RtD(InstrD[20:16]),
    .RdD(InstrD[15:11]),
    .i_signextImmediate(SignImmD),
    .ALUct(ALUControlD),
    .o_ALUct(ALUControlE),
    .o_signextImmediate(SignImmE),
    .o_MemtoReg(MemtoRegE),
    .o_MemWrite(MemWriteE),
    .o_ALUSrc(ALUSrcE),
    .o_RegDst(RegDstE),
    .o_RegWrite(RegWriteE),
    .o_Rdata1(Data1),
    .o_Rdata2(Data2),
    .RsE(RsE),
    .RtE(RtE),
    .RdE(RdE)
);
MUX_5_bit MUX_5_bit_MIPS(
    .a_mux(RtE),
    .b_mux(RdE),
    .in(RegDstE),
    .m_out(WriteRegE) 
);
MUX_2bit_in MUX_2bit_in_MIPS1(
    .a(Data1),
    .b(ResultW),
    .c(ALUOutM),
    .sel(ForwardAE),
    .o_out(SrcAE)
);
MUX_2bit_in MUX_2bit_in_MIPS2(
    .a(Data2),
    .b(ResultW),
    .c(ALUOutM),
    .sel(ForwardBE),
    .o_out(WriteDataE)
);

MUX_1 MUX_1_ID_EX(
    .a_mux(WriteDataE),
    .b_mux(SignImmE),
    .in(ALUSrcE),
    .m_out(SrcBE)
);
ALU_2 ALU_2_MIPS(
    .a_in(SrcAE),
    .b_in(SrcBE),
    .ALUctrl(ALUControlE),
    .result(ALUOutE)
);

EX_MEM EX_MEM_MIPS(
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_MemtoReg(MemtoRegE),
    .i_MemWrite(MemWriteE),
    .i_RegWrite(RegWriteE),
    .i_ALUresult(ALUOutE),
    .i_Rdata2(WriteDataE),
    .i_Reg_Dst(WriteRegE),
    .o_MemtoReg(MemtoRegM),
    .o_MemWrite(MemWriteM),
    .o_RegWrite(RegWriteM),
    .o_ALUresult(ALUOutM),
    .o_Rdata2(WriteDataM),
    .o_Reg_Dst(WriteRegM)
);

Data_memory Data_memory_MIPS(
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .MemWrite(MemWriteM),
    .Memaddr(ALUOutM),
    .MemWriteData(WriteDataM),
    .MemReadData(DM_out_MEMWB)
);

MEM_WB MEM_WB_MIPS(
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_MemtoReg(MemtoRegM),
    .i_RegWrite(RegWriteM),
    .i_Rdata(DM_out_MEMWB),
    .i_ALUresult(ALUOutM),
    .i_Reg_Dst(WriteRegM),
    .o_MemtoReg(MemtoRegW),
    .o_RegWrite(RegWriteW),
    .o_Rdata(ReadDataW),
    .o_ALUresult(ALUOutW),
    .o_Reg_Dst(WriteRegW)
);

MUX_1 MUX_1_LAST(
    .a_mux(ALUOutW),
    .b_mux(ReadDataW),
    .in(MemtoRegW),
    .m_out(ResultW)    
);
DDL DDL_MIPS(
    .BranchD(BranchD),
    .RsD(InstrD[25:21]),
    .RtD(InstrD[20:16]),
    .RsE(RsE),
    .RtE(RtE),
    .WriteRegE(WriteRegE),
    .MemtoRegE(MemtoRegE),
    .RegWriteE(RegWriteE),
    .WriteRegM(WriteRegM),
    .MemtoRegM(MemtoRegM),
    .RegWriteM(RegWriteM),
    .WriteRegW(WriteRegW),
    .RegWriteW(RegWriteW),
    .stallIF(StallF),
    .stallID(StallD),
    .ForwardAD(ForwardAD),
    .ForwardBD(ForwardBD),
    .FlushE(FlushE),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE)
);

endmodule