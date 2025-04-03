module top #(
    parameter C_AXIL_ADDR_WIDTH = 4,
    parameter C_AXIL_DATA_WIDTH = 32
)(
    input aclk,
    input aresetn,

    // AXI-Lite Slave Interface
    input  [C_AXIL_ADDR_WIDTH-1:0] s_axi_awaddr,
    input                       s_axi_awvalid,

    input  [C_AXIL_DATA_WIDTH-1:0] s_axi_wdata,
    input                       s_axi_wvalid,


    input                       s_axi_bready,

    input   [C_AXIL_ADDR_WIDTH-1:0] s_axi_araddr, 
    input                       s_axi_arvalid,


    input                       s_axi_rready
    
);

    wire                  s_axi_awready;
    wire                  s_axi_wready;
    wire [1:0]            s_axi_bresp;
    wire                  s_axi_bvalid;
    wire                  s_axi_arready;
    wire [C_AXIL_DATA_WIDTH-1:0] s_axi_rdata;
    wire [1:0]            s_axi_rresp;
    wire                  s_axi_rvalid;

    wire [C_AXIL_DATA_WIDTH-1:0] tdata1, tdata2;
    wire                    tvalid1,tvalid2;
    wire                     tready1, tready2;




s_axil m_lfsr(
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

    .m_axis_tdata(tdata1),
    .m_axis_tvalid(tvalid1),
    .m_axis_tready(tready1)
);
s_m_hist m_hist(
    .aclk(aclk),
    .aresetn(aresetn),
    .s_axis_tdata(tdata1),
    .s_axis_tvalid(tvalid1),
    .s_axis_tready(tready1),
    .m_axis_tdata(tdata2),
    .m_axis_tvalid(tvalid2),
    .m_axis_tready(tready2)
);

axi_ram m_ram(
    .aclk(aclk),
    .aresetn(aresetn),
    .s_axis_tdata(tdata2),
    .s_axis_tvalid(tvalid2),
    .s_axis_tready(tready2)
);
endmodule