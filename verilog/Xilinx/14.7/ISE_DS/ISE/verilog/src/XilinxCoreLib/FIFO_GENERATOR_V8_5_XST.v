/*
 *******************************************************************************
 *
 * FIFO Generator - Verilog Behavioral Model
 *
 *******************************************************************************
 *
 * (c) Copyright 1995 - 2009 Xilinx, Inc. All rights reserved.
 *
 * This file contains confidential and proprietary information
 * of Xilinx, Inc. and is protected under U.S. and
 * international copyright and other intellectual property
 * laws.
 *
 * DISCLAIMER
 * This disclaimer is not a license and does not grant any
 * rights to the materials distributed herewith. Except as
 * otherwise provided in a valid license issued to you by
 * Xilinx, and to the maximum extent permitted by applicable
 * law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
 * WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
 * AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
 * BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
 * INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
 * (2) Xilinx shall not be liable (whether in contract or tort,
 * including negligence, or under any other theory of
 * liability) for any loss or damage of any kind or nature
 * related to, arising under or in connection with these
 * materials, including for any direct, or any indirect,
 * special, incidental, or consequential loss or damage
 * (including loss of data, profits, goodwill, or any type of
 * loss or damage suffered as a result of any action brought
 * by a third party) even if such damage or loss was
 * reasonably foreseeable or Xilinx had been advised of the
 * possibility of the same.
 *
 * CRITICAL APPLICATIONS
 * Xilinx products are not designed or intended to be fail-
 * safe, or for use in any application requiring fail-safe
 * performance, such as life-support or safety devices or
 * systems, Class III medical devices, nuclear facilities,
 * applications related to the deployment of airbags, or any
 * other applications that could lead to death, personal
 * injury, or severe property or environmental damage
 * (individually and collectively, "Critical
 * Applications"). Customer assumes the sole risk and
 * liability of any use of Xilinx products in Critical
 * Applications, subject only to applicable laws and
 * regulations governing limitations on product liability.
 *
 * THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
 * PART OF THIS FILE AT ALL TIMES.
 *
 *******************************************************************************
 *******************************************************************************
 *
 * Filename: fifo_generator_v8_5_bhv.v
 *
 * Description:
 *  The verilog behavioral model for the FIFO generator core.
 *
 *******************************************************************************
 */

