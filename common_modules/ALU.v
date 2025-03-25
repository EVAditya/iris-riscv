`include "ass1/parameters.v"

module ALU (
    input [3:0] ALUCtl,
    input [31:0] A,B,
    output reg [31:0] ALUOut,
    output reg zero
);
    // ALU has two operand, it execute different operator based on ALUctl wire 
    // output zero is for determining taking branch or not 

    // TODO: implement your ALU here
    // Hint: you can use operator to implement
    reg carry;

    always @(*) begin
    case(ALUCtl)
        `ADD: {carry,ALUOut} = A+B;
        `SUB: {carry,ALUOut} = A - B; 
        `XOR: begin
             ALUOut = A ^ B;
             zero=A^B;  //XOR and BNE are same.  //Did this so that 4'b0 is free.
        end
        `OR: ALUOut = A | B;
        `AND: ALUOut = A & B;
        `SLL: {carry,ALUOut} = A << B;
        `SRL: ALUOut = A >> B;
        `SRA: ALUOut = $signed (A) >>> B;
        `SLT: ALUOut = ($signed (A) < $signed (B)) ? 1 : 0;
        `SLTU: ALUOut = (A < B) ? 1 : 0;

        `BEQ: zero=(A==B);
        `BLT: zero=($signed (A) < $signed (B));
        `BGE: zero=($signed (A) >= $signed (B));
        `BLTU: zero=(A < B);
        `BGEU: zero=(A >= B);

        default: ALUOut = 32'b0;
    endcase
    end

    
endmodule

