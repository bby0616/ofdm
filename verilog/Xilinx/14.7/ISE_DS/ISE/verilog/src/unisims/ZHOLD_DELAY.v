// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/fuji/ZHOLD_DELAY.v,v 1.7 2012/05/14 21:39:53 robh Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2010 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 10.1
//  \   \         Description : Xilinx TEST ONLY Library Component
//  /   /                  Delay Element.
// /___/   /\     Filename : ZHOLD_DELAY.v
// \   \  /  \    
//  \___\/\___\
//
// Revision:
//    04/14/10 - Initial version.
//    05/12/11 - 609212 -- fix for ncsim
//    07/11/11 - 616630 -- Change/Combine attributes
//    05/10/12 - 659430 - remove GSR ref
// End Revision

`timescale  1 ps / 1 ps
module ZHOLD_DELAY (
          DLYFABRIC,
          DLYIFF,
          DLYIN
      );

   parameter ZHOLD_FABRIC = "DEFAULT"; // {"DEFAULT", "0", .... "31"}
   parameter ZHOLD_IFF    = "DEFAULT"; // {"DEFAULT", "0", .... "31"}

   output    DLYFABRIC;
   output    DLYIFF;
   input     DLYIN;

       localparam MODULE_NAME = "ZHOLD_DELAY";

//------------------- constants ------------------------------------
       localparam MAX_IFF_DELAY_COUNT = 31;
       localparam MIN_IFF_DELAY_COUNT = 0;

       localparam MAX_IDELAY_COUNT = 31;
       localparam MIN_IDELAY_COUNT = 0;

       real TAP_DELAY = 200.0;

       integer idelay_count=0;
       integer iff_idelay_count=0;

       // inputs
       wire dlyin_in;

       // outputs
       reg tap_out_fabric = 0;
       reg tap_out_iff = 0;

//----------------------------------------------------------------------
//-------------------------------  Output ------------------------------
//----------------------------------------------------------------------
       assign DLYFABRIC = tap_out_fabric;
       assign DLYIFF = tap_out_iff;

//----------------------------------------------------------------------
//-------------------------------  Input -------------------------------
//----------------------------------------------------------------------
       assign dlyin_in = DLYIN;


//------------------------------------------------------------
//---------------------   Initialization  --------------------
//------------------------------------------------------------
       initial begin

        //-------- ZHOLD_FABRIC check
           case (ZHOLD_FABRIC)
               "DEFAULT" : idelay_count = 0;
               "0"       : idelay_count = 0;
               "1"       : idelay_count = 1;
               "2"       : idelay_count = 2;
               "3"       : idelay_count = 3;
               "4"       : idelay_count = 4;
               "5"       : idelay_count = 5;
               "6"       : idelay_count = 6;
               "7"       : idelay_count = 7;
               "8"       : idelay_count = 8;
               "9"       : idelay_count = 9;
               "10"      : idelay_count = 10;
               "11"      : idelay_count = 11;
               "12"      : idelay_count = 12;
               "13"      : idelay_count = 13;
               "14"      : idelay_count = 14;
               "15"      : idelay_count = 15;
               "16"      : idelay_count = 16;
               "17"      : idelay_count = 17;
               "18"      : idelay_count = 18;
               "19"      : idelay_count = 19;
               "20"      : idelay_count = 20;
               "21"      : idelay_count = 21;
               "22"      : idelay_count = 22;
               "23"      : idelay_count = 23;
               "24"      : idelay_count = 24;
               "25"      : idelay_count = 25;
               "26"      : idelay_count = 26;
               "27"      : idelay_count = 27;
               "28"      : idelay_count = 28;
               "29"      : idelay_count = 29;
               "30"      : idelay_count = 30;
               "31"      : idelay_count = 31;
               default : begin
                  $display("Attribute Syntax Error : The attribute ZHOLD_FABRIC on %s instance %m is set to %s.  Legal values for this attribute are \"DEFAULT\", \"0\", \"1\" ..... \"31\"",MODULE_NAME,ZHOLD_FABRIC);
                  $finish;
               end
           endcase

        //-------- ZHOLD_IFF check
           case (ZHOLD_IFF)
               "DEFAULT" : iff_idelay_count = 0;
               "0"       : iff_idelay_count = 0;
               "1"       : iff_idelay_count = 1;
               "2"       : iff_idelay_count = 2;
               "3"       : iff_idelay_count = 3;
               "4"       : iff_idelay_count = 4;
               "5"       : iff_idelay_count = 5;
               "6"       : iff_idelay_count = 6;
               "7"       : iff_idelay_count = 7;
               "8"       : iff_idelay_count = 8;
               "9"       : iff_idelay_count = 9;
               "10"      : iff_idelay_count = 10;
               "11"      : iff_idelay_count = 11;
               "12"      : iff_idelay_count = 12;
               "13"      : iff_idelay_count = 13;
               "14"      : iff_idelay_count = 14;
               "15"      : iff_idelay_count = 15;
               "16"      : iff_idelay_count = 16;
               "17"      : iff_idelay_count = 17;
               "18"      : iff_idelay_count = 18;
               "19"      : iff_idelay_count = 19;
               "20"      : iff_idelay_count = 20;
               "21"      : iff_idelay_count = 21;
               "22"      : iff_idelay_count = 22;
               "23"      : iff_idelay_count = 23;
               "24"      : iff_idelay_count = 24;
               "25"      : iff_idelay_count = 25;
               "26"      : iff_idelay_count = 26;
               "27"      : iff_idelay_count = 27;
               "28"      : iff_idelay_count = 28;
               "29"      : iff_idelay_count = 29;
               "30"      : iff_idelay_count = 30;
               "31"      : iff_idelay_count = 31;
               default : begin
                  $display("Attribute Syntax Error : The attribute ZHOLD_IFF on %s instance %m is set to %s.  Legal values for this attribute are \"DEFAULT\", \"0\", \"1\"...\"31\"",MODULE_NAME,ZHOLD_IFF);
                  $finish;
               end
           endcase

       end // initial begin

    always@(dlyin_in) begin
        tap_out_fabric <= #(TAP_DELAY*idelay_count) dlyin_in;
        tap_out_iff    <= #(TAP_DELAY*iff_idelay_count) dlyin_in;
    end  // end always
    specify


       specparam PATHPULSE$ = 0;

    endspecify

endmodule // ZHOLD_DELAY
