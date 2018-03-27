// (C) 2001-2017 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/17.1std/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2017/07/30 $
// $Author: swbranch $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// either (a) the address or (b) the dest id. The DECODER_TYPE
// parameter controls this behaviour. 0 means address decoder,
// 1 means dest id decoder.
//
// In the case of (a), it also sets the destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

module jaxa_mm_interconnect_0_router_default_decode
  #(
     parameter DEFAULT_CHANNEL = 15,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 26 
   )
  (output [106 - 101 : 0] default_destination_id,
   output [34-1 : 0] default_wr_channel,
   output [34-1 : 0] default_rd_channel,
   output [34-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[106 - 101 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 34'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 34'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 34'b1 << DEFAULT_RD_CHANNEL;
    end
  endgenerate

endmodule


module jaxa_mm_interconnect_0_router
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [131-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [131-1    : 0] src_data,
    output reg [34-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 65;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 106;
    localparam PKT_DEST_ID_L = 101;
    localparam PKT_PROTECTION_H = 121;
    localparam PKT_PROTECTION_L = 119;
    localparam ST_DATA_W = 131;
    localparam ST_CHANNEL_W = 34;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 68;
    localparam PKT_TRANS_READ  = 69;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h10010 - 64'h10000); 
    localparam PAD1 = log2ceil(64'h20010 - 64'h20000); 
    localparam PAD2 = log2ceil(64'h30010 - 64'h30000); 
    localparam PAD3 = log2ceil(64'h40010 - 64'h40000); 
    localparam PAD4 = log2ceil(64'h50010 - 64'h50000); 
    localparam PAD5 = log2ceil(64'h5a010 - 64'h5a000); 
    localparam PAD6 = log2ceil(64'h60010 - 64'h60000); 
    localparam PAD7 = log2ceil(64'h6a010 - 64'h6a000); 
    localparam PAD8 = log2ceil(64'h70010 - 64'h70000); 
    localparam PAD9 = log2ceil(64'h80010 - 64'h80000); 
    localparam PAD10 = log2ceil(64'h90010 - 64'h90000); 
    localparam PAD11 = log2ceil(64'ha0010 - 64'ha0000); 
    localparam PAD12 = log2ceil(64'hb0010 - 64'hb0000); 
    localparam PAD13 = log2ceil(64'hc0010 - 64'hc0000); 
    localparam PAD14 = log2ceil(64'he0010 - 64'he0000); 
    localparam PAD15 = log2ceil(64'hf0010 - 64'hf0000); 
    localparam PAD16 = log2ceil(64'h1000010 - 64'h1000000); 
    localparam PAD17 = log2ceil(64'h1020010 - 64'h1020000); 
    localparam PAD18 = log2ceil(64'h1100010 - 64'h1100000); 
    localparam PAD19 = log2ceil(64'h1200010 - 64'h1200000); 
    localparam PAD20 = log2ceil(64'h1300010 - 64'h1300000); 
    localparam PAD21 = log2ceil(64'h2000010 - 64'h2000000); 
    localparam PAD22 = log2ceil(64'h2200010 - 64'h2200000); 
    localparam PAD23 = log2ceil(64'h2300010 - 64'h2300000); 
    localparam PAD24 = log2ceil(64'h2400010 - 64'h2400000); 
    localparam PAD25 = log2ceil(64'h2500010 - 64'h2500000); 
    localparam PAD26 = log2ceil(64'h3000010 - 64'h3000000); 
    localparam PAD27 = log2ceil(64'h3100010 - 64'h3100000); 
    localparam PAD28 = log2ceil(64'h3200010 - 64'h3200000); 
    localparam PAD29 = log2ceil(64'h3300010 - 64'h3300000); 
    localparam PAD30 = log2ceil(64'h4300010 - 64'h4300000); 
    localparam PAD31 = log2ceil(64'h4400010 - 64'h4400000); 
    localparam PAD32 = log2ceil(64'h10000010 - 64'h10000000); 
    localparam PAD33 = log2ceil(64'h20000010 - 64'h20000000); 
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'h20000010;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;

    localparam RG = RANGE_ADDR_WIDTH-1;
    localparam REAL_ADDRESS_RANGE = OPTIMIZED_ADDR_H - PKT_ADDR_L;

      reg [PKT_ADDR_W-1 : 0] address;
      always @* begin
        address = {PKT_ADDR_W{1'b0}};
        address [REAL_ADDRESS_RANGE:0] = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];
      end   

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;
    wire [PKT_DEST_ID_W-1:0] default_destid;
    wire [34-1 : 0] default_src_channel;




    // -------------------------------------------------------
    // Write and read transaction signals
    // -------------------------------------------------------
    wire read_transaction;
    assign read_transaction  = sink_data[PKT_TRANS_READ];


    jaxa_mm_interconnect_0_router_default_decode the_default_decode(
      .default_destination_id (default_destid),
      .default_wr_channel   (),
      .default_rd_channel   (),
      .default_src_channel  (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;
        src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = default_destid;

        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------

    // ( 0x10000 .. 0x10010 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 30'h10000  && read_transaction  ) begin
            src_channel = 34'b0000000000000000001000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 26;
    end

    // ( 0x20000 .. 0x20010 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 30'h20000  && read_transaction  ) begin
            src_channel = 34'b0000000000000000000100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 24;
    end

    // ( 0x30000 .. 0x30010 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 30'h30000  && read_transaction  ) begin
            src_channel = 34'b0000000000000000000000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
    end

    // ( 0x40000 .. 0x40010 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 30'h40000   ) begin
            src_channel = 34'b0000000000000000000000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0x50000 .. 0x50010 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 30'h50000  && read_transaction  ) begin
            src_channel = 34'b0000000000000000000000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0x5a000 .. 0x5a010 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 30'h5a000  && read_transaction  ) begin
            src_channel = 34'b0000000000000000000000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 30;
    end

    // ( 0x60000 .. 0x60010 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 30'h60000  && read_transaction  ) begin
            src_channel = 34'b0000000000000000000000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

    // ( 0x6a000 .. 0x6a010 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 30'h6a000  && read_transaction  ) begin
            src_channel = 34'b0000000000000000000000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0x70000 .. 0x70010 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 30'h70000   ) begin
            src_channel = 34'b0000000000000000000000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x80000 .. 0x80010 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 30'h80000   ) begin
            src_channel = 34'b0000000000000000000000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

    // ( 0x90000 .. 0x90010 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 30'h90000   ) begin
            src_channel = 34'b0000000000000000000000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0xa0000 .. 0xa0010 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 30'ha0000   ) begin
            src_channel = 34'b0000000000000000000000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 31;
    end

    // ( 0xb0000 .. 0xb0010 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 30'hb0000   ) begin
            src_channel = 34'b0000000000000000000000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 33;
    end

    // ( 0xc0000 .. 0xc0010 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 30'hc0000  && read_transaction  ) begin
            src_channel = 34'b0000000000000000000000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 32;
    end

    // ( 0xe0000 .. 0xe0010 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 30'he0000   ) begin
            src_channel = 34'b0000000000000000000010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 25;
    end

    // ( 0xf0000 .. 0xf0010 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 30'hf0000   ) begin
            src_channel = 34'b0000000000000000000001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 23;
    end

    // ( 0x1000000 .. 0x1000010 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 30'h1000000   ) begin
            src_channel = 34'b0000001000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0x1020000 .. 0x1020010 )
    if ( {address[RG:PAD17],{PAD17{1'b0}}} == 30'h1020000   ) begin
            src_channel = 34'b0000000000000001000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 20;
    end

    // ( 0x1100000 .. 0x1100010 )
    if ( {address[RG:PAD18],{PAD18{1'b0}}} == 30'h1100000   ) begin
            src_channel = 34'b0000000001000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 18;
    end

    // ( 0x1200000 .. 0x1200010 )
    if ( {address[RG:PAD19],{PAD19{1'b0}}} == 30'h1200000  && read_transaction  ) begin
            src_channel = 34'b0000000000000010000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0x1300000 .. 0x1300010 )
    if ( {address[RG:PAD20],{PAD20{1'b0}}} == 30'h1300000  && read_transaction  ) begin
            src_channel = 34'b0000000010000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 19;
    end

    // ( 0x2000000 .. 0x2000010 )
    if ( {address[RG:PAD21],{PAD21{1'b0}}} == 30'h2000000  && read_transaction  ) begin
            src_channel = 34'b0000000100000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
    end

    // ( 0x2200000 .. 0x2200010 )
    if ( {address[RG:PAD22],{PAD22{1'b0}}} == 30'h2200000  && read_transaction  ) begin
            src_channel = 34'b0000000000000100000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x2300000 .. 0x2300010 )
    if ( {address[RG:PAD23],{PAD23{1'b0}}} == 30'h2300000   ) begin
            src_channel = 34'b0000000000001000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 28;
    end

    // ( 0x2400000 .. 0x2400010 )
    if ( {address[RG:PAD24],{PAD24{1'b0}}} == 30'h2400000   ) begin
            src_channel = 34'b0000000000010000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 29;
    end

    // ( 0x2500000 .. 0x2500010 )
    if ( {address[RG:PAD25],{PAD25{1'b0}}} == 30'h2500000  && read_transaction  ) begin
            src_channel = 34'b0000000000100000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 27;
    end

    // ( 0x3000000 .. 0x3000010 )
    if ( {address[RG:PAD26],{PAD26{1'b0}}} == 30'h3000000   ) begin
            src_channel = 34'b1000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0x3100000 .. 0x3100010 )
    if ( {address[RG:PAD27],{PAD27{1'b0}}} == 30'h3100000  && read_transaction  ) begin
            src_channel = 34'b0100000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0x3200000 .. 0x3200010 )
    if ( {address[RG:PAD28],{PAD28{1'b0}}} == 30'h3200000  && read_transaction  ) begin
            src_channel = 34'b0010000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x3300000 .. 0x3300010 )
    if ( {address[RG:PAD29],{PAD29{1'b0}}} == 30'h3300000  && read_transaction  ) begin
            src_channel = 34'b0001000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x4300000 .. 0x4300010 )
    if ( {address[RG:PAD30],{PAD30{1'b0}}} == 30'h4300000  && read_transaction  ) begin
            src_channel = 34'b0000100000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x4400000 .. 0x4400010 )
    if ( {address[RG:PAD31],{PAD31{1'b0}}} == 30'h4400000   ) begin
            src_channel = 34'b0000010000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0x10000000 .. 0x10000010 )
    if ( {address[RG:PAD32],{PAD32{1'b0}}} == 30'h10000000  && read_transaction  ) begin
            src_channel = 34'b0000000000000000010000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 21;
    end

    // ( 0x20000000 .. 0x20000010 )
    if ( {address[RG:PAD33],{PAD33{1'b0}}} == 30'h20000000   ) begin
            src_channel = 34'b0000000000000000100000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 22;
    end

end


    // --------------------------------------------------
    // Ceil(log2()) function
    // --------------------------------------------------
    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


