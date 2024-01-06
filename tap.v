
module tk_tdr #(
parameter REG_WIDTH = 8
)(
   ijtag_tck,
   ijtag_reset,
   ijtag_sel,
   ijtag_ce,
   ijtag_se,
   ijtag_ue,
   ijtag_si,
   ijtag_so,
   data_in,
   data_out,
   load_data_en   
);
input                  ijtag_si;                        // Shift in
input                  ijtag_tck;                       // Clock
input                  ijtag_sel;                       // Enable to load data to TDR
input                  ijtag_ce;                        // Capture Enable
input                  ijtag_se;                        // Shift Enable
input                  ijtag_ue;                        // Update Enable
input                  ijtag_reset;                     // Reset (active low), Asynchronous reset
input  [REG_WIDTH-1:0]  data_in;                        // Parallel data in
output [REG_WIDTH-1:0]  data_out;                       // Parallel TDR out //assign data_in=data_out to load tdr back,
input                   load_data_en;
output                  ijtag_so;                       // Shift out

   reg    [REG_WIDTH-1:0] tdr;      // = {REG_WIDTH{1'b0}};  //comment out to avoid X skipping
   reg    [REG_WIDTH-1:0] data_out; // = {REG_WIDTH{1'b0}};
   reg    ijtag_so;                 

   always @ (posedge ijtag_tck) begin
     if (ijtag_ce  & ijtag_sel) begin
       tdr <= load_data_en ? data_in: data_out; //reload data 0:org 1:data_in
     end else if (ijtag_se & ijtag_sel ) begin
       tdr <= {ijtag_si, tdr[REG_WIDTH-1:1]};
     end
   end
   
   always @ (negedge ijtag_tck) begin
     ijtag_so <= tdr[0];
   end
  
   always @ (negedge ijtag_tck or negedge ijtag_reset) begin
     if (~ijtag_reset) begin
       data_out <= {REG_WIDTH{1'b0}};
     end else begin
       if (ijtag_ue & ijtag_sel) begin
         data_out <= tdr;
       end
     end
   end
endmodule // tdr

module tap_main (
    tdi                  , // i
    tms                  , // i
    tck                  , // i
    trst                 , // i
    tdo                  , // o
    fsm_state            , // o
    host_bscan_to_sel    , // o
    host_bscan_from_so   , // i
    force_disable        , // o
    select_jtag_input    , // o
    select_jtag_output   , // o
    extest_pulse         , // o
    extest_train         , // o
    host_1_to_sel        , // o
    host_1_from_so       , // i
    usr_ir_sel           , // o
    usr_dr_so            , // i
    capture_dr_en        , // o
    test_logic_reset     , // o
    shift_dr_en          , // o
    update_dr_en         , // o
    tdo_en               , // o
    monitor_IR           , // o
    monitor_DR_up        , // o
    monitor_DR             // o
); 
 
    input       tdi;
    input       tms;
    input       tck;
    input       trst;
    output      tdo;
    output      tdo_en;
    output[3:0] fsm_state;
    output      host_bscan_to_sel;
    input       host_bscan_from_so;
    output      force_disable;
    output      select_jtag_input;
    output      select_jtag_output;
    output      extest_pulse;
    output      extest_train;
    output      capture_dr_en;
    output      test_logic_reset;
    output      shift_dr_en;
    output      update_dr_en;
    output      host_1_to_sel;
    input       host_1_from_so;
    output [49:0]       usr_ir_sel;
    input  [49:0]       usr_dr_so;
//DFT
    output              monitor_DR_up;
    output [5:0]        monitor_IR;
    output [63:0]       monitor_DR;
 

reg [5:0] instruction, instruction_latch;
reg bypass;
reg  host_1_to_sel;
wire host_1_to_sel_int;
reg  host_tdr_00_to_sel;
wire host_tdr_00_to_sel_int;
reg  host_tdr_01_to_sel;
wire host_tdr_01_to_sel_int;
reg  host_tdr_02_to_sel;
wire host_tdr_02_to_sel_int;
reg  host_tdr_03_to_sel;
wire host_tdr_03_to_sel_int;
reg  host_tdr_04_to_sel;
wire host_tdr_04_to_sel_int;
reg  host_tdr_05_to_sel;
wire host_tdr_05_to_sel_int;
reg  host_tdr_06_to_sel;
wire host_tdr_06_to_sel_int;
reg  host_tdr_07_to_sel;
wire host_tdr_07_to_sel_int;
reg  host_tdr_08_to_sel;
wire host_tdr_08_to_sel_int;
reg  host_tdr_09_to_sel;
wire host_tdr_09_to_sel_int;
reg  host_tdr_10_to_sel;
wire host_tdr_10_to_sel_int;
reg  host_tdr_11_to_sel;
wire host_tdr_11_to_sel_int;
reg  host_tdr_12_to_sel;
wire host_tdr_12_to_sel_int;
reg  host_tdr_13_to_sel;
wire host_tdr_13_to_sel_int;
reg  host_tdr_14_to_sel;
wire host_tdr_14_to_sel_int;
reg  host_tdr_15_to_sel;
wire host_tdr_15_to_sel_int;
reg  host_tdr_16_to_sel;
wire host_tdr_16_to_sel_int;
reg  host_tdr_17_to_sel;
wire host_tdr_17_to_sel_int;
reg  host_tdr_18_to_sel;
wire host_tdr_18_to_sel_int;
reg  host_tdr_19_to_sel;
wire host_tdr_19_to_sel_int;
reg  host_tdr_20_to_sel;
wire host_tdr_20_to_sel_int;
reg  host_tdr_21_to_sel;
wire host_tdr_21_to_sel_int;
reg  host_tdr_22_to_sel;
wire host_tdr_22_to_sel_int;
reg  host_tdr_23_to_sel;
wire host_tdr_23_to_sel_int;
reg  host_tdr_24_to_sel;
wire host_tdr_24_to_sel_int;
reg  host_tdr_25_to_sel;
wire host_tdr_25_to_sel_int;
reg  host_tdr_26_to_sel;
wire host_tdr_26_to_sel_int;
reg  host_tdr_27_to_sel;
wire host_tdr_27_to_sel_int;
reg  host_tdr_28_to_sel;
wire host_tdr_28_to_sel_int;
reg  host_tdr_29_to_sel;
wire host_tdr_29_to_sel_int;
reg  host_tdr_30_to_sel;
wire host_tdr_30_to_sel_int;
reg  host_tdr_31_to_sel;
wire host_tdr_31_to_sel_int;
reg  host_tdr_32_to_sel;
wire host_tdr_32_to_sel_int;
reg  host_tdr_33_to_sel;
wire host_tdr_33_to_sel_int;
reg  host_tdr_34_to_sel;
wire host_tdr_34_to_sel_int;
reg  host_tdr_35_to_sel;
wire host_tdr_35_to_sel_int;
reg  host_tdr_36_to_sel;
wire host_tdr_36_to_sel_int;
reg  host_tdr_37_to_sel;
wire host_tdr_37_to_sel_int;
reg  host_tdr_38_to_sel;
wire host_tdr_38_to_sel_int;
reg  host_tdr_39_to_sel;
wire host_tdr_39_to_sel_int;
reg  host_tdr_40_to_sel;
wire host_tdr_40_to_sel_int;
reg  host_tdr_41_to_sel;
wire host_tdr_41_to_sel_int;
reg  host_tdr_42_to_sel;
wire host_tdr_42_to_sel_int;
reg  host_tdr_43_to_sel;
wire host_tdr_43_to_sel_int;
reg  host_tdr_44_to_sel;
wire host_tdr_44_to_sel_int;
reg  host_tdr_45_to_sel;
wire host_tdr_45_to_sel_int;
reg  host_tdr_46_to_sel;
wire host_tdr_46_to_sel_int;
reg  host_tdr_47_to_sel;
wire host_tdr_47_to_sel_int;
reg  host_tdr_48_to_sel;
wire host_tdr_48_to_sel_int;
reg  host_tdr_49_to_sel;
wire host_tdr_49_to_sel_int;
reg  retiming_tdo;
wire capture_dr_en;
wire test_logic_reset;
wire shift_dr_en;
wire update_dr_en;
wire tdo, tdo_int, tdr_mux;
wire irSel, irce, irse, irue, tlr;
wire [3:0] fsm_state_int;
wire bypass_or_unknown_instruction;
wire BYPASS_decoded;
wire CLAMP_decoded;
wire EXTEST_decoded;
wire EXTEST_PULSE_decoded;
wire EXTEST_TRAIN_decoded;
wire INTEST_decoded;
wire SAMPLE_PRELOAD_decoded;
wire HIGHZ_decoded;
wire HOSTIJTAG_1_decoded;
wire USERDEFINED_00_decoded;
wire USERDEFINED_01_decoded;
wire USERDEFINED_02_decoded;
wire USERDEFINED_03_decoded;
wire USERDEFINED_04_decoded;
wire USERDEFINED_05_decoded;
wire USERDEFINED_06_decoded;
wire USERDEFINED_07_decoded;
wire USERDEFINED_08_decoded;
wire USERDEFINED_09_decoded;
wire USERDEFINED_10_decoded;
wire USERDEFINED_11_decoded;
wire USERDEFINED_12_decoded;
wire USERDEFINED_13_decoded;
wire USERDEFINED_14_decoded;
wire USERDEFINED_15_decoded;
wire USERDEFINED_16_decoded;
wire USERDEFINED_17_decoded;
wire USERDEFINED_18_decoded;
wire USERDEFINED_19_decoded;
wire USERDEFINED_20_decoded;
wire USERDEFINED_21_decoded;
wire USERDEFINED_22_decoded;
wire USERDEFINED_23_decoded;
wire USERDEFINED_24_decoded;
wire USERDEFINED_25_decoded;
wire USERDEFINED_26_decoded;
wire USERDEFINED_27_decoded;
wire USERDEFINED_28_decoded;
wire USERDEFINED_29_decoded;
wire USERDEFINED_30_decoded;
wire USERDEFINED_31_decoded;
wire USERDEFINED_32_decoded;
wire USERDEFINED_33_decoded;
wire USERDEFINED_34_decoded;
wire USERDEFINED_35_decoded;
wire USERDEFINED_36_decoded;
wire USERDEFINED_37_decoded;
wire USERDEFINED_38_decoded;
wire USERDEFINED_39_decoded;
wire USERDEFINED_40_decoded;
wire USERDEFINED_41_decoded;
wire USERDEFINED_42_decoded;
wire USERDEFINED_43_decoded;
wire USERDEFINED_44_decoded;
wire USERDEFINED_45_decoded;
wire USERDEFINED_46_decoded;
wire USERDEFINED_47_decoded;
wire USERDEFINED_48_decoded;
wire USERDEFINED_49_decoded;
reg  BYPASS_decoded_latched;
reg  host_bscan_to_sel;
wire host_bscan_to_sel_int;
reg  force_disable;
wire force_disable_int;
reg  select_jtag_input;
wire select_jtag_input_int;
reg  select_jtag_output;
wire select_jtag_output_int;
reg  extest_pulse;
wire extest_pulse_int;
reg  extest_train;
wire extest_train_int;

//DFT

assign monitor_IR = instruction;
assign monitor_DR_up = update_dr_en;

tk_tdr #(.REG_WIDTH(64)) monitor_tdr(   
      .ijtag_reset(test_logic_reset), .ijtag_sel(1'b1), 
      .ijtag_si(tdi), .ijtag_ce(capture_dr_en), .ijtag_se(shift_dr_en), 
      .ijtag_ue(update_dr_en), .ijtag_tck(tck),  
      .ijtag_so(),
      .data_in(64'h0000000000000000),
      .data_out(monitor_DR),
      .load_data_en(1'b1)   
    );

    assign usr_ir_sel[0] = host_tdr_00_to_sel;      
    assign usr_ir_sel[1] = host_tdr_01_to_sel;    
    assign usr_ir_sel[2] = host_tdr_02_to_sel;      
    assign usr_ir_sel[3] = host_tdr_03_to_sel;    
    assign usr_ir_sel[4] = host_tdr_04_to_sel;   
    assign usr_ir_sel[5] = host_tdr_05_to_sel;   
    assign usr_ir_sel[6] = host_tdr_06_to_sel;   
    assign usr_ir_sel[7] = host_tdr_07_to_sel;   
    assign usr_ir_sel[8] = host_tdr_08_to_sel;   
    assign usr_ir_sel[9] = host_tdr_09_to_sel;   
    assign usr_ir_sel[10] = host_tdr_10_to_sel;      
    assign usr_ir_sel[11] = host_tdr_11_to_sel;    
    assign usr_ir_sel[12] = host_tdr_12_to_sel;      
    assign usr_ir_sel[13] = host_tdr_13_to_sel;    
    assign usr_ir_sel[14] = host_tdr_14_to_sel;   
    assign usr_ir_sel[15] = host_tdr_15_to_sel;   
    assign usr_ir_sel[16] = host_tdr_16_to_sel;   
    assign usr_ir_sel[17] = host_tdr_17_to_sel;   
    assign usr_ir_sel[18] = host_tdr_18_to_sel;   
    assign usr_ir_sel[19] = host_tdr_19_to_sel;  
    assign usr_ir_sel[20] = host_tdr_20_to_sel;   
    assign usr_ir_sel[21] = host_tdr_21_to_sel;    
    assign usr_ir_sel[22] = host_tdr_22_to_sel;      
    assign usr_ir_sel[23] = host_tdr_23_to_sel;    
    assign usr_ir_sel[24] = host_tdr_24_to_sel;   
    assign usr_ir_sel[25] = host_tdr_25_to_sel;   
    assign usr_ir_sel[26] = host_tdr_26_to_sel;   
    assign usr_ir_sel[27] = host_tdr_27_to_sel;   
    assign usr_ir_sel[28] = host_tdr_28_to_sel;   
    assign usr_ir_sel[29] = host_tdr_29_to_sel;   
    assign usr_ir_sel[30] = host_tdr_30_to_sel;   
    assign usr_ir_sel[31] = host_tdr_31_to_sel;    
    assign usr_ir_sel[32] = host_tdr_32_to_sel;      
    assign usr_ir_sel[33] = host_tdr_33_to_sel;    
    assign usr_ir_sel[34] = host_tdr_34_to_sel;   
    assign usr_ir_sel[35] = host_tdr_35_to_sel;   
    assign usr_ir_sel[36] = host_tdr_36_to_sel;   
    assign usr_ir_sel[37] = host_tdr_37_to_sel;   
    assign usr_ir_sel[38] = host_tdr_38_to_sel;   
    assign usr_ir_sel[39] = host_tdr_39_to_sel;   
    assign usr_ir_sel[40] = host_tdr_40_to_sel;   
    assign usr_ir_sel[41] = host_tdr_41_to_sel;    
    assign usr_ir_sel[42] = host_tdr_42_to_sel;      
    assign usr_ir_sel[43] = host_tdr_43_to_sel;    
    assign usr_ir_sel[44] = host_tdr_44_to_sel;   
    assign usr_ir_sel[45] = host_tdr_45_to_sel;   
    assign usr_ir_sel[46] = host_tdr_46_to_sel;   
    assign usr_ir_sel[47] = host_tdr_47_to_sel;   
    assign usr_ir_sel[48] = host_tdr_48_to_sel;   
    assign usr_ir_sel[49] = host_tdr_49_to_sel;   

    assign host_tdr_00_from_so = usr_dr_so[0];      
    assign host_tdr_01_from_so = usr_dr_so[1];    
    assign host_tdr_02_from_so = usr_dr_so[2];      
    assign host_tdr_03_from_so = usr_dr_so[3];    
    assign host_tdr_04_from_so = usr_dr_so[4];   
    assign host_tdr_05_from_so = usr_dr_so[5];   
    assign host_tdr_06_from_so = usr_dr_so[6];   
    assign host_tdr_07_from_so = usr_dr_so[7];   
    assign host_tdr_08_from_so = usr_dr_so[8];   
    assign host_tdr_09_from_so = usr_dr_so[9];   
    assign host_tdr_10_from_so = usr_dr_so[10];      
    assign host_tdr_11_from_so = usr_dr_so[11];    
    assign host_tdr_12_from_so = usr_dr_so[12];      
    assign host_tdr_13_from_so = usr_dr_so[13];    
    assign host_tdr_14_from_so = usr_dr_so[14];   
    assign host_tdr_15_from_so = usr_dr_so[15];   
    assign host_tdr_16_from_so = usr_dr_so[16];   
    assign host_tdr_17_from_so = usr_dr_so[17];   
    assign host_tdr_18_from_so = usr_dr_so[18];   
    assign host_tdr_19_from_so = usr_dr_so[19];   
    assign host_tdr_20_from_so = usr_dr_so[20];      
    assign host_tdr_21_from_so = usr_dr_so[21];    
    assign host_tdr_22_from_so = usr_dr_so[22];      
    assign host_tdr_23_from_so = usr_dr_so[23];    
    assign host_tdr_24_from_so = usr_dr_so[24];   
    assign host_tdr_25_from_so = usr_dr_so[25];   
    assign host_tdr_26_from_so = usr_dr_so[26];   
    assign host_tdr_27_from_so = usr_dr_so[27];   
    assign host_tdr_28_from_so = usr_dr_so[28];   
    assign host_tdr_29_from_so = usr_dr_so[29];   
    assign host_tdr_30_from_so = usr_dr_so[30];   
    assign host_tdr_31_from_so = usr_dr_so[31];    
    assign host_tdr_32_from_so = usr_dr_so[32];      
    assign host_tdr_33_from_so = usr_dr_so[33];    
    assign host_tdr_34_from_so = usr_dr_so[34];   
    assign host_tdr_35_from_so = usr_dr_so[35];   
    assign host_tdr_36_from_so = usr_dr_so[36];   
    assign host_tdr_37_from_so = usr_dr_so[37];   
    assign host_tdr_38_from_so = usr_dr_so[38];   
    assign host_tdr_39_from_so = usr_dr_so[39];   
    assign host_tdr_40_from_so = usr_dr_so[40];   
    assign host_tdr_41_from_so = usr_dr_so[41];    
    assign host_tdr_42_from_so = usr_dr_so[42];      
    assign host_tdr_43_from_so = usr_dr_so[43];    
    assign host_tdr_44_from_so = usr_dr_so[44];   
    assign host_tdr_45_from_so = usr_dr_so[45];   
    assign host_tdr_46_from_so = usr_dr_so[46];   
    assign host_tdr_47_from_so = usr_dr_so[47];   
    assign host_tdr_48_from_so = usr_dr_so[48];   
    assign host_tdr_49_from_so = usr_dr_so[49];   

assign host_bscan_to_sel_int = 
  (
    EXTEST_decoded |
    INTEST_decoded |
    EXTEST_PULSE_decoded |
    EXTEST_TRAIN_decoded |
    SAMPLE_PRELOAD_decoded  
  );
assign force_disable_int = HIGHZ_decoded;
assign select_jtag_input_int = INTEST_decoded;
assign select_jtag_output_int = 
  (
    EXTEST_decoded |
    EXTEST_PULSE_decoded |
    EXTEST_TRAIN_decoded |
    CLAMP_decoded |
    HIGHZ_decoded  
  );
assign extest_pulse_int = EXTEST_PULSE_decoded;
assign extest_train_int = EXTEST_TRAIN_decoded;
assign fsm_state = fsm_state_int;
assign host_1_to_sel_int = HOSTIJTAG_1_decoded;
assign host_tdr_00_to_sel_int = USERDEFINED_00_decoded;
assign host_tdr_01_to_sel_int = USERDEFINED_01_decoded;
assign host_tdr_02_to_sel_int = USERDEFINED_02_decoded;
assign host_tdr_03_to_sel_int = USERDEFINED_03_decoded;
assign host_tdr_04_to_sel_int = USERDEFINED_04_decoded;
assign host_tdr_05_to_sel_int = USERDEFINED_05_decoded;
assign host_tdr_06_to_sel_int = USERDEFINED_06_decoded;
assign host_tdr_07_to_sel_int = USERDEFINED_07_decoded;
assign host_tdr_08_to_sel_int = USERDEFINED_08_decoded;
assign host_tdr_09_to_sel_int = USERDEFINED_09_decoded;
assign host_tdr_10_to_sel_int = USERDEFINED_10_decoded;

 
// --------- Instruction Decoding ----------
assign bypass_or_unknown_instruction =
 ~(
     CLAMP_decoded | 
     EXTEST_decoded | 
     EXTEST_PULSE_decoded | 
     EXTEST_TRAIN_decoded | 
     INTEST_decoded | 
     SAMPLE_PRELOAD_decoded | 
     HIGHZ_decoded | 
     HOSTIJTAG_1_decoded | 
     USERDEFINED_00_decoded | 
     USERDEFINED_01_decoded | 
     USERDEFINED_02_decoded | 
     USERDEFINED_03_decoded | 
     USERDEFINED_04_decoded | 
     USERDEFINED_05_decoded | 
     USERDEFINED_06_decoded | 
     USERDEFINED_07_decoded | 
     USERDEFINED_08_decoded | 
     USERDEFINED_09_decoded | 
     USERDEFINED_10_decoded 
     
  );
assign BYPASS_decoded = 
     bypass_or_unknown_instruction |
  (
  // instruction_code(0) 6'b111111
     instruction[5] &
     instruction[4] &
     instruction[3] &
     instruction[2] &
     instruction[1] &
     instruction[0] 
  );
assign CLAMP_decoded = 
  (
  // instruction_code(0) 6'b000000
    ~instruction[5] &
    ~instruction[4] &
    ~instruction[3] &
    ~instruction[2] &
    ~instruction[1] &
    ~instruction[0] 
  );
assign EXTEST_decoded = 
  (
  // instruction_code(0) 6'b000001
    ~instruction[5] &
    ~instruction[4] &
    ~instruction[3] &
    ~instruction[2] &
    ~instruction[1] &
     instruction[0] 
  );
assign EXTEST_PULSE_decoded = 
  (
  // instruction_code(0) 6'b000010
    ~instruction[5] &
    ~instruction[4] &
    ~instruction[3] &
    ~instruction[2] &
     instruction[1] &
    ~instruction[0] 
  );
assign EXTEST_TRAIN_decoded = 
  (
  // instruction_code(0) 6'b000011
    ~instruction[5] &
    ~instruction[4] &
    ~instruction[3] &
    ~instruction[2] &
     instruction[1] &
     instruction[0] 
  );
assign INTEST_decoded = 
  (
  // instruction_code(0) 6'b000100
    ~instruction[5] &
    ~instruction[4] &
    ~instruction[3] &
     instruction[2] &
    ~instruction[1] &
    ~instruction[0] 
  );
assign SAMPLE_PRELOAD_decoded = 
  (
  // instruction_code(0) 6'b000101
    ~instruction[5] &
    ~instruction[4] &
    ~instruction[3] &
     instruction[2] &
    ~instruction[1] &
     instruction[0] 
  );
assign HIGHZ_decoded = 
  (
  // instruction_code(0) 6'b000110
    ~instruction[5] &
    ~instruction[4] &
    ~instruction[3] &
     instruction[2] &
     instruction[1] &
    ~instruction[0] 
  );
assign HOSTIJTAG_1_decoded = 
  (
  // instruction_code(0) 6'b000111
    ~instruction[5] &
    ~instruction[4] &
    ~instruction[3] &
     instruction[2] &
     instruction[1] &
     instruction[0] 
  );
assign USERDEFINED_00_decoded = 
  (
  // instruction_code(0) 6'b001000
    ~instruction[5] &
    ~instruction[4] &
     instruction[3] &
    ~instruction[2] &
    ~instruction[1] &
    ~instruction[0] 
  );
assign USERDEFINED_01_decoded = 
  (
  // instruction_code(0) 6'b001001
    ~instruction[5] &
    ~instruction[4] &
     instruction[3] &
    ~instruction[2] &
    ~instruction[1] &
     instruction[0] 
  );
assign USERDEFINED_02_decoded = 
  (
  // instruction_code(0) 6'b001010
    ~instruction[5] &
    ~instruction[4] &
     instruction[3] &
    ~instruction[2] &
     instruction[1] &
    ~instruction[0] 
  );
assign USERDEFINED_03_decoded = 
  (
  // instruction_code(0) 6'b001011
    ~instruction[5] &
    ~instruction[4] &
     instruction[3] &
    ~instruction[2] &
     instruction[1] &
     instruction[0] 
  );
assign USERDEFINED_04_decoded = 
  (
  // instruction_code(0) 6'b001100
    ~instruction[5] &
    ~instruction[4] &
     instruction[3] &
     instruction[2] &
    ~instruction[1] &
    ~instruction[0] 
  );
assign USERDEFINED_05_decoded = 
  (
  // instruction_code(0) 6'b001101
    ~instruction[5] &
    ~instruction[4] &
     instruction[3] &
     instruction[2] &
    ~instruction[1] &
     instruction[0] 
  );
assign USERDEFINED_06_decoded = 
  (
  // instruction_code(0) 6'b001110
    ~instruction[5] &
    ~instruction[4] &
     instruction[3] &
     instruction[2] &
     instruction[1] &
    ~instruction[0] 
  );
assign USERDEFINED_07_decoded = 
  (
  // instruction_code(0) 6'b001111
    ~instruction[5] &
    ~instruction[4] &
     instruction[3] &
     instruction[2] &
     instruction[1] &
     instruction[0] 
  );
assign USERDEFINED_08_decoded = 
  (
  // instruction_code(0) 6'b010000
    ~instruction[5] &
     instruction[4] &
    ~instruction[3] &
    ~instruction[2] &
    ~instruction[1] &
    ~instruction[0] 
  );
assign USERDEFINED_09_decoded = 
  (
  // instruction_code(0) 6'b010001
    ~instruction[5] &
     instruction[4] &
    ~instruction[3] &
    ~instruction[2] &
    ~instruction[1] &
     instruction[0] 
  );
assign USERDEFINED_10_decoded = 
  (
  // instruction_code(0) 6'b010010
    ~instruction[5] &
     instruction[4] &
    ~instruction[3] &
    ~instruction[2] &
     instruction[1] &
    ~instruction[0] 
  );

assign tdr_mux =  BYPASS_decoded_latched ? bypass:
                  (BYPASS_decoded & bypass) |
                  (CLAMP_decoded & bypass) |
                  (EXTEST_decoded & host_bscan_from_so) |
                  (EXTEST_PULSE_decoded & host_bscan_from_so) |
                  (EXTEST_TRAIN_decoded & host_bscan_from_so) |
                  (INTEST_decoded & host_bscan_from_so) |
                  (SAMPLE_PRELOAD_decoded & host_bscan_from_so) |
                  (HIGHZ_decoded & bypass) |
                  (HOSTIJTAG_1_decoded & host_1_from_so) |
                  (USERDEFINED_00_decoded & host_tdr_00_from_so) |
                  (USERDEFINED_01_decoded & host_tdr_01_from_so) |
                  (USERDEFINED_02_decoded & host_tdr_02_from_so) |
                  (USERDEFINED_03_decoded & host_tdr_03_from_so) |
                  (USERDEFINED_04_decoded & host_tdr_04_from_so) |
                  (USERDEFINED_05_decoded & host_tdr_05_from_so) |
                  (USERDEFINED_06_decoded & host_tdr_06_from_so) |
                  (USERDEFINED_07_decoded & host_tdr_07_from_so) |
                  (USERDEFINED_08_decoded & host_tdr_08_from_so) |
                  (USERDEFINED_09_decoded & host_tdr_09_from_so) |
                  (USERDEFINED_10_decoded & host_tdr_10_from_so);
 
assign tdo_int = (irSel) ? instruction[0] : tdr_mux;
 
always @ (tck or tdo_int) begin
   if (~tck) begin
      retiming_tdo <= tdo_int;
   end
end
assign tdo = retiming_tdo;
 
always @ (posedge tck) begin
   if (irce) begin
       instruction <= 6'b000001;
   end else begin
       if (irse) begin
          instruction <= {tdi,instruction[5:1]};
       end
   end
   if (capture_dr_en) begin
       bypass <= 1'b0;
   end else begin
       if (shift_dr_en) begin
          bypass <= tdi;
       end
   end
end
always @ (negedge tck or negedge trst) begin
   if (~trst) begin
      instruction_latch       <= 6'b111111;
      host_bscan_to_sel       <= 1'b0;
      force_disable           <= 1'b0;
      select_jtag_input       <= 1'b0;
      select_jtag_output      <= 1'b0;
      extest_pulse            <= 1'b0;
      extest_train            <= 1'b0;
      host_1_to_sel           <= 1'b0;
      host_tdr_00_to_sel      <= 1'b0;
      host_tdr_01_to_sel      <= 1'b0;
      host_tdr_02_to_sel      <= 1'b0;
      host_tdr_03_to_sel      <= 1'b0;
      host_tdr_04_to_sel      <= 1'b0;
      host_tdr_05_to_sel      <= 1'b0;
      host_tdr_06_to_sel      <= 1'b0;
      host_tdr_07_to_sel      <= 1'b0;
      host_tdr_08_to_sel      <= 1'b0;
      host_tdr_09_to_sel      <= 1'b0;
      host_tdr_10_to_sel      <= 1'b0;
      BYPASS_decoded_latched  <= 1'b1;
   end else begin
      if (~test_logic_reset) begin
         instruction_latch    <= 6'b111111;
         host_bscan_to_sel    <= 1'b0;
         force_disable        <= 1'b0;
         select_jtag_input    <= 1'b0;
         select_jtag_output   <= 1'b0;
         extest_pulse         <= 1'b0;
         extest_train         <= 1'b0;
         host_1_to_sel        <= 1'b0;
         host_tdr_00_to_sel   <= 1'b0;
         host_tdr_01_to_sel   <= 1'b0;
         host_tdr_02_to_sel   <= 1'b0;
         host_tdr_03_to_sel   <= 1'b0;
         host_tdr_04_to_sel   <= 1'b0;
         host_tdr_05_to_sel   <= 1'b0;
         host_tdr_06_to_sel   <= 1'b0;
         host_tdr_07_to_sel   <= 1'b0;
         host_tdr_08_to_sel   <= 1'b0;
         host_tdr_09_to_sel   <= 1'b0;
         host_tdr_10_to_sel   <= 1'b0;
         BYPASS_decoded_latched <= 1'b1;
      end else begin
         if (irue) begin
            instruction_latch <= instruction;
            host_bscan_to_sel <= host_bscan_to_sel_int;
            force_disable     <= force_disable_int;
            select_jtag_input <= select_jtag_input_int;
            select_jtag_output <= select_jtag_output_int;
            extest_pulse      <= extest_pulse_int;
            extest_train      <= extest_train_int;
            host_1_to_sel     <= host_1_to_sel_int;
            host_tdr_00_to_sel <= host_tdr_00_to_sel_int;
            host_tdr_01_to_sel <= host_tdr_01_to_sel_int;
            host_tdr_02_to_sel <= host_tdr_02_to_sel_int;
            host_tdr_03_to_sel <= host_tdr_03_to_sel_int;
            host_tdr_04_to_sel <= host_tdr_04_to_sel_int;
            host_tdr_05_to_sel <= host_tdr_05_to_sel_int;
            host_tdr_06_to_sel <= host_tdr_06_to_sel_int;
            host_tdr_07_to_sel <= host_tdr_07_to_sel_int;
            host_tdr_08_to_sel <= host_tdr_08_to_sel_int;
            host_tdr_09_to_sel <= host_tdr_09_to_sel_int;
            host_tdr_10_to_sel <= host_tdr_10_to_sel_int;
            BYPASS_decoded_latched <= BYPASS_decoded;
         end
      end
   end
end
 
tap_main_fsm fsm (.tck(tck), .trst(trst), .tms(tms), .irSel(irSel), .irce(irce), .irse(irse), .irue(irue), .tlr(test_logic_reset), .ce(capture_dr_en), .se(shift_dr_en), .ue(update_dr_en), .state(fsm_state_int));
 
assign tdo_en = ~(irse | shift_dr_en);
 
endmodule
 
module tap_main_fsm (tck, trst, tms, irSel, irce, irse, irue, tlr, ce, se, ue, state);
input tck, trst, tms;
output irSel, irce, irse, irue, tlr, ce, se;
output ue;
output [3:0] state;
reg [3:0] state;
reg irSel, irce, irse, irue, tlr, ce, se;
reg ue;
reg [3:0] tms_sr;
wire five_tms;
always @ (negedge tck or negedge trst) begin
  if (~trst) begin
      irce  <= 1'b0;
      irse  <= 1'b0;
      ce    <= 1'b0;
      se    <= 1'b0;
  end else begin
      ce    <= (state == 4'b0110);
      se    <= (state == 4'b0010);
      irce  <= (state == 4'b1110);
      irse  <= (state == 4'b1010);
  end
end
assign five_tms = &tms_sr & tms;
always @ (posedge tck or negedge trst) begin
   if (~trst) begin
      state    <= 4'b1111;
      irSel    <= 1'b0;
      irue     <= 1'b0;
      tlr      <= 1'b0;
      ue       <= 1'b0;
      tms_sr   <= 4'b0;
   end else begin
      if (tms) begin
         tms_sr <= {1'b1,tms_sr[3:1]};
      end else begin
         tms_sr <= 4'b0;
      end
      if (five_tms) begin
        state <= 4'b1111;
        irSel <= 1'b0;
        irue  <= 1'b0;
        tlr   <= 1'b0;
        ue    <= 1'b0;
      end else begin
           if ((state == 4'b0100) & ~tms) irSel <= 1'b1;
           if (state == 4'b1101)          irSel <= 1'b0;
           irue <= ((state == 4'b1001) | (state == 4'b1000)) & tms;
           ue   <= ((state == 4'b0001) | (state == 4'b0000)) & tms;
           tlr  <= ~(((state == 4'b0100) | (state == 4'b1111)) & tms);
           case (state)
           4'b1111: if (tms)  state <= 4'b1111;
                    else      state <= 4'b1100;
           4'b1100: if (tms)  state <= 4'b0111;
                    else      state <= 4'b1100;
           4'b0111: if (tms)  state <= 4'b0100;
                    else      state <= 4'b0110;
           4'b0110: if (tms)  state <= 4'b0001;
                    else      state <= 4'b0010;
           4'b0010: if (tms)  state <= 4'b0001;
                    else      state <= 4'b0010;
           4'b0001: if (tms)  state <= 4'b0101;
                    else      state <= 4'b0011;
           4'b0011: if (tms)  state <= 4'b0000;
                    else      state <= 4'b0011;
           4'b0000: if (tms)  state <= 4'b0101;
                    else      state <= 4'b0010;
           4'b0101: if (tms)  state <= 4'b0111;
                    else      state <= 4'b1100;
           4'b0100: if (tms)  state <= 4'b1111;
                    else      state <= 4'b1110;
           4'b1110: if (tms)  state <= 4'b1001;
                    else      state <= 4'b1010;
           4'b1010: if (tms)  state <= 4'b1001;
                    else      state <= 4'b1010;
           4'b1001: if (tms)  state <= 4'b1101;
                    else      state <= 4'b1011;
           4'b1011: if (tms)  state <= 4'b1000;
                    else      state <= 4'b1011;
           4'b1000: if (tms)  state <= 4'b1101;
                    else      state <= 4'b1010;
           4'b1101: if (tms)  state <= 4'b0111;
                    else      state <= 4'b1100;
          endcase
      end
   end
end

endmodule
    

