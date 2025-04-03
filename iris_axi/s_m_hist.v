//////////////////////////////////////////////////////////////////////////////////////////////////
////      Edit to create a block to create a data processing block, which takes in data //////////
/// from the lfsr through a AXI-Stream slave interface, and categorises them into bins  //////////
/////      The output data includes the  count value of numbers in each bin and data    //////////
////     + address in ram , which the data is supposed to be written to as provided in  //////////
////                            the address map below                                   //////////
////     The output data is to sent out through a AXI-Stream master/AXI-Lite interface.    ///////
//////////////////////////////////////////////////////////////////////////////////////////////////


//  -------------------------------------------------
//  | Bin Number |    Range of Values               |
//  -------------------------------------------------
//  | Bin 0      |        1   -  32                 |
//  | Bin 1      |       33   -  64                 |
//  | Bin 2      |       65   -  96                 |
//  | Bin 3      |       97   - 128                 |
//  | Bin 4      |      129   - 160                 |
//  | Bin 5      |      161   - 192                 |
//  | Bin 6      |      193   - 224                 |
//  | Bin 7      |      225   - 255                 |
//  -------------------------------------------------


// assume the ram to be 0x120 x 8 bit 

// ----------------------------------------------------------------------------------------
// | Address Range     | Register / Memory     | Description                              |
// ----------------------------------------------------------------------------------------
// | 0x00              | Bin 0 Count           | Count for values in range 1-32           |
// | 0x04              | Bin 1 Count           | Count for values in range 33-64          |
// | 0x08              | Bin 2 Count           | Count for values in range 65-96          |
// | 0x0C              | Bin 3 Count           | Count for values in range 97-128         |
// | 0x10              | Bin 4 Count           | Count for values in range 129-160        |
// | 0x14              | Bin 5 Count           | Count for values in range 161-192        |
// | 0x18              | Bin 6 Count           | Count for values in range 193-224        |
// | 0x1C              | Bin 7 Count           | Count for values in range 225-255        |
// ----------------------------------------------------------------------------------------
// | 0x20 - 0x3F       | Bin 0 Data Storage    | Stores values belonging to Bin 0         |
// | 0x40 - 0x5F       | Bin 1 Data Storage    | Stores values belonging to Bin 1         |
// | 0x60 - 0x7F       | Bin 2 Data Storage    | Stores values belonging to Bin 2         |
// | 0x80 - 0x9F       | Bin 3 Data Storage    | Stores values belonging to Bin 3         |
// | 0xA0 - 0xBF       | Bin 4 Data Storage    | Stores values belonging to Bin 4         |
// | 0xC0 - 0xDF       | Bin 5 Data Storage    | Stores values belonging to Bin 5         |
// | 0xE0 - 0xFF       | Bin 6 Data Storage    | Stores values belonging to Bin 6         |
// | 0x100 - 0x11F     | Bin 7 Data Storage    | Stores values belonging to Bin 7         |
// ----------------------------------------------------------------------------------------





module s_m_hist (

    input aclk,
    input aresetn,

    // AXI-Stream Slave

    input [31:0]s_axis_tdata,
    input s_axis_tvalid,
    output reg s_axis_tready,

    // AXI-Stream Master 

    output reg [31:0]m_axis_tdata,
    output reg m_axis_tvalid,
    input m_axis_tready
    
);
    //HIST
    reg [7:0] count;
    reg [2:0] count_bin; // Bin index (0-7)
    reg [8:0] data_bin;   // Bin value + base address

    //Slave side
    reg [7:0] number; // Changed to 8-bit input

    //Slave side
    always @(posedge aclk) begin
        if (!aresetn) begin
            s_axis_tready <= m_axis_tready;
            count <= 8'b0;
            count_bin <= 3'b0;
            data_bin <= 9'b0;

        end else s_axis_tready <= m_axis_tready;
        
        if (s_axis_tvalid && s_axis_tready) begin
            number <= s_axis_tdata[7:0]; // Assuming the data is in the lower 8 bits
        end
    end
    


        
//Master side
    always @(posedge aclk) begin
        if(!aresetn) begin
            m_axis_tvalid <= 1'b0;
            m_axis_tdata <= 32'b0;
        end 
        if(s_axis_tvalid) m_axis_tvalid <= 1'b1;
        if (m_axis_tready && m_axis_tvalid) begin
            m_axis_tdata <= {4'b0, number, count, count_bin, data_bin}; // Send count and bin index
        end
    end


reg [7:0] bin [0:7];
    integer i;

    always @(posedge aclk or posedge aresetn) begin
        if (!aresetn) begin
            for ( i = 0; i < 8; i = i + 1) begin
                bin[i] <= 8'b0;
            end
            count <= 8'b0;
            count_bin <= 3'b0;
            data_bin <= 9'b0;
        end
        else if(m_axis_tready) begin
            if (number>=1 && number <= 32) begin
                bin[0] <= bin[0] + 1;
                count <= bin[0] + 1;
                count_bin <= 3'b000;
                data_bin <= 9'h020 + bin[0]; // Base address 0x20 + count
            end
            else if (number >=33 && number <= 64) begin
                bin[1] <= bin[1] + 1;
                count <= bin[1] + 1;
                count_bin <= 3'b001;
                data_bin <= 9'h040 + bin[1]; // Base address 0x40 + count
            end
            else if (number >= 65 && number <= 96) begin
                bin[2] <= bin[2] + 1;
                count <= bin[2] + 1;
                count_bin <= 3'b010;
                data_bin <= 9'h060 + bin[2];
            end
            else if (number >= 97 && number <= 128) begin
                bin[3] <= bin[3] + 1;
                count <= bin[3] + 1;
                count_bin <= 3'b011;
                data_bin <= 9'h080 + bin[3];
            end
            else if (number >= 129 && number <= 160) begin
                bin[4] <= bin[4] + 1;
                count <= bin[4] + 1;
                count_bin <= 3'b100;
                data_bin <= 9'h0A0 + bin[4];
            end
            else if (number >= 161 && number <= 192) begin
                bin[5] <= bin[5] + 1;
                count <= bin[5] + 1;
                count_bin <= 3'b101;
                data_bin <= 9'h0C0 + bin[5];
            end
            else if (number >= 193 && number <= 224) begin
                bin[6] <= bin[6] + 1;
                count <= bin[6] + 1;
                count_bin <= 3'b110;
                data_bin <= 9'h0E0 + bin[6];
            end
            else if (number==255 && number == 255) begin
                bin[7] <= bin[7] + 1;
                count <= bin[7] + 1;
                count_bin <= 3'b111;
                data_bin <= 9'h100 + bin[7]; // Base address 0x100 + count
            end
            else if(number == 0) begin end
        end
    end

endmodule