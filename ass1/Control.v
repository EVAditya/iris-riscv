module Control (
    input [6:0] opcode,
    output  branch,
    output  memRead,
    output  memtoReg, //If 1 reg<=mem, else reg<=alu
    output  [1:0] ALUOp,
    output  memWrite,
    output  ALUSrc, //1 if imm, 0 if reg
    output  regWrite
    );

    // TODO: implement your Control here
    // Hint: follow the Architecture to set output signal

    always @(posedge clk) begin
        case(opcode)
            RTYPE: begin
                branch = 0;
                memRead = 0;
                memtoReg = 0;
                ALUOp = 2'b00;
                memWrite = 0;
                ALUSrc = 0;
                regWrite = 1;
            end
            ITYPE: begin
                branch = 0;
                memRead = 0;
                memtoReg = 0;
                ALUOp = 2'b01;
                memWrite = 0;
                ALUSrc = 1;
                regWrite = 1;
            end
            I2TYPE: begin
                branch = 0;
                memRead = 1;
                memtoReg = 0;
                ALUOp = 2'b01;
                memWrite = 0;
                ALUSrc = 1;
                regWrite = 1;
            end
            STYPE: begin
                branch = 0;
                memRead = 0;
                memtoReg = 0;
                ALUOp = 2'b10;
                memWrite = 1;
                ALUSrc = 1;
                regWrite = 0;
            end
            BTYPE: begin
                branch = 1;
                memRead = 0;
                memtoReg = 0;
                ALUOp = 2'b00;
                memWrite = 0;
                ALUSrc = 0;
                regWrite = 0;
            end
            UTYPE: begin
                branch = 0;
                memRead = 0;
                memtoReg = 0;
                ALUOp = 2'b00;
                memWrite = 0;
                ALUSrc = 1;
                regWrite = 1;
            end
            JTYPE: begin
                branch = 1;
                memRead = 0;
                memtoReg = 0;
                ALUOp = 2'b00;
                memWrite = 0;
                ALUSrc = 1;
                regWrite = 1;
            end
            default: begin
                branch = 0;
                memRead = 0;
                memtoReg = 0;
                ALUOp = 2'b00;
                memWrite = 0;
                ALUSrc = 0;
                regWrite = 0;
            end
    endcase
    end     


endmodule




