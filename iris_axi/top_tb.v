`timescale 1ns/1ns

module top_tb;

    parameter C_AXIL_ADDR_WIDTH = 4;
    parameter C_AXIL_DATA_WIDTH = 32;

    reg aclk;
    reg aresetn;

    // AXI-Lite Slave Interface
    reg  [C_AXIL_ADDR_WIDTH-1:0] s_axi_awaddr;
    reg                       s_axi_awvalid;

    reg  [C_AXIL_DATA_WIDTH-1:0] s_axi_wdata;
    reg                       s_axi_wvalid;


    reg                       s_axi_bready;

    reg   [C_AXIL_ADDR_WIDTH-1:0] s_axi_araddr; 
    reg                       s_axi_arvalid; 
    reg                       s_axi_rready; 
    reg                       s_axi_rvalid; 

    top m_top(
        .aclk(aclk),
        .aresetn(aresetn),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_rready(s_axi_rready)
    );
    
    initial begin aclk = 0;
    forever #5 aclk = ~aclk;
    end



    initial begin
    $dumpfile("top_tb.vcd");
    $dumpvars(0, top_tb);
    // $monitor("%h, %h, %h, %h, %h, %h, %h, %h",
    //     m_top.m_ram.mem[0],
    //     m_top.m_ram.mem[4],
    //     m_top.m_ram.mem[8],
    //     m_top.m_ram.mem[12],
    //     m_top.m_ram.mem[16],
    //     m_top.m_ram.mem[20],
    //     m_top.m_ram.mem[24],
    //     m_top.m_ram.mem[28]
    // );



    // 0x00 - start_reg
    // 0x04 - stop_reg
    // 0x08 - seed_reg
    // 0x0C - taps_reg


    $monitor("time %5d no %h %d, %d, %d, %d, %d, %d, %d, %d",
        $time,
                m_top.m_ram.number,
        m_top.m_hist.bin[0],
        m_top.m_hist.bin[1],
        m_top.m_hist.bin[2],
        m_top.m_hist.bin[3],
        m_top.m_hist.bin[4],
        m_top.m_hist.bin[5],
        m_top.m_hist.bin[6],
        m_top.m_hist.bin[7]
    );

    //     $monitor(" %h  ",
    //     m_top.m_ram.number
    // );


    aresetn <= 0;
    #10 aresetn <=1;
    s_axi_awaddr <= 0;
    s_axi_awvalid <= 0;
    s_axi_wdata <= 0;
    s_axi_wvalid <= 0;
    s_axi_araddr <= 0; 
    s_axi_arvalid <= 0;
    s_axi_araddr <= 0; 
    s_axi_arvalid <= 0;

    s_axi_rready <= 1;

    s_axi_bready <= 1;

    #10  s_axi_awaddr <= 32'h08;
    s_axi_awvalid <= 1;

    s_axi_wdata <= 32'h1D;
    s_axi_wvalid <= 1;

     #10  s_axi_awaddr <= 32'h0C;
    s_axi_awvalid <= 1;

    s_axi_wdata <= 32'h1D;
    s_axi_wvalid <= 1;

    #10  s_axi_awaddr <= 32'h04;
    s_axi_awvalid <= 1;

    s_axi_wdata <= 32'h01;
    s_axi_wvalid <= 1;



    #10  s_axi_awaddr <= 32'h00;
    s_axi_awvalid <= 1;

    s_axi_wdata <= 32'h01;
    s_axi_wvalid <= 1;

    #10  s_axi_awaddr <= 32'h04;
    s_axi_awvalid <= 1;

    s_axi_wdata <= 32'h00;
    s_axi_wvalid <= 1;

    #10 s_axi_araddr <= 32'h00;
    s_axi_arvalid <= 1;
    s_axi_rready <= 1;
    

    
    #3000 $finish;

    end
    
endmodule 


    // initial begin
    //     $dumpfile("top_tb.vcd");
    //     $dumpvars(0, top_tb);
    //     $monitor("%h, %h, %h, %h, %h, %h, %h, %h",
    //         m_top.m_ram.mem[0],
    //         m_top.m_ram.mem[1],
    //         m_top.m_ram.mem[2],
    //         m_top.m_ram.mem[3],
    //         m_top.m_ram.mem[4],
    //         m_top.m_ram.mem[5],
    //         m_top.m_ram.mem[6],
    //         m_top.m_ram.mem[7]
    //     );
    //     aclk = 0;
    //     aresetn = 0;
    //     s_axi_awaddr = 0;
    //     s_axi_awvalid = 0;
    //     s_axi_wdata = 0;
    //     s_axi_wvalid = 0;
    //     s_axi_bready = 0;
    //     s_axi_araddr = 0;
    //     s_axi_arvalid = 0;
    //     s_axi_rready = 0;

    //     #50 aresetn = 1;

    //     // Test the AXI-Lite interface

    //     #50 s_axi_awaddr <= 4'h8; // Address of seed_reg
    //     s_axi_awvalid <= 1'b1;
    //     s_axi_wdata <= 32'h69; // Write value to seed_reg
    //     s_axi_wvalid <= 1'b1;
    //     #50 s_axi_wvalid <= 1'b0;
    //      s_axi_awvalid <= 1'b0;



    //     #50 s_axi_awaddr = 4'hC; // Address of taps_reg
    //     s_axi_awvalid = 1'b1;
    //     s_axi_wdata = 32'h11D; // Write value to taps_reg
    //     s_axi_wvalid = 1'b1;
    //     #50 s_axi_wvalid = 1'b0;
    //     #50 s_axi_awvalid = 1'b0;
    //     #50 s_axi_bready = 1'b1; // Read response
    //         #50 s_axi_bready = 1'b0;

    //     #50 s_axi_awaddr = 4'h0; // Address of start_reg
    //         s_axi_awvalid = 1'b1;
    //         #50 s_axi_awvalid = 1'b0;

    //     #50 s_axi_wdata = 32'h00000001; // Write value to start_reg
    //         s_axi_wvalid = 1'b1;
    //         #50 s_axi_wvalid = 1'b0;

    //     #50 s_axi_bready = 1'b1; // Read response
    //         #50 s_axi_bready = 1'b0;

    // end

