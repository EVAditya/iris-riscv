// LFSR is a sequential circuit used to generate Pseudo- Random numbers. 
// Build an 8 bit LFSR with separate registers for start, stop , seed and
//  taps, interfaced with AXI-Lite slave (check files for more details).


module LFSR(
    input clk,
    input reset,
    input start,
    input stop,
    input [7:0] seed,
    input [1:8] taps,
    output wire [7:0] lfsr_out

);

    reg [1:8] regs;
    wire feedback;
    wire [1:8] a;
    assign a = regs & taps;
    assign feedback = ^a; 
    assign lfsr_out = regs;

    always @(posedge clk) begin
        if(!reset) begin
            regs <= seed;
        end
        else if(stop) begin
            regs <= seed;
        end
        else if(start && !stop) begin
            regs <= {feedback,regs[1:7]};
        end
    end

endmodule