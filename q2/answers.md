# Write down the values of all the control signals for beq, sw  and lw instructions. Use “x” for don’t care.


a)
I have defined ALUOp as such
2'b00 : ALU does nothing
2'b01: For R-TYPE instructions
2'b10: For I-Type instructions (immediate and load instructions)
2'b11: Branch type instructions

BEQ:
Branch = 1;
memRead = 0;
MemtoReg = 0;
ALUOp = 2'b11;
memWrite = 0;
ALUSrc = 0;
regWrite = 0;

SW:
branch = 0;
memRead = 0;
memtoReg = 0;
ALUOp = 2'b00;
memWrite = 1;
ALUSrc = 1;
regWrite = 0;

LW:
branch = 0;
memRead = 1;
memtoReg = 0;
ALUOp = 2'b10;
memWrite = 0;
ALUSrc = 1;
regWrite = 1;


b) Final value =0
x1 starts at 8, x2 starts at 2
The first line puts x2=1 as long as x1!=0
3rd line reduces x1 by 1 every cycle
So after 8 cycles, x1 becomes 0
Then x2 becomes 0
2nd line branches the final result to done

So finally x2 has value of 2


c)
rs1 is anyways an output wire. So no extra control signals are required.


