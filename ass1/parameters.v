//Opcodes
parameter RTYPE = 7'b0110011;
parameter ITYPE = 7'b0010011; // For immediate arithmetic instructions (addi)
parameter I2TYPE = 7'b0000011; // For load instructions
parameter STYPE = 7'b0100011;
parameter BTYPE = 7'b1100011;
parameter UTYPE = 7'b0110111;
parameter JTYPE = 7'b1101111;

// R-type instructions
parameter f3add = 3'b000;
parameter f7add = 7'b0000000;
parameter f3sub = 3'b000;
parameter f7sub = 7'b0100000;
parameter f3sll = 3'b001;
parameter f7sll = 7'b0000000;
parameter f3slt = 3'b010;
parameter f7slt = 7'b0000000;
parameter f3sltu = 3'b011;
parameter f7sltu = 7'b0000000;
parameter f3xor = 3'b100;
parameter f7xor = 7'b0000000;
parameter f3srl = 3'b101;
parameter f7srl = 7'b0000000;
parameter f3sra = 3'b101;
parameter f7sra = 7'b0100000;
parameter f3or = 3'b110;
parameter f7or = 7'b0000000;
parameter f3and = 3'b111;
parameter f7and = 7'b0000000;

// I-type instructions
parameter f3addi = 3'b000;
parameter f3andi = 3'b700;
parameter f3ori = 3'b600;
parameter f3xori = 3'b400;
parameter f3slti = 3'b010;
parameter f3sltiu = 3'b011;
parameter f3shlli = 3'b001;
parameter f3srli = 3'b101;
parameter f3srai = 3'b101;

//I2-type instructions
parameter f3lb = 3'b000; // Load Byte
parameter f3lh = 3'b001; // Load Halfword
parameter f3lw = 3'b010; // Load Word
parameter f3lbu = 3'b100; // Load Byte Unsigned
parameter f3lhu = 3'b101; // Load Halfword Unsigned

// S-type instructions
parameter f3sb = 3'b000;
parameter f3sh = 3'b001;
parameter f3sw = 3'b010;

//  B-type instructions
parameter f3beq = 3'b000;
parameter f3bne = 3'b001;
parameter f3blt = 3'b100;
parameter f3bge = 3'b101;
parameter f3bltu = 3'b110;
parameter f3bgeu = 3'b111;

// Define U-type instructions
parameter f3lui = 3'b000; // Not used, but for completeness
parameter f3auipc = 3'b000; // Not used, but for completeness

// Define J-type instructions
parameter f3jal = 3'b000; // Not used, but for completeness
parameter f3jalr = 3'b000; // Not used, but for completeness

// Define SYSTEM instructions
parameter f3ecall = 3'b000;
parameter f3ebreak = 3'b001;
parameter f3csrrw = 3'b001;
parameter f3csrrs = 3'b010;
parameter f3csrrc = 3'b011;
parameter f3csrrwi = 3'b101;
parameter f3csrrsi = 3'b110;
parameter f3csrrci = 3'b111;

// Define other instructions
parameter f3fence = 3'b000; // Not used, but for completeness

// Define the opcode for load instructions (I2-type)

// Define funct3 for load instructions


//ALUCtl

parameter ADD = 4'b0010;
parameter SUB = 4'b0110;
parameter XOR = 4'b0111;
parameter OR = 4'b0001;
parameter AND = 4'b0000;
parameter SLL = 4'b0011; // Shift Left Logical
parameter SRL = 4'b1010; // Shift Right Logical
parameter SRA = 4'b1011; // Shift Right Arithmetic
parameter SLT = 4'b0101; // Set Less Than
parameter SLTU = 4'b0100; // Set Less Than Unsigned
parameter LB = 4'b1100;  // Load Byte
parameter LH = 4'b1101;  // Load Halfword
parameter LW = 4'b1110;  // Load Word
parameter LBU = 4'b1111; // Load Byte Unsigned
parameter LHU = 4'b1000; // Load Halfword Unsigned\
parameter unused_here=4'b1000;`

// parameter ADDI = 4'b1000; // Add Immediate
// parameter XORI = 4'b1001; // Xor Immediate
// parameter ORI = 4'b1010; // Or Immediate
// parameter ANDI = 4'b1011; // And Immediate
// parameter SLLI = 4'b1100; // Shift Left Logical Immediate
// parameter SRLI = 4'b1101; // Shift Right Logical Immediate
// parameter SRAI = 4'b1110; // Shift Right Arithmetic Immediate
// parameter SLTI = 4'b1111; // Set Less Than Immediate
// parameter SLTIU = 4'b1112; // Set Less Than Unsigned Immediate
