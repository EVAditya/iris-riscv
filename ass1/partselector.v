module partselector(
    input trueop,
    input [7:0]funct3,
    input [31:0] datatowrite,
    output reg [31:0] part
);

always @(*) begin
    if(trueop) begin
        case(funct3)
            8'h0: part = {24*{datatowrite[7]},datatowrite[7:0]}; //byte
            8'h1 : part = {16*{datatowrite[15]},datatowrite[15:0]}; //half
            8'h2 : part = datatowrite; //word
            8'h4 : part = {24'b0,datatowrite[7:0]}; //byte unsigned
            8'h5 : part = {16'b0,datatowrite[15:0]}; //half unsigned
            default : part = datatowrite;
        endcase
    end
end
endmodule
