/// use this module to create a RAM with AXI-Stream interface
/// you are allowed to change the input interface to axi-lite if you want


module axi_ram (

    input aclk,
    input aresetn,

    // AXI-Stream Slave

    input [31:0]s_axis_tdata,
    input s_axis_tvalid,
    output reg s_axis_tready

    // AXI-Stream Master 

    // output reg [31:0]m_axis_tdata,
    // output reg m_axis_tvalid,
    // input m_axis_tready
    
);

reg [7:0] mem [0:288];
reg [7:0] number;
reg [7:0] count;
reg [2:0] count_bin;
reg [8:0] data_bin;  

wire ready;

assign ready = (count <= 8'h20);

integer i;

always @(posedge aclk) begin
    if(!aresetn) begin
        for(i=0;i<288;i=i+1) begin
            mem[i] <= 0;
        end
        number <= 0;
        count <= 0;
        count_bin <= 0;
        data_bin <= 0;
        s_axis_tready <= 1'b1;
    end
    if(!ready) s_axis_tready <=1'b0;


    
    if (s_axis_tvalid && s_axis_tready) begin
        {number, count, count_bin, data_bin} <= s_axis_tdata[27:0];
        mem[count_bin<<2] <= count;
        mem[data_bin] <= number;
    end
end

// Do the master implementation


endmodule