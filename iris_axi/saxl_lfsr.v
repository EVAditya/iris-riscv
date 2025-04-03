//////////////////////////////////////////////////////////////////////////////////
////      Edit to create a 8bit LFSR module with AXI-Lite interface          /////
/////      for register configuration and AX-Stream for lfsr output          /////
//////////////////////////////////////////////////////////////////////////////////


module s_axil #(
    parameter C_AXIL_ADDR_WIDTH = 4,
    parameter C_AXIL_DATA_WIDTH = 32
)(
    input aclk,
    input aresetn,

    // AXI-Lite Slave Interface
    input  [C_AXIL_ADDR_WIDTH-1:0] s_axi_awaddr,
    input                       s_axi_awvalid,
    output reg                  s_axi_awready,

    input  [C_AXIL_DATA_WIDTH-1:0] s_axi_wdata,
    input                       s_axi_wvalid,
    output reg                  s_axi_wready,

    output reg [1:0]            s_axi_bresp,
    output reg                  s_axi_bvalid,
    input                       s_axi_bready,

    input   [C_AXIL_ADDR_WIDTH-1:0] s_axi_araddr, 
    input                       s_axi_arvalid,
    output reg                  s_axi_arready,

    output reg [C_AXIL_DATA_WIDTH-1:0] s_axi_rdata,
    output reg [1:0]            s_axi_rresp,
    output reg                  s_axi_rvalid,
    input                       s_axi_rready,

    // AXI - Stream Master Interface
    output reg [C_AXIL_DATA_WIDTH-1:0] m_axis_tdata,
    output reg                    m_axis_tvalid,
    input                         m_axis_tready
);


    //Address map for these registers

    // 0x00 - start_reg
    // 0x04 - stop_reg
    // 0x08 - seed_reg
    // 0x0C - taps_reg

    // Registers
    reg start_reg;
    reg stop_reg;
    reg [7:0] seed_reg;
    reg [7:0] taps_reg;

    wire [7:0] lfsr_out;

    reg awhandshake;
    reg [C_AXIL_ADDR_WIDTH-1:0] awreg;

    always @(posedge aclk) begin
        if (!aresetn) begin
            s_axi_awready <= 1'b0;
            s_axi_wready <= 1'b0;
            s_axi_bvalid <= 1'b0;

            start_reg <= 1'b0;
            stop_reg <= 1'b0;
            seed_reg <= 8'h00;
            taps_reg <= 8'h00;

            awhandshake <= 1'b0;
            awreg <= 4'h0;
        end else begin  //this circuit is completed in 1 cycle always. So slave is always ready. otherwise  WREADY <= slave_is_ready; 
            s_axi_arready <= 1'b1;
            s_axi_awready <= 1'b1;
            s_axi_wready <= 1'b1;
        end
            

        if(s_axi_wvalid && s_axi_wready) begin  
            if (awhandshake) begin  //If aw handshake happened before
                case (awreg)
                    4'h0: start_reg <= s_axi_wdata[0];
                    4'h4: stop_reg <= s_axi_wdata[0];
                    4'h8: seed_reg <= s_axi_wdata[7:0];
                    4'hC: taps_reg <= s_axi_wdata[7:0];
                endcase
                awhandshake <= 1'b0;
                s_axi_bvalid <= 1'b1;  
                case(awreg)
                    4'h0, 4'h4, 4'h8, 4'hC: s_axi_bresp <= 2'b00; //OKAY
                    default: s_axi_bresp <= 2'b11; //SLVERR
                endcase          
            end
            else if(s_axi_awvalid && s_axi_awready) begin  //If aw handshake didn't happen
                case (s_axi_awaddr)
                    4'h0: start_reg <= s_axi_wdata[0];
                    4'h4: stop_reg <= s_axi_wdata[0];
                    4'h8: seed_reg <= s_axi_wdata[7:0];
                    4'hC: taps_reg <= s_axi_wdata[7:0];
                endcase
                awhandshake <= 1'b0;
                s_axi_bvalid <= 1'b1;
                case(s_axi_awaddr)
                    4'h0, 4'h4, 4'h8, 4'hC: s_axi_bresp <= 2'b00; //OKAY
                    default: s_axi_bresp <= 2'b11; //SLVERR
                endcase
            end
        end else if(s_axi_awvalid && s_axi_awready) begin //If aw handshake happened but data didn't come yet
            awhandshake <= 1'b1;
            awreg <= s_axi_awaddr;
        end
        if(s_axi_bvalid && s_axi_bready) begin
                s_axi_bvalid <= 1'b0;    
        end
    end

    always @(posedge aclk) begin
        if(!aresetn) begin
            s_axi_rvalid <= 1'b0;
            s_axi_rresp <= 2'b00;
            s_axi_rdata <= 32'b0;
            s_axi_arready <= 1'b0;
        end else begin
            s_axi_arready <= 1'b1;
        end
        if(s_axi_arvalid && s_axi_arready) begin
            s_axi_rdata <= {24'b0,lfsr_out};  //Only 1 output, so araddr is not required
            s_axi_rvalid <= 1'b1;
        end
        if(s_axi_rvalid && s_axi_rready) begin
            s_axi_rresp <= 2'b00; //OKAY
            s_axi_rvalid <= 1'b0; 
        end
    end
    
    
    always @(posedge aclk) begin
        if(!aresetn) begin
        // m_axis_tvalid <= 1'b0;
        m_axis_tdata <= 32'b0;
        end
        if(start_reg & ~stop_reg ) m_axis_tvalid <= 1'b1;
        else m_axis_tvalid <= 1'b0;
        if(m_axis_tready && m_axis_tvalid) begin
            m_axis_tdata <= {24'b0,lfsr_out};
        end 
     end
    



    LFSR m_lfsr(
        .clk(aclk),
        .reset(aresetn),
        .start(start_reg),
        .stop(stop_reg),
        .seed(seed_reg),
        .taps(taps_reg),
        .lfsr_out(lfsr_out)
    );


endmodule