`timescale 1ps/1ps

/*******************************************************************************
 * Declaration of top-level module
 ******************************************************************************/
module FIFO_GENERATOR_V8_5_XST
  #(
    //-----------------------------------------------------------------------
    // Generic Declarations
    //-----------------------------------------------------------------------
    parameter C_COMMON_CLOCK                 = 0,
    parameter C_COUNT_TYPE                   = 0,
    parameter C_DATA_COUNT_WIDTH             = 2,
    parameter C_DEFAULT_VALUE                = "",
    parameter C_DIN_WIDTH                    = 8,
    parameter C_DOUT_RST_VAL                 = "",
    parameter C_DOUT_WIDTH                   = 8,
    parameter C_ENABLE_RLOCS                 = 0,
    parameter C_FAMILY                       = "",
    parameter C_FULL_FLAGS_RST_VAL           = 1,
    parameter C_HAS_ALMOST_EMPTY             = 0,
    parameter C_HAS_ALMOST_FULL              = 0,
    parameter C_HAS_BACKUP                   = 0,
    parameter C_HAS_DATA_COUNT               = 0,
    parameter C_HAS_INT_CLK                  = 0,
    parameter C_HAS_MEMINIT_FILE             = 0,
    parameter C_HAS_OVERFLOW                 = 0,
    parameter C_HAS_RD_DATA_COUNT            = 0,
    parameter C_HAS_RD_RST                   = 0,
    parameter C_HAS_RST                      = 1,
    parameter C_HAS_SRST                     = 0,
    parameter C_HAS_UNDERFLOW                = 0,
    parameter C_HAS_VALID                    = 0,
    parameter C_HAS_WR_ACK                   = 0,
    parameter C_HAS_WR_DATA_COUNT            = 0,
    parameter C_HAS_WR_RST                   = 0,
    parameter C_IMPLEMENTATION_TYPE          = 0,
    parameter C_INIT_WR_PNTR_VAL             = 0,
    parameter C_MEMORY_TYPE                  = 1,
    parameter C_MIF_FILE_NAME                = "",
    parameter C_OPTIMIZATION_MODE            = 0,
    parameter C_OVERFLOW_LOW                 = 0,
    parameter C_PRELOAD_LATENCY              = 1,
    parameter C_PRELOAD_REGS                 = 0,
    parameter C_PRIM_FIFO_TYPE               = "4kx4",
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL = 0,
    parameter C_PROG_EMPTY_THRESH_NEGATE_VAL = 0,
    parameter C_PROG_EMPTY_TYPE              = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL  = 0,
    parameter C_PROG_FULL_THRESH_NEGATE_VAL  = 0,
    parameter C_PROG_FULL_TYPE               = 0,
    parameter C_RD_DATA_COUNT_WIDTH          = 2,
    parameter C_RD_DEPTH                     = 256,
    parameter C_RD_FREQ                      = 1,
    parameter C_RD_PNTR_WIDTH                = 8,
    parameter C_UNDERFLOW_LOW                = 0,
    parameter C_USE_DOUT_RST                 = 0,
    parameter C_USE_ECC                      = 0,
    parameter C_USE_EMBEDDED_REG             = 0,
    parameter C_USE_FIFO16_FLAGS             = 0,
    parameter C_USE_FWFT_DATA_COUNT          = 0,
    parameter C_VALID_LOW                    = 0,
    parameter C_WR_ACK_LOW                   = 0,
    parameter C_WR_DATA_COUNT_WIDTH          = 2,
    parameter C_WR_DEPTH                     = 256,
    parameter C_WR_FREQ                      = 1,
    parameter C_WR_PNTR_WIDTH                = 8,
    parameter C_WR_RESPONSE_LATENCY          = 1,
    parameter C_MSGON_VAL                    = 1,
    parameter C_ENABLE_RST_SYNC              = 1,
    parameter C_ERROR_INJECTION_TYPE         = 0,
    parameter C_SYNCHRONIZER_STAGE           = 2,

    // AXI Interface related parameters start here
    parameter C_INTERFACE_TYPE               = 0, // 0: Native Interface, 1: AXI Interface
    parameter C_AXI_TYPE                     = 0, // 0: AXI Stream, 1: AXI Full, 2: AXI Lite
    parameter C_HAS_AXI_WR_CHANNEL           = 0,
    parameter C_HAS_AXI_RD_CHANNEL           = 0,
    parameter C_HAS_SLAVE_CE                 = 0,
    parameter C_HAS_MASTER_CE                = 0,
    parameter C_ADD_NGC_CONSTRAINT           = 0,
    parameter C_USE_COMMON_UNDERFLOW         = 0,
    parameter C_USE_COMMON_OVERFLOW          = 0,
    parameter C_USE_DEFAULT_SETTINGS         = 0,

    // AXI Full/Lite
    parameter C_AXI_ID_WIDTH                 = 0,
    parameter C_AXI_ADDR_WIDTH               = 0,
    parameter C_AXI_DATA_WIDTH               = 0,
    parameter C_HAS_AXI_AWUSER               = 0,
    parameter C_HAS_AXI_WUSER                = 0,
    parameter C_HAS_AXI_BUSER                = 0,
    parameter C_HAS_AXI_ARUSER               = 0,
    parameter C_HAS_AXI_RUSER                = 0,
    parameter C_AXI_ARUSER_WIDTH             = 0,
    parameter C_AXI_AWUSER_WIDTH             = 0,
    parameter C_AXI_WUSER_WIDTH              = 0,
    parameter C_AXI_BUSER_WIDTH              = 0,
    parameter C_AXI_RUSER_WIDTH              = 0,

    // AXI Streaming
    parameter C_HAS_AXIS_TDATA               = 0,
    parameter C_HAS_AXIS_TID                 = 0,
    parameter C_HAS_AXIS_TDEST               = 0,
    parameter C_HAS_AXIS_TUSER               = 0,
    parameter C_HAS_AXIS_TREADY              = 0,
    parameter C_HAS_AXIS_TLAST               = 0,
    parameter C_HAS_AXIS_TSTRB               = 0,
    parameter C_HAS_AXIS_TKEEP               = 0,
    parameter C_AXIS_TDATA_WIDTH             = 1,
    parameter C_AXIS_TID_WIDTH               = 1,
    parameter C_AXIS_TDEST_WIDTH             = 1,
    parameter C_AXIS_TUSER_WIDTH             = 1,
    parameter C_AXIS_TSTRB_WIDTH             = 1,
    parameter C_AXIS_TKEEP_WIDTH             = 1,

    // AXI Channel Type
    // WACH --> Write Address Channel
    // WDCH --> Write Data Channel
    // WRCH --> Write Response Channel
    // RACH --> Read Address Channel
    // RDCH --> Read Data Channel
    // AXIS --> AXI Streaming
    parameter C_WACH_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logic
    parameter C_WDCH_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logie
    parameter C_WRCH_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logie
    parameter C_RACH_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logie
    parameter C_RDCH_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logie
    parameter C_AXIS_TYPE                    = 0, // 0 = FIFO, 1 = Register Slice, 2 = Pass Through Logie

    // AXI Implementation Type
    // 1 = Common Clock Block RAM FIFO
    // 2 = Common Clock Distributed RAM FIFO
    // 11 = Independent Clock Block RAM FIFO
    // 12 = Independent Clock Distributed RAM FIFO
    parameter C_IMPLEMENTATION_TYPE_WACH     = 0,
    parameter C_IMPLEMENTATION_TYPE_WDCH     = 0,
    parameter C_IMPLEMENTATION_TYPE_WRCH     = 0,
    parameter C_IMPLEMENTATION_TYPE_RACH     = 0,
    parameter C_IMPLEMENTATION_TYPE_RDCH     = 0,
    parameter C_IMPLEMENTATION_TYPE_AXIS     = 0,

    // AXI FIFO Type
    // 0 = Data FIFO
    // 1 = Packet FIFO
    // 2 = Low Latency Data FIFO
    parameter C_APPLICATION_TYPE_WACH        = 0,
    parameter C_APPLICATION_TYPE_WDCH        = 0,
    parameter C_APPLICATION_TYPE_WRCH        = 0,
    parameter C_APPLICATION_TYPE_RACH        = 0,
    parameter C_APPLICATION_TYPE_RDCH        = 0,
    parameter C_APPLICATION_TYPE_AXIS        = 0,

    // Enable ECC
    // 0 = ECC disabled
    // 1 = ECC enabled
    parameter C_USE_ECC_WACH                 = 0,
    parameter C_USE_ECC_WDCH                 = 0,
    parameter C_USE_ECC_WRCH                 = 0,
    parameter C_USE_ECC_RACH                 = 0,
    parameter C_USE_ECC_RDCH                 = 0,
    parameter C_USE_ECC_AXIS                 = 0,

    // ECC Error Injection Type
    // 0 = No Error Injection
    // 1 = Single Bit Error Injection
    // 2 = Double Bit Error Injection
    // 3 = Single Bit and Double Bit Error Injection
    parameter C_ERROR_INJECTION_TYPE_WACH    = 0,
    parameter C_ERROR_INJECTION_TYPE_WDCH    = 0,
    parameter C_ERROR_INJECTION_TYPE_WRCH    = 0,
    parameter C_ERROR_INJECTION_TYPE_RACH    = 0,
    parameter C_ERROR_INJECTION_TYPE_RDCH    = 0,
    parameter C_ERROR_INJECTION_TYPE_AXIS    = 0,

    // Input Data Width
    // Accumulation of all AXI input signal's width
    parameter C_DIN_WIDTH_WACH               = 1,
    parameter C_DIN_WIDTH_WDCH               = 1,
    parameter C_DIN_WIDTH_WRCH               = 1,
    parameter C_DIN_WIDTH_RACH               = 1,
    parameter C_DIN_WIDTH_RDCH               = 1,
    parameter C_DIN_WIDTH_AXIS               = 1,

    parameter C_WR_DEPTH_WACH                = 16,
    parameter C_WR_DEPTH_WDCH                = 16,
    parameter C_WR_DEPTH_WRCH                = 16,
    parameter C_WR_DEPTH_RACH                = 16,
    parameter C_WR_DEPTH_RDCH                = 16,
    parameter C_WR_DEPTH_AXIS                = 16,

    parameter C_WR_PNTR_WIDTH_WACH           = 4,
    parameter C_WR_PNTR_WIDTH_WDCH           = 4,
    parameter C_WR_PNTR_WIDTH_WRCH           = 4,
    parameter C_WR_PNTR_WIDTH_RACH           = 4,
    parameter C_WR_PNTR_WIDTH_RDCH           = 4,
    parameter C_WR_PNTR_WIDTH_AXIS           = 4,

    parameter C_HAS_DATA_COUNTS_WACH         = 0,
    parameter C_HAS_DATA_COUNTS_WDCH         = 0,
    parameter C_HAS_DATA_COUNTS_WRCH         = 0,
    parameter C_HAS_DATA_COUNTS_RACH         = 0,
    parameter C_HAS_DATA_COUNTS_RDCH         = 0,
    parameter C_HAS_DATA_COUNTS_AXIS         = 0,

    parameter C_HAS_PROG_FLAGS_WACH          = 0,
    parameter C_HAS_PROG_FLAGS_WDCH          = 0,
    parameter C_HAS_PROG_FLAGS_WRCH          = 0,
    parameter C_HAS_PROG_FLAGS_RACH          = 0,
    parameter C_HAS_PROG_FLAGS_RDCH          = 0,
    parameter C_HAS_PROG_FLAGS_AXIS          = 0,

    parameter C_PROG_FULL_TYPE_WACH          = 0,
    parameter C_PROG_FULL_TYPE_WDCH          = 0,
    parameter C_PROG_FULL_TYPE_WRCH          = 0,
    parameter C_PROG_FULL_TYPE_RACH          = 0,
    parameter C_PROG_FULL_TYPE_RDCH          = 0,
    parameter C_PROG_FULL_TYPE_AXIS          = 0,

    parameter C_PROG_FULL_THRESH_ASSERT_VAL_WACH      = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL_WDCH      = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL_WRCH      = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL_RACH      = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL_RDCH      = 0,
    parameter C_PROG_FULL_THRESH_ASSERT_VAL_AXIS      = 0,

    parameter C_PROG_EMPTY_TYPE_WACH         = 0,
    parameter C_PROG_EMPTY_TYPE_WDCH         = 0,
    parameter C_PROG_EMPTY_TYPE_WRCH         = 0,
    parameter C_PROG_EMPTY_TYPE_RACH         = 0,
    parameter C_PROG_EMPTY_TYPE_RDCH         = 0,
    parameter C_PROG_EMPTY_TYPE_AXIS         = 0,

    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH     = 0,
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH     = 0,
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH     = 0,
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH     = 0,
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH     = 0,
    parameter C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS     = 0,

    parameter C_REG_SLICE_MODE_WACH          = 0,
    parameter C_REG_SLICE_MODE_WDCH          = 0,
    parameter C_REG_SLICE_MODE_WRCH          = 0,
    parameter C_REG_SLICE_MODE_RACH          = 0,
    parameter C_REG_SLICE_MODE_RDCH          = 0,
    parameter C_REG_SLICE_MODE_AXIS          = 0

    )

  (
    //------------------------------------------------------------------------------
    // Input and Output Declarations
    //------------------------------------------------------------------------------

    // Conventional FIFO Interface Signals
    input                               BACKUP,
    input                               BACKUP_MARKER,
    input                               CLK,
    input                               RST,
    input                               SRST,
    input                               WR_CLK,
    input                               WR_RST,
    input                               RD_CLK,
    input                               RD_RST,
    input [C_DIN_WIDTH-1:0]             DIN,
    input                               WR_EN,
    input                               RD_EN,
    // Optional inputs
    input [C_RD_PNTR_WIDTH-1:0]         PROG_EMPTY_THRESH,
    input [C_RD_PNTR_WIDTH-1:0]         PROG_EMPTY_THRESH_ASSERT,
    input [C_RD_PNTR_WIDTH-1:0]         PROG_EMPTY_THRESH_NEGATE,
    input [C_WR_PNTR_WIDTH-1:0]         PROG_FULL_THRESH,
    input [C_WR_PNTR_WIDTH-1:0]         PROG_FULL_THRESH_ASSERT,
    input [C_WR_PNTR_WIDTH-1:0]         PROG_FULL_THRESH_NEGATE,
    input                               INT_CLK,
    input                               INJECTDBITERR,
    input                               INJECTSBITERR,

    output [C_DOUT_WIDTH-1:0]           DOUT,
    output                              FULL,
    output                              ALMOST_FULL,
    output                              WR_ACK,
    output                              OVERFLOW,
    output                              EMPTY,
    output                              ALMOST_EMPTY,
    output                              VALID,
    output                              UNDERFLOW,
    output [C_DATA_COUNT_WIDTH-1:0]     DATA_COUNT,
    output [C_RD_DATA_COUNT_WIDTH-1:0]  RD_DATA_COUNT,
    output [C_WR_DATA_COUNT_WIDTH-1:0]  WR_DATA_COUNT,
    output                              PROG_FULL,
    output                              PROG_EMPTY,
    output                              SBITERR,
    output                              DBITERR,


    // AXI Global Signal
    input                               M_ACLK,
    input                               S_ACLK,
    input                               S_ARESETN,
    input                               S_ACLK_EN,
    input                               M_ACLK_EN,
    
    // AXI Full/Lite Slave Write Channel (write side)
    input [C_AXI_ID_WIDTH-1:0]          S_AXI_AWID,
    input [C_AXI_ADDR_WIDTH-1:0]        S_AXI_AWADDR,
    input [8-1:0]                       S_AXI_AWLEN,
    input [3-1:0]                       S_AXI_AWSIZE,
    input [2-1:0]                       S_AXI_AWBURST,
    input [2-1:0]                       S_AXI_AWLOCK,
    input [4-1:0]                       S_AXI_AWCACHE,
    input [3-1:0]                       S_AXI_AWPROT,
    input [4-1:0]                       S_AXI_AWQOS,
    input [4-1:0]                       S_AXI_AWREGION,
    input [C_AXI_AWUSER_WIDTH-1:0]      S_AXI_AWUSER,
    input                               S_AXI_AWVALID,
    output                              S_AXI_AWREADY,
    input [C_AXI_ID_WIDTH-1:0]          S_AXI_WID,
    input [C_AXI_DATA_WIDTH-1:0]        S_AXI_WDATA,
    input [C_AXI_DATA_WIDTH/8-1:0]      S_AXI_WSTRB,
    input                               S_AXI_WLAST,
    input [C_AXI_WUSER_WIDTH-1:0]       S_AXI_WUSER,
    input                               S_AXI_WVALID,
    output                              S_AXI_WREADY,
    output [C_AXI_ID_WIDTH-1:0]         S_AXI_BID,
    output [2-1:0]                      S_AXI_BRESP,
    output [C_AXI_BUSER_WIDTH-1:0]      S_AXI_BUSER,
    output                              S_AXI_BVALID,
    input                               S_AXI_BREADY,
    
    // AXI Full/Lite Master Write Channel (Read side)
    output [C_AXI_ID_WIDTH-1:0]         M_AXI_AWID,
    output [C_AXI_ADDR_WIDTH-1:0]       M_AXI_AWADDR,
    output [8-1:0]                      M_AXI_AWLEN,
    output [3-1:0]                      M_AXI_AWSIZE,
    output [2-1:0]                      M_AXI_AWBURST,
    output [2-1:0]                      M_AXI_AWLOCK,
    output [4-1:0]                      M_AXI_AWCACHE,
    output [3-1:0]                      M_AXI_AWPROT,
    output [4-1:0]                      M_AXI_AWQOS,
    output [4-1:0]                      M_AXI_AWREGION,
    output [C_AXI_AWUSER_WIDTH-1:0]     M_AXI_AWUSER,
    output                              M_AXI_AWVALID,
    input                               M_AXI_AWREADY,
    output [C_AXI_ID_WIDTH-1:0]         M_AXI_WID,
    output [C_AXI_DATA_WIDTH-1:0]       M_AXI_WDATA,
    output [C_AXI_DATA_WIDTH/8-1:0]     M_AXI_WSTRB,
    output                              M_AXI_WLAST,
    output [C_AXI_WUSER_WIDTH-1:0]      M_AXI_WUSER,
    output                              M_AXI_WVALID,
    input                               M_AXI_WREADY,
    input [C_AXI_ID_WIDTH-1:0]          M_AXI_BID,
    input [2-1:0]                       M_AXI_BRESP,
    input [C_AXI_BUSER_WIDTH-1:0]       M_AXI_BUSER,
    input                               M_AXI_BVALID,
    output                              M_AXI_BREADY,
    
    
    // AXI Full/Lite Slave Read Channel (Write side)
    input [C_AXI_ID_WIDTH-1:0]          S_AXI_ARID,
    input [C_AXI_ADDR_WIDTH-1:0]        S_AXI_ARADDR, 
    input [8-1:0]                       S_AXI_ARLEN,
    input [3-1:0]                       S_AXI_ARSIZE,
    input [2-1:0]                       S_AXI_ARBURST,
    input [2-1:0]                       S_AXI_ARLOCK,
    input [4-1:0]                       S_AXI_ARCACHE,
    input [3-1:0]                       S_AXI_ARPROT,
    input [4-1:0]                       S_AXI_ARQOS,
    input [4-1:0]                       S_AXI_ARREGION,
    input [C_AXI_ARUSER_WIDTH-1:0]      S_AXI_ARUSER,
    input                               S_AXI_ARVALID,
    output                              S_AXI_ARREADY,
    output [C_AXI_ID_WIDTH-1:0]         S_AXI_RID,       
    output [C_AXI_DATA_WIDTH-1:0]       S_AXI_RDATA, 
    output [2-1:0]                      S_AXI_RRESP,
    output                              S_AXI_RLAST,
    output [C_AXI_RUSER_WIDTH-1:0]      S_AXI_RUSER,
    output                              S_AXI_RVALID,
    input                               S_AXI_RREADY,
    
    
    
    // AXI Full/Lite Master Read Channel (Read side)
    output [C_AXI_ID_WIDTH-1:0]         M_AXI_ARID,        
    output [C_AXI_ADDR_WIDTH-1:0]       M_AXI_ARADDR,  
    output [8-1:0]                      M_AXI_ARLEN,
    output [3-1:0]                      M_AXI_ARSIZE,
    output [2-1:0]                      M_AXI_ARBURST,
    output [2-1:0]                      M_AXI_ARLOCK,
    output [4-1:0]                      M_AXI_ARCACHE,
    output [3-1:0]                      M_AXI_ARPROT,
    output [4-1:0]                      M_AXI_ARQOS,
    output [4-1:0]                      M_AXI_ARREGION,
    output [C_AXI_ARUSER_WIDTH-1:0]     M_AXI_ARUSER,
    output                              M_AXI_ARVALID,
    input                               M_AXI_ARREADY,
    input [C_AXI_ID_WIDTH-1:0]          M_AXI_RID,        
    input [C_AXI_DATA_WIDTH-1:0]        M_AXI_RDATA,  
    input [2-1:0]                       M_AXI_RRESP,
    input                               M_AXI_RLAST,
    input [C_AXI_RUSER_WIDTH-1:0]       M_AXI_RUSER,
    input                               M_AXI_RVALID,
    output                              M_AXI_RREADY,
    
    
    // AXI Streaming Slave Signals (Write side)
    input                               S_AXIS_TVALID,
    output                              S_AXIS_TREADY,
    input [C_AXIS_TDATA_WIDTH-1:0]      S_AXIS_TDATA,
    input [C_AXIS_TSTRB_WIDTH-1:0]      S_AXIS_TSTRB,
    input [C_AXIS_TKEEP_WIDTH-1:0]      S_AXIS_TKEEP,
    input                               S_AXIS_TLAST,
    input [C_AXIS_TID_WIDTH-1:0]        S_AXIS_TID,
    input [C_AXIS_TDEST_WIDTH-1:0]      S_AXIS_TDEST,
    input [C_AXIS_TUSER_WIDTH-1:0]      S_AXIS_TUSER,
    
    // AXI Streaming Master Signals (Read side)
    output                              M_AXIS_TVALID,
    input                               M_AXIS_TREADY,
    output [C_AXIS_TDATA_WIDTH-1:0]     M_AXIS_TDATA,
    output [C_AXIS_TSTRB_WIDTH-1:0]     M_AXIS_TSTRB,
    output [C_AXIS_TKEEP_WIDTH-1:0]     M_AXIS_TKEEP,
    output                              M_AXIS_TLAST,
    output [C_AXIS_TID_WIDTH-1:0]       M_AXIS_TID,
    output [C_AXIS_TDEST_WIDTH-1:0]     M_AXIS_TDEST,
    output [C_AXIS_TUSER_WIDTH-1:0]     M_AXIS_TUSER,
    
           
    
    
    // AXI Full/Lite Write Address Channel Signals
    input                               AXI_AW_INJECTSBITERR,
    input                               AXI_AW_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_WACH-1:0]   AXI_AW_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_WACH-1:0]   AXI_AW_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_WACH:0]     AXI_AW_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WACH:0]     AXI_AW_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WACH:0]     AXI_AW_RD_DATA_COUNT,
    output                              AXI_AW_SBITERR,
    output                              AXI_AW_DBITERR,
    output                              AXI_AW_OVERFLOW,
    output                              AXI_AW_UNDERFLOW,
    
    
    // AXI Full/Lite Write Data Channel Signals
    input                               AXI_W_INJECTSBITERR,
    input                               AXI_W_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_WDCH-1:0]   AXI_W_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_WDCH-1:0]   AXI_W_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_WDCH:0]     AXI_W_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WDCH:0]     AXI_W_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WDCH:0]     AXI_W_RD_DATA_COUNT,
    output                              AXI_W_SBITERR,
    output                              AXI_W_DBITERR,
    output                              AXI_W_OVERFLOW,
    output                              AXI_W_UNDERFLOW,
    
    
    // AXI Full/Lite Write Response Channel Signals
    input                               AXI_B_INJECTSBITERR,
    input                               AXI_B_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_WRCH-1:0]   AXI_B_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_WRCH-1:0]   AXI_B_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_WRCH:0]     AXI_B_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WRCH:0]     AXI_B_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_WRCH:0]     AXI_B_RD_DATA_COUNT,
    output                              AXI_B_SBITERR,
    output                              AXI_B_DBITERR,
    output                              AXI_B_OVERFLOW,
    output                              AXI_B_UNDERFLOW,
    
    
    
    // AXI Full/Lite Read Address Channel Signals
    input                               AXI_AR_INJECTSBITERR,
    input                               AXI_AR_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_RACH-1:0]   AXI_AR_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_RACH-1:0]   AXI_AR_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_RACH:0]     AXI_AR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_RACH:0]     AXI_AR_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_RACH:0]     AXI_AR_RD_DATA_COUNT,
    output                              AXI_AR_SBITERR,
    output                              AXI_AR_DBITERR,
    output                              AXI_AR_OVERFLOW,
    output                              AXI_AR_UNDERFLOW,

    
    // AXI Full/Lite Read Data Channel Signals
    input                               AXI_R_INJECTSBITERR,
    input                               AXI_R_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_RDCH-1:0]   AXI_R_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_RDCH-1:0]   AXI_R_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_RDCH:0]     AXI_R_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_RDCH:0]     AXI_R_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_RDCH:0]     AXI_R_RD_DATA_COUNT,
    output                              AXI_R_SBITERR,
    output                              AXI_R_DBITERR,
    output                              AXI_R_OVERFLOW,
    output                              AXI_R_UNDERFLOW,

    
    // AXI Streaming FIFO Related Signals
    input                               AXIS_INJECTSBITERR,
    input                               AXIS_INJECTDBITERR,
    input  [C_WR_PNTR_WIDTH_AXIS-1:0]   AXIS_PROG_FULL_THRESH,
    input  [C_WR_PNTR_WIDTH_AXIS-1:0]   AXIS_PROG_EMPTY_THRESH,
    output [C_WR_PNTR_WIDTH_AXIS:0]     AXIS_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_AXIS:0]     AXIS_WR_DATA_COUNT,
    output [C_WR_PNTR_WIDTH_AXIS:0]     AXIS_RD_DATA_COUNT,
    output                              AXIS_SBITERR,
    output                              AXIS_DBITERR,
    output                              AXIS_OVERFLOW,
    output                              AXIS_UNDERFLOW

    );


  FIFO_GENERATOR_V8_5
  #(
        .C_COMMON_CLOCK                      (C_COMMON_CLOCK),
        .C_COUNT_TYPE                        (C_COUNT_TYPE),
        .C_DATA_COUNT_WIDTH                  (C_DATA_COUNT_WIDTH),
        .C_DEFAULT_VALUE                     (C_DEFAULT_VALUE),
        .C_DIN_WIDTH                         (C_DIN_WIDTH),
        .C_DOUT_RST_VAL                      (C_DOUT_RST_VAL),
        .C_DOUT_WIDTH                        (C_DOUT_WIDTH),
        .C_ENABLE_RLOCS                      (C_ENABLE_RLOCS),
        .C_FAMILY                            (C_FAMILY),
        .C_FULL_FLAGS_RST_VAL                (C_FULL_FLAGS_RST_VAL),
        .C_HAS_ALMOST_EMPTY                  (C_HAS_ALMOST_EMPTY),
        .C_HAS_ALMOST_FULL                   (C_HAS_ALMOST_FULL),
        .C_HAS_BACKUP                        (C_HAS_BACKUP),
        .C_HAS_DATA_COUNT                    (C_HAS_DATA_COUNT),
        .C_HAS_INT_CLK                       (C_HAS_INT_CLK),
        .C_HAS_MEMINIT_FILE                  (C_HAS_MEMINIT_FILE),
        .C_HAS_OVERFLOW                      (C_HAS_OVERFLOW),
        .C_HAS_RD_DATA_COUNT                 (C_HAS_RD_DATA_COUNT),
        .C_HAS_RD_RST                        (C_HAS_RD_RST),
        .C_HAS_RST                           (C_HAS_RST),
        .C_HAS_SRST                          (C_HAS_SRST),
        .C_HAS_UNDERFLOW                     (C_HAS_UNDERFLOW),
        .C_HAS_VALID                         (C_HAS_VALID),
        .C_HAS_WR_ACK                        (C_HAS_WR_ACK),
        .C_HAS_WR_DATA_COUNT                 (C_HAS_WR_DATA_COUNT),
        .C_HAS_WR_RST                        (C_HAS_WR_RST),
        .C_IMPLEMENTATION_TYPE               (C_IMPLEMENTATION_TYPE),
        .C_INIT_WR_PNTR_VAL                  (C_INIT_WR_PNTR_VAL),
        .C_MEMORY_TYPE                       (C_MEMORY_TYPE),
        .C_MIF_FILE_NAME                     (C_MIF_FILE_NAME),
        .C_OPTIMIZATION_MODE                 (C_OPTIMIZATION_MODE),
        .C_OVERFLOW_LOW                      (C_OVERFLOW_LOW),
        .C_PRELOAD_LATENCY                   (C_PRELOAD_LATENCY),
        .C_PRELOAD_REGS                      (C_PRELOAD_REGS),
        .C_PRIM_FIFO_TYPE                    (C_PRIM_FIFO_TYPE),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL      (C_PROG_EMPTY_THRESH_ASSERT_VAL),
        .C_PROG_EMPTY_THRESH_NEGATE_VAL      (C_PROG_EMPTY_THRESH_NEGATE_VAL),
        .C_PROG_EMPTY_TYPE                   (C_PROG_EMPTY_TYPE),
        .C_PROG_FULL_THRESH_ASSERT_VAL       (C_PROG_FULL_THRESH_ASSERT_VAL),
        .C_PROG_FULL_THRESH_NEGATE_VAL       (C_PROG_FULL_THRESH_NEGATE_VAL),
        .C_PROG_FULL_TYPE                    (C_PROG_FULL_TYPE),
        .C_RD_DATA_COUNT_WIDTH               (C_RD_DATA_COUNT_WIDTH),
        .C_RD_DEPTH                          (C_RD_DEPTH),
        .C_RD_FREQ                           (C_RD_FREQ),
        .C_RD_PNTR_WIDTH                     (C_RD_PNTR_WIDTH),
        .C_UNDERFLOW_LOW                     (C_UNDERFLOW_LOW),
        .C_USE_DOUT_RST                      (C_USE_DOUT_RST),
        .C_USE_ECC                           (C_USE_ECC),
        .C_USE_EMBEDDED_REG                  (C_USE_EMBEDDED_REG),
        .C_USE_FIFO16_FLAGS                  (C_USE_FIFO16_FLAGS),
        .C_USE_FWFT_DATA_COUNT               (C_USE_FWFT_DATA_COUNT),
        .C_VALID_LOW                         (C_VALID_LOW),
        .C_WR_ACK_LOW                        (C_WR_ACK_LOW),
        .C_WR_DATA_COUNT_WIDTH               (C_WR_DATA_COUNT_WIDTH),
        .C_WR_DEPTH                          (C_WR_DEPTH),
        .C_WR_FREQ                           (C_WR_FREQ),
        .C_WR_PNTR_WIDTH                     (C_WR_PNTR_WIDTH),
        .C_WR_RESPONSE_LATENCY               (C_WR_RESPONSE_LATENCY),
        .C_MSGON_VAL                         (C_MSGON_VAL),
        .C_ENABLE_RST_SYNC                   (C_ENABLE_RST_SYNC),
        .C_ERROR_INJECTION_TYPE              (C_ERROR_INJECTION_TYPE),
	.C_SYNCHRONIZER_STAGE                (C_SYNCHRONIZER_STAGE),
                                            
        .C_INTERFACE_TYPE                    (C_INTERFACE_TYPE),
        .C_AXI_TYPE                          (C_AXI_TYPE),
        .C_HAS_AXI_WR_CHANNEL                (C_HAS_AXI_WR_CHANNEL),
        .C_HAS_AXI_RD_CHANNEL                (C_HAS_AXI_RD_CHANNEL),
        .C_HAS_SLAVE_CE                      (C_HAS_SLAVE_CE),
        .C_HAS_MASTER_CE                     (C_HAS_MASTER_CE),
        .C_ADD_NGC_CONSTRAINT                (C_ADD_NGC_CONSTRAINT),
        .C_USE_COMMON_OVERFLOW               (C_USE_COMMON_OVERFLOW),
        .C_USE_COMMON_UNDERFLOW              (C_USE_COMMON_UNDERFLOW),
        .C_USE_DEFAULT_SETTINGS              (C_USE_DEFAULT_SETTINGS),

        .C_AXI_ID_WIDTH                      (C_AXI_ID_WIDTH),
        .C_AXI_ADDR_WIDTH                    (C_AXI_ADDR_WIDTH),
        .C_AXI_DATA_WIDTH                    (C_AXI_DATA_WIDTH),
        .C_HAS_AXI_AWUSER                    (C_HAS_AXI_AWUSER),
        .C_HAS_AXI_WUSER                     (C_HAS_AXI_WUSER),
        .C_HAS_AXI_BUSER                     (C_HAS_AXI_BUSER),
        .C_HAS_AXI_ARUSER                    (C_HAS_AXI_ARUSER),
        .C_HAS_AXI_RUSER                     (C_HAS_AXI_RUSER),
        .C_AXI_AWUSER_WIDTH                  (C_AXI_AWUSER_WIDTH),
        .C_AXI_WUSER_WIDTH                   (C_AXI_WUSER_WIDTH),
        .C_AXI_BUSER_WIDTH                   (C_AXI_BUSER_WIDTH),
        .C_AXI_ARUSER_WIDTH                  (C_AXI_ARUSER_WIDTH),
        .C_AXI_RUSER_WIDTH                   (C_AXI_RUSER_WIDTH),

        .C_HAS_AXIS_TDATA                    (C_HAS_AXIS_TDATA),
        .C_HAS_AXIS_TID                      (C_HAS_AXIS_TID),
        .C_HAS_AXIS_TDEST                    (C_HAS_AXIS_TDEST),
        .C_HAS_AXIS_TUSER                    (C_HAS_AXIS_TUSER),
        .C_HAS_AXIS_TREADY                   (C_HAS_AXIS_TREADY),
        .C_HAS_AXIS_TLAST                    (C_HAS_AXIS_TLAST),
        .C_HAS_AXIS_TSTRB                    (C_HAS_AXIS_TSTRB),
        .C_HAS_AXIS_TKEEP                    (C_HAS_AXIS_TKEEP),
        .C_AXIS_TDATA_WIDTH                  (C_AXIS_TDATA_WIDTH),
        .C_AXIS_TID_WIDTH                    (C_AXIS_TID_WIDTH),
        .C_AXIS_TDEST_WIDTH                  (C_AXIS_TDEST_WIDTH),
        .C_AXIS_TUSER_WIDTH                  (C_AXIS_TUSER_WIDTH),
        .C_AXIS_TSTRB_WIDTH                  (C_AXIS_TSTRB_WIDTH),
        .C_AXIS_TKEEP_WIDTH                  (C_AXIS_TKEEP_WIDTH),

        .C_WACH_TYPE                         (C_WACH_TYPE),
        .C_WDCH_TYPE                         (C_WDCH_TYPE),
        .C_WRCH_TYPE                         (C_WRCH_TYPE),
        .C_RACH_TYPE                         (C_RACH_TYPE),
        .C_RDCH_TYPE                         (C_RDCH_TYPE),
        .C_AXIS_TYPE                         (C_AXIS_TYPE),

        .C_IMPLEMENTATION_TYPE_WACH          (C_IMPLEMENTATION_TYPE_WACH),
        .C_IMPLEMENTATION_TYPE_WDCH          (C_IMPLEMENTATION_TYPE_WDCH),
        .C_IMPLEMENTATION_TYPE_WRCH          (C_IMPLEMENTATION_TYPE_WRCH),
        .C_IMPLEMENTATION_TYPE_RACH          (C_IMPLEMENTATION_TYPE_RACH),
        .C_IMPLEMENTATION_TYPE_RDCH          (C_IMPLEMENTATION_TYPE_RDCH),
        .C_IMPLEMENTATION_TYPE_AXIS          (C_IMPLEMENTATION_TYPE_AXIS),

        .C_APPLICATION_TYPE_WACH             (C_APPLICATION_TYPE_WACH),
        .C_APPLICATION_TYPE_WDCH             (C_APPLICATION_TYPE_WDCH),
        .C_APPLICATION_TYPE_WRCH             (C_APPLICATION_TYPE_WRCH),
        .C_APPLICATION_TYPE_RACH             (C_APPLICATION_TYPE_RACH),
        .C_APPLICATION_TYPE_RDCH             (C_APPLICATION_TYPE_RDCH),
        .C_APPLICATION_TYPE_AXIS             (C_APPLICATION_TYPE_AXIS),

        .C_USE_ECC_WACH                      (C_USE_ECC_WACH),
        .C_USE_ECC_WDCH                      (C_USE_ECC_WDCH),
        .C_USE_ECC_WRCH                      (C_USE_ECC_WRCH),
        .C_USE_ECC_RACH                      (C_USE_ECC_RACH),
        .C_USE_ECC_RDCH                      (C_USE_ECC_RDCH),
        .C_USE_ECC_AXIS                      (C_USE_ECC_AXIS),

        .C_ERROR_INJECTION_TYPE_WACH         (C_ERROR_INJECTION_TYPE_WACH),
        .C_ERROR_INJECTION_TYPE_WDCH         (C_ERROR_INJECTION_TYPE_WDCH),
        .C_ERROR_INJECTION_TYPE_WRCH         (C_ERROR_INJECTION_TYPE_WRCH),
        .C_ERROR_INJECTION_TYPE_RACH         (C_ERROR_INJECTION_TYPE_RACH),
        .C_ERROR_INJECTION_TYPE_RDCH         (C_ERROR_INJECTION_TYPE_RDCH),
        .C_ERROR_INJECTION_TYPE_AXIS         (C_ERROR_INJECTION_TYPE_AXIS),

        .C_DIN_WIDTH_WACH                    (C_DIN_WIDTH_WACH),
        .C_DIN_WIDTH_WDCH                    (C_DIN_WIDTH_WDCH),
        .C_DIN_WIDTH_WRCH                    (C_DIN_WIDTH_WRCH),
        .C_DIN_WIDTH_RACH                    (C_DIN_WIDTH_RACH),
        .C_DIN_WIDTH_RDCH                    (C_DIN_WIDTH_RDCH),
        .C_DIN_WIDTH_AXIS                    (C_DIN_WIDTH_AXIS),

        .C_WR_DEPTH_WACH                     (C_WR_DEPTH_WACH),
        .C_WR_DEPTH_WDCH                     (C_WR_DEPTH_WDCH),
        .C_WR_DEPTH_WRCH                     (C_WR_DEPTH_WRCH),
        .C_WR_DEPTH_RACH                     (C_WR_DEPTH_RACH),
        .C_WR_DEPTH_RDCH                     (C_WR_DEPTH_RDCH),
        .C_WR_DEPTH_AXIS                     (C_WR_DEPTH_AXIS),

        .C_WR_PNTR_WIDTH_WACH                (C_WR_PNTR_WIDTH_WACH),
        .C_WR_PNTR_WIDTH_WDCH                (C_WR_PNTR_WIDTH_WDCH),
        .C_WR_PNTR_WIDTH_WRCH                (C_WR_PNTR_WIDTH_WRCH),
        .C_WR_PNTR_WIDTH_RACH                (C_WR_PNTR_WIDTH_RACH),
        .C_WR_PNTR_WIDTH_RDCH                (C_WR_PNTR_WIDTH_RDCH),
        .C_WR_PNTR_WIDTH_AXIS                (C_WR_PNTR_WIDTH_AXIS),

        .C_HAS_DATA_COUNTS_WACH              (C_HAS_DATA_COUNTS_WACH),
        .C_HAS_DATA_COUNTS_WDCH              (C_HAS_DATA_COUNTS_WDCH),
        .C_HAS_DATA_COUNTS_WRCH              (C_HAS_DATA_COUNTS_WRCH),
        .C_HAS_DATA_COUNTS_RACH              (C_HAS_DATA_COUNTS_RACH),
        .C_HAS_DATA_COUNTS_RDCH              (C_HAS_DATA_COUNTS_RDCH),
        .C_HAS_DATA_COUNTS_AXIS              (C_HAS_DATA_COUNTS_AXIS),

        .C_PROG_FULL_TYPE_WACH               (C_PROG_FULL_TYPE_WACH),
        .C_PROG_FULL_TYPE_WDCH               (C_PROG_FULL_TYPE_WDCH),
        .C_PROG_FULL_TYPE_WRCH               (C_PROG_FULL_TYPE_WRCH),
        .C_PROG_FULL_TYPE_RACH               (C_PROG_FULL_TYPE_RACH),
        .C_PROG_FULL_TYPE_RDCH               (C_PROG_FULL_TYPE_RDCH),
        .C_PROG_FULL_TYPE_AXIS               (C_PROG_FULL_TYPE_AXIS),

        .C_PROG_FULL_THRESH_ASSERT_VAL_WACH  (C_PROG_FULL_THRESH_ASSERT_VAL_WACH),
        .C_PROG_FULL_THRESH_ASSERT_VAL_WDCH  (C_PROG_FULL_THRESH_ASSERT_VAL_WDCH),
        .C_PROG_FULL_THRESH_ASSERT_VAL_WRCH  (C_PROG_FULL_THRESH_ASSERT_VAL_WRCH),
        .C_PROG_FULL_THRESH_ASSERT_VAL_RACH  (C_PROG_FULL_THRESH_ASSERT_VAL_RACH),
        .C_PROG_FULL_THRESH_ASSERT_VAL_RDCH  (C_PROG_FULL_THRESH_ASSERT_VAL_RDCH),
        .C_PROG_FULL_THRESH_ASSERT_VAL_AXIS  (C_PROG_FULL_THRESH_ASSERT_VAL_AXIS),

        .C_PROG_EMPTY_TYPE_WACH              (C_PROG_EMPTY_TYPE_WACH),
        .C_PROG_EMPTY_TYPE_WDCH              (C_PROG_EMPTY_TYPE_WDCH),
        .C_PROG_EMPTY_TYPE_WRCH              (C_PROG_EMPTY_TYPE_WRCH),
        .C_PROG_EMPTY_TYPE_RACH              (C_PROG_EMPTY_TYPE_RACH),
        .C_PROG_EMPTY_TYPE_RDCH              (C_PROG_EMPTY_TYPE_RDCH),
        .C_PROG_EMPTY_TYPE_AXIS              (C_PROG_EMPTY_TYPE_AXIS),

        .C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH (C_PROG_EMPTY_THRESH_ASSERT_VAL_WACH),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH (C_PROG_EMPTY_THRESH_ASSERT_VAL_WDCH),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH (C_PROG_EMPTY_THRESH_ASSERT_VAL_WRCH),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH (C_PROG_EMPTY_THRESH_ASSERT_VAL_RACH),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH (C_PROG_EMPTY_THRESH_ASSERT_VAL_RDCH),
        .C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS (C_PROG_EMPTY_THRESH_ASSERT_VAL_AXIS),

        .C_REG_SLICE_MODE_WACH               (C_REG_SLICE_MODE_WACH),
        .C_REG_SLICE_MODE_WDCH               (C_REG_SLICE_MODE_WDCH),
        .C_REG_SLICE_MODE_WRCH               (C_REG_SLICE_MODE_WRCH),
        .C_REG_SLICE_MODE_RACH               (C_REG_SLICE_MODE_RACH),
        .C_REG_SLICE_MODE_RDCH               (C_REG_SLICE_MODE_RDCH),
        .C_REG_SLICE_MODE_AXIS               (C_REG_SLICE_MODE_AXIS)
        )
  fifo_generator_v8_5_dut
  (
        .BACKUP                         (BACKUP),
        .BACKUP_MARKER                  (BACKUP_MARKER),
        .CLK                            (CLK),
        .RST                            (RST),
        .SRST                           (SRST),
        .WR_CLK                         (WR_CLK),
        .WR_RST                         (WR_RST),
        .RD_CLK                         (RD_CLK),
        .RD_RST                         (RD_RST),
        .DIN                            (DIN),
        .WR_EN                          (WR_EN),
        .RD_EN                          (RD_EN),
        .PROG_EMPTY_THRESH              (PROG_EMPTY_THRESH),
        .PROG_EMPTY_THRESH_ASSERT       (PROG_EMPTY_THRESH_ASSERT),
        .PROG_EMPTY_THRESH_NEGATE       (PROG_EMPTY_THRESH_NEGATE),
        .PROG_FULL_THRESH               (PROG_FULL_THRESH),
        .PROG_FULL_THRESH_ASSERT        (PROG_FULL_THRESH_ASSERT),
        .PROG_FULL_THRESH_NEGATE        (PROG_FULL_THRESH_NEGATE),
        .INT_CLK                        (INT_CLK),
        .INJECTDBITERR                  (INJECTDBITERR),
        .INJECTSBITERR                  (INJECTSBITERR),
        .DOUT                           (DOUT),
        .FULL                           (FULL),
        .ALMOST_FULL                    (ALMOST_FULL),
        .WR_ACK                         (WR_ACK),
        .OVERFLOW                       (OVERFLOW),
        .EMPTY                          (EMPTY),
        .ALMOST_EMPTY                   (ALMOST_EMPTY),
        .VALID                          (VALID),
        .UNDERFLOW                      (UNDERFLOW),
        .DATA_COUNT                     (DATA_COUNT),
        .RD_DATA_COUNT                  (RD_DATA_COUNT),
        .WR_DATA_COUNT                  (WR_DATA_COUNT),
        .PROG_FULL                      (PROG_FULL),
        .PROG_EMPTY                     (PROG_EMPTY),
        .SBITERR                        (SBITERR),
        .DBITERR                        (DBITERR),

        .M_ACLK                         (M_ACLK),
        .S_ACLK                         (S_ACLK),
        .S_ARESETN                      (S_ARESETN),
        .M_ACLK_EN                      (M_ACLK_EN),
        .S_ACLK_EN                      (S_ACLK_EN),

        .M_AXI_AWID                     (M_AXI_AWID),
        .M_AXI_AWADDR                   (M_AXI_AWADDR),
        .M_AXI_AWLEN                    (M_AXI_AWLEN),
        .M_AXI_AWSIZE                   (M_AXI_AWSIZE),
        .M_AXI_AWBURST                  (M_AXI_AWBURST),
        .M_AXI_AWLOCK                   (M_AXI_AWLOCK),
        .M_AXI_AWCACHE                  (M_AXI_AWCACHE),
        .M_AXI_AWPROT                   (M_AXI_AWPROT),
        .M_AXI_AWQOS                    (M_AXI_AWQOS),
        .M_AXI_AWREGION                 (M_AXI_AWREGION),
        .M_AXI_AWUSER                   (M_AXI_AWUSER),
        .M_AXI_AWVALID                  (M_AXI_AWVALID),
        .M_AXI_AWREADY                  (M_AXI_AWREADY),
        .M_AXI_WID                      (M_AXI_WID),
        .M_AXI_WDATA                    (M_AXI_WDATA),
        .M_AXI_WSTRB                    (M_AXI_WSTRB),
        .M_AXI_WLAST                    (M_AXI_WLAST),
        .M_AXI_WUSER                    (M_AXI_WUSER),
        .M_AXI_WVALID                   (M_AXI_WVALID),
        .M_AXI_WREADY                   (M_AXI_WREADY),
        .M_AXI_BID                      (M_AXI_BID),
        .M_AXI_BRESP                    (M_AXI_BRESP),
        .M_AXI_BUSER                    (M_AXI_BUSER),
        .M_AXI_BVALID                   (M_AXI_BVALID),
        .M_AXI_BREADY                   (M_AXI_BREADY),

        .S_AXI_AWID                     (S_AXI_AWID),
        .S_AXI_AWADDR                   (S_AXI_AWADDR),
        .S_AXI_AWLEN                    (S_AXI_AWLEN),
        .S_AXI_AWSIZE                   (S_AXI_AWSIZE),
        .S_AXI_AWBURST                  (S_AXI_AWBURST),
        .S_AXI_AWLOCK                   (S_AXI_AWLOCK),
        .S_AXI_AWCACHE                  (S_AXI_AWCACHE),
        .S_AXI_AWPROT                   (S_AXI_AWPROT),
        .S_AXI_AWQOS                    (S_AXI_AWQOS),
        .S_AXI_AWREGION                 (S_AXI_AWREGION),
        .S_AXI_AWUSER                   (S_AXI_AWUSER),
        .S_AXI_AWVALID                  (S_AXI_AWVALID),
        .S_AXI_AWREADY                  (S_AXI_AWREADY),
        .S_AXI_WID                      (S_AXI_WID),
        .S_AXI_WDATA                    (S_AXI_WDATA),
        .S_AXI_WSTRB                    (S_AXI_WSTRB),
        .S_AXI_WLAST                    (S_AXI_WLAST),
        .S_AXI_WUSER                    (S_AXI_WUSER),
        .S_AXI_WVALID                   (S_AXI_WVALID),
        .S_AXI_WREADY                   (S_AXI_WREADY),
        .S_AXI_BID                      (S_AXI_BID),
        .S_AXI_BRESP                    (S_AXI_BRESP),
        .S_AXI_BUSER                    (S_AXI_BUSER),
        .S_AXI_BVALID                   (S_AXI_BVALID),
        .S_AXI_BREADY                   (S_AXI_BREADY),

        .M_AXI_ARID                     (M_AXI_ARID),
        .M_AXI_ARADDR                   (M_AXI_ARADDR),
        .M_AXI_ARLEN                    (M_AXI_ARLEN),
        .M_AXI_ARSIZE                   (M_AXI_ARSIZE),
        .M_AXI_ARBURST                  (M_AXI_ARBURST),
        .M_AXI_ARLOCK                   (M_AXI_ARLOCK),
        .M_AXI_ARCACHE                  (M_AXI_ARCACHE),
        .M_AXI_ARPROT                   (M_AXI_ARPROT),
        .M_AXI_ARQOS                    (M_AXI_ARQOS),
        .M_AXI_ARREGION                 (M_AXI_ARREGION),
        .M_AXI_ARUSER                   (M_AXI_ARUSER),
        .M_AXI_ARVALID                  (M_AXI_ARVALID),
        .M_AXI_ARREADY                  (M_AXI_ARREADY),
        .M_AXI_RID                      (M_AXI_RID),
        .M_AXI_RDATA                    (M_AXI_RDATA),
        .M_AXI_RRESP                    (M_AXI_RRESP),
        .M_AXI_RLAST                    (M_AXI_RLAST),
        .M_AXI_RUSER                    (M_AXI_RUSER),
        .M_AXI_RVALID                   (M_AXI_RVALID),
        .M_AXI_RREADY                   (M_AXI_RREADY),

        .S_AXI_ARID                     (S_AXI_ARID),
        .S_AXI_ARADDR                   (S_AXI_ARADDR),
        .S_AXI_ARLEN                    (S_AXI_ARLEN),
        .S_AXI_ARSIZE                   (S_AXI_ARSIZE),
        .S_AXI_ARBURST                  (S_AXI_ARBURST),
        .S_AXI_ARLOCK                   (S_AXI_ARLOCK),
        .S_AXI_ARCACHE                  (S_AXI_ARCACHE),
        .S_AXI_ARPROT                   (S_AXI_ARPROT),
        .S_AXI_ARQOS                    (S_AXI_ARQOS),
        .S_AXI_ARREGION                 (S_AXI_ARREGION),
        .S_AXI_ARUSER                   (S_AXI_ARUSER),
        .S_AXI_ARVALID                  (S_AXI_ARVALID),
        .S_AXI_ARREADY                  (S_AXI_ARREADY),
        .S_AXI_RID                      (S_AXI_RID),
        .S_AXI_RDATA                    (S_AXI_RDATA),
        .S_AXI_RRESP                    (S_AXI_RRESP),
        .S_AXI_RLAST                    (S_AXI_RLAST),
        .S_AXI_RUSER                    (S_AXI_RUSER),
        .S_AXI_RVALID                   (S_AXI_RVALID),
        .S_AXI_RREADY                   (S_AXI_RREADY),

        .M_AXIS_TVALID                  (M_AXIS_TVALID),
        .M_AXIS_TREADY                  (M_AXIS_TREADY),
        .M_AXIS_TDATA                   (M_AXIS_TDATA),
        .M_AXIS_TSTRB                   (M_AXIS_TSTRB),
        .M_AXIS_TKEEP                   (M_AXIS_TKEEP),
        .M_AXIS_TLAST                   (M_AXIS_TLAST),
        .M_AXIS_TID                     (M_AXIS_TID),
        .M_AXIS_TDEST                   (M_AXIS_TDEST),
        .M_AXIS_TUSER                   (M_AXIS_TUSER),

        .S_AXIS_TVALID                  (S_AXIS_TVALID),
        .S_AXIS_TREADY                  (S_AXIS_TREADY),
        .S_AXIS_TDATA                   (S_AXIS_TDATA),
        .S_AXIS_TSTRB                   (S_AXIS_TSTRB),
        .S_AXIS_TKEEP                   (S_AXIS_TKEEP),
        .S_AXIS_TLAST                   (S_AXIS_TLAST),
        .S_AXIS_TID                     (S_AXIS_TID),
        .S_AXIS_TDEST                   (S_AXIS_TDEST),
        .S_AXIS_TUSER                   (S_AXIS_TUSER),

        .AXI_AW_INJECTSBITERR           (AXI_AW_INJECTSBITERR),
        .AXI_AW_INJECTDBITERR           (AXI_AW_INJECTDBITERR),
        .AXI_AW_PROG_FULL_THRESH        (AXI_AW_PROG_FULL_THRESH),
        .AXI_AW_PROG_EMPTY_THRESH       (AXI_AW_PROG_EMPTY_THRESH),
        .AXI_AW_DATA_COUNT              (AXI_AW_DATA_COUNT),
        .AXI_AW_WR_DATA_COUNT           (AXI_AW_WR_DATA_COUNT),
        .AXI_AW_RD_DATA_COUNT           (AXI_AW_RD_DATA_COUNT),
        .AXI_AW_SBITERR                 (AXI_AW_SBITERR),
        .AXI_AW_DBITERR                 (AXI_AW_DBITERR),
        .AXI_AW_OVERFLOW                (AXI_AW_OVERFLOW),
        .AXI_AW_UNDERFLOW               (AXI_AW_UNDERFLOW),

        .AXI_W_INJECTSBITERR            (AXI_W_INJECTSBITERR),
        .AXI_W_INJECTDBITERR            (AXI_W_INJECTDBITERR),
        .AXI_W_PROG_FULL_THRESH         (AXI_W_PROG_FULL_THRESH),
        .AXI_W_PROG_EMPTY_THRESH        (AXI_W_PROG_EMPTY_THRESH),
        .AXI_W_DATA_COUNT               (AXI_W_DATA_COUNT),
        .AXI_W_WR_DATA_COUNT            (AXI_W_WR_DATA_COUNT),
        .AXI_W_RD_DATA_COUNT            (AXI_W_RD_DATA_COUNT),
        .AXI_W_SBITERR                  (AXI_W_SBITERR),
        .AXI_W_DBITERR                  (AXI_W_DBITERR),
        .AXI_W_OVERFLOW                 (AXI_W_OVERFLOW),
        .AXI_W_UNDERFLOW                (AXI_W_UNDERFLOW),

        .AXI_B_INJECTSBITERR            (AXI_B_INJECTSBITERR),
        .AXI_B_INJECTDBITERR            (AXI_B_INJECTDBITERR),
        .AXI_B_PROG_FULL_THRESH         (AXI_B_PROG_FULL_THRESH),
        .AXI_B_PROG_EMPTY_THRESH        (AXI_B_PROG_EMPTY_THRESH),
        .AXI_B_DATA_COUNT               (AXI_B_DATA_COUNT),
        .AXI_B_WR_DATA_COUNT            (AXI_B_WR_DATA_COUNT),
        .AXI_B_RD_DATA_COUNT            (AXI_B_RD_DATA_COUNT),
        .AXI_B_SBITERR                  (AXI_B_SBITERR),
        .AXI_B_DBITERR                  (AXI_B_DBITERR),
        .AXI_B_OVERFLOW                 (AXI_B_OVERFLOW),
        .AXI_B_UNDERFLOW                (AXI_B_UNDERFLOW),

        .AXI_AR_INJECTSBITERR           (AXI_AR_INJECTSBITERR),
        .AXI_AR_INJECTDBITERR           (AXI_AR_INJECTDBITERR),
        .AXI_AR_PROG_FULL_THRESH        (AXI_AR_PROG_FULL_THRESH),
        .AXI_AR_PROG_EMPTY_THRESH       (AXI_AR_PROG_EMPTY_THRESH),
        .AXI_AR_DATA_COUNT              (AXI_AR_DATA_COUNT),
        .AXI_AR_WR_DATA_COUNT           (AXI_AR_WR_DATA_COUNT),
        .AXI_AR_RD_DATA_COUNT           (AXI_AR_RD_DATA_COUNT),
        .AXI_AR_SBITERR                 (AXI_AR_SBITERR),
        .AXI_AR_DBITERR                 (AXI_AR_DBITERR),
        .AXI_AR_OVERFLOW                (AXI_AR_OVERFLOW),
        .AXI_AR_UNDERFLOW               (AXI_AR_UNDERFLOW),

        .AXI_R_INJECTSBITERR            (AXI_R_INJECTSBITERR),
        .AXI_R_INJECTDBITERR            (AXI_R_INJECTDBITERR),
        .AXI_R_PROG_FULL_THRESH         (AXI_R_PROG_FULL_THRESH),
        .AXI_R_PROG_EMPTY_THRESH        (AXI_R_PROG_EMPTY_THRESH),
        .AXI_R_DATA_COUNT               (AXI_R_DATA_COUNT),
        .AXI_R_WR_DATA_COUNT            (AXI_R_WR_DATA_COUNT),
        .AXI_R_RD_DATA_COUNT            (AXI_R_RD_DATA_COUNT),
        .AXI_R_SBITERR                  (AXI_R_SBITERR),
        .AXI_R_DBITERR                  (AXI_R_DBITERR),
        .AXI_R_OVERFLOW                 (AXI_R_OVERFLOW),
        .AXI_R_UNDERFLOW                (AXI_R_UNDERFLOW),

        .AXIS_INJECTSBITERR             (AXIS_INJECTSBITERR),
        .AXIS_INJECTDBITERR             (AXIS_INJECTDBITERR),
        .AXIS_PROG_FULL_THRESH          (AXIS_PROG_FULL_THRESH),
        .AXIS_PROG_EMPTY_THRESH         (AXIS_PROG_EMPTY_THRESH),
        .AXIS_DATA_COUNT                (AXIS_DATA_COUNT),
        .AXIS_WR_DATA_COUNT             (AXIS_WR_DATA_COUNT),
        .AXIS_RD_DATA_COUNT             (AXIS_RD_DATA_COUNT),
        .AXIS_SBITERR                   (AXIS_SBITERR),
        .AXIS_DBITERR                   (AXIS_DBITERR),
        .AXIS_OVERFLOW                  (AXIS_OVERFLOW),
        .AXIS_UNDERFLOW                 (AXIS_UNDERFLOW)
  
    );

endmodule
