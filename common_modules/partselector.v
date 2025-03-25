module partselector(
    input trueop,
    input [2:0] funct3, // Still 3 bits
    input [31:0] datatowrite,
    output reg [31:0] part
);

always @(*) begin
    if (trueop) begin
        case (funct3)
            3'h0: part = {{24{datatowrite[7]}}, datatowrite[7:0]}; // Byte (sign-extended)
            3'h1: part = {{16{datatowrite[15]}}, datatowrite[15:0]}; // Halfword (sign-extended)
            3'h2: part = datatowrite; // Word
            3'h4: part = {24'b0, datatowrite[7:0]}; // Byte unsigned (zero-extended)
            3'h5: part = {16'b0, datatowrite[15:0]}; // Halfword unsigned (zero-extended)
            default: part = datatowrite; // Default case
        endcase
    end else begin
        part = datatowrite; // Need not give any value if trueop is false, but let's see.
    end
end

endmodule
