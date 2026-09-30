// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Mon Sep 14 10:27:39 2026
// Host        : LU running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/vivadou_CEP/0_session/0_session.sim/sim_1/impl/timing/xsim/testbench_counter_8_bits_lesson_0_time_impl.v
// Design      : counter_8_bits_lesson_0
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "3b885d01" *) 
(* NotValidForBitStream *)
(* \DesignAttr:ENABLE_NOC_NETLIST_VIEW  *) 
(* \DesignAttr:ENABLE_AIE_NETLIST_VIEW  *) 
module counter_8_bits_lesson_0
   (clk,
    reset,
    ce,
    load,
    din,
    q,
    tc);
  input clk;
  input reset;
  input ce;
  input load;
  input [7:0]din;
  output [7:0]q;
  output tc;

  wire ce;
  wire ce_IBUF;
  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [7:0]din;
  wire [7:0]din_IBUF;
  wire load;
  wire load_IBUF;
  wire [7:0]p_1_in;
  wire [7:0]q;
  wire [7:0]q_OBUF;
  wire reset;
  wire reset_IBUF;
  wire tc;
  wire tc_OBUF;
  wire tc_OBUF_inst_i_2_n_0;
  wire \temp[4]_i_2_n_0 ;
  wire \temp[5]_i_2_n_0 ;
  wire \temp[7]_i_1_n_0 ;

initial begin
 $sdf_annotate("testbench_counter_8_bits_lesson_0_time_impl.sdf",,,,"tool_control");
