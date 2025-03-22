module ALUCtrl (
    input [1:0] ALUOp, //It is operand[5:4] from instruction
    input funct7,  //5th bit of funct7
    input [2:0] funct3,
    output reg [3:0] ALUCtl
);

    // TODO: implement your ALU ALUCtl here
   // Hint: using ALUOp, funct7, funct3 to select exact operation
    always @(*) begin
    casex (ALUOp)
        2'b0x: begin //00 is RTYPE and 01 is ITYPE
            case(funct3)
                f3add : ALUCtl = (funct7) ? ADD : SUB; // funct7 = 0 for add, funct7 = 1 for sub
                f3xor : ALUCtl = XOR;
                f3and : ALUCtl = AND;
                f3slt : ALUCtl = SLT;
                f3sltu : ALUCtl = SLTU;
                f3sll : ALUCtl = SLL;
                f3srl : ALUCtl = (funct7)? SRL : SRA; // funct7 = 0 for srl, funct7 = 1 for sra
                f3slt : ALUCtl = SLT;
                f3sltu : ALUCtl = SLTU;
                default: ALUCtl = 4'b0000; // Default case to avoid latches       
            endcase
        end
        2'b10: begin //I2TYPE
            case(funct3)
                f3lb : ALUCtl = LB;
                f3lh : ALUCtl = LH;
                f3lw : ALUCtl = LW;
                f3lbu : ALUCtl = LBU;
                f3lhu : ALUCtl = LHU;
                default: ALUCtl = ADD; // Default case to avoid latches

            endcase
        end
    endcase
    end
                
                
                
endmodule

