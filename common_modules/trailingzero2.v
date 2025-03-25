module trailing2(
    input [31:0] data,
    output [4:0] wonderdrug
)
assign wonderdrug =  (data==32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx1) ? 5'b00000 :
                     (data==32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx10) ? 5'b00001 :
                     (data==32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxx100) ? 5'b00010 :
                     (data==32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxx1000) ? 5'b00011 :
                     (data==32'bxxxxxxxxxxxxxxxxxxxxxxxxxxx10000) ? 5'b00100 :
                     (data==32'bxxxxxxxxxxxxxxxxxxxxxxxxxx100000) ? 5'b00101 :
                     (data==32'bxxxxxxxxxxxxxxxxxxxxxxxxx1000000) ? 5'b00110 :
                     (data==32'bxxxxxxxxxxxxxxxxxxxxxxxx10000000) ? 5'b00111 :
                     (data==32'bxxxxxxxxxxxxxxxxxxxxxxx100000000) ? 5'b01000 :
                     (data==32'bxxxxxxxxxxxxxxxxxxxxxx1000000000) ? 5'b01001 :
                     (data==32'bxxxxxxxxxxxxxxxxxxxxx10000000000) ? 5'b01010 :
                     (data==32'bxxxxxxxxxxxxxxxxxxxx100000000000) ? 5'b01011 :
                     (data==32'bxxxxxxxxxxxxxxxxxxx1000000000000) ? 5'b01100 :
                     (data==32'bxxxxxxxxxxxxxxxxxx10000000000000) ? 5'b01101 :
                     (data==32'bxxxxxxxxxxxxxxxxx100000000000000) ? 5'b01110 :
                     (data==32'bxxxxxxxxxxxxxxxx1000000000000000) ? 5'b01111 :
                     (data==32'bxxxxxxxxxxxxxxx10000000000000000) ? 5'b10000 :
                     (data==32'bxxxxxxxxxxxxxx100000000000000000) ? 5'b10001 :
                     (data==32'bxxxxxxxxxxxxx1000000000000000000) ? 5'b10010 :
                     (data==32'bxxxxxxxxxxxx10000000000000000000) ? 5'b10011 :
                     (data==32'bxxxxxxxxxxx100000000000000000000) ? 5'b10100 :
                     (data==32'bxxxxxxxxxx1000000000000000000000) ? 5'b10101 :
                     (data==32'bxxxxxxxxx10000000000000000000000) ? 5'b10110 :
                     (data==32'bxxxxxxxx100000000000000000000000) ? 5'b10111 :
                     (data==32'bxxxxxxx1000000000000000000000000) ? 5'b11000 :
                     (data==32'bxxxxxx10000000000000000000000000) ? 5'b11001 :
                     (data==32'bxxxxx100000000000000000000000000) ? 5'b11010 :
                     (data==32'bxxxx1000000000000000000000000000) ? 5'b11011 :
                     (data==32'bxxx10000000000000000000000000000) ? 5'b11100 :
                     (data==32'bxx100000000000000000000000000000) ? 5'b11101 :
                     (data==32'bx1000000000000000000000000000000) ? 5'b11110 :
                     (data==32'b10000000000000000000000000000000) ? 5'b11111 :
                     5'b00000;
                     
endmodule