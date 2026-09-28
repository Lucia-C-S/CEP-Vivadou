// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Mon Sep 28 10:41:21 2026
// Host        : LU running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/vivadou_CEP/phase_2/phase_2.sim/sim_1/impl/timing/xsim/tb_top_board_VGA_interface_phase_1_time_impl.v
// Design      : top_board_VGA_interface_phase_1
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

module CE_generator_25MHz
   (E,
    CLK,
    SW14_IBUF,
    ce_50Hz);
  output [0:0]E;
  input CLK;
  input SW14_IBUF;
  input ce_50Hz;

  wire CLK;
  wire [0:0]E;
  wire SW14_IBUF;
  wire ce_25MHz;
  wire ce_25MHz_i_1_n_0;
  wire ce_50Hz;
  wire [1:0]count;
  wire \count[0]_i_1_n_0 ;
  wire \count[1]_i_1_n_0 ;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h8)) 
    ce_25MHz_i_1
       (.I0(count[0]),
        .I1(count[1]),
        .O(ce_25MHz_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    ce_25MHz_reg
       (.C(CLK),
        .CE(1'b1),
        .D(ce_25MHz_i_1_n_0),
        .Q(ce_25MHz),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1 
       (.I0(count[0]),
        .O(\count[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count[1]_i_1 
       (.I0(count[1]),
        .I1(count[0]),
        .O(\count[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\count[0]_i_1_n_0 ),
        .Q(count[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(\count[1]_i_1_n_0 ),
        .Q(count[1]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hB8)) 
    \s_hctr[9]_i_1 
       (.I0(ce_25MHz),
        .I1(SW14_IBUF),
        .I2(ce_50Hz),
        .O(E));
endmodule

module CE_generator_50Hz
   (ce_50Hz,
    CLK);
  output ce_50Hz;
  input CLK;

  wire CLK;
  wire ce_50Hz;
  wire count0_carry__0_n_0;
  wire count0_carry__0_n_4;
  wire count0_carry__0_n_5;
  wire count0_carry__0_n_6;
  wire count0_carry__0_n_7;
  wire count0_carry__1_n_0;
  wire count0_carry__1_n_4;
  wire count0_carry__1_n_5;
  wire count0_carry__1_n_6;
  wire count0_carry__1_n_7;
  wire count0_carry__2_n_0;
  wire count0_carry__2_n_4;
  wire count0_carry__2_n_5;
  wire count0_carry__2_n_6;
  wire count0_carry__2_n_7;
  wire count0_carry__3_n_4;
  wire count0_carry__3_n_5;
  wire count0_carry__3_n_6;
  wire count0_carry__3_n_7;
  wire count0_carry_n_0;
  wire count0_carry_n_4;
  wire count0_carry_n_5;
  wire count0_carry_n_6;
  wire count0_carry_n_7;
  wire \count[0]_i_1_n_0 ;
  wire \count[20]_i_1_n_0 ;
  wire \count[20]_i_2_n_0 ;
  wire \count[20]_i_3_n_0 ;
  wire \count[20]_i_4_n_0 ;
  wire \count[20]_i_5_n_0 ;
  wire \count[20]_i_6_n_0 ;
  wire \count_reg_n_0_[0] ;
  wire \count_reg_n_0_[10] ;
  wire \count_reg_n_0_[11] ;
  wire \count_reg_n_0_[12] ;
  wire \count_reg_n_0_[13] ;
  wire \count_reg_n_0_[14] ;
  wire \count_reg_n_0_[15] ;
  wire \count_reg_n_0_[16] ;
  wire \count_reg_n_0_[17] ;
  wire \count_reg_n_0_[18] ;
  wire \count_reg_n_0_[19] ;
  wire \count_reg_n_0_[1] ;
  wire \count_reg_n_0_[20] ;
  wire \count_reg_n_0_[2] ;
  wire \count_reg_n_0_[3] ;
  wire \count_reg_n_0_[4] ;
  wire \count_reg_n_0_[5] ;
  wire \count_reg_n_0_[6] ;
  wire \count_reg_n_0_[7] ;
  wire \count_reg_n_0_[8] ;
  wire \count_reg_n_0_[9] ;
  wire [2:0]NLW_count0_carry_CO_UNCONNECTED;
  wire [2:0]NLW_count0_carry__0_CO_UNCONNECTED;
  wire [2:0]NLW_count0_carry__1_CO_UNCONNECTED;
  wire [2:0]NLW_count0_carry__2_CO_UNCONNECTED;
  wire [3:0]NLW_count0_carry__3_CO_UNCONNECTED;

  FDRE #(
    .INIT(1'b0)) 
    ce_50Hz_reg
       (.C(CLK),
        .CE(1'b1),
        .D(\count[20]_i_1_n_0 ),
        .Q(ce_50Hz),
        .R(1'b0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 count0_carry
       (.CI(1'b0),
        .CO({count0_carry_n_0,NLW_count0_carry_CO_UNCONNECTED[2:0]}),
        .CYINIT(\count_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({count0_carry_n_4,count0_carry_n_5,count0_carry_n_6,count0_carry_n_7}),
        .S({\count_reg_n_0_[4] ,\count_reg_n_0_[3] ,\count_reg_n_0_[2] ,\count_reg_n_0_[1] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 count0_carry__0
       (.CI(count0_carry_n_0),
        .CO({count0_carry__0_n_0,NLW_count0_carry__0_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({count0_carry__0_n_4,count0_carry__0_n_5,count0_carry__0_n_6,count0_carry__0_n_7}),
        .S({\count_reg_n_0_[8] ,\count_reg_n_0_[7] ,\count_reg_n_0_[6] ,\count_reg_n_0_[5] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 count0_carry__1
       (.CI(count0_carry__0_n_0),
        .CO({count0_carry__1_n_0,NLW_count0_carry__1_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({count0_carry__1_n_4,count0_carry__1_n_5,count0_carry__1_n_6,count0_carry__1_n_7}),
        .S({\count_reg_n_0_[12] ,\count_reg_n_0_[11] ,\count_reg_n_0_[10] ,\count_reg_n_0_[9] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 count0_carry__2
       (.CI(count0_carry__1_n_0),
        .CO({count0_carry__2_n_0,NLW_count0_carry__2_CO_UNCONNECTED[2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({count0_carry__2_n_4,count0_carry__2_n_5,count0_carry__2_n_6,count0_carry__2_n_7}),
        .S({\count_reg_n_0_[16] ,\count_reg_n_0_[15] ,\count_reg_n_0_[14] ,\count_reg_n_0_[13] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 count0_carry__3
       (.CI(count0_carry__2_n_0),
        .CO(NLW_count0_carry__3_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({count0_carry__3_n_4,count0_carry__3_n_5,count0_carry__3_n_6,count0_carry__3_n_7}),
        .S({\count_reg_n_0_[20] ,\count_reg_n_0_[19] ,\count_reg_n_0_[18] ,\count_reg_n_0_[17] }));
  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1 
       (.I0(\count_reg_n_0_[0] ),
        .O(\count[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \count[20]_i_1 
       (.I0(\count[20]_i_2_n_0 ),
        .I1(\count[20]_i_3_n_0 ),
        .I2(\count[20]_i_4_n_0 ),
        .I3(\count[20]_i_5_n_0 ),
        .I4(\count[20]_i_6_n_0 ),
        .O(\count[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000080000000000)) 
    \count[20]_i_2 
       (.I0(\count_reg_n_0_[10] ),
        .I1(\count_reg_n_0_[1] ),
        .I2(\count_reg_n_0_[12] ),
        .I3(\count_reg_n_0_[2] ),
        .I4(\count_reg_n_0_[16] ),
        .I5(\count_reg_n_0_[17] ),
        .O(\count[20]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hDF)) 
    \count[20]_i_3 
       (.I0(\count_reg_n_0_[6] ),
        .I1(\count_reg_n_0_[8] ),
        .I2(\count_reg_n_0_[15] ),
        .O(\count[20]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \count[20]_i_4 
       (.I0(\count_reg_n_0_[18] ),
        .I1(\count_reg_n_0_[3] ),
        .I2(\count_reg_n_0_[4] ),
        .I3(\count_reg_n_0_[11] ),
        .O(\count[20]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFF7)) 
    \count[20]_i_5 
       (.I0(\count_reg_n_0_[20] ),
        .I1(\count_reg_n_0_[0] ),
        .I2(\count_reg_n_0_[7] ),
        .I3(\count_reg_n_0_[9] ),
        .O(\count[20]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \count[20]_i_6 
       (.I0(\count_reg_n_0_[14] ),
        .I1(\count_reg_n_0_[13] ),
        .I2(\count_reg_n_0_[19] ),
        .I3(\count_reg_n_0_[5] ),
        .O(\count[20]_i_6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\count[0]_i_1_n_0 ),
        .Q(\count_reg_n_0_[0] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[10] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__1_n_6),
        .Q(\count_reg_n_0_[10] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[11] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__1_n_5),
        .Q(\count_reg_n_0_[11] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[12] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__1_n_4),
        .Q(\count_reg_n_0_[12] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[13] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__2_n_7),
        .Q(\count_reg_n_0_[13] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[14] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__2_n_6),
        .Q(\count_reg_n_0_[14] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[15] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__2_n_5),
        .Q(\count_reg_n_0_[15] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[16] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__2_n_4),
        .Q(\count_reg_n_0_[16] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[17] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__3_n_7),
        .Q(\count_reg_n_0_[17] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[18] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__3_n_6),
        .Q(\count_reg_n_0_[18] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[19] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__3_n_5),
        .Q(\count_reg_n_0_[19] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry_n_7),
        .Q(\count_reg_n_0_[1] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[20] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__3_n_4),
        .Q(\count_reg_n_0_[20] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry_n_6),
        .Q(\count_reg_n_0_[2] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry_n_5),
        .Q(\count_reg_n_0_[3] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[4] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry_n_4),
        .Q(\count_reg_n_0_[4] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[5] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__0_n_7),
        .Q(\count_reg_n_0_[5] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[6] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__0_n_6),
        .Q(\count_reg_n_0_[6] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[7] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__0_n_5),
        .Q(\count_reg_n_0_[7] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[8] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__0_n_4),
        .Q(\count_reg_n_0_[8] ),
        .R(\count[20]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[9] 
       (.C(CLK),
        .CE(1'b1),
        .D(count0_carry__1_n_7),
        .Q(\count_reg_n_0_[9] ),
        .R(\count[20]_i_1_n_0 ));
endmodule

module RGB_generator_Nexys_4_DDR
   (SR,
    Q,
    \green_reg[3]_0 ,
    \blue_reg[3]_0 ,
    CPU_RESETN_IBUF,
    E,
    D,
    CLK,
    \green_reg[3]_1 ,
    \blue_reg[3]_1 );
  output [0:0]SR;
  output [3:0]Q;
  output [3:0]\green_reg[3]_0 ;
  output [3:0]\blue_reg[3]_0 ;
  input CPU_RESETN_IBUF;
  input [0:0]E;
  input [3:0]D;
  input CLK;
  input [3:0]\green_reg[3]_1 ;
  input [3:0]\blue_reg[3]_1 ;

  wire CLK;
  wire CPU_RESETN_IBUF;
  wire [3:0]D;
  wire [0:0]E;
  wire [3:0]Q;
  wire [0:0]SR;
  wire [3:0]\blue_reg[3]_0 ;
  wire [3:0]\blue_reg[3]_1 ;
  wire [3:0]\green_reg[3]_0 ;
  wire [3:0]\green_reg[3]_1 ;

  LUT1 #(
    .INIT(2'h1)) 
    \FSM_onehot_C_S[14]_i_2 
       (.I0(CPU_RESETN_IBUF),
        .O(SR));
  FDRE #(
    .INIT(1'b0)) 
    \blue_reg[0] 
       (.C(CLK),
        .CE(E),
        .D(\blue_reg[3]_1 [0]),
        .Q(\blue_reg[3]_0 [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \blue_reg[1] 
       (.C(CLK),
        .CE(E),
        .D(\blue_reg[3]_1 [1]),
        .Q(\blue_reg[3]_0 [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \blue_reg[2] 
       (.C(CLK),
        .CE(E),
        .D(\blue_reg[3]_1 [2]),
        .Q(\blue_reg[3]_0 [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \blue_reg[3] 
       (.C(CLK),
        .CE(E),
        .D(\blue_reg[3]_1 [3]),
        .Q(\blue_reg[3]_0 [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \green_reg[0] 
       (.C(CLK),
        .CE(E),
        .D(\green_reg[3]_1 [0]),
        .Q(\green_reg[3]_0 [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \green_reg[1] 
       (.C(CLK),
        .CE(E),
        .D(\green_reg[3]_1 [1]),
        .Q(\green_reg[3]_0 [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \green_reg[2] 
       (.C(CLK),
        .CE(E),
        .D(\green_reg[3]_1 [2]),
        .Q(\green_reg[3]_0 [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \green_reg[3] 
       (.C(CLK),
        .CE(E),
        .D(\green_reg[3]_1 [3]),
        .Q(\green_reg[3]_0 [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \red_reg[0] 
       (.C(CLK),
        .CE(E),
        .D(D[0]),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \red_reg[1] 
       (.C(CLK),
        .CE(E),
        .D(D[1]),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \red_reg[2] 
       (.C(CLK),
        .CE(E),
        .D(D[2]),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \red_reg[3] 
       (.C(CLK),
        .CE(E),
        .D(D[3]),
        .Q(Q[3]),
        .R(SR));
endmodule

module edge_detector
   (E,
    input_sync_aux_reg_0,
    CLK,
    CPU_RESETN_IBUF);
  output [0:0]E;
  input input_sync_aux_reg_0;
  input CLK;
  input CPU_RESETN_IBUF;

  wire CLK;
  wire CPU_RESETN_IBUF;
  wire [0:0]E;
  wire input_sync_aux_reg_0;
  wire input_sync_aux_reg_n_0;
  wire input_t_1;
  wire input_t_1_i_1_n_0;

  FDRE #(
    .INIT(1'b0)) 
    input_sync_aux_reg
       (.C(CLK),
        .CE(1'b1),
        .D(input_sync_aux_reg_0),
        .Q(input_sync_aux_reg_n_0),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h8)) 
    input_t_1_i_1
       (.I0(input_sync_aux_reg_n_0),
        .I1(CPU_RESETN_IBUF),
        .O(input_t_1_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    input_t_1_reg
       (.C(CLK),
        .CE(1'b1),
        .D(input_t_1_i_1_n_0),
        .Q(input_t_1),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    \s_vctr[9]_i_1 
       (.I0(input_sync_aux_reg_n_0),
        .I1(input_t_1),
        .O(E));
endmodule

module horizontal_ctr
   (D,
    \s_hctr_reg[9]_0 ,
    \s_vctr_reg[9] ,
    \s_vctr_reg[9]_0 ,
    \s_hctr_reg[7]_0 ,
    Q,
    SW_IBUF,
    \blue_reg[1] ,
    SR,
    E,
    CLK);
  output [3:0]D;
  output [9:0]\s_hctr_reg[9]_0 ;
  output [3:0]\s_vctr_reg[9] ;
  output [3:0]\s_vctr_reg[9]_0 ;
  output \s_hctr_reg[7]_0 ;
  input [0:0]Q;
  input [11:0]SW_IBUF;
  input \blue_reg[1] ;
  input [0:0]SR;
  input [0:0]E;
  input CLK;

  wire CLK;
  wire [3:0]D;
  wire [0:0]E;
  wire [0:0]Q;
  wire [0:0]SR;
  wire [11:0]SW_IBUF;
  wire \blue_reg[1] ;
  wire hsync_i_2_n_0;
  wire [9:0]s_hctr;
  wire \s_hctr[2]_i_1_n_0 ;
  wire \s_hctr[9]_i_3_n_0 ;
  wire \s_hctr_reg[7]_0 ;
  wire [9:0]\s_hctr_reg[9]_0 ;
  wire [3:0]\s_vctr_reg[9] ;
  wire [3:0]\s_vctr_reg[9]_0 ;

  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \blue[0]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[0]),
        .I5(\blue_reg[1] ),
        .O(D[0]));
  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \blue[1]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[1]),
        .I5(\blue_reg[1] ),
        .O(D[1]));
  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \blue[2]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[2]),
        .I5(\blue_reg[1] ),
        .O(D[2]));
  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \blue[3]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[3]),
        .I5(\blue_reg[1] ),
        .O(D[3]));
  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \green[0]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[4]),
        .I5(\blue_reg[1] ),
        .O(\s_vctr_reg[9]_0 [0]));
  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \green[1]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[5]),
        .I5(\blue_reg[1] ),
        .O(\s_vctr_reg[9]_0 [1]));
  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \green[2]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[6]),
        .I5(\blue_reg[1] ),
        .O(\s_vctr_reg[9]_0 [2]));
  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \green[3]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[7]),
        .I5(\blue_reg[1] ),
        .O(\s_vctr_reg[9]_0 [3]));
  LUT6 #(
    .INIT(64'hFFF7F7F7F7F7F7FF)) 
    hsync_i_1
       (.I0(\s_hctr_reg[9]_0 [7]),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [8]),
        .I3(\s_hctr_reg[9]_0 [5]),
        .I4(\s_hctr_reg[9]_0 [6]),
        .I5(hsync_i_2_n_0),
        .O(\s_hctr_reg[7]_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    hsync_i_2
       (.I0(\s_hctr_reg[9]_0 [4]),
        .I1(\s_hctr_reg[9]_0 [3]),
        .O(hsync_i_2_n_0));
  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \red[0]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[8]),
        .I5(\blue_reg[1] ),
        .O(\s_vctr_reg[9] [0]));
  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \red[1]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[9]),
        .I5(\blue_reg[1] ),
        .O(\s_vctr_reg[9] [1]));
  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \red[2]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[10]),
        .I5(\blue_reg[1] ),
        .O(\s_vctr_reg[9] [2]));
  LUT6 #(
    .INIT(64'h0000000011150000)) 
    \red[3]_i_1 
       (.I0(Q),
        .I1(\s_hctr_reg[9]_0 [9]),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(SW_IBUF[11]),
        .I5(\blue_reg[1] ),
        .O(\s_vctr_reg[9] [3]));
  (* \PinAttr:I0:HOLD_DETOUR  = "195" *) 
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \s_hctr[0]_i_1 
       (.I0(\s_hctr_reg[9]_0 [0]),
        .O(s_hctr[0]));
  (* \PinAttr:I1:HOLD_DETOUR  = "195" *) 
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \s_hctr[1]_i_1 
       (.I0(\s_hctr_reg[9]_0 [1]),
        .I1(\s_hctr_reg[9]_0 [0]),
        .O(s_hctr[1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \s_hctr[2]_i_1 
       (.I0(\s_hctr_reg[9]_0 [2]),
        .I1(\s_hctr_reg[9]_0 [1]),
        .I2(\s_hctr_reg[9]_0 [0]),
        .O(\s_hctr[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \s_hctr[3]_i_1 
       (.I0(\s_hctr_reg[9]_0 [3]),
        .I1(\s_hctr_reg[9]_0 [1]),
        .I2(\s_hctr_reg[9]_0 [0]),
        .I3(\s_hctr_reg[9]_0 [2]),
        .O(s_hctr[3]));
  (* \PinAttr:I0:HOLD_DETOUR  = "193" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \s_hctr[4]_i_1 
       (.I0(\s_hctr_reg[9]_0 [4]),
        .I1(\s_hctr_reg[9]_0 [2]),
        .I2(\s_hctr_reg[9]_0 [0]),
        .I3(\s_hctr_reg[9]_0 [1]),
        .I4(\s_hctr_reg[9]_0 [3]),
        .O(s_hctr[4]));
  LUT6 #(
    .INIT(64'hFFFF00000000EFFF)) 
    \s_hctr[5]_i_1 
       (.I0(\s_hctr_reg[9]_0 [6]),
        .I1(\s_hctr_reg[9]_0 [7]),
        .I2(\s_hctr_reg[9]_0 [9]),
        .I3(\s_hctr_reg[9]_0 [8]),
        .I4(\s_hctr[9]_i_3_n_0 ),
        .I5(\s_hctr_reg[9]_0 [5]),
        .O(s_hctr[5]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \s_hctr[6]_i_1 
       (.I0(\s_hctr_reg[9]_0 [6]),
        .I1(\s_hctr[9]_i_3_n_0 ),
        .I2(\s_hctr_reg[9]_0 [5]),
        .O(s_hctr[6]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h9AAA)) 
    \s_hctr[7]_i_1 
       (.I0(\s_hctr_reg[9]_0 [7]),
        .I1(\s_hctr[9]_i_3_n_0 ),
        .I2(\s_hctr_reg[9]_0 [6]),
        .I3(\s_hctr_reg[9]_0 [5]),
        .O(s_hctr[7]));
  LUT6 #(
    .INIT(64'hFFFF3FFD0000C000)) 
    \s_hctr[8]_i_1 
       (.I0(\s_hctr_reg[9]_0 [9]),
        .I1(\s_hctr_reg[9]_0 [6]),
        .I2(\s_hctr_reg[9]_0 [5]),
        .I3(\s_hctr_reg[9]_0 [7]),
        .I4(\s_hctr[9]_i_3_n_0 ),
        .I5(\s_hctr_reg[9]_0 [8]),
        .O(s_hctr[8]));
  LUT6 #(
    .INIT(64'hDFFFFFFD20000000)) 
    \s_hctr[9]_i_2 
       (.I0(\s_hctr_reg[9]_0 [8]),
        .I1(\s_hctr[9]_i_3_n_0 ),
        .I2(\s_hctr_reg[9]_0 [7]),
        .I3(\s_hctr_reg[9]_0 [5]),
        .I4(\s_hctr_reg[9]_0 [6]),
        .I5(\s_hctr_reg[9]_0 [9]),
        .O(s_hctr[9]));
  (* \PinAttr:I4:HOLD_DETOUR  = "193" *) 
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \s_hctr[9]_i_3 
       (.I0(\s_hctr_reg[9]_0 [1]),
        .I1(\s_hctr_reg[9]_0 [0]),
        .I2(\s_hctr_reg[9]_0 [2]),
        .I3(\s_hctr_reg[9]_0 [3]),
        .I4(\s_hctr_reg[9]_0 [4]),
        .O(\s_hctr[9]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \s_hctr_reg[0] 
       (.C(CLK),
        .CE(E),
        .D(s_hctr[0]),
        .Q(\s_hctr_reg[9]_0 [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_hctr_reg[1] 
       (.C(CLK),
        .CE(E),
        .D(s_hctr[1]),
        .Q(\s_hctr_reg[9]_0 [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_hctr_reg[2] 
       (.C(CLK),
        .CE(E),
        .D(\s_hctr[2]_i_1_n_0 ),
        .Q(\s_hctr_reg[9]_0 [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_hctr_reg[3] 
       (.C(CLK),
        .CE(E),
        .D(s_hctr[3]),
        .Q(\s_hctr_reg[9]_0 [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_hctr_reg[4] 
       (.C(CLK),
        .CE(E),
        .D(s_hctr[4]),
        .Q(\s_hctr_reg[9]_0 [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_hctr_reg[5] 
       (.C(CLK),
        .CE(E),
        .D(s_hctr[5]),
        .Q(\s_hctr_reg[9]_0 [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_hctr_reg[6] 
       (.C(CLK),
        .CE(E),
        .D(s_hctr[6]),
        .Q(\s_hctr_reg[9]_0 [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_hctr_reg[7] 
       (.C(CLK),
        .CE(E),
        .D(s_hctr[7]),
        .Q(\s_hctr_reg[9]_0 [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_hctr_reg[8] 
       (.C(CLK),
        .CE(E),
        .D(s_hctr[8]),
        .Q(\s_hctr_reg[9]_0 [8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_hctr_reg[9] 
       (.C(CLK),
        .CE(E),
        .D(s_hctr[9]),
        .Q(\s_hctr_reg[9]_0 [9]),
        .R(SR));
endmodule

module hsync_generator
   (VGA_hsync_OBUF,
    hsync_reg_0,
    SR,
    E,
    hsync_reg_1,
    CLK,
    CPU_RESETN_IBUF,
    lopt,
    lopt_1);
  output VGA_hsync_OBUF;
  output hsync_reg_0;
  input [0:0]SR;
  input [0:0]E;
  input hsync_reg_1;
  input CLK;
  input CPU_RESETN_IBUF;
  output lopt;
  output lopt_1;

  wire CLK;
  wire CPU_RESETN_IBUF;
  wire [0:0]E;
  wire [0:0]SR;
  wire VGA_hsync_OBUF;
  wire hsync_reg_0;
  wire hsync_reg_1;
  wire hsync_reg_lopt_replica_1;
  wire hsync_reg_lopt_replica_2_1;

  assign lopt = hsync_reg_lopt_replica_1;
  assign lopt_1 = hsync_reg_lopt_replica_2_1;
  FDSE #(
    .INIT(1'b1)) 
    hsync_reg
       (.C(CLK),
        .CE(E),
        .D(hsync_reg_1),
        .Q(VGA_hsync_OBUF),
        .S(SR));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDSE #(
    .INIT(1'b1)) 
    hsync_reg_lopt_replica
       (.C(CLK),
        .CE(E),
        .D(hsync_reg_1),
        .Q(hsync_reg_lopt_replica_1),
        .S(SR));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDSE #(
    .INIT(1'b1)) 
    hsync_reg_lopt_replica_2
       (.C(CLK),
        .CE(E),
        .D(hsync_reg_1),
        .Q(hsync_reg_lopt_replica_2_1),
        .S(SR));
  LUT2 #(
    .INIT(4'h8)) 
    input_sync_aux_i_1
       (.I0(VGA_hsync_OBUF),
        .I1(CPU_RESETN_IBUF),
        .O(hsync_reg_0));
endmodule

(* ECO_CHECKSUM = "f4f6deef" *) 
(* NotValidForBitStream *)
(* \DesignAttr:ENABLE_NOC_NETLIST_VIEW  *) 
(* \DesignAttr:ENABLE_AIE_NETLIST_VIEW  *) 
module top_board_VGA_interface_phase_1
   (clk,
    CPU_RESETN,
    SW15,
    SW14,
    SW,
    LED,
    vsync_led,
    vsync_os,
    hsync_os,
    VGA_hsync,
    VGA_vsync,
    VGA_R,
    VGA_G,
    VGA_B);
  input clk;
  input CPU_RESETN;
  input SW15;
  input SW14;
  input [11:0]SW;
  output [9:0]LED;
  output vsync_led;
  output vsync_os;
  output hsync_os;
  output VGA_hsync;
  output VGA_vsync;
  output [3:0]VGA_R;
  output [3:0]VGA_G;
  output [3:0]VGA_B;

  wire CPU_RESETN;
  wire CPU_RESETN_IBUF;
  wire [9:0]LED;
  wire [9:0]LED_OBUF;
  wire [11:0]SW;
  wire SW14;
  wire SW14_IBUF;
  wire SW15;
  wire SW15_IBUF;
  wire [11:0]SW_IBUF;
  wire [3:0]VGA_B;
  wire [3:0]VGA_B_OBUF;
  wire [3:0]VGA_G;
  wire [3:0]VGA_G_OBUF;
  wire [3:0]VGA_R;
  wire [3:0]VGA_R_OBUF;
  wire VGA_hsync;
  wire VGA_vsync;
  wire VGA_vsync_OBUF;
  wire ce_50Hz;
  wire ce_vga;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire hsync_os;
  wire lopt;
  wire lopt_1;
  wire lopt_3;
  wire lopt_4;
  wire vsync_led;
  wire vsync_os;
  wire NLW_VGA_VGA_hsync_OBUF_UNCONNECTED;
  wire NLW_VGA_lopt_2_UNCONNECTED;
  wire [0:0]NLW_VGA_SR_UNCONNECTED;

initial begin
 $sdf_annotate("tb_top_board_VGA_interface_phase_1_time_impl.sdf",,,,"tool_control");
end
  CE_generator_25MHz CE_generator_25MHz_inst
       (.CLK(clk_IBUF_BUFG),
        .E(ce_vga),
        .SW14_IBUF(SW14_IBUF),
        .ce_50Hz(ce_50Hz));
  CE_generator_50Hz CE_generator_50Hz_inst
       (.CLK(clk_IBUF_BUFG),
        .ce_50Hz(ce_50Hz));
  IBUF CPU_RESETN_IBUF_inst
       (.I(CPU_RESETN),
        .O(CPU_RESETN_IBUF));
  OBUF \LED_OBUF[0]_inst 
       (.I(LED_OBUF[0]),
        .O(LED[0]));
  OBUF \LED_OBUF[1]_inst 
       (.I(LED_OBUF[1]),
        .O(LED[1]));
  OBUF \LED_OBUF[2]_inst 
       (.I(LED_OBUF[2]),
        .O(LED[2]));
  OBUF \LED_OBUF[3]_inst 
       (.I(LED_OBUF[3]),
        .O(LED[3]));
  OBUF \LED_OBUF[4]_inst 
       (.I(LED_OBUF[4]),
        .O(LED[4]));
  OBUF \LED_OBUF[5]_inst 
       (.I(LED_OBUF[5]),
        .O(LED[5]));
  OBUF \LED_OBUF[6]_inst 
       (.I(LED_OBUF[6]),
        .O(LED[6]));
  OBUF \LED_OBUF[7]_inst 
       (.I(LED_OBUF[7]),
        .O(LED[7]));
  OBUF \LED_OBUF[8]_inst 
       (.I(LED_OBUF[8]),
        .O(LED[8]));
  OBUF \LED_OBUF[9]_inst 
       (.I(LED_OBUF[9]),
        .O(LED[9]));
  IBUF SW14_IBUF_inst
       (.I(SW14),
        .O(SW14_IBUF));
  IBUF SW15_IBUF_inst
       (.I(SW15),
        .O(SW15_IBUF));
  IBUF \SW_IBUF[0]_inst 
       (.I(SW[0]),
        .O(SW_IBUF[0]));
  IBUF \SW_IBUF[10]_inst 
       (.I(SW[10]),
        .O(SW_IBUF[10]));
  IBUF \SW_IBUF[11]_inst 
       (.I(SW[11]),
        .O(SW_IBUF[11]));
  IBUF \SW_IBUF[1]_inst 
       (.I(SW[1]),
        .O(SW_IBUF[1]));
  IBUF \SW_IBUF[2]_inst 
       (.I(SW[2]),
        .O(SW_IBUF[2]));
  IBUF \SW_IBUF[3]_inst 
       (.I(SW[3]),
        .O(SW_IBUF[3]));
  IBUF \SW_IBUF[4]_inst 
       (.I(SW[4]),
        .O(SW_IBUF[4]));
  IBUF \SW_IBUF[5]_inst 
       (.I(SW[5]),
        .O(SW_IBUF[5]));
  IBUF \SW_IBUF[6]_inst 
       (.I(SW[6]),
        .O(SW_IBUF[6]));
  IBUF \SW_IBUF[7]_inst 
       (.I(SW[7]),
        .O(SW_IBUF[7]));
  IBUF \SW_IBUF[8]_inst 
       (.I(SW[8]),
        .O(SW_IBUF[8]));
  IBUF \SW_IBUF[9]_inst 
       (.I(SW[9]),
        .O(SW_IBUF[9]));
  vga_interface VGA
       (.CLK(clk_IBUF_BUFG),
        .CPU_RESETN_IBUF(CPU_RESETN_IBUF),
        .E(ce_vga),
        .LED_OBUF(LED_OBUF),
        .Q(VGA_R_OBUF),
        .SR(NLW_VGA_SR_UNCONNECTED[0]),
        .SW15_IBUF(SW15_IBUF),
        .SW_IBUF(SW_IBUF),
        .VGA_hsync_OBUF(NLW_VGA_VGA_hsync_OBUF_UNCONNECTED),
        .VGA_vsync_OBUF(VGA_vsync_OBUF),
        .\blue_reg[3] (VGA_B_OBUF),
        .\green_reg[3] (VGA_G_OBUF),
        .lopt(lopt),
        .lopt_1(lopt_1),
        .lopt_2(NLW_VGA_lopt_2_UNCONNECTED),
        .lopt_3(lopt_3),
        .lopt_4(lopt_4));
  OBUF \VGA_B_OBUF[0]_inst 
       (.I(VGA_B_OBUF[0]),
        .O(VGA_B[0]));
  OBUF \VGA_B_OBUF[1]_inst 
       (.I(VGA_B_OBUF[1]),
        .O(VGA_B[1]));
  OBUF \VGA_B_OBUF[2]_inst 
       (.I(VGA_B_OBUF[2]),
        .O(VGA_B[2]));
  OBUF \VGA_B_OBUF[3]_inst 
       (.I(VGA_B_OBUF[3]),
        .O(VGA_B[3]));
  OBUF \VGA_G_OBUF[0]_inst 
       (.I(VGA_G_OBUF[0]),
        .O(VGA_G[0]));
  OBUF \VGA_G_OBUF[1]_inst 
       (.I(VGA_G_OBUF[1]),
        .O(VGA_G[1]));
  OBUF \VGA_G_OBUF[2]_inst 
       (.I(VGA_G_OBUF[2]),
        .O(VGA_G[2]));
  OBUF \VGA_G_OBUF[3]_inst 
       (.I(VGA_G_OBUF[3]),
        .O(VGA_G[3]));
  OBUF \VGA_R_OBUF[0]_inst 
       (.I(VGA_R_OBUF[0]),
        .O(VGA_R[0]));
  OBUF \VGA_R_OBUF[1]_inst 
       (.I(VGA_R_OBUF[1]),
        .O(VGA_R[1]));
  OBUF \VGA_R_OBUF[2]_inst 
       (.I(VGA_R_OBUF[2]),
        .O(VGA_R[2]));
  OBUF \VGA_R_OBUF[3]_inst 
       (.I(VGA_R_OBUF[3]),
        .O(VGA_R[3]));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF VGA_hsync_OBUF_inst
       (.I(lopt_3),
        .O(VGA_hsync));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF VGA_vsync_OBUF_inst
       (.I(lopt),
        .O(VGA_vsync));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF hsync_os_OBUF_inst
       (.I(lopt_4),
        .O(hsync_os));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF vsync_led_OBUF_inst
       (.I(lopt_1),
        .O(vsync_led));
  (* OPT_MODIFIED = "SWEEP" *) 
  OBUF vsync_os_OBUF_inst
       (.I(VGA_vsync_OBUF),
        .O(vsync_os));
endmodule

module vertical_ctr
   (Q,
    \s_vctr_reg[6]_0 ,
    \s_vctr_reg[9]_0 ,
    LED_OBUF,
    SW15_IBUF,
    \LED[9] ,
    SR,
    E,
    CLK);
  output [0:0]Q;
  output \s_vctr_reg[6]_0 ;
  output \s_vctr_reg[9]_0 ;
  output [9:0]LED_OBUF;
  input SW15_IBUF;
  input [9:0]\LED[9] ;
  input [0:0]SR;
  input [0:0]E;
  input CLK;

  wire CLK;
  wire [0:0]E;
  wire [9:0]\LED[9] ;
  wire [9:0]LED_OBUF;
  wire [0:0]Q;
  wire [0:0]SR;
  wire SW15_IBUF;
  wire [9:1]s_vctr;
  wire \s_vctr[0]_i_1_n_0 ;
  wire \s_vctr[3]_i_2_n_0 ;
  wire \s_vctr[4]_i_1_n_0 ;
  wire \s_vctr[9]_i_3_n_0 ;
  wire \s_vctr[9]_i_4_n_0 ;
  wire \s_vctr[9]_i_5_n_0 ;
  wire \s_vctr_reg[6]_0 ;
  wire \s_vctr_reg[9]_0 ;
  wire [8:0]vctr;
  wire vsync_i_2_n_0;

  LUT3 #(
    .INIT(8'hB8)) 
    \LED_OBUF[0]_inst_i_1 
       (.I0(vctr[0]),
        .I1(SW15_IBUF),
        .I2(\LED[9] [0]),
        .O(LED_OBUF[0]));
  LUT3 #(
    .INIT(8'hB8)) 
    \LED_OBUF[1]_inst_i_1 
       (.I0(vctr[1]),
        .I1(SW15_IBUF),
        .I2(\LED[9] [1]),
        .O(LED_OBUF[1]));
  LUT3 #(
    .INIT(8'hB8)) 
    \LED_OBUF[2]_inst_i_1 
       (.I0(vctr[2]),
        .I1(SW15_IBUF),
        .I2(\LED[9] [2]),
        .O(LED_OBUF[2]));
  LUT3 #(
    .INIT(8'hB8)) 
    \LED_OBUF[3]_inst_i_1 
       (.I0(vctr[3]),
        .I1(SW15_IBUF),
        .I2(\LED[9] [3]),
        .O(LED_OBUF[3]));
  LUT3 #(
    .INIT(8'hB8)) 
    \LED_OBUF[4]_inst_i_1 
       (.I0(vctr[4]),
        .I1(SW15_IBUF),
        .I2(\LED[9] [4]),
        .O(LED_OBUF[4]));
  LUT3 #(
    .INIT(8'hB8)) 
    \LED_OBUF[5]_inst_i_1 
       (.I0(vctr[5]),
        .I1(SW15_IBUF),
        .I2(\LED[9] [5]),
        .O(LED_OBUF[5]));
  LUT3 #(
    .INIT(8'hB8)) 
    \LED_OBUF[6]_inst_i_1 
       (.I0(vctr[6]),
        .I1(SW15_IBUF),
        .I2(\LED[9] [6]),
        .O(LED_OBUF[6]));
  LUT3 #(
    .INIT(8'hB8)) 
    \LED_OBUF[7]_inst_i_1 
       (.I0(vctr[7]),
        .I1(SW15_IBUF),
        .I2(\LED[9] [7]),
        .O(LED_OBUF[7]));
  LUT3 #(
    .INIT(8'hB8)) 
    \LED_OBUF[8]_inst_i_1 
       (.I0(vctr[8]),
        .I1(SW15_IBUF),
        .I2(\LED[9] [8]),
        .O(LED_OBUF[8]));
  LUT3 #(
    .INIT(8'hB8)) 
    \LED_OBUF[9]_inst_i_1 
       (.I0(Q),
        .I1(SW15_IBUF),
        .I2(\LED[9] [9]),
        .O(LED_OBUF[9]));
  LUT5 #(
    .INIT(32'h55555554)) 
    \s_vctr[0]_i_1 
       (.I0(vctr[0]),
        .I1(\s_vctr[9]_i_3_n_0 ),
        .I2(vctr[8]),
        .I3(vctr[1]),
        .I4(vctr[7]),
        .O(\s_vctr[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \s_vctr[1]_i_1 
       (.I0(vctr[1]),
        .I1(vctr[0]),
        .O(s_vctr[1]));
  LUT6 #(
    .INIT(64'h00FFFFFEFF000000)) 
    \s_vctr[2]_i_1 
       (.I0(vctr[7]),
        .I1(vctr[8]),
        .I2(\s_vctr[9]_i_3_n_0 ),
        .I3(vctr[1]),
        .I4(vctr[0]),
        .I5(vctr[2]),
        .O(s_vctr[2]));
  LUT6 #(
    .INIT(64'h00000000FFFFFFFE)) 
    \s_vctr[3]_i_1 
       (.I0(vctr[7]),
        .I1(vctr[1]),
        .I2(vctr[8]),
        .I3(\s_vctr[9]_i_3_n_0 ),
        .I4(vctr[0]),
        .I5(\s_vctr[3]_i_2_n_0 ),
        .O(s_vctr[3]));
  LUT4 #(
    .INIT(16'h9555)) 
    \s_vctr[3]_i_2 
       (.I0(vctr[3]),
        .I1(vctr[2]),
        .I2(vctr[1]),
        .I3(vctr[0]),
        .O(\s_vctr[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \s_vctr[4]_i_1 
       (.I0(vctr[4]),
        .I1(vctr[3]),
        .I2(vctr[2]),
        .I3(vctr[1]),
        .I4(vctr[0]),
        .O(\s_vctr[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \s_vctr[5]_i_1 
       (.I0(vctr[3]),
        .I1(vctr[2]),
        .I2(vctr[1]),
        .I3(vctr[0]),
        .I4(vctr[4]),
        .I5(vctr[5]),
        .O(s_vctr[5]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h9A)) 
    \s_vctr[6]_i_1 
       (.I0(vctr[6]),
        .I1(\s_vctr[9]_i_5_n_0 ),
        .I2(vctr[5]),
        .O(s_vctr[6]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h9AAA)) 
    \s_vctr[7]_i_1 
       (.I0(vctr[7]),
        .I1(\s_vctr[9]_i_5_n_0 ),
        .I2(vctr[6]),
        .I3(vctr[5]),
        .O(s_vctr[7]));
  LUT5 #(
    .INIT(32'h9AAAAAAA)) 
    \s_vctr[8]_i_1 
       (.I0(vctr[8]),
        .I1(\s_vctr[9]_i_5_n_0 ),
        .I2(vctr[7]),
        .I3(vctr[5]),
        .I4(vctr[6]),
        .O(s_vctr[8]));
  LUT6 #(
    .INIT(64'hEF0000EFEF00EF00)) 
    \s_vctr[9]_i_2 
       (.I0(vctr[0]),
        .I1(\s_vctr[9]_i_3_n_0 ),
        .I2(\s_vctr[9]_i_4_n_0 ),
        .I3(Q),
        .I4(\s_vctr[9]_i_5_n_0 ),
        .I5(\s_vctr_reg[6]_0 ),
        .O(s_vctr[9]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFF7FFFF)) 
    \s_vctr[9]_i_3 
       (.I0(Q),
        .I1(vctr[3]),
        .I2(vctr[6]),
        .I3(vctr[5]),
        .I4(vctr[2]),
        .I5(vctr[4]),
        .O(\s_vctr[9]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \s_vctr[9]_i_4 
       (.I0(vctr[8]),
        .I1(vctr[1]),
        .I2(vctr[7]),
        .O(\s_vctr[9]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \s_vctr[9]_i_5 
       (.I0(vctr[3]),
        .I1(vctr[2]),
        .I2(vctr[1]),
        .I3(vctr[0]),
        .I4(vctr[4]),
        .O(\s_vctr[9]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \s_vctr[9]_i_6 
       (.I0(vctr[6]),
        .I1(vctr[5]),
        .I2(vctr[7]),
        .I3(vctr[8]),
        .O(\s_vctr_reg[6]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \s_vctr_reg[0] 
       (.C(CLK),
        .CE(E),
        .D(\s_vctr[0]_i_1_n_0 ),
        .Q(vctr[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_vctr_reg[1] 
       (.C(CLK),
        .CE(E),
        .D(s_vctr[1]),
        .Q(vctr[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_vctr_reg[2] 
       (.C(CLK),
        .CE(E),
        .D(s_vctr[2]),
        .Q(vctr[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_vctr_reg[3] 
       (.C(CLK),
        .CE(E),
        .D(s_vctr[3]),
        .Q(vctr[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_vctr_reg[4] 
       (.C(CLK),
        .CE(E),
        .D(\s_vctr[4]_i_1_n_0 ),
        .Q(vctr[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_vctr_reg[5] 
       (.C(CLK),
        .CE(E),
        .D(s_vctr[5]),
        .Q(vctr[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_vctr_reg[6] 
       (.C(CLK),
        .CE(E),
        .D(s_vctr[6]),
        .Q(vctr[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_vctr_reg[7] 
       (.C(CLK),
        .CE(E),
        .D(s_vctr[7]),
        .Q(vctr[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_vctr_reg[8] 
       (.C(CLK),
        .CE(E),
        .D(s_vctr[8]),
        .Q(vctr[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \s_vctr_reg[9] 
       (.C(CLK),
        .CE(E),
        .D(s_vctr[9]),
        .Q(Q),
        .R(SR));
  LUT6 #(
    .INIT(64'hFEFFFEFFFEFFFFEF)) 
    vsync_i_1
       (.I0(vsync_i_2_n_0),
        .I1(Q),
        .I2(vctr[4]),
        .I3(vctr[2]),
        .I4(vctr[0]),
        .I5(vctr[1]),
        .O(\s_vctr_reg[9]_0 ));
  LUT6 #(
    .INIT(64'h6FFFFFFFFFFFFFFF)) 
    vsync_i_2
       (.I0(vctr[2]),
        .I1(vctr[3]),
        .I2(vctr[8]),
        .I3(vctr[7]),
        .I4(vctr[5]),
        .I5(vctr[6]),
        .O(vsync_i_2_n_0));
endmodule

module vga_interface
   (VGA_hsync_OBUF,
    SR,
    VGA_vsync_OBUF,
    LED_OBUF,
    Q,
    \green_reg[3] ,
    \blue_reg[3] ,
    E,
    CLK,
    SW_IBUF,
    SW15_IBUF,
    CPU_RESETN_IBUF,
    lopt,
    lopt_1,
    lopt_2,
    lopt_3,
    lopt_4);
  output VGA_hsync_OBUF;
  output [0:0]SR;
  output VGA_vsync_OBUF;
  output [9:0]LED_OBUF;
  output [3:0]Q;
  output [3:0]\green_reg[3] ;
  output [3:0]\blue_reg[3] ;
  input [0:0]E;
  input CLK;
  input [11:0]SW_IBUF;
  input SW15_IBUF;
  input CPU_RESETN_IBUF;
  output lopt;
  output lopt_1;
  output lopt_2;
  output lopt_3;
  output lopt_4;

  wire CLK;
  wire CPU_RESETN_IBUF;
  wire [0:0]E;
  wire HORIZONTAL_COUNTER_INST_n_0;
  wire HORIZONTAL_COUNTER_INST_n_1;
  wire HORIZONTAL_COUNTER_INST_n_14;
  wire HORIZONTAL_COUNTER_INST_n_15;
  wire HORIZONTAL_COUNTER_INST_n_16;
  wire HORIZONTAL_COUNTER_INST_n_17;
  wire HORIZONTAL_COUNTER_INST_n_18;
  wire HORIZONTAL_COUNTER_INST_n_19;
  wire HORIZONTAL_COUNTER_INST_n_2;
  wire HORIZONTAL_COUNTER_INST_n_20;
  wire HORIZONTAL_COUNTER_INST_n_21;
  wire HORIZONTAL_COUNTER_INST_n_22;
  wire HORIZONTAL_COUNTER_INST_n_3;
  wire HSYNC_GENERATOR_INST_n_1;
  wire [9:0]LED_OBUF;
  wire [3:0]Q;
  wire [0:0]\^SR ;
  wire SW15_IBUF;
  wire [11:0]SW_IBUF;
  wire VERTICAL_COUNTER_INST_n_1;
  wire VERTICAL_COUNTER_INST_n_2;
  wire VGA_hsync_OBUF;
  wire VGA_vsync_OBUF;
  wire [3:0]\blue_reg[3] ;
  wire [3:0]\green_reg[3] ;
  wire [9:0]hctr;
  wire hsync_rising_edge;
  wire lopt;
  wire lopt_1;
  wire lopt_3;
  wire lopt_4;
  wire [9:9]vctr;
  wire NLW_VSYNC_GENERATOR_INST_lopt_2_UNCONNECTED;

  edge_detector EDGE_DETECTOR_INST
       (.CLK(CLK),
        .CPU_RESETN_IBUF(CPU_RESETN_IBUF),
        .E(hsync_rising_edge),
        .input_sync_aux_reg_0(HSYNC_GENERATOR_INST_n_1));
  horizontal_ctr HORIZONTAL_COUNTER_INST
       (.CLK(CLK),
        .D({HORIZONTAL_COUNTER_INST_n_0,HORIZONTAL_COUNTER_INST_n_1,HORIZONTAL_COUNTER_INST_n_2,HORIZONTAL_COUNTER_INST_n_3}),
        .E(E),
        .Q(vctr),
        .SR(\^SR ),
        .SW_IBUF(SW_IBUF),
        .\blue_reg[1] (VERTICAL_COUNTER_INST_n_1),
        .\s_hctr_reg[7]_0 (HORIZONTAL_COUNTER_INST_n_22),
        .\s_hctr_reg[9]_0 (hctr),
        .\s_vctr_reg[9] ({HORIZONTAL_COUNTER_INST_n_14,HORIZONTAL_COUNTER_INST_n_15,HORIZONTAL_COUNTER_INST_n_16,HORIZONTAL_COUNTER_INST_n_17}),
        .\s_vctr_reg[9]_0 ({HORIZONTAL_COUNTER_INST_n_18,HORIZONTAL_COUNTER_INST_n_19,HORIZONTAL_COUNTER_INST_n_20,HORIZONTAL_COUNTER_INST_n_21}));
  hsync_generator HSYNC_GENERATOR_INST
       (.CLK(CLK),
        .CPU_RESETN_IBUF(CPU_RESETN_IBUF),
        .E(E),
        .SR(\^SR ),
        .VGA_hsync_OBUF(VGA_hsync_OBUF),
        .hsync_reg_0(HSYNC_GENERATOR_INST_n_1),
        .hsync_reg_1(HORIZONTAL_COUNTER_INST_n_22),
        .lopt(lopt_3),
        .lopt_1(lopt_4));
  RGB_generator_Nexys_4_DDR RGB_GENERATOR_INST
       (.CLK(CLK),
        .CPU_RESETN_IBUF(CPU_RESETN_IBUF),
        .D({HORIZONTAL_COUNTER_INST_n_14,HORIZONTAL_COUNTER_INST_n_15,HORIZONTAL_COUNTER_INST_n_16,HORIZONTAL_COUNTER_INST_n_17}),
        .E(E),
        .Q(Q),
        .SR(\^SR ),
        .\blue_reg[3]_0 (\blue_reg[3] ),
        .\blue_reg[3]_1 ({HORIZONTAL_COUNTER_INST_n_0,HORIZONTAL_COUNTER_INST_n_1,HORIZONTAL_COUNTER_INST_n_2,HORIZONTAL_COUNTER_INST_n_3}),
        .\green_reg[3]_0 (\green_reg[3] ),
        .\green_reg[3]_1 ({HORIZONTAL_COUNTER_INST_n_18,HORIZONTAL_COUNTER_INST_n_19,HORIZONTAL_COUNTER_INST_n_20,HORIZONTAL_COUNTER_INST_n_21}));
  vertical_ctr VERTICAL_COUNTER_INST
       (.CLK(CLK),
        .E(hsync_rising_edge),
        .\LED[9] (hctr),
        .LED_OBUF(LED_OBUF),
        .Q(vctr),
        .SR(\^SR ),
        .SW15_IBUF(SW15_IBUF),
        .\s_vctr_reg[6]_0 (VERTICAL_COUNTER_INST_n_1),
        .\s_vctr_reg[9]_0 (VERTICAL_COUNTER_INST_n_2));
  vsync_generator VSYNC_GENERATOR_INST
       (.CLK(CLK),
        .E(E),
        .SR(\^SR ),
        .VGA_vsync_OBUF(VGA_vsync_OBUF),
        .lopt(lopt),
        .lopt_1(lopt_1),
        .lopt_2(NLW_VSYNC_GENERATOR_INST_lopt_2_UNCONNECTED),
        .vsync_reg_0(VERTICAL_COUNTER_INST_n_2));
endmodule

module vsync_generator
   (VGA_vsync_OBUF,
    SR,
    E,
    vsync_reg_0,
    CLK,
    lopt,
    lopt_1,
    lopt_2);
  output VGA_vsync_OBUF;
  input [0:0]SR;
  input [0:0]E;
  input vsync_reg_0;
  input CLK;
  output lopt;
  output lopt_1;
  output lopt_2;

  wire CLK;
  wire [0:0]E;
  wire [0:0]SR;
  wire VGA_vsync_OBUF;
  wire vsync_reg_0;
  wire vsync_reg_lopt_replica_1;
  wire vsync_reg_lopt_replica_2_1;

  assign lopt = vsync_reg_lopt_replica_1;
  assign lopt_1 = vsync_reg_lopt_replica_2_1;
  FDSE #(
    .INIT(1'b1)) 
    vsync_reg
       (.C(CLK),
        .CE(E),
        .D(vsync_reg_0),
        .Q(VGA_vsync_OBUF),
        .S(SR));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDSE #(
    .INIT(1'b1)) 
    vsync_reg_lopt_replica
       (.C(CLK),
        .CE(E),
        .D(vsync_reg_0),
        .Q(vsync_reg_lopt_replica_1),
        .S(SR));
  (* OPT_INSERTED_REPDRIVER *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  FDSE #(
    .INIT(1'b1)) 
    vsync_reg_lopt_replica_2
       (.C(CLK),
        .CE(E),
        .D(vsync_reg_0),
        .Q(vsync_reg_lopt_replica_2_1),
        .S(SR));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
