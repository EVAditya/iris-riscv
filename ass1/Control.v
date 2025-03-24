`include "ass1/parameters.v"

module Control (
    input [6:0] opcode,
    output reg branch,
    output reg memRead,
    output reg [1:0] memtoReg, //00 ALu, 01 mem, 10 PC(jal), 11 PCnext (for aiupc)
    output reg [1:0] ALUOp,
    output reg memWrite,
    output reg ALUSrc, //1 if imm, 0 if reg
    output reg regWrite,
    output reg jalr  //True when jalr instruction is executed (input will be taken from ALU)
    );

    // TODO: implement your Control here
    // Hint: follow the Architecture to set output signal

    always @(*) begin
        case(opcode)
            `RTYPE: begin
                branch = 0;
                memRead = 0;
                memtoReg = 2'b00;
                ALUOp = 2'b01;
                memWrite = 0;
                ALUSrc = 0;
                regWrite = 1;
                jalr=0;
            end
            `ITYPE: begin
                branch = 0;
                memRead = 2'b00;
                memtoReg = 0;
                ALUOp = 2'b10;
                memWrite = 0;
                ALUSrc = 1;
                regWrite = 1;
                jalr=0;
             
            end
            `I2TYPE: begin
                branch = 0;
                memRead = 1;
                memtoReg = 2'b00;
                ALUOp = 2'b10;
                memWrite = 0;
                ALUSrc = 1;
                regWrite = 1;
                jalr=0;
            end
            `STYPE: begin
                branch = 0;
                memRead = 0;
                memtoReg = 2'b00;
                ALUOp = 2'b00;
                memWrite = 1;
                ALUSrc = 1;
                regWrite = 0;
                jalr=0;
            end
            `BTYPE: begin
                branch = 1;
                memRead = 0;
                memtoReg = 2'b00;
                ALUOp = 2'b11;
                memWrite = 0;
                ALUSrc = 0;
                regWrite = 0;
                jalr=0;
            end
            `JAL: begin
                branch = 1;
                memRead = 0;
                memtoReg = 2'b01;
                ALUOp = 2'b10;
                memWrite = 0;
                ALUSrc = 0;
                regWrite = 1;
                jalr=0;
            end
            `JALR: begin
                branch = 1;
                memRead = 0;
                memtoReg = 2'b00;
                ALUOp = 2'b01;
                memWrite = 0;
                ALUSrc = 0;
                regWrite = 1;
                jalr=1;
            end
            `LUI: begin
                branch = 0;
                memRead = 0;
                memtoReg = 2'b00;
                ALUOp = 2'b10;
                memWrite = 0;
                ALUSrc = 1;
                regWrite = 1;
                jalr=0;
            end
            `AUIPC: begin
                branch = 0;
                memRead = 0;
                memtoReg = 2'b11;
                ALUOp = 2'b00;
                memWrite = 0;
                ALUSrc = 1;
                regWrite = 1;
                jalr=0; 
            end
            default: begin
                branch = 0;
                memRead = 0;
                memtoReg = 2'b00;
                ALUOp = 2'b11;
                memWrite = 0;
                ALUSrc = 0;
                regWrite = 0;
                jal=0;
                jalr=0;
            end
    endcase
    end

//    always@(branch) begin
        


endmodule




