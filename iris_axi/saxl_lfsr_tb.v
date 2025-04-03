module saxl_lfsr_tb;

reg aclk;
reg aresetn;

// reg s_axi_awaddr;
// reg s_axi_awvalid;

// reg s_axi_wdata;
// reg s_axi_wvalid;

// reg s_axi_bready;

// reg [31:0] s_axi_araddr;
// reg s_axi_arvalid;

// output reg [C_AXIL_DATA_WIDTH-1:0] s_axi_rdata;
// wire [1:0]            s_axi_rresp;
// output reg                  s_axi_rvalid;
// input                       s_axi_rready;

// // AXI - Stream Master Interface
// output reg [C_AXIL_DATA_WIDTH-1:0] m_axis_tdata;
// output reg                    m_axis_tvalid;
// input                         m_axis_tready

    reg  [31:0] s_axi_awaddr;
    reg                       s_axi_awvalid;
    wire                  s_axi_awready;

    reg  [31:0] s_axi_wdata;
    reg                       s_axi_wvalid;
    wire                  s_axi_wready;

    wire [1:0]            s_axi_bresp;
    wire                  s_axi_bvalid;
    reg                       s_axi_bready;

    reg   [31:0] s_axi_araddr; 
    reg                       s_axi_arvalid;
    wire                  s_axi_arready;

    wire [31:0] s_axi_rdata;
    wire [1:0]            s_axi_rresp;
    wire                  s_axi_rvalid;
    reg                       s_axi_rready;

    // AXI - Stream Master Interface
    wire [31:0] m_axis_tdata;
    wire                    m_axis_tvalid;
    reg                         m_axis_tready;

    s_axil uut(
        .aclk(aclk),
        .aresetn(aresetn),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_awready(s_axi_awready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axi_wready(s_axi_wready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_arready(s_axi_arready),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_rready(s_axi_rready),

        .m_axis_tdata(m_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tready(m_axis_tready)
    );

    initial begin
        aclk <= 0;
        forever #5 aclk <= ~aclk;
    end

    initial begin

    $monitor("start %h stop %h seed %h taps %h lfsr_out %h", uut.start_reg, uut.stop_reg, uut.seed_reg, uut.taps_reg, uut.lfsr_out);
    aresetn <= 0;
    #10 aresetn <=1;
    s_axi_awaddr <= 0;
    s_axi_awvalid <= 0;
    s_axi_wdata <= 0;
    s_axi_wvalid <= 0;
    s_axi_bready <= 0;
    s_axi_araddr <= 0; 
    s_axi_arvalid <= 0;
    s_axi_rready <= 0;
    s_axi_araddr <= 0; 
    s_axi_arvalid <= 0;

    s_axi_rready <= 0;

    m_axis_tready <= 1;
    s_axi_bready <= 1;

    #10  s_axi_awaddr <= 32'h08;
    s_axi_awvalid <= 1;

    s_axi_wdata <= 32'h11D;
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
    

    #10000 $finish;

    end

endmodule


