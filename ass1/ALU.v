module ALU (
    input [3:0] ALUCtl,
    input [31:0] A,B,
    output reg [31:0] ALUOut,
    output zero
);
    // ALU has two operand, it execute different operator based on ALUctl wire 
    // output zero is for determining taking branch or not 

    // TODO: implement your ALU here
    // Hint: you can use operator to implement
    wire carry;
    wire [32:0] sum;
    assign sum = A + B;
    always @(*) begin
    case(ALUCtl)
        ADD: {carry,ALUOut} = sum;
        SUB: {carry,ALUOut} = A - B;
        XOR: ALUOut = A ^ B;
        OR: ALUOut = A | B;
        AND: ALUOut = A & B;
        SLL: {carry,ALUOut} = A << B;
        SRL: ALUOut = A >> B;
        SRA: ALUOut = $signed (A) >>> B;
        SLT: ALUOut = ($signed (A) < $signed (B)) ? 1 : 0;
        SLTU: ALUOut = (A < B) ? 1 : 0;

        LB: ALUOut = sum;//not implemented
        LH: ALUOut = sum;//not implemented
        LW: ALUOut = sum;
        LBU: ALUOut = sum; //not implemented
        LHU: ALUOut = sum; //not implemented

        


        // ADDI: {carry,ALUOut} = A + B;
        // XORI: ALUOut = A ^ B;
        // ORI: ALUOut = A | B;
        // ANDI: ALUOut = A & B;
        // SLLI: ALUOut = A << B;
        // SRLI: ALUOut = A >> B;
        // SRAI: ALUOut = $signed (A) >>> B;
        // SLTI: ALUOut = ($signed (A) < $signed (B)) ? 1 : 0;
        // SLTIU: ALUOut = (A < B) ? 1 : 0;

        default: ALUOut = 32'b0;
    endcase
    end

    assign zero =(ALUCtl==ADD|SUB|ADDI) ? (carry^ALUOut[31]):0;
    
endmodule

