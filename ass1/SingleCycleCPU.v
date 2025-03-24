/*
LIMITATIONS:
ecall and ebreak not implemented
for slli, srli, srai, imm must only have value in [4:0], all other bits must be 0
*/

`include "ass1/parameters.v"

module SingleCycleCPU (
    input clk,
    input start
);

// Declare all variables as wire or reg
wire [31:0] pc; // Current PC
wire [31:0] pcnext; // Next PC
wire [31:0] imm;

wire [31:0] instr;
wire [31:0] pctarget, pcplus4;

//assign pc = (pcsrc) ? pctarget : pcplus4;

wire branch, memRead, memtoReg, memWrite, ALUSrc, regWrite;
wire [1:0] ALUOp;

wire [31:0] writeData;

wire [31:0] readData2, srcA, srcB;
// assign srcB = (ALUSrc) ? immext : readData2;

wire [3:0] ALUCtl;
wire zero;

wire [31:0] ALUOut; // Declare ALUOut as a wire
wire [31:0] readData; // Declare readData as a wire

wire readReg1, opcode, funct3, funct7;

assign opcode=instr[6:0];
assign funct3=instr[14:12];
assign funct7=instr[30];

// assign writeData = (memtoReg) ? readData : ALUOut;

wire jal;
wire jalr;

// Declare pcsel as a wire
wire pcsel;
assign pcsel=branch&zero;

PC m_PC(
    .clk(clk),
    .rst(start), // Invert start for active-low reset
    .pc_i(pcnext),
    .pc_o(pc)
);

Adder m_pc_plus_4(
    .a(pc),
    .b(32'd4),
    .sum(pcplus4)
);

InstructionMemory m_InstMem(
    .readAddr(pc),
    .inst(instr)
);

Control m_Control(
    .opcode(instr[6:0]),
    .branch(branch),
    .memRead(memRead),
    .memtoReg(memtoReg),
    .ALUOp(ALUOp),
    .memWrite(memWrite),
    .ALUSrc(ALUSrc),
    .regWrite(regWrite),
    .jalr(jalr)
);

assign readData1= (opcode==`LUI) ? 32'b0 : instr[19:15]; 
//This change ansures ALU adds zero reg and imm for LUI instruction

Register m_Register(
    .clk(clk),
    .rst(start), // Invert start for active-low reset
    .regWrite(regWrite),
    .readReg1(readData1),
    .readReg2(instr[24:20]),
    .writeReg(instr[11:7]),
    .writeData(loadbus),
    .readData1(srcA),
    .readData2(readData2)
);

wire [31:0] storebus;
wire isstore;
assign isstore = (opcode==`STYPE);

partselector m_store(
    .trueop(isstore),
    .funct3(funct3),
    .datatowrite(readData2),
    .part(storebus)
);

ImmGen #(.Width(32)) m_ImmGen(
    .inst(instr),
    .imm(imm)
);

ShiftLeftOne m_ShiftLeftOne(
    .i(imm),
    .o()
);

Adder m_Adder_2(
    .a(pc),
    .b(imm),
    .sum(pctarget)
);

// Mux2to1 #(.size(32)) m_Mux_PC(
//     .sel(pcsel),
//     .s0(pcplus4),
//     .s1(pctarget),
//     .out(pcnext)
// );

//Need a 4*1 mux here
assign pcnext=(pcsel) ? pctarget : (jalr) ? ALUOut : pcplus4;

Mux2to1 #(.size(32)) m_Mux_ALU(
    .sel(ALUSrc),
    .s0(readData2),``
    .s1(imm),
    .out(srcB)
);

ALUCtrl m_ALUCtrl(
    .ALUOp(ALUOp),
    .funct7(instr[30]),
    .funct3(instr[14:12]),
    .ALUCtl(ALUCtl)
);

ALU m_ALU(
    .ALUCtl(ALUCtl),
    .A(srcA),
    .B(srcB),
    .ALUOut(ALUOut),
    .zero(zero)
);

DataMemory m_DataMemory(
    .rst(start), // Invert start for active-low reset
    .clk(clk),
    .memWrite(memWrite),
    .memRead(memRead),
    .address(ALUOut), // Assuming address is srcB
    .writeData(storebus), // Assuming write data is readData2
    .readData(readData)
);

wire [31:0] loadbus;
wire isload;
assign isload = (opcode==`I2TYPE);

partselector m_load(
    .trueop(isload),
    .funct3(funct3),
    .datatowrite(readData),
    .part(loadbus)
);

// Mux2to1 #(.size(32)) m_Mux_WriteData(
//     .sel(memtoReg),
//     .s0(ALUOut),
//     .s1(readData),
//     .out(writeData)
// );

//Needed a 4*1 mux here
assign writeData = (memtoReg==00) ? ALUOut :
                    (memtoReg==01) ? readData :
                    (memtoReg==10) ? pc : //JAL        
                    (memtoReg==11) ? pcnext : 0; //AUIPC

endmodule





