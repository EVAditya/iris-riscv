module lfsr_tb;

reg clk;
reg reset;
reg start;
reg stop;
reg [7:0] seed;
reg [7:0] taps;
wire [7:0] lfsr_out;
reg [7:0] expected_lfsr_out;


LFSR uut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .stop(stop),
    .seed(seed),
    .taps(taps),
    .lfsr_out(lfsr_out)
);
initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk; // Clock period of 10 time units
end

initial begin
    

    reset = 0; start = 0; seed = 8'b10101010; taps = 8'h11D;
    #20 reset = 1; start = 1; stop = 0; // Start LFSR




    #200 $finish;
end

endmodule