end
  IBUF ce_IBUF_inst
       (.I(ce),
        .O(ce_IBUF));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  IBUF \din_IBUF[0]_inst 
       (.I(din[0]),
        .O(din_IBUF[0]));
  IBUF \din_IBUF[1]_inst 
       (.I(din[1]),
        .O(din_IBUF[1]));
  IBUF \din_IBUF[2]_inst 
       (.I(din[2]),
        .O(din_IBUF[2]));
  IBUF \din_IBUF[3]_inst 
       (.I(din[3]),
        .O(din_IBUF[3]));
  IBUF \din_IBUF[4]_inst 
       (.I(din[4]),
        .O(din_IBUF[4]));
  IBUF \din_IBUF[5]_inst 
       (.I(din[5]),
        .O(din_IBUF[5]));
  IBUF \din_IBUF[6]_inst 
       (.I(din[6]),
        .O(din_IBUF[6]));
  IBUF \din_IBUF[7]_inst 
       (.I(din[7]),
        .O(din_IBUF[7]));
  IBUF load_IBUF_inst
       (.I(load),
        .O(load_IBUF));
  OBUF \q_OBUF[0]_inst 
       (.I(q_OBUF[0]),
        .O(q[0]));
  OBUF \q_OBUF[1]_inst 
       (.I(q_OBUF[1]),
        .O(q[1]));
  OBUF \q_OBUF[2]_inst 
       (.I(q_OBUF[2]),
        .O(q[2]));
  OBUF \q_OBUF[3]_inst 
       (.I(q_OBUF[3]),
        .O(q[3]));
  OBUF \q_OBUF[4]_inst 
       (.I(q_OBUF[4]),
        .O(q[4]));
  OBUF \q_OBUF[5]_inst 
       (.I(q_OBUF[5]),
        .O(q[5]));
  OBUF \q_OBUF[6]_inst 
       (.I(q_OBUF[6]),
        .O(q[6]));
  OBUF \q_OBUF[7]_inst 
       (.I(q_OBUF[7]),
        .O(q[7]));
  IBUF reset_IBUF_inst
       (.I(reset),
        .O(reset_IBUF));
  OBUF tc_OBUF_inst
       (.I(tc_OBUF),
        .O(tc));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h80)) 
    tc_OBUF_inst_i_1
       (.I0(q_OBUF[7]),
        .I1(tc_OBUF_inst_i_2_n_0),
        .I2(q_OBUF[6]),
        .O(tc_OBUF));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    tc_OBUF_inst_i_2
       (.I0(q_OBUF[5]),
        .I1(q_OBUF[1]),
        .I2(q_OBUF[0]),
        .I3(q_OBUF[3]),
        .I4(q_OBUF[2]),
        .I5(q_OBUF[4]),
        .O(tc_OBUF_inst_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hC5)) 
    \temp[0]_i_1 
       (.I0(q_OBUF[0]),
        .I1(din_IBUF[0]),
        .I2(load_IBUF),
        .O(p_1_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h8BB8)) 
    \temp[1]_i_1 
       (.I0(din_IBUF[1]),
        .I1(load_IBUF),
        .I2(q_OBUF[0]),
        .I3(q_OBUF[1]),
        .O(p_1_in[1]));
  LUT5 #(
    .INIT(32'h8BB8B8B8)) 
    \temp[2]_i_1 
       (.I0(din_IBUF[2]),
        .I1(load_IBUF),
        .I2(q_OBUF[2]),
        .I3(q_OBUF[1]),
        .I4(q_OBUF[0]),
        .O(p_1_in[2]));
  LUT6 #(
    .INIT(64'h8BB8B8B8B8B8B8B8)) 
    \temp[3]_i_1 
       (.I0(din_IBUF[3]),
        .I1(load_IBUF),
        .I2(q_OBUF[3]),
        .I3(q_OBUF[0]),
        .I4(q_OBUF[1]),
        .I5(q_OBUF[2]),
        .O(p_1_in[3]));
  LUT6 #(
    .INIT(64'h8BB8B8B8B8B8B8B8)) 
    \temp[4]_i_1 
       (.I0(din_IBUF[4]),
        .I1(load_IBUF),
        .I2(q_OBUF[4]),
        .I3(q_OBUF[2]),
        .I4(q_OBUF[3]),
        .I5(\temp[4]_i_2_n_0 ),
        .O(p_1_in[4]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \temp[4]_i_2 
       (.I0(q_OBUF[0]),
        .I1(q_OBUF[1]),
        .O(\temp[4]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h8BB8)) 
    \temp[5]_i_1 
       (.I0(din_IBUF[5]),
        .I1(load_IBUF),
        .I2(q_OBUF[5]),
        .I3(\temp[5]_i_2_n_0 ),
        .O(p_1_in[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    \temp[5]_i_2 
       (.I0(q_OBUF[4]),
        .I1(q_OBUF[2]),
        .I2(q_OBUF[3]),
        .I3(q_OBUF[0]),
        .I4(q_OBUF[1]),
        .O(\temp[5]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h8BB8)) 
    \temp[6]_i_1 
       (.I0(din_IBUF[6]),
        .I1(load_IBUF),
        .I2(q_OBUF[6]),
        .I3(tc_OBUF_inst_i_2_n_0),
        .O(p_1_in[6]));
  LUT2 #(
    .INIT(4'hE)) 
    \temp[7]_i_1 
       (.I0(load_IBUF),
        .I1(ce_IBUF),
        .O(\temp[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h8BB8B8B8)) 
    \temp[7]_i_2 
       (.I0(din_IBUF[7]),
        .I1(load_IBUF),
        .I2(q_OBUF[7]),
        .I3(tc_OBUF_inst_i_2_n_0),
        .I4(q_OBUF[6]),
        .O(p_1_in[7]));
  FDRE #(
    .INIT(1'b0)) 
    \temp_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\temp[7]_i_1_n_0 ),
        .D(p_1_in[0]),
        .Q(q_OBUF[0]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \temp_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\temp[7]_i_1_n_0 ),
        .D(p_1_in[1]),
        .Q(q_OBUF[1]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \temp_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\temp[7]_i_1_n_0 ),
        .D(p_1_in[2]),
        .Q(q_OBUF[2]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \temp_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\temp[7]_i_1_n_0 ),
        .D(p_1_in[3]),
        .Q(q_OBUF[3]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \temp_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\temp[7]_i_1_n_0 ),
        .D(p_1_in[4]),
        .Q(q_OBUF[4]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \temp_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\temp[7]_i_1_n_0 ),
        .D(p_1_in[5]),
        .Q(q_OBUF[5]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \temp_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\temp[7]_i_1_n_0 ),
        .D(p_1_in[6]),
        .Q(q_OBUF[6]),
        .R(reset_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \temp_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\temp[7]_i_1_n_0 ),
        .D(p_1_in[7]),
        .Q(q_OBUF[7]),
        .R(reset_IBUF));
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
