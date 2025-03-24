`include "ass1/parameters.v"

module ImmGen#(parameter Width = 32) (
    input [Width-1:0] inst,
    output reg signed [Width-1:0] imm
);
    // ImmGen generate imm value based on opcode

    wire [6:0] opcode = inst[6:0];
    always @(*) 
    begin
        case(opcode)
            
            // TODO: implement your ImmGen here
            // Hint: follow the RV32I opcode map table to set imm value
            //Done
            `ITYPE: imm=inst[31:20];
            `I2TYPE: imm=inst[31:20];
            `STYPE: imm={{20{inst[31]}},inst[31:25],inst[11:7]};
            `BTYPE: imm={{19{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8],1'b0};
            `JAL: imm={{11{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0};
            `JALR: imm=inst[31:20];
            `AUIPC: imm={inst[31:12], 12'b0};
            `LUI: imm={inst[31:12], 12'b0};

            
            default: imm=0;
	endcase
    end
            
endmodule

