module SingleCycleCPU (
    input clk,
    input start
);

// Declare all variables as wire or reg
wire pc; // Current PC
wire pcnext; // Next PC
wire [31:0] immext;

wire [31:0] instr;
wire [31:0] pctarget, pcplus4;

assign pc = (pcsrc) ? pctarget : pcplus4;

wire branch, memRead, memtoReg, memWrite, ALUSrc, regWrite;
wire [1:0] ALUOp;

wire writeData;
assign writeData = (memtoReg) ? readData : ALUOut;

wire [31:0] readData2, srcA, srcB;
assign srcB = (ALUSrc) ? immext : readData2;

wire ALUCtl;
wire zero;

wire [31:0] ALUOut; // Declare ALUOut as a wire
wire [31:0] readData; // Declare readData as a wire

// Declare pcsel as a wire
wire pcsel;
assign pcsel=branch&zero;

PC m_PC(
    .clk(clk),
    .rst(~start), // Invert start for active-low reset
    .pc_i(pcnext),
    .pc_o(pc)
);

Adder m_pc_plus_4(
    .a(pc),
    .b(32'b100),
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
    .regWrite(regWrite)
);

Register m_Register(
    .clk(clk),
    .rst(~start), // Invert start for active-low reset
    .regWrite(regWrite),
    .readReg1(instr[19:15]),
    .readReg2(instr[24:20]),
    .writeReg(instr[11:7]),
    .writeData(writeData),
    .readData1(srcA),
    .readData2(readData2)
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

Mux2to1 #(.size(32)) m_Mux_PC(
    .sel(pcsel),
    .s0(pcplus4),
    .s1(pctarget),
    .out(pcnext)
);

Mux2to1 #(.size(32)) m_Mux_ALU(
    .sel(ALUSrc),
    .s0(readData2),
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
    .ALUctl(ALUCtl),
    .A(srcA),
    .B(srcB),
    .ALUOut(ALUOut),
    .zero(zero)
);

DataMemory m_DataMemory(
    .rst(~start), // Invert start for active-low reset
    .clk(clk),
    .memWrite(memWrite),
    .memRead(memRead),
    .address(ALUOut), // Assuming address is srcB
    .writeData(readData2), // Assuming write data is readData2
    .readData(readData)
);

Mux2to1 #(.size(32)) m_Mux_WriteData(
    .sel(memtoReg),
    .s0(ALUOut),
    .s1(readData),
    .out(writeData)
);

endmodule





/*



module SingleCycleCPU (
    input clk,
    input start
    
);

// When input start is zero, cpu should reset
// When input start is high, cpu start running

// TODO: connect wire to realize SingleCycleCPU
// The following provides simple template,

wire pc ;//Current PC
wire pcnext; //Next PC
wire [31:0] immext;

wire [31:0] instr;
wire [31:0] pctarget, pcplus4;

assign pc=(pcsrc)?pctarget:pcplus4;

wire branch, memRead, memtoReg, memWrite, ALUSrc, regWrite;
wire [1:0] ALUOp;

wire writeData;
assign writeData = (memtoReg)?readData:ALUOut;

wire [31:0] readData2, srcA, srcB;
assign srcB=(ALUSrc)?immext:readData2;

wire [31:0] ALUOut; 
wire [31:0] readData;

wire pcsrc;

wire ALUCtl;
PC m_PC(
    .clk(clk),
    .rst(start),
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
    .regWrite(regWrite)
);


Register m_Register(
    .clk(clk),
    .rst(start),
    .regWrite(regWrite),
    .readReg1(instr[19:15]),
    .readReg2(instr[24:20]),
    .writeReg(instr[11:7]),
    .writeData(writeData),
    .readData1(srcA),
    .readData2(readData2)
);


ImmGen #(.Width(32)) m_ImmGen(
    .inst(),
    .imm()
);

ShiftLeftOne m_ShiftLeftOne(
    .i(),
    .o()
);

Adder m_Adder_2(
    .a(pc),
    .b(immext),
    .sum(pctarget)
);

Mux2to1 #(.size(32)) m_Mux_PC(
    .sel(),
    .s0(),
    .s1(),
    .out()
);

Mux2to1 #(.size(32)) m_Mux_ALU(
    .sel(),
    .s0(),
    .s1(),
    .out()
);

ALUCtrl m_ALUCtrl(
    .ALUOp(ALUOp),
    .funct7(instr[30]),
    .funct3(instr[14:12]),
    .ALUCtl(ALUctl)
);

ALU m_ALU(
    .ALUctl(ALUCtl),
    .A(srcA),
    .B(srcB),
    .ALUOut(ALUOut),
    .zero(zero)
);

DataMemory m_DataMemory(
    .rst(start),
    .clk(),
    .memWrite(),
    .memRead(),
    .address(),
    .writeData(),
    .readData()
);

Mux2to1 #(.size(32)) m_Mux_WriteData(
    .sel(),
    .s0(),
    .s1(),
    .out()
);

endmodule

*/