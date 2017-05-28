// (C) 2001-2017 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel MegaCore Function License Agreement, or other applicable 
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


// $Id: //acds/rel/17.0std/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2017/01/22 $
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

module spw_ulight_nofifo_mm_interconnect_0_router_default_decode
  #(
     parameter DEFAULT_CHANNEL = 0,
               DEFAULT_WR_CHANNEL = -1,
               DEFAULT_RD_CHANNEL = -1,
               DEFAULT_DESTID = 19 
   )
  (output [106 - 101 : 0] default_destination_id,
   output [36-1 : 0] default_wr_channel,
   output [36-1 : 0] default_rd_channel,
   output [36-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[106 - 101 : 0];

  generate
    if (DEFAULT_CHANNEL == -1) begin : no_default_channel_assignment
      assign default_src_channel = '0;
    end
    else begin : default_channel_assignment
      assign default_src_channel = 36'b1 << DEFAULT_CHANNEL;
    end
  endgenerate

  generate
    if (DEFAULT_RD_CHANNEL == -1) begin : no_default_rw_channel_assignment
      assign default_wr_channel = '0;
      assign default_rd_channel = '0;
    end
    else begin : default_rw_channel_assignment
      assign default_wr_channel = 36'b1 << DEFAULT_WR_CHANNEL;
      assign default_rd_channel = 36'b1 << DEFAULT_RD_CHANNEL;
    end
  endgenerate

endmodule


module spw_ulight_nofifo_mm_interconnect_0_router
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
    output reg [36-1 : 0] src_channel,
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
    localparam ST_CHANNEL_W = 36;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 68;
    localparam PKT_TRANS_READ  = 69;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;



    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h10 - 64'h0); 
    localparam PAD1 = log2ceil(64'h20 - 64'h10); 
    localparam PAD2 = log2ceil(64'h30 - 64'h20); 
    localparam PAD3 = log2ceil(64'h40 - 64'h30); 
    localparam PAD4 = log2ceil(64'h50 - 64'h40); 
    localparam PAD5 = log2ceil(64'h60 - 64'h50); 
    localparam PAD6 = log2ceil(64'h70 - 64'h60); 
    localparam PAD7 = log2ceil(64'h80 - 64'h70); 
    localparam PAD8 = log2ceil(64'h90 - 64'h80); 
    localparam PAD9 = log2ceil(64'ha0 - 64'h90); 
    localparam PAD10 = log2ceil(64'hb0 - 64'ha0); 
    localparam PAD11 = log2ceil(64'hc0 - 64'hb0); 
    localparam PAD12 = log2ceil(64'hd0 - 64'hc0); 
    localparam PAD13 = log2ceil(64'he0 - 64'hd0); 
    localparam PAD14 = log2ceil(64'hf0 - 64'he0); 
    localparam PAD15 = log2ceil(64'h100 - 64'hf0); 
    localparam PAD16 = log2ceil(64'h200 - 64'h1f0); 
    localparam PAD17 = log2ceil(64'h300 - 64'h2f0); 
    localparam PAD18 = log2ceil(64'h400 - 64'h3f0); 
    localparam PAD19 = log2ceil(64'h500 - 64'h4f0); 
    localparam PAD20 = log2ceil(64'h600 - 64'h5f0); 
    localparam PAD21 = log2ceil(64'h700 - 64'h6f0); 
    localparam PAD22 = log2ceil(64'h800 - 64'h7f0); 
    localparam PAD23 = log2ceil(64'h900 - 64'h8f0); 
    localparam PAD24 = log2ceil(64'ha00 - 64'h9f0); 
    localparam PAD25 = log2ceil(64'hb00 - 64'haf0); 
    localparam PAD26 = log2ceil(64'hc00 - 64'hbf0); 
    localparam PAD27 = log2ceil(64'hd00 - 64'hcf0); 
    localparam PAD28 = log2ceil(64'he00 - 64'hdf0); 
    localparam PAD29 = log2ceil(64'hf00 - 64'hef0); 
    localparam PAD30 = log2ceil(64'h1000 - 64'hff0); 
    localparam PAD31 = log2ceil(64'h10010 - 64'h10000); 
    localparam PAD32 = log2ceil(64'h20010 - 64'h20000); 
    localparam PAD33 = log2ceil(64'h30010 - 64'h30000); 
    localparam PAD34 = log2ceil(64'h40010 - 64'h40000); 
    localparam PAD35 = log2ceil(64'h50010 - 64'h50000); 
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'h50010;
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
    wire [36-1 : 0] default_src_channel;




    // -------------------------------------------------------
    // Write and read transaction signals
    // -------------------------------------------------------
    wire read_transaction;
    assign read_transaction  = sink_data[PKT_TRANS_READ];


    spw_ulight_nofifo_mm_interconnect_0_router_default_decode the_default_decode(
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

    // ( 0x0 .. 0x10 )
    if ( {address[RG:PAD0],{PAD0{1'b0}}} == 19'h0   ) begin
            src_channel = 36'b000000000000000000000000000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 19;
    end

    // ( 0x10 .. 0x20 )
    if ( {address[RG:PAD1],{PAD1{1'b0}}} == 19'h10  && read_transaction  ) begin
            src_channel = 36'b000000000000000000000000000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
    end

    // ( 0x20 .. 0x30 )
    if ( {address[RG:PAD2],{PAD2{1'b0}}} == 19'h20  && read_transaction  ) begin
            src_channel = 36'b000000000000000000000000000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
    end

    // ( 0x30 .. 0x40 )
    if ( {address[RG:PAD3],{PAD3{1'b0}}} == 19'h30   ) begin
            src_channel = 36'b000000000000000000000000000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
    end

    // ( 0x40 .. 0x50 )
    if ( {address[RG:PAD4],{PAD4{1'b0}}} == 19'h40   ) begin
            src_channel = 36'b000000000000000000000000000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
    end

    // ( 0x50 .. 0x60 )
    if ( {address[RG:PAD5],{PAD5{1'b0}}} == 19'h50   ) begin
            src_channel = 36'b000000000000000000000000000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
    end

    // ( 0x60 .. 0x70 )
    if ( {address[RG:PAD6],{PAD6{1'b0}}} == 19'h60   ) begin
            src_channel = 36'b000000000000000000000000000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
    end

    // ( 0x70 .. 0x80 )
    if ( {address[RG:PAD7],{PAD7{1'b0}}} == 19'h70   ) begin
            src_channel = 36'b000000000000000000000000000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
    end

    // ( 0x80 .. 0x90 )
    if ( {address[RG:PAD8],{PAD8{1'b0}}} == 19'h80   ) begin
            src_channel = 36'b000000000000000000000000000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
    end

    // ( 0x90 .. 0xa0 )
    if ( {address[RG:PAD9],{PAD9{1'b0}}} == 19'h90   ) begin
            src_channel = 36'b000000000000000000000000001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
    end

    // ( 0xa0 .. 0xb0 )
    if ( {address[RG:PAD10],{PAD10{1'b0}}} == 19'ha0  && read_transaction  ) begin
            src_channel = 36'b000000000000000000000000010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
    end

    // ( 0xb0 .. 0xc0 )
    if ( {address[RG:PAD11],{PAD11{1'b0}}} == 19'hb0  && read_transaction  ) begin
            src_channel = 36'b000000000000000000000000100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
    end

    // ( 0xc0 .. 0xd0 )
    if ( {address[RG:PAD12],{PAD12{1'b0}}} == 19'hc0   ) begin
            src_channel = 36'b000000000000000000000001000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
    end

    // ( 0xd0 .. 0xe0 )
    if ( {address[RG:PAD13],{PAD13{1'b0}}} == 19'hd0  && read_transaction  ) begin
            src_channel = 36'b000000000000000000000010000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
    end

    // ( 0xe0 .. 0xf0 )
    if ( {address[RG:PAD14],{PAD14{1'b0}}} == 19'he0  && read_transaction  ) begin
            src_channel = 36'b000000000000000000000100000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 14;
    end

    // ( 0xf0 .. 0x100 )
    if ( {address[RG:PAD15],{PAD15{1'b0}}} == 19'hf0  && read_transaction  ) begin
            src_channel = 36'b000000000000000000001000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 13;
    end

    // ( 0x1f0 .. 0x200 )
    if ( {address[RG:PAD16],{PAD16{1'b0}}} == 19'h1f0   ) begin
            src_channel = 36'b000000000000000000010000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 16;
    end

    // ( 0x2f0 .. 0x300 )
    if ( {address[RG:PAD17],{PAD17{1'b0}}} == 19'h2f0   ) begin
            src_channel = 36'b000000000000000000100000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 15;
    end

    // ( 0x3f0 .. 0x400 )
    if ( {address[RG:PAD18],{PAD18{1'b0}}} == 19'h3f0  && read_transaction  ) begin
            src_channel = 36'b000000000000000001000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 18;
    end

    // ( 0x4f0 .. 0x500 )
    if ( {address[RG:PAD19],{PAD19{1'b0}}} == 19'h4f0  && read_transaction  ) begin
            src_channel = 36'b000000000000000010000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 17;
    end

    // ( 0x5f0 .. 0x600 )
    if ( {address[RG:PAD20],{PAD20{1'b0}}} == 19'h5f0   ) begin
            src_channel = 36'b000000000000000100000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 21;
    end

    // ( 0x6f0 .. 0x700 )
    if ( {address[RG:PAD21],{PAD21{1'b0}}} == 19'h6f0   ) begin
            src_channel = 36'b000000000000001000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 20;
    end

    // ( 0x7f0 .. 0x800 )
    if ( {address[RG:PAD22],{PAD22{1'b0}}} == 19'h7f0   ) begin
            src_channel = 36'b000000000000010000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 23;
    end

    // ( 0x8f0 .. 0x900 )
    if ( {address[RG:PAD23],{PAD23{1'b0}}} == 19'h8f0   ) begin
            src_channel = 36'b000000000000100000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 22;
    end

    // ( 0x9f0 .. 0xa00 )
    if ( {address[RG:PAD24],{PAD24{1'b0}}} == 19'h9f0   ) begin
            src_channel = 36'b000000000001000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 25;
    end

    // ( 0xaf0 .. 0xb00 )
    if ( {address[RG:PAD25],{PAD25{1'b0}}} == 19'haf0   ) begin
            src_channel = 36'b000000000010000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 24;
    end

    // ( 0xbf0 .. 0xc00 )
    if ( {address[RG:PAD26],{PAD26{1'b0}}} == 19'hbf0   ) begin
            src_channel = 36'b000000000100000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 27;
    end

    // ( 0xcf0 .. 0xd00 )
    if ( {address[RG:PAD27],{PAD27{1'b0}}} == 19'hcf0   ) begin
            src_channel = 36'b000000001000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 26;
    end

    // ( 0xdf0 .. 0xe00 )
    if ( {address[RG:PAD28],{PAD28{1'b0}}} == 19'hdf0  && read_transaction  ) begin
            src_channel = 36'b000000010000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 29;
    end

    // ( 0xef0 .. 0xf00 )
    if ( {address[RG:PAD29],{PAD29{1'b0}}} == 19'hef0  && read_transaction  ) begin
            src_channel = 36'b000000100000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 28;
    end

    // ( 0xff0 .. 0x1000 )
    if ( {address[RG:PAD30],{PAD30{1'b0}}} == 19'hff0  && read_transaction  ) begin
            src_channel = 36'b000001000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 31;
    end

    // ( 0x10000 .. 0x10010 )
    if ( {address[RG:PAD31],{PAD31{1'b0}}} == 19'h10000  && read_transaction  ) begin
            src_channel = 36'b000010000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 30;
    end

    // ( 0x20000 .. 0x20010 )
    if ( {address[RG:PAD32],{PAD32{1'b0}}} == 19'h20000  && read_transaction  ) begin
            src_channel = 36'b000100000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 33;
    end

    // ( 0x30000 .. 0x30010 )
    if ( {address[RG:PAD33],{PAD33{1'b0}}} == 19'h30000  && read_transaction  ) begin
            src_channel = 36'b001000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 32;
    end

    // ( 0x40000 .. 0x40010 )
    if ( {address[RG:PAD34],{PAD34{1'b0}}} == 19'h40000   ) begin
            src_channel = 36'b010000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 35;
    end

    // ( 0x50000 .. 0x50010 )
    if ( {address[RG:PAD35],{PAD35{1'b0}}} == 19'h50000   ) begin
            src_channel = 36'b100000000000000000000000000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 34;
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


