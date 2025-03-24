`include "ass1/parameters.v"

module ALUCtrl (
    input [1:0] ALUOp, //It is operand[5:4] from instruction
    input funct7,  //5th bit of funct7
    input [2:0] funct3,
    output reg [3:0] ALUCtl
);

    // TODO: implement your ALU ALUCtl here
   // Hint: using ALUOp, funct7, funct3 to select exact operation
    always @(*) begin
    case (ALUOp)
        2'b00: ALUCtl=4'b0000; // Default case
        2'b01: begin // RTYPE
            case(funct3)
                `f3add : ALUCtl = (funct7) ? `ADD : `SUB; // funct7 = 0 for add, funct7 = 1 for sub
                `f3xor : ALUCtl = `XOR;
                `f3and : ALUCtl = `AND;
                `f3slt : ALUCtl = `SLT;
                `f3sltu : ALUCtl = `SLTU;
                `f3sll : ALUCtl = `SLL;
                `f3srl : ALUCtl = (funct7)? `SRL : `SRA; // funct7 = 0 for srl, funct7 = 1 for sra

                `f3or : ALUCtl = `OR;
                default: ALUCtl = `ADD;

                // `f3addi : ALUCtl = `ADD;
                // `f3ori : ALUCtl = `OR;
                // `f3andi : ALUCtl = `AND;
                // `f3xori : ALUCtl = `XOR;
                // `f3slti : ALUCtl = `SLT;
                // `f3sltiu : ALUCtl = `SLTU;
                // `f3shlli : ALUCtl = `SLL;
                // `f3srli : ALUCtl = (funct7)? `SRL : `SRA; // funct7 = 0 for srli, funct7 = 1 for srai
                // default: ALUCtl = 4'b0000; // Default case to avoid latches       
            endcase
        end
        2'b10: begin //ITYPE AND I2TYPE
           case(funct3)
                `f3addi : ALUCtl = `ADD;
                `f3ori : ALUCtl = `OR;
                `f3andi : ALUCtl = `AND;
                `f3xori : ALUCtl = `XOR;
                `f3slti : ALUCtl = `SLT;
                `f3sltiu : ALUCtl = `SLTU;
                `f3shlli : ALUCtl = `SLL;
                `f3srli : ALUCtl = (funct7)? `SRL : `SRA; // funct7 = 0 for srli, funct7 = 1 for srai
                default: ALUCtl = `ADD; // For I2TYPE and JALR
            endcase        end
        2'b11: begin //BTYPE,
            case(funct3)
                `f3beq : ALUCtl = `BEQ;
                `f3bne : ALUCtl = `XOR;
                `f3blt : ALUCtl = `BLT;
                `f3bge : ALUCtl = `BGE;
                `f3bltu : ALUCtl = `BLTU;
                `f3bgeu : ALUCtl = `BGEU;
                default: ALUCtl = 4'b0000; // Default case to avoid latches
            endcase
        end
    endcase
    end
                
endmodule
