// parameters.v
`define RTYPE 7'b0110011
`define ITYPE 7'b0010011 // For immediate arithmetic instructions (addi)
`define I2TYPE 7'b0000011 // For load instructions
`define STYPE 7'b0100011
`define BTYPE 7'b1100011
`define JAL 7'b1101111
`define JALR 7'b1100111
`define LUI 7'b0110111
`define AUIPC 7'b0010111

`define ECALL 7'b1110011
`define EBREAK 7'b1110011
`define CSRRW 7'b1110011
`define CSRRS 7'b1110011
`define CSRRC 7'b1110011
`define CSRRWI 7'b1110011
`define CSRRSI 7'b1110011
`define CSRRCI 7'b1110011


// R-type instructions
`define f3add 3'b000
`define f3sub 3'b000
`define f3sll 3'b001
`define f3slt 3'b010
`define f3sltu 3'b011
`define f3xor 3'b100
`define f3srl 3'b101
`define f3sra 3'b101
`define f3or 3'b110
`define f3and 3'b111

// I-type instructions
`define f3addi 3'b000
`define f3andi 3'b111
`define f3ori 3'b110
`define f3xori 3'b100
`define f3slti 3'b010
`define f3sltiu 3'b011
`define f3shlli 3'b001
`define f3srli 3'b101
`define f3srai 3'b101

// I2-type instructions
`define f3lb 3'b000 // Load Byte
`define f3lh 3'b001 // Load Halfword
`define f3lw 3'b010 // Load Word
`define f3lbu 3'b100 // Load Byte Unsigned
`define f3lhu 3'b101 // Load Halfword Unsigned

// S-type instructions
`define f3sb 3'b000
`define f3sh 3'b001
`define f3sw 3'b010

// B-type instructions
`define f3beq 3'b000
`define f3bne 3'b001
`define f3blt 3'b100
`define f3bge 3'b101
`define f3bltu 3'b110
`define f3bgeu 3'b111

// Define U-type instructions
`define f3lui 3'b000 // Not used, but for completeness
`define f3auipc 3'b000 // Not used, but for completeness

// Define J-type instructions
`define f3jal 3'b000 // Not used, but for completeness
`define f3jalr 3'b000 // Not used, but for completeness

// Define SYSTEM instructions
`define f3ecall 3'b000
`define f3ebreak 3'b001
`define f3csrrw 3'b001
`define f3csrrs 3'b010
`define f3csrrc 3'b011
`define f3csrrwi 3'b101
`define f3csrrsi 3'b110
`define f3csrrci 3'b111

// Define other instructions
`define f3fence 3'b000 // Not used, but for completeness

// Define the opcode for load instructions (I2-type)

// Define funct3 for load instructions

// ALUCtl
`define ADD 4'b0001
`define SUB 4'b0010
`define XOR 4'b0011
`define OR 4'b0100
`define AND 4'b0101
`define SLL 4'b0110 // Shift Left Logical
`define SRL 4'b0111 // Shift Right Logical
`define SRA 4'b1000 // Shift Right Arithmetic
`define SLT 4'b1001 // Set Less Than
`define SLTU 4'b1010 // Set Less Than Unsigned
`define BEQ 4'b1011 // Branch Equal
`define BLT 4'b1101 // Branch Less Than
`define BGE 4'b1110 // Branch Greater or Equal
`define BLTU 4'b1111 // Branch Less Than Unsigned
`define BGEU 4'b1100 // Branch Greater or Equal Unsigned

`define unused_here1 4'b0000 // Branch Not Equal


// Additional defines for immediate instructions

`define LB 4'b1100  // Load Byte
`define LH 4'b1101  // Load Halfword
`define LW 4'b1110  // Load Word
`define LBU 4'b1111 // Load Byte Unsigned
`define LHU 4'b1000 // Load Halfword Unsigned
`define unused_here 4'b1000

`define ADDI 4'b1000 // Add Immediate
`define XORI 4'b1001 // Xor Immediate
`define ORI 4'b1010 // Or Immediate
`define ANDI 4'b1011 // And Immediate
`define SLLI 4'b1100 // Shift Left Logical Immediate
`define SRLI 4'b1101 // Shift Right Logical Immediate
`define SRAI 4'b1110 // Shift Right Arithmetic Immediate
`define SLTI 4'b1111 // Set Less Than Immediate
// Note: SLTIU cannot be defined as 4'b1112 because it exceeds the 4-bit range.
