`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2023 03:38:32 PM
// Design Name: 
// Module Name: chip
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module chip(trst_n, tms, tdi, tck,tdo,led,sw);
    input trst_n;
    input tms;
    input tdi;
    input tck;
    input sw;
    output tdo;
    output[15:0] led;
    
    assign led[0] = select[1];
    assign led[1] = trst_n;
    assign led[2] = tdi;
    assign led[3] = tms;
    //assign led[4] = trst_n;
    //assign led[5] = tdo;
    //assign led[6] = trst;
    //assign tdo = 1'b0;
    //assign led[15:8] = 8'hFF;
    wire [49:0] select;
    wire  led_tdr_do;
    //wire [7:0] out;
    wire [7:0] led_tdr_out;
    wire [5:0] IR;
    assign led[15:8] = led_tdr_out; 
    
    tk_tdr #(.REG_WIDTH(8)) led_tdr(
   .ijtag_tck(tck),
   .ijtag_reset(tlr),
   .ijtag_sel(select[0]),
   .ijtag_ce(ce),
   .ijtag_se(se),
   .ijtag_ue(ue),
   .ijtag_si(tdi),
   .ijtag_so(led_tdr_do),
   .data_in(8'h0),
   .data_out(led_tdr_out),
   .load_data_en(1'b0)   
);
    wire IDCODE_tdr_do;
     tk_tdr #(.REG_WIDTH(32)) IDCODE(
   .ijtag_tck(tck),
   .ijtag_reset(tlr),
   .ijtag_sel(select[1]),
   .ijtag_ce(ce),
   .ijtag_se(se),
   .ijtag_ue(ue),
   .ijtag_si(tdi),
   .ijtag_so(IDCODE_tdr_do),
   .data_in(32'hA8B967EE),
   .data_out(),
   .load_data_en(1'b1)   
);
    
    
    tap_main tap(
    .tdi(tdi)                  , // i
    .tms(tms)                  , // i
    .tck(tck)                  , // i
    .trst(trst_n)                 , // i
    .tdo(tdo)                  , // o
    .fsm_state()            , // o
    .host_bscan_to_sel()    , // o
    .host_bscan_from_so(1'b0)   , // i
    .force_disable()        , // o
    .select_jtag_input()    , // o
    .select_jtag_output()   , // o
    .extest_pulse()         , // o
    .extest_train()         , // o
    .host_1_to_sel()        , // o
    .host_1_from_so(1'b0)       , // i
    .usr_ir_sel(select)           , // o
    .usr_dr_so({48'b0,IDCODE_tdr_do,led_tdr_do})            , // i
    .capture_dr_en(ce)        , // o
    .test_logic_reset(tlr)     , // o
    .shift_dr_en(se)          , // o
    .update_dr_en(ue)         , // o
    .tdo_en(tdo_en)               , // o
    .monitor_IR(IR)           , // o
    .monitor_DR_up()        , // o
    .monitor_DR()             // o
); 
    
endmodule
