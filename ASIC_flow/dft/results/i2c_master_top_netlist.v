/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Fri Aug 21 21:25:55 2026
/////////////////////////////////////////////////////////////


module i2c_master_bit_ctrl_DW01_dec_0 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;
  wire   n5, n15, n17, n21, n23, n25, n27, n29, n30, n31, n33, n35, n38, n41,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65;

  AO21X1 U24 ( .IN1(A[1]), .IN2(A[0]), .IN3(n30), .Q(SUM[1]) );
  XOR2X1 U25 ( .IN1(n31), .IN2(A[13]), .Q(SUM[13]) );
  XNOR2X1 U27 ( .IN1(A[12]), .IN2(n55), .Q(SUM[12]) );
  AO21X1 U1 ( .IN1(A[3]), .IN2(n63), .IN3(n27), .Q(SUM[3]) );
  AO21X1 U5 ( .IN1(A[4]), .IN2(n62), .IN3(n25), .Q(SUM[4]) );
  AO21X1 U6 ( .IN1(A[11]), .IN2(n56), .IN3(n33), .Q(SUM[11]) );
  AO21X1 U7 ( .IN1(A[9]), .IN2(n58), .IN3(n15), .Q(SUM[9]) );
  AO21X1 U8 ( .IN1(A[7]), .IN2(n59), .IN3(n54), .Q(SUM[7]) );
  AO21X1 U10 ( .IN1(A[10]), .IN2(n57), .IN3(n35), .Q(SUM[10]) );
  AO21X1 U11 ( .IN1(A[8]), .IN2(n41), .IN3(n17), .Q(SUM[8]) );
  AO21X1 U12 ( .IN1(A[6]), .IN2(n60), .IN3(n21), .Q(SUM[6]) );
  AO21X1 U14 ( .IN1(A[5]), .IN2(n61), .IN3(n23), .Q(SUM[5]) );
  AND2X1 U18 ( .IN1(n38), .IN2(n25), .Q(n17) );
  AO21X1 U30 ( .IN1(A[2]), .IN2(n64), .IN3(n29), .Q(SUM[2]) );
  INVX0 U2 ( .INP(n33), .ZN(n55) );
  INVX0 U3 ( .INP(n35), .ZN(n56) );
  INVX0 U4 ( .INP(n30), .ZN(n64) );
  INVX0 U9 ( .INP(n29), .ZN(n63) );
  INVX0 U13 ( .INP(n15), .ZN(n57) );
  INVX0 U15 ( .INP(n27), .ZN(n62) );
  INVX0 U16 ( .INP(n17), .ZN(n58) );
  INVX0 U17 ( .INP(n23), .ZN(n60) );
  INVX0 U19 ( .INP(n25), .ZN(n61) );
  NAND2X1 U20 ( .IN1(n23), .IN2(n5), .QN(n41) );
  INVX0 U21 ( .INP(A[0]), .ZN(SUM[0]) );
  NOR2X0 U22 ( .IN1(n55), .IN2(A[12]), .QN(n31) );
  INVX0 U23 ( .INP(n41), .ZN(n54) );
  INVX0 U26 ( .INP(n21), .ZN(n59) );
  NOR2X0 U28 ( .IN1(n62), .IN2(A[4]), .QN(n25) );
  NOR2X0 U29 ( .IN1(A[1]), .IN2(A[0]), .QN(n30) );
  NOR2X0 U31 ( .IN1(n57), .IN2(A[10]), .QN(n35) );
  NOR2X0 U32 ( .IN1(n56), .IN2(A[11]), .QN(n33) );
  NOR2X0 U33 ( .IN1(n64), .IN2(A[2]), .QN(n29) );
  NOR2X0 U34 ( .IN1(n58), .IN2(A[9]), .QN(n15) );
  NOR2X0 U35 ( .IN1(n63), .IN2(A[3]), .QN(n27) );
  NOR2X0 U36 ( .IN1(n53), .IN2(A[5]), .QN(n38) );
  NAND2X1 U37 ( .IN1(n65), .IN2(n5), .QN(n53) );
  NOR2X0 U38 ( .IN1(A[6]), .IN2(A[7]), .QN(n5) );
  NOR2X0 U39 ( .IN1(n61), .IN2(A[5]), .QN(n23) );
  NOR2X0 U40 ( .IN1(n60), .IN2(A[6]), .QN(n21) );
  INVX0 U41 ( .INP(A[8]), .ZN(n65) );
endmodule


module i2c_master_bit_ctrl_DW01_dec_1 ( A, SUM );
  input [15:0] A;
  output [15:0] SUM;
  wire   n8, n9, n18, n20, n22, n24, n26, n28, n30, n32, n33, n36, n38, n40,
         n42, n44, n45, n46, n47, n48, n49, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75;

  AND2X1 U12 ( .IN1(n24), .IN2(n8), .Q(n20) );
  AND2X1 U14 ( .IN1(n32), .IN2(n9), .Q(n28) );
  AND2X1 U1 ( .IN1(n42), .IN2(n49), .Q(n36) );
  AO21X1 U3 ( .IN1(A[12]), .IN2(n70), .IN3(n38), .Q(SUM[12]) );
  AO21X1 U4 ( .IN1(A[10]), .IN2(n72), .IN3(n42), .Q(SUM[10]) );
  AO21X1 U5 ( .IN1(A[9]), .IN2(n73), .IN3(n18), .Q(SUM[9]) );
  AO21X1 U6 ( .IN1(A[2]), .IN2(n74), .IN3(n32), .Q(SUM[2]) );
  XOR2X1 U7 ( .IN1(A[14]), .IN2(n36), .Q(SUM[14]) );
  AO21X1 U8 ( .IN1(A[8]), .IN2(n67), .IN3(n20), .Q(SUM[8]) );
  AO21X1 U10 ( .IN1(A[4]), .IN2(n63), .IN3(n28), .Q(SUM[4]) );
  AO21X1 U13 ( .IN1(A[11]), .IN2(n71), .IN3(n40), .Q(SUM[11]) );
  AO21X1 U15 ( .IN1(A[7]), .IN2(n68), .IN3(n22), .Q(SUM[7]) );
  AO21X1 U16 ( .IN1(A[5]), .IN2(n66), .IN3(n26), .Q(SUM[5]) );
  AO21X1 U17 ( .IN1(A[6]), .IN2(n65), .IN3(n24), .Q(SUM[6]) );
  OR2X1 U18 ( .IN1(A[12]), .IN2(A[13]), .Q(n44) );
  XNOR2X1 U19 ( .IN1(A[15]), .IN2(n45), .Q(SUM[15]) );
  AND2X1 U24 ( .IN1(n46), .IN2(n47), .Q(n24) );
  AND2X1 U25 ( .IN1(n48), .IN2(n9), .Q(n47) );
  AO21X1 U32 ( .IN1(A[13]), .IN2(n69), .IN3(n36), .Q(SUM[13]) );
  AO21X1 U46 ( .IN1(A[1]), .IN2(A[0]), .IN3(n33), .Q(SUM[1]) );
  AO21X1 U48 ( .IN1(A[3]), .IN2(n64), .IN3(n30), .Q(SUM[3]) );
  INVX0 U2 ( .INP(n28), .ZN(n66) );
  INVX0 U9 ( .INP(n33), .ZN(n74) );
  INVX0 U11 ( .INP(n40), .ZN(n70) );
  INVX0 U20 ( .INP(n42), .ZN(n71) );
  INVX0 U21 ( .INP(n18), .ZN(n72) );
  INVX0 U22 ( .INP(n20), .ZN(n73) );
  INVX0 U23 ( .INP(n32), .ZN(n64) );
  INVX0 U26 ( .INP(n24), .ZN(n68) );
  NAND2X1 U27 ( .IN1(n75), .IN2(n36), .QN(n45) );
  INVX0 U28 ( .INP(A[14]), .ZN(n75) );
  INVX0 U29 ( .INP(A[0]), .ZN(SUM[0]) );
  INVX0 U30 ( .INP(n26), .ZN(n65) );
  INVX0 U31 ( .INP(n38), .ZN(n69) );
  INVX0 U33 ( .INP(n30), .ZN(n63) );
  INVX0 U34 ( .INP(n22), .ZN(n67) );
  NOR2X0 U35 ( .IN1(n72), .IN2(A[10]), .QN(n42) );
  NOR2X0 U36 ( .IN1(n71), .IN2(A[11]), .QN(n40) );
  NOR2X0 U37 ( .IN1(n70), .IN2(A[12]), .QN(n38) );
  NOR2X0 U38 ( .IN1(A[0]), .IN2(A[1]), .QN(n33) );
  NOR2X0 U39 ( .IN1(n73), .IN2(A[9]), .QN(n18) );
  NOR2X0 U40 ( .IN1(A[7]), .IN2(A[8]), .QN(n8) );
  NOR2X0 U41 ( .IN1(n74), .IN2(A[2]), .QN(n46) );
  NOR2X0 U42 ( .IN1(A[5]), .IN2(A[6]), .QN(n48) );
  NOR2X0 U43 ( .IN1(A[11]), .IN2(n44), .QN(n49) );
  NOR2X0 U44 ( .IN1(A[3]), .IN2(A[4]), .QN(n9) );
  NOR2X0 U45 ( .IN1(n74), .IN2(A[2]), .QN(n32) );
  NOR2X0 U47 ( .IN1(n66), .IN2(A[5]), .QN(n26) );
  NOR2X0 U49 ( .IN1(n68), .IN2(A[7]), .QN(n22) );
  NOR2X0 U50 ( .IN1(n64), .IN2(A[3]), .QN(n30) );
endmodule


module i2c_master_bit_ctrl_test_1 ( clk, rst, nReset, ena, clk_cnt, cmd, 
        cmd_ack, busy, al, din, dout, scl_i, scl_o, scl_oen, sda_i, sda_o, 
        sda_oen, VDD, VSS, test_si, test_so, test_se );
  input [15:0] clk_cnt;
  input [3:0] cmd;
  input clk, rst, nReset, ena, din, scl_i, sda_i, VDD, VSS, test_si, test_se;
  output cmd_ack, busy, al, dout, scl_o, scl_oen, sda_o, sda_oen, test_so;
  wire   n491, dscl_oen, sSCL, N30, N35, N36, N37, N38, N39, N40, N41, N42,
         N43, N44, N45, N46, N47, N48, N49, N50, cSCL_1_, cSDA_1_, N71, N72,
         N73, N74, N79, N80, N81, N82, N83, N84, N85, N86, N87, N88, N89, N90,
         N91, N92, N93, N94, N95, N96, N97, N98, N99, N100, N101, N102, N103,
         N104, N105, N106, N123, N124, N125, N126, sta_condition,
         sto_condition, N129, N130, N132, sda_chk, N139, N228, n51, n57, n58,
         n59, n62, n75, n77, n79, n80, n115, n116, n117, n121, n122, n123,
         n124, n125, n150, n151, n152, n153, n154, n155, n156, n157, n158,
         n159, n160, n161, n164, n172, n173, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200,
         n201, n202, n203, n204, n205, n206, n207, n208, n209, n210, n211,
         n212, n213, n214, n492, n136, n137, n145, n238, n118, n126, n127,
         n128, n129, n131, n132, n133, n134, n139, n140, n141, n142, n143,
         n144, n250, n251, n252, n253, n254, n255, n256, n257, n258, n259,
         n275, n287, n291, n295, n297, n469, n470, n473, n495, n496, n497,
         n498, n499, n500, n501, n502, n503, n504, n505, n506, n507, n508,
         n509, n510, n511, n512, n513, n514, n515, n516, n517, n518, n519,
         n520, n521, n522, n523, n524, n525, n526, n527, n528, n529, n530,
         n531, n21, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n52,
         n53, n54, n55, n56, n60, n61, n63, n64, n65, n66, n68, n69, n70, n71,
         n72, n73, n74, n76, n78, n81, n82, n83, n84, n85, n86, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n22, n23,
         n24, n25, n67, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96;
  wire   [15:1] cnt;
  wire   [13:1] filter_cnt;

  SDFFARX1 cSDA_reg_0_ ( .D(N73), .SI(n529), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(n528), .QN(n125) );
  SDFFARX1 cSDA_reg_1_ ( .D(N74), .SI(n528), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cSDA_1_), .QN(n527) );
  SDFFARX1 cSCL_reg_0_ ( .D(N71), .SI(n531), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(n530), .QN(n124) );
  SDFFARX1 cSCL_reg_1_ ( .D(N72), .SI(n530), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cSCL_1_), .QN(n529) );
  SDFFARX1 filter_cnt_reg_7_ ( .D(N100), .SI(n501), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(filter_cnt[7]), .QN(n500) );
  SDFFARX1 filter_cnt_reg_1_ ( .D(N94), .SI(n145), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(filter_cnt[1]), .QN(n117) );
  SDFFARX1 filter_cnt_reg_2_ ( .D(N95), .SI(n117), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(filter_cnt[2]), .QN(n503) );
  SDFFARX1 filter_cnt_reg_6_ ( .D(N99), .SI(n502), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(filter_cnt[6]), .QN(n501) );
  SDFFARX1 filter_cnt_reg_8_ ( .D(N101), .SI(n500), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(filter_cnt[8]), .QN(n121) );
  SDFFARX1 filter_cnt_reg_9_ ( .D(N102), .SI(filter_cnt[8]), .SE(test_se), 
        .CLK(clk), .RSTB(nReset), .Q(filter_cnt[9]), .QN(n122) );
  SDFFARX1 filter_cnt_reg_10_ ( .D(N103), .SI(filter_cnt[9]), .SE(test_se), 
        .CLK(clk), .RSTB(nReset), .Q(filter_cnt[10]), .QN(n499) );
  SDFFARX1 filter_cnt_reg_11_ ( .D(N104), .SI(n499), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(filter_cnt[11]), .QN(n498) );
  SDFFARX1 filter_cnt_reg_12_ ( .D(N105), .SI(n498), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(filter_cnt[12]), .QN(n115) );
  SDFFARX1 filter_cnt_reg_13_ ( .D(N106), .SI(filter_cnt[12]), .SE(test_se), 
        .CLK(clk), .RSTB(nReset), .Q(filter_cnt[13]), .QN(n116) );
  SDFFASX1 fSCL_reg_0_ ( .D(n214), .SI(n510), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n469), .QN(n509) );
  SDFFASX1 fSCL_reg_1_ ( .D(n213), .SI(n509), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n79), .QN(n508) );
  SDFFASX1 fSCL_reg_2_ ( .D(n212), .SI(n508), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n80), .QN(n507) );
  SDFFASX1 fSDA_reg_0_ ( .D(n211), .SI(n507), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n470), .QN(n506) );
  SDFFASX1 fSDA_reg_1_ ( .D(n210), .SI(n506), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n75), .QN(n505) );
  SDFFASX1 fSDA_reg_2_ ( .D(n209), .SI(n505), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n77), .QN(n504) );
  SDFFASX1 dSCL_reg ( .D(N125), .SI(cnt[15]), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n118), .QN(n513) );
  SDFFASX1 dSDA_reg ( .D(N126), .SI(n513), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n133), .QN(n512) );
  SDFFARX1 sta_condition_reg ( .D(N129), .SI(n496), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(sta_condition), .QN(n495) );
  SDFFARX1 sto_condition_reg ( .D(N130), .SI(n495), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(sto_condition), .QN(test_so) );
  SDFFARX1 busy_reg ( .D(N132), .SI(n123), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(busy), .QN(n531) );
  SDFFX1 dout_reg ( .D(n164), .SI(n512), .SE(test_se), .CLK(clk), .Q(dout), 
        .QN(n511) );
  SDFFARX1 c_state_reg_0_ ( .D(n208), .SI(n527), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n144), .QN(n526) );
  SDFFARX1 c_state_reg_1_ ( .D(n203), .SI(n526), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n59), .QN(n525) );
  SDFFARX1 c_state_reg_2_ ( .D(n202), .SI(n525), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n58), .QN(n524) );
  SDFFARX1 c_state_reg_3_ ( .D(n201), .SI(n524), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n57), .QN(n523) );
  SDFFARX1 c_state_reg_4_ ( .D(n200), .SI(n523), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n143), .QN(n522) );
  SDFFARX1 c_state_reg_13_ ( .D(n191), .SI(n132), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n142), .QN(n518) );
  SDFFARX1 c_state_reg_14_ ( .D(n190), .SI(n518), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n257), .QN(n128) );
  SDFFARX1 c_state_reg_15_ ( .D(n189), .SI(n257), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n254), .QN(n129) );
  SDFFARX1 sda_chk_reg ( .D(n207), .SI(n297), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(sda_chk), .QN(n497) );
  SDFFARX1 c_state_reg_16_ ( .D(n204), .SI(n254), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n250), .QN(n517) );
  SDFFARX1 c_state_reg_5_ ( .D(n199), .SI(n522), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n255), .QN(n126) );
  SDFFARX1 c_state_reg_6_ ( .D(n198), .SI(n255), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n258), .QN(n127) );
  SDFFARX1 c_state_reg_7_ ( .D(n197), .SI(n258), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n51), .QN(n521) );
  SDFFARX1 c_state_reg_8_ ( .D(n196), .SI(n521), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n251), .QN(n131) );
  SDFFARX1 c_state_reg_9_ ( .D(n195), .SI(n131), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n141), .QN(n275) );
  SDFFARX1 c_state_reg_10_ ( .D(n194), .SI(n275), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n140), .QN(n520) );
  SDFFARX1 c_state_reg_11_ ( .D(n193), .SI(n520), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n139), .QN(n519) );
  SDFFARX1 c_state_reg_12_ ( .D(n192), .SI(n519), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n256), .QN(n132) );
  SDFFX1 dscl_oen_reg ( .D(n91), .SI(n511), .SE(test_se), .CLK(clk), .Q(
        dscl_oen), .QN(n510) );
  SDFFARX1 slave_wait_reg ( .D(N30), .SI(n287), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .QN(n496) );
  SDFFARX1 cmd_ack_reg ( .D(N228), .SI(n516), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cmd_ack), .QN(n515) );
  SDFFARX1 cmd_stop_reg ( .D(n205), .SI(n515), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(n514), .QN(n259) );
  SDFFARX1 cnt_reg_15_ ( .D(n173), .SI(cnt[14]), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(cnt[15]), .QN(n161) );
  SDFFARX1 cnt_reg_1_ ( .D(n187), .SI(n291), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cnt[1]) );
  SDFFARX1 cnt_reg_2_ ( .D(n186), .SI(cnt[1]), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cnt[2]) );
  SDFFARX1 cnt_reg_3_ ( .D(n185), .SI(cnt[2]), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cnt[3]) );
  SDFFARX1 cnt_reg_4_ ( .D(n184), .SI(cnt[3]), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cnt[4]), .QN(n150) );
  SDFFARX1 cnt_reg_5_ ( .D(n183), .SI(n150), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cnt[5]), .QN(n151) );
  SDFFARX1 cnt_reg_6_ ( .D(n182), .SI(n151), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(n253), .QN(n152) );
  SDFFARX1 cnt_reg_7_ ( .D(n181), .SI(n253), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cnt[7]), .QN(n153) );
  SDFFARX1 cnt_reg_8_ ( .D(n180), .SI(cnt[7]), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cnt[8]), .QN(n154) );
  SDFFARX1 cnt_reg_9_ ( .D(n179), .SI(cnt[8]), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cnt[9]), .QN(n155) );
  SDFFARX1 cnt_reg_10_ ( .D(n178), .SI(cnt[9]), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(cnt[10]), .QN(n156) );
  SDFFARX1 cnt_reg_11_ ( .D(n177), .SI(cnt[10]), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(cnt[11]), .QN(n157) );
  SDFFARX1 cnt_reg_12_ ( .D(n176), .SI(cnt[11]), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(cnt[12]), .QN(n158) );
  SDFFARX1 cnt_reg_13_ ( .D(n175), .SI(cnt[12]), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(cnt[13]), .QN(n159) );
  SDFFARX1 al_reg ( .D(N139), .SI(test_si), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(al), .QN(n123) );
  SDFFARX1 cnt_reg_0_ ( .D(n188), .SI(n514), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(n291) );
  SDFFARX1 filter_cnt_reg_0_ ( .D(N93), .SI(n504), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n252), .QN(n145) );
  SDFFARX1 filter_cnt_reg_5_ ( .D(N98), .SI(filter_cnt[4]), .SE(test_se), 
        .CLK(clk), .RSTB(nReset), .Q(filter_cnt[5]), .QN(n502) );
  SDFFARX1 filter_cnt_reg_3_ ( .D(N96), .SI(n503), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(filter_cnt[3]), .QN(n137) );
  SDFFARX1 filter_cnt_reg_4_ ( .D(N97), .SI(filter_cnt[3]), .SE(test_se), 
        .CLK(clk), .RSTB(nReset), .Q(filter_cnt[4]), .QN(n136) );
  SDFFARX1 cnt_reg_14_ ( .D(n174), .SI(cnt[13]), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(cnt[14]), .QN(n160) );
  SDFFASX1 sda_oen_reg ( .D(n172), .SI(n497), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n492), .QN(n287) );
  SDFFASX1 scl_oen_reg ( .D(n206), .SI(n473), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n491), .QN(n297) );
  SDFFASX1 sSCL_reg ( .D(N123), .SI(filter_cnt[13]), .SE(test_se), .CLK(clk), 
        .SETB(nReset), .Q(sSCL), .QN(n295) );
  SDFFASX1 sSDA_reg ( .D(N124), .SI(sSCL), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n473), .QN(n134) );
  INVX1 U54 ( .INP(rst), .ZN(n21) );
  AO221X1 U59 ( .IN1(n469), .IN2(n24), .IN3(cSCL_1_), .IN4(n26), .IN5(rst), 
        .Q(n214) );
  AO221X1 U60 ( .IN1(n79), .IN2(n24), .IN3(n26), .IN4(n469), .IN5(rst), .Q(
        n213) );
  AO221X1 U61 ( .IN1(n80), .IN2(n24), .IN3(n79), .IN4(n26), .IN5(rst), .Q(n212) );
  AO221X1 U62 ( .IN1(n470), .IN2(n24), .IN3(cSDA_1_), .IN4(n26), .IN5(rst), 
        .Q(n211) );
  AO221X1 U63 ( .IN1(n75), .IN2(n24), .IN3(n470), .IN4(n26), .IN5(rst), .Q(
        n210) );
  AO221X1 U64 ( .IN1(n77), .IN2(n24), .IN3(n75), .IN4(n26), .IN5(rst), .Q(n209) );
  AO21X1 U65 ( .IN1(n144), .IN2(n7), .IN3(n27), .Q(n208) );
  AO22X1 U66 ( .IN1(sda_chk), .IN2(n6), .IN3(n254), .IN4(n22), .Q(n207) );
  AO22X1 U67 ( .IN1(n30), .IN2(n91), .IN3(n67), .IN4(n31), .Q(n206) );
  NAND3X0 U68 ( .IN1(n90), .IN2(n32), .IN3(n131), .QN(n31) );
  AO21X1 U69 ( .IN1(n526), .IN2(n35), .IN3(n36), .Q(n34) );
  NAND4X0 U70 ( .IN1(n126), .IN2(n37), .IN3(n38), .IN4(n32), .QN(n35) );
  OR4X1 U71 ( .IN1(n516), .IN2(n96), .IN3(n41), .IN4(cmd[3]), .Q(n40) );
  AO22X1 U72 ( .IN1(n250), .IN2(n7), .IN3(n254), .IN4(n23), .Q(n204) );
  AO22X1 U73 ( .IN1(n59), .IN2(n8), .IN3(n144), .IN4(n22), .Q(n203) );
  AO22X1 U74 ( .IN1(n58), .IN2(n6), .IN3(n59), .IN4(n23), .Q(n202) );
  AO22X1 U75 ( .IN1(n57), .IN2(n7), .IN3(n58), .IN4(n22), .Q(n201) );
  AO22X1 U76 ( .IN1(n143), .IN2(n8), .IN3(n57), .IN4(n23), .Q(n200) );
  AO22X1 U77 ( .IN1(n255), .IN2(n6), .IN3(n42), .IN4(cmd[1]), .Q(n199) );
  AO22X1 U79 ( .IN1(n258), .IN2(n7), .IN3(n255), .IN4(n22), .Q(n198) );
  AO22X1 U80 ( .IN1(n51), .IN2(n8), .IN3(n258), .IN4(n23), .Q(n197) );
  AO22X1 U81 ( .IN1(n251), .IN2(n6), .IN3(n51), .IN4(n22), .Q(n196) );
  OAI21X1 U82 ( .IN1(n275), .IN2(n33), .IN3(n43), .QN(n195) );
  NAND4X0 U83 ( .IN1(n20), .IN2(n96), .IN3(n87), .IN4(n44), .QN(n43) );
  AO22X1 U84 ( .IN1(n140), .IN2(n7), .IN3(n141), .IN4(n23), .Q(n194) );
  AO22X1 U85 ( .IN1(n139), .IN2(n8), .IN3(n140), .IN4(n22), .Q(n193) );
  AO22X1 U86 ( .IN1(n256), .IN2(n6), .IN3(n139), .IN4(n20), .Q(n192) );
  AO21X1 U87 ( .IN1(n142), .IN2(n8), .IN3(n45), .Q(n191) );
  NAND3X0 U88 ( .IN1(n20), .IN2(n94), .IN3(n87), .QN(n28) );
  AO22X1 U89 ( .IN1(n257), .IN2(n7), .IN3(n142), .IN4(n20), .Q(n190) );
  AO22X1 U90 ( .IN1(n254), .IN2(n8), .IN3(n257), .IN4(n20), .Q(n189) );
  AO222X1 U91 ( .IN1(n291), .IN2(n15), .IN3(N35), .IN4(n17), .IN5(clk_cnt[0]), 
        .IN6(n11), .Q(n188) );
  AO222X1 U92 ( .IN1(n14), .IN2(cnt[1]), .IN3(N36), .IN4(n19), .IN5(clk_cnt[1]), .IN6(n11), .Q(n187) );
  AO222X1 U93 ( .IN1(n14), .IN2(cnt[2]), .IN3(N37), .IN4(n18), .IN5(clk_cnt[2]), .IN6(n11), .Q(n186) );
  AO222X1 U94 ( .IN1(n14), .IN2(cnt[3]), .IN3(N38), .IN4(n17), .IN5(clk_cnt[3]), .IN6(n13), .Q(n185) );
  AO222X1 U95 ( .IN1(cnt[4]), .IN2(n16), .IN3(N39), .IN4(n19), .IN5(clk_cnt[4]), .IN6(n12), .Q(n184) );
  AO222X1 U96 ( .IN1(cnt[5]), .IN2(n15), .IN3(N40), .IN4(n18), .IN5(clk_cnt[5]), .IN6(n13), .Q(n183) );
  AO222X1 U97 ( .IN1(n253), .IN2(n16), .IN3(N41), .IN4(n17), .IN5(clk_cnt[6]), 
        .IN6(n12), .Q(n182) );
  AO222X1 U98 ( .IN1(cnt[7]), .IN2(n15), .IN3(N42), .IN4(n19), .IN5(clk_cnt[7]), .IN6(n13), .Q(n181) );
  AO222X1 U99 ( .IN1(cnt[8]), .IN2(n16), .IN3(N43), .IN4(n18), .IN5(clk_cnt[8]), .IN6(n12), .Q(n180) );
  AO222X1 U100 ( .IN1(cnt[9]), .IN2(n15), .IN3(N44), .IN4(n17), .IN5(
        clk_cnt[9]), .IN6(n13), .Q(n179) );
  AO222X1 U101 ( .IN1(cnt[10]), .IN2(n16), .IN3(N45), .IN4(n19), .IN5(
        clk_cnt[10]), .IN6(n12), .Q(n178) );
  AO222X1 U102 ( .IN1(cnt[11]), .IN2(n15), .IN3(N46), .IN4(n18), .IN5(
        clk_cnt[11]), .IN6(n13), .Q(n177) );
  AO222X1 U103 ( .IN1(cnt[12]), .IN2(n16), .IN3(N47), .IN4(n17), .IN5(
        clk_cnt[12]), .IN6(n12), .Q(n176) );
  AO222X1 U104 ( .IN1(cnt[13]), .IN2(n15), .IN3(N48), .IN4(n19), .IN5(
        clk_cnt[13]), .IN6(n13), .Q(n175) );
  AO222X1 U105 ( .IN1(cnt[14]), .IN2(n16), .IN3(N49), .IN4(n18), .IN5(
        clk_cnt[14]), .IN6(n12), .Q(n174) );
  AO222X1 U106 ( .IN1(cnt[15]), .IN2(n14), .IN3(N50), .IN4(n17), .IN5(
        clk_cnt[15]), .IN6(n13), .Q(n173) );
  OR4X1 U108 ( .IN1(n52), .IN2(n53), .IN3(n54), .IN4(n55), .Q(n50) );
  NAND4X0 U109 ( .IN1(n153), .IN2(n152), .IN3(n151), .IN4(n150), .QN(n55) );
  OR4X1 U110 ( .IN1(cnt[3]), .IN2(cnt[2]), .IN3(cnt[1]), .IN4(n291), .Q(n54)
         );
  NAND4X0 U111 ( .IN1(n161), .IN2(n160), .IN3(n159), .IN4(n158), .QN(n53) );
  NAND4X0 U112 ( .IN1(n157), .IN2(n156), .IN3(n155), .IN4(n154), .QN(n52) );
  NAND3X0 U113 ( .IN1(n295), .IN2(n118), .IN3(n491), .QN(n49) );
  AO22X1 U114 ( .IN1(n492), .IN2(n88), .IN3(n56), .IN4(n60), .Q(n172) );
  OR4X1 U115 ( .IN1(n140), .IN2(n139), .IN3(n61), .IN4(n63), .Q(n60) );
  NAND4X0 U116 ( .IN1(n132), .IN2(n131), .IN3(n90), .IN4(n64), .QN(n63) );
  OR4X1 U117 ( .IN1(n142), .IN2(n250), .IN3(n254), .IN4(n257), .Q(n65) );
  OR3X1 U118 ( .IN1(n144), .IN2(n59), .IN3(n141), .Q(n61) );
  AO22X1 U119 ( .IN1(dout), .IN2(n25), .IN3(n473), .IN4(n66), .Q(n164) );
  AO22X1 U120 ( .IN1(n5), .IN2(clk_cnt[8]), .IN3(N85), .IN4(n10), .Q(N99) );
  AO22X1 U121 ( .IN1(n5), .IN2(clk_cnt[7]), .IN3(N84), .IN4(n10), .Q(N98) );
  AO22X1 U122 ( .IN1(n5), .IN2(clk_cnt[6]), .IN3(N83), .IN4(n10), .Q(N97) );
  AO22X1 U123 ( .IN1(n5), .IN2(clk_cnt[5]), .IN3(N82), .IN4(n10), .Q(N96) );
  AO22X1 U124 ( .IN1(n5), .IN2(clk_cnt[4]), .IN3(N81), .IN4(n10), .Q(N95) );
  AO22X1 U125 ( .IN1(n5), .IN2(clk_cnt[3]), .IN3(N80), .IN4(n10), .Q(N94) );
  AO22X1 U126 ( .IN1(n5), .IN2(clk_cnt[2]), .IN3(N79), .IN4(n10), .Q(N93) );
  AND2X1 U127 ( .IN1(sda_i), .IN2(n21), .Q(N73) );
  AND2X1 U128 ( .IN1(scl_i), .IN2(n21), .Q(N71) );
  NOR3X0 U129 ( .IN1(n516), .IN2(n37), .IN3(n36), .QN(N228) );
  NAND4X0 U130 ( .IN1(sto_condition), .IN2(n259), .IN3(n46), .IN4(n21), .QN(
        n71) );
  NAND4X0 U131 ( .IN1(n37), .IN2(n32), .IN3(n126), .IN4(n72), .QN(n46) );
  NOR3X0 U132 ( .IN1(n141), .IN2(n144), .IN3(n142), .QN(n72) );
  NAND4X0 U133 ( .IN1(n129), .IN2(n128), .IN3(n127), .IN4(n519), .QN(n74) );
  OR3X1 U134 ( .IN1(n58), .IN2(n59), .IN3(n57), .Q(n73) );
  NAND3X0 U135 ( .IN1(sda_chk), .IN2(n92), .IN3(n492), .QN(n70) );
  NOR3X0 U136 ( .IN1(n76), .IN2(sto_condition), .IN3(rst), .QN(N132) );
  AND3X1 U137 ( .IN1(sSCL), .IN2(n92), .IN3(n133), .Q(N129) );
  AO221X1 U138 ( .IN1(n77), .IN2(n78), .IN3(n75), .IN4(n470), .IN5(rst), .Q(
        N124) );
  OR2X1 U139 ( .IN1(n75), .IN2(n470), .Q(n78) );
  AO221X1 U140 ( .IN1(n80), .IN2(n81), .IN3(n79), .IN4(n469), .IN5(rst), .Q(
        N123) );
  OR2X1 U141 ( .IN1(n79), .IN2(n469), .Q(n81) );
  AO22X1 U142 ( .IN1(n5), .IN2(clk_cnt[15]), .IN3(N92), .IN4(n9), .Q(N106) );
  AO22X1 U143 ( .IN1(n5), .IN2(clk_cnt[14]), .IN3(N91), .IN4(n9), .Q(N105) );
  AO22X1 U144 ( .IN1(n5), .IN2(clk_cnt[13]), .IN3(N90), .IN4(n9), .Q(N104) );
  AO22X1 U145 ( .IN1(n5), .IN2(clk_cnt[12]), .IN3(N89), .IN4(n9), .Q(N103) );
  AO22X1 U146 ( .IN1(n5), .IN2(clk_cnt[11]), .IN3(N88), .IN4(n9), .Q(N102) );
  AO22X1 U147 ( .IN1(n5), .IN2(clk_cnt[10]), .IN3(N87), .IN4(n9), .Q(N101) );
  AO22X1 U148 ( .IN1(n5), .IN2(clk_cnt[9]), .IN3(N86), .IN4(n9), .Q(N100) );
  NAND4X0 U151 ( .IN1(n83), .IN2(n115), .IN3(n84), .IN4(n85), .QN(n82) );
  AND4X1 U152 ( .IN1(n137), .IN2(n136), .IN3(n145), .IN4(n86), .Q(n85) );
  AND4X1 U153 ( .IN1(n122), .IN2(n121), .IN3(n117), .IN4(n116), .Q(n86) );
  i2c_master_bit_ctrl_DW01_dec_0 sub_260 ( .A({filter_cnt, n252}), .SUM({N92, 
        N91, N90, N89, N88, N87, N86, N85, N84, N83, N82, N81, N80, N79}) );
  i2c_master_bit_ctrl_DW01_dec_1 sub_228 ( .A({cnt[15:7], n253, cnt[5:1], n291}), .SUM({N50, N49, N48, N47, N46, N45, N44, N43, N42, N41, N40, N39, N38, N37, 
        N36, N35}) );
  SDFFASX1 clk_en_reg ( .D(n12), .SI(n517), .SE(test_se), .CLK(clk), .SETB(
        nReset), .Q(n62), .QN(n516) );
  INVX0 U3 ( .INP(1'b1), .ZN(scl_o) );
  INVX0 U5 ( .INP(1'b1), .ZN(sda_o) );
  AND2X1 U7 ( .IN1(n26), .IN2(ena), .Q(n5) );
  NBUFFX2 U8 ( .INP(n48), .Z(n17) );
  NBUFFX2 U9 ( .INP(n48), .Z(n18) );
  NBUFFX2 U10 ( .INP(n48), .Z(n19) );
  NBUFFX2 U11 ( .INP(n89), .Z(n6) );
  NBUFFX2 U12 ( .INP(n89), .Z(n8) );
  NBUFFX2 U13 ( .INP(n89), .Z(n7) );
  NOR2X0 U14 ( .IN1(n14), .IN2(n11), .QN(n48) );
  NBUFFX2 U15 ( .INP(n47), .Z(n14) );
  INVX0 U16 ( .INP(n33), .ZN(n89) );
  NBUFFX2 U17 ( .INP(n29), .Z(n22) );
  NBUFFX2 U18 ( .INP(n29), .Z(n20) );
  NBUFFX2 U19 ( .INP(n29), .Z(n23) );
  NBUFFX2 U20 ( .INP(n47), .Z(n15) );
  NBUFFX2 U21 ( .INP(n47), .Z(n16) );
  NOR2X0 U22 ( .IN1(n496), .IN2(n11), .QN(n47) );
  NBUFFX2 U23 ( .INP(n238), .Z(n11) );
  NOR2X0 U24 ( .IN1(n36), .IN2(n6), .QN(n29) );
  INVX0 U25 ( .INP(n36), .ZN(n90) );
  NAND2X1 U26 ( .IN1(n90), .IN2(n516), .QN(n33) );
  NBUFFX2 U27 ( .INP(n238), .Z(n13) );
  INVX0 U28 ( .INP(n26), .ZN(n24) );
  NBUFFX2 U29 ( .INP(n238), .Z(n12) );
  NBUFFX2 U30 ( .INP(n68), .Z(n10) );
  NBUFFX2 U31 ( .INP(n68), .Z(n9) );
  INVX0 U32 ( .INP(n46), .ZN(n87) );
  NAND2X1 U33 ( .IN1(n93), .IN2(n95), .QN(n41) );
  INVX0 U34 ( .INP(N126), .ZN(n92) );
  NOR2X0 U35 ( .IN1(filter_cnt[11]), .IN2(filter_cnt[10]), .QN(n83) );
  NOR4X0 U36 ( .IN1(filter_cnt[7]), .IN2(filter_cnt[6]), .IN3(filter_cnt[5]), 
        .IN4(filter_cnt[2]), .QN(n84) );
  NOR2X0 U37 ( .IN1(n82), .IN2(rst), .QN(n26) );
  NAND4X0 U38 ( .IN1(ena), .IN2(n49), .IN3(n50), .IN4(n21), .QN(n238) );
  NAND2X1 U39 ( .IN1(n123), .IN2(n21), .QN(n36) );
  NOR2X0 U40 ( .IN1(n28), .IN2(n41), .QN(n42) );
  NOR4X0 U41 ( .IN1(cmd[1]), .IN2(cmd[0]), .IN3(n28), .IN4(n95), .QN(n45) );
  NOR4X0 U42 ( .IN1(cmd[2]), .IN2(cmd[1]), .IN3(n28), .IN4(n93), .QN(n27) );
  NOR2X0 U43 ( .IN1(n41), .IN2(n94), .QN(n44) );
  AND3X1 U44 ( .IN1(n82), .IN2(n21), .IN3(ena), .Q(n68) );
  INVX0 U45 ( .INP(n56), .ZN(n88) );
  OA21X1 U46 ( .IN1(n46), .IN2(n36), .IN3(n33), .Q(n56) );
  NOR4X0 U47 ( .IN1(n51), .IN2(n140), .IN3(n73), .IN4(n74), .QN(n32) );
  INVX0 U48 ( .INP(n30), .ZN(n67) );
  NAND2X1 U49 ( .IN1(n33), .IN2(n34), .QN(n30) );
  NAND2X1 U50 ( .IN1(din), .IN2(n65), .QN(n64) );
  NOR4X0 U51 ( .IN1(n143), .IN2(n250), .IN3(n251), .IN4(n256), .QN(n37) );
  NAND2X1 U52 ( .IN1(n70), .IN2(n71), .QN(N139) );
  NOR2X0 U53 ( .IN1(n142), .IN2(n141), .QN(n38) );
  INVX0 U55 ( .INP(cmd[3]), .ZN(n94) );
  INVX0 U56 ( .INP(cmd[2]), .ZN(n95) );
  INVX0 U57 ( .INP(cmd[0]), .ZN(n93) );
  INVX0 U58 ( .INP(cmd[1]), .ZN(n96) );
  NOR2X0 U78 ( .IN1(rst), .IN2(n39), .QN(n205) );
  OA21X1 U107 ( .IN1(n62), .IN2(n259), .IN3(n40), .Q(n39) );
  NOR2X0 U149 ( .IN1(sSCL), .IN2(n69), .QN(N30) );
  OA21X1 U150 ( .IN1(n297), .IN2(dscl_oen), .IN3(n496), .Q(n69) );
  NOR4X0 U156 ( .IN1(rst), .IN2(n134), .IN3(n133), .IN4(n295), .QN(N130) );
  NAND2X1 U157 ( .IN1(n295), .IN2(n21), .QN(N125) );
  NAND2X1 U158 ( .IN1(n134), .IN2(n21), .QN(N126) );
  INVX0 U159 ( .INP(n297), .ZN(n91) );
  INVX0 U160 ( .INP(n66), .ZN(n25) );
  NOR2X0 U161 ( .IN1(n295), .IN2(n118), .QN(n66) );
  NOR2X0 U162 ( .IN1(busy), .IN2(sta_condition), .QN(n76) );
  NOR2X0 U163 ( .IN1(rst), .IN2(n124), .QN(N72) );
  NOR2X0 U164 ( .IN1(rst), .IN2(n125), .QN(N74) );
  INVX0 U165 ( .INP(n297), .ZN(scl_oen) );
  INVX0 U166 ( .INP(n287), .ZN(sda_oen) );
endmodule


module i2c_master_byte_ctrl_test_1 ( clk, rst, nReset, ena, clk_cnt, start, 
        stop, read, write, ack_in, din, cmd_ack, ack_out, dout, i2c_busy, 
        i2c_al, scl_i, scl_o, scl_oen, sda_i, sda_o, sda_oen, VDD, VSS, 
        test_si, test_so, test_se );
  input [15:0] clk_cnt;
  input [7:0] din;
  output [7:0] dout;
  input clk, rst, nReset, ena, start, stop, read, write, ack_in, scl_i, sda_i,
         VDD, VSS, test_si, test_se;
  output cmd_ack, ack_out, i2c_busy, i2c_al, scl_o, scl_oen, sda_o, sda_oen,
         test_so;
  wire   core_ack, core_txd, core_rxd, shift, N104, N105, N106, N107, n13, n21,
         n26, n44, n51, n54, n63, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n105,
         n106, n107, n114, n115, n116, n117, n118, n119, n120, n204, n205,
         n206, n207, n208, n209, n210, n211, n212, n213, n214, n215, n216,
         n217, n218, n219, n220, n11, n15, n16, n17, n18, n19, n20, n22, n23,
         n24, n25, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n45, n46, n47, n48, n49, n50, n52, n53, n55,
         n56, n57, n58, n59, n60, n61, n62, n5, n6, n7, n8, n9, n10, n12, n14,
         n64, n86, n87, n88, n89, n90, n91, n92;
  wire   [3:0] core_cmd;

  SDFFARX1 dcnt_reg_0_ ( .D(n75), .SI(n214), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(n118), .QN(n106) );
  SDFFARX1 dcnt_reg_1_ ( .D(n76), .SI(n118), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(n117), .QN(n44) );
  SDFFARX1 dcnt_reg_2_ ( .D(n74), .SI(n117), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(n213), .QN(n107) );
  SDFFARX1 sr_reg_1_ ( .D(n85), .SI(n210), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(dout[1]), .QN(n209) );
  SDFFARX1 sr_reg_2_ ( .D(n83), .SI(n209), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(dout[2]), .QN(n208) );
  SDFFARX1 sr_reg_3_ ( .D(n82), .SI(n208), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(dout[3]), .QN(n207) );
  SDFFARX1 sr_reg_4_ ( .D(n81), .SI(n207), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(dout[4]), .QN(n206) );
  SDFFARX1 sr_reg_5_ ( .D(n80), .SI(n206), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(dout[5]), .QN(n205) );
  SDFFARX1 sr_reg_6_ ( .D(n79), .SI(n205), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(dout[6]), .QN(n204) );
  SDFFARX1 sr_reg_7_ ( .D(n78), .SI(n204), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(dout[7]), .QN(test_so) );
  SDFFARX1 core_txd_reg ( .D(N104), .SI(n215), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(core_txd), .QN(n214) );
  SDFFARX1 sr_reg_0_ ( .D(n84), .SI(n211), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(dout[0]), .QN(n210) );
  SDFFARX1 core_cmd_reg_0_ ( .D(n69), .SI(cmd_ack), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(core_cmd[0]), .QN(n218) );
  SDFFARX1 core_cmd_reg_3_ ( .D(n66), .SI(n216), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(core_cmd[3]), .QN(n215) );
  SDFFARX1 core_cmd_reg_2_ ( .D(n67), .SI(n217), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(core_cmd[2]), .QN(n216) );
  SDFFARX1 ack_out_reg ( .D(n65), .SI(test_si), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(ack_out), .QN(n220) );
  SDFFARX1 cmd_ack_reg ( .D(N107), .SI(n119), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(cmd_ack), .QN(n105) );
  SDFFARX1 shift_reg ( .D(N105), .SI(n212), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(shift), .QN(n211) );
  SDFFARX1 core_cmd_reg_1_ ( .D(n68), .SI(n218), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(core_cmd[1]), .QN(n217) );
  SDFFARX1 ld_reg ( .D(N106), .SI(n213), .SE(test_se), .CLK(clk), .RSTB(nReset), .Q(n212), .QN(n51) );
  SDFFARX1 c_state_reg_0_ ( .D(n73), .SI(n219), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n115), .QN(n63) );
  SDFFARX1 c_state_reg_1_ ( .D(n72), .SI(n115), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n114), .QN(n13) );
  SDFFARX1 c_state_reg_2_ ( .D(n71), .SI(n13), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(n116), .QN(n21) );
  SDFFARX1 c_state_reg_4_ ( .D(n77), .SI(n26), .SE(test_se), .CLK(clk), .RSTB(
        nReset), .Q(n119), .QN(n54) );
  SDFFARX1 c_state_reg_3_ ( .D(n70), .SI(n116), .SE(test_se), .CLK(clk), 
        .RSTB(nReset), .Q(n120), .QN(n26) );
  INVX1 U32 ( .INP(rst), .ZN(n11) );
  AO222X1 U35 ( .IN1(din[1]), .IN2(n15), .IN3(dout[1]), .IN4(n16), .IN5(
        dout[0]), .IN6(n6), .Q(n85) );
  AO222X1 U36 ( .IN1(din[0]), .IN2(n15), .IN3(dout[0]), .IN4(n16), .IN5(
        core_rxd), .IN6(n7), .Q(n84) );
  AO222X1 U37 ( .IN1(din[2]), .IN2(n15), .IN3(dout[2]), .IN4(n16), .IN5(n7), 
        .IN6(dout[1]), .Q(n83) );
  AO222X1 U38 ( .IN1(din[3]), .IN2(n15), .IN3(dout[3]), .IN4(n16), .IN5(
        dout[2]), .IN6(n6), .Q(n82) );
  AO222X1 U39 ( .IN1(din[4]), .IN2(n15), .IN3(dout[4]), .IN4(n16), .IN5(
        dout[3]), .IN6(n7), .Q(n81) );
  AO222X1 U40 ( .IN1(din[5]), .IN2(n15), .IN3(dout[5]), .IN4(n16), .IN5(
        dout[4]), .IN6(n6), .Q(n80) );
  AO222X1 U41 ( .IN1(din[6]), .IN2(n15), .IN3(dout[6]), .IN4(n16), .IN5(
        dout[5]), .IN6(n7), .Q(n79) );
  AO222X1 U42 ( .IN1(din[7]), .IN2(n15), .IN3(dout[7]), .IN4(n16), .IN5(
        dout[6]), .IN6(n6), .Q(n78) );
  NOR3X0 U43 ( .IN1(n15), .IN2(rst), .IN3(n5), .QN(n16) );
  AO22X1 U44 ( .IN1(n119), .IN2(n9), .IN3(n18), .IN4(n19), .Q(n77) );
  AO221X1 U45 ( .IN1(n20), .IN2(n106), .IN3(n117), .IN4(n22), .IN5(n15), .Q(
        n76) );
  AO221X1 U46 ( .IN1(n24), .IN2(n118), .IN3(n106), .IN4(n5), .IN5(n15), .Q(n75) );
  AO221X1 U47 ( .IN1(n25), .IN2(n213), .IN3(n88), .IN4(n5), .IN5(n15), .Q(n74)
         );
  AO21X1 U48 ( .IN1(n117), .IN2(n6), .IN3(n22), .Q(n25) );
  AO22X1 U50 ( .IN1(n23), .IN2(n11), .IN3(n118), .IN4(n7), .Q(n22) );
  NAND3X0 U51 ( .IN1(n51), .IN2(n11), .IN3(shift), .QN(n23) );
  AO21X1 U52 ( .IN1(n115), .IN2(n9), .IN3(n27), .Q(n73) );
  AO21X1 U53 ( .IN1(n114), .IN2(n28), .IN3(n64), .Q(n72) );
  AO21X1 U54 ( .IN1(n116), .IN2(n28), .IN3(n86), .Q(n71) );
  AO21X1 U55 ( .IN1(n31), .IN2(n32), .IN3(n9), .Q(n28) );
  NAND3X0 U56 ( .IN1(n33), .IN2(n34), .IN3(n35), .QN(n70) );
  AO21X1 U57 ( .IN1(core_cmd[0]), .IN2(n9), .IN3(n27), .Q(n69) );
  AND3X1 U58 ( .IN1(n18), .IN2(n90), .IN3(start), .Q(n27) );
  AO22X1 U59 ( .IN1(core_cmd[1]), .IN2(n9), .IN3(n18), .IN4(n19), .Q(n68) );
  AO21X1 U60 ( .IN1(stop), .IN2(n120), .IN3(n36), .Q(n19) );
  NAND4X0 U61 ( .IN1(n38), .IN2(n39), .IN3(n30), .IN4(n33), .QN(n67) );
  NAND3X0 U62 ( .IN1(n88), .IN2(n18), .IN3(n114), .QN(n33) );
  NAND3X0 U63 ( .IN1(n40), .IN2(n92), .IN3(n41), .QN(n30) );
  OR2X1 U64 ( .IN1(n115), .IN2(write), .Q(n40) );
  NAND3X0 U65 ( .IN1(n18), .IN2(n32), .IN3(n116), .QN(n39) );
  NAND4X0 U66 ( .IN1(n42), .IN2(n43), .IN3(n29), .IN4(n34), .QN(n66) );
  NAND3X0 U67 ( .IN1(n88), .IN2(n18), .IN3(n116), .QN(n34) );
  AND2X1 U68 ( .IN1(n18), .IN2(n45), .Q(n41) );
  AO21X1 U69 ( .IN1(n90), .IN2(n91), .IN3(n115), .Q(n45) );
  NAND3X0 U70 ( .IN1(n18), .IN2(n32), .IN3(n114), .QN(n43) );
  OAI22X1 U72 ( .IN1(n90), .IN2(core_ack), .IN3(n37), .IN4(n47), .QN(n46) );
  NAND3X0 U73 ( .IN1(n120), .IN2(core_rxd), .IN3(n50), .QN(n49) );
  NAND3X0 U74 ( .IN1(n31), .IN2(n12), .IN3(ack_out), .QN(n48) );
  AO22X1 U75 ( .IN1(n50), .IN2(n115), .IN3(n55), .IN4(n47), .Q(N106) );
  AND2X1 U76 ( .IN1(n105), .IN2(n56), .Q(n47) );
  OR3X1 U77 ( .IN1(stop), .IN2(write), .IN3(read), .Q(n56) );
  NAND4X0 U78 ( .IN1(n63), .IN2(n54), .IN3(n57), .IN4(n21), .QN(n37) );
  NAND3X0 U79 ( .IN1(n107), .IN2(n106), .IN3(n44), .QN(n32) );
  AND2X1 U80 ( .IN1(n31), .IN2(n59), .Q(N104) );
  AO221X1 U81 ( .IN1(ack_in), .IN2(n60), .IN3(dout[7]), .IN4(n61), .IN5(n52), 
        .Q(n59) );
  NAND4X0 U82 ( .IN1(n63), .IN2(n54), .IN3(n62), .IN4(n21), .QN(n61) );
  AOI22X1 U83 ( .IN1(n14), .IN2(n114), .IN3(n13), .IN4(n26), .QN(n62) );
  AO21X1 U84 ( .IN1(core_ack), .IN2(n114), .IN3(n120), .Q(n60) );
  i2c_master_bit_ctrl_test_1 bit_controller ( .clk(clk), .rst(rst), .nReset(
        nReset), .ena(ena), .clk_cnt(clk_cnt), .cmd(core_cmd), .cmd_ack(
        core_ack), .busy(i2c_busy), .al(i2c_al), .din(core_txd), .dout(
        core_rxd), .scl_i(scl_i), .scl_oen(scl_oen), .sda_i(sda_i), .sda_oen(
        sda_oen), .VDD(VDD), .VSS(VSS), .test_si(n220), .test_so(n219), 
        .test_se(test_se) );
  INVX0 U3 ( .INP(1'b1), .ZN(scl_o) );
  INVX0 U5 ( .INP(1'b1), .ZN(sda_o) );
  NOR2X0 U7 ( .IN1(n87), .IN2(n8), .QN(n18) );
  NBUFFX2 U8 ( .INP(n89), .Z(n5) );
  NBUFFX2 U9 ( .INP(n89), .Z(n7) );
  NBUFFX2 U10 ( .INP(n89), .Z(n6) );
  INVX0 U11 ( .INP(n50), .ZN(n10) );
  INVX0 U12 ( .INP(n37), .ZN(n90) );
  NBUFFX2 U13 ( .INP(n17), .Z(n8) );
  INVX0 U14 ( .INP(n23), .ZN(n89) );
  INVX0 U15 ( .INP(n31), .ZN(n87) );
  NBUFFX2 U16 ( .INP(n17), .Z(n9) );
  NOR2X0 U17 ( .IN1(n14), .IN2(n87), .QN(n50) );
  INVX0 U18 ( .INP(n32), .ZN(n88) );
  NOR2X0 U19 ( .IN1(n51), .IN2(rst), .QN(n15) );
  NOR2X0 U20 ( .IN1(n120), .IN2(n114), .QN(n57) );
  AND2X1 U21 ( .IN1(n31), .IN2(n46), .Q(n17) );
  INVX0 U22 ( .INP(read), .ZN(n92) );
  INVX0 U23 ( .INP(start), .ZN(n91) );
  NAND2X1 U24 ( .IN1(read), .IN2(n41), .QN(n29) );
  INVX0 U25 ( .INP(n29), .ZN(n64) );
  INVX0 U26 ( .INP(n30), .ZN(n86) );
  NAND2X1 U27 ( .IN1(core_cmd[3]), .IN2(n8), .QN(n42) );
  NAND2X1 U28 ( .IN1(core_cmd[2]), .IN2(n8), .QN(n38) );
  NAND2X1 U29 ( .IN1(n8), .IN2(n120), .QN(n35) );
  NOR2X0 U30 ( .IN1(rst), .IN2(i2c_al), .QN(n31) );
  NOR2X0 U31 ( .IN1(n117), .IN2(n23), .QN(n20) );
  NOR2X0 U33 ( .IN1(rst), .IN2(n5), .QN(n24) );
  NOR4X0 U34 ( .IN1(write), .IN2(start), .IN3(read), .IN4(n37), .QN(n36) );
  NOR2X0 U49 ( .IN1(n37), .IN2(n87), .QN(n55) );
  NAND2X1 U71 ( .IN1(n48), .IN2(n49), .QN(n65) );
  INVX0 U87 ( .INP(n52), .ZN(n12) );
  NOR2X0 U88 ( .IN1(n58), .IN2(n10), .QN(N105) );
  OA21X1 U89 ( .IN1(n21), .IN2(n88), .IN3(n13), .Q(n58) );
  NOR2X0 U90 ( .IN1(n53), .IN2(n10), .QN(N107) );
  OA21X1 U91 ( .IN1(stop), .IN2(n26), .IN3(n54), .Q(n53) );
  INVX0 U92 ( .INP(core_ack), .ZN(n14) );
  NOR2X0 U93 ( .IN1(n14), .IN2(n26), .QN(n52) );
endmodule


module i2c_master_top ( wb_clk_i, wb_rst_i, test_mode, dft_clk_i, dft_rst_i, 
        arst_i, wb_adr_i, wb_dat_i, wb_dat_o, wb_we_i, wb_stb_i, wb_cyc_i, 
        wb_ack_o, wb_inta_o, scl_pad_i, scl_pad_o, scl_padoen_o, sda_pad_i, 
        sda_pad_o, sda_padoen_o, VDD, VSS, Scan_Data_In, Scan_Data_Out, 
        Scan_En );
  input [2:0] wb_adr_i;
  input [7:0] wb_dat_i;
  output [7:0] wb_dat_o;
  input wb_clk_i, wb_rst_i, test_mode, dft_clk_i, dft_rst_i, arst_i, wb_we_i,
         wb_stb_i, wb_cyc_i, scl_pad_i, sda_pad_i, VDD, VSS, Scan_Data_In,
         Scan_En;
  output wb_ack_o, wb_inta_o, scl_pad_o, scl_padoen_o, sda_pad_o, sda_padoen_o,
         Scan_Data_Out;
  wire   n475, n476, n477, n478, n479, n480, n481, n482, n421, sel_clk,
         a_sel_rst, N23, ctr_7_, sr_0, N46, N47, N48, N49, N50, N51, N52, N53,
         N55, N92, N95, done, i2c_al, irxack, N114, N119, N120, N121, N122,
         N124, N127, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n102, n104, n159, n160, n216, n217, n218, n219, n220, n221, n222,
         n223, n224, n225, n227, n228, n229, n234, n235, n236, n237, n238,
         n239, n240, n241, n242, n243, n244, n245, n246, n247, n248, n249,
         n250, n251, n252, n253, n254, n299, n425, n426, n427, n428, n429,
         n430, n431, n432, n433, n434, n435, n436, n437, n438, n439, n440,
         n441, n442, n443, n444, n445, n446, n447, n519, n520, n526, n527,
         n528, n529, n530, n531, n532, n533, n534, n535, n536, n537, n538,
         n539, n540, n541, n542, n543, n544, n545, n546, n547, n548, n549,
         n550, n551, n552, n553, n554, n555, n556, n557, n558, n559, n560,
         n561, n562, n563, n564, n565, n566, n567, n568, n569, n570, n571,
         n572, n573, n574, n575, n576, n577, n584, n585, n586, n587, n588,
         n589, n590, n591, n592, n593, n594, n595, n596, n597, n598, n599,
         n600, n601, n602, n603, n604, n605, n606, n607, n608, n609;
  wire   [15:0] prer;
  wire   [7:0] rxr;
  wire   [6:5] sr;
  wire   [7:0] txr;
  wire   [7:0] cr;

  INVX1 I_25 ( .INP(wb_rst_i), .ZN(N124) );
  INVX1 I_21 ( .INP(wb_rst_i), .ZN(N114) );
  NBUFFX2 B_23 ( .INP(wb_rst_i), .Z(N95) );
  NBUFFX2 B_22 ( .INP(wb_rst_i), .Z(N55) );
  INVX0 U38 ( .INP(N55), .ZN(N92) );
  MUX21X1 U188 ( .IN1(arst_i), .IN2(dft_rst_i), .S(test_mode), .Q(a_sel_rst)
         );
  MUX21X1 U189 ( .IN1(wb_clk_i), .IN2(dft_clk_i), .S(test_mode), .Q(sel_clk)
         );
  INVX1 U187 ( .INP(N92), .ZN(n159) );
  INVX1 U192 ( .INP(N114), .ZN(n160) );
  SDFFX1 wb_ack_o_reg ( .D(N23), .SI(n243), .SE(Scan_En), .CLK(sel_clk), .Q(
        n421), .QN(n235) );
  SDFFARX1 ctr_reg_6_ ( .D(n88), .SI(n219), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(n238), .QN(n218) );
  SDFFARX1 ctr_reg_5_ ( .D(n87), .SI(n220), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(n250), .QN(n219) );
  SDFFARX1 ctr_reg_4_ ( .D(n86), .SI(n221), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(n253), .QN(n220) );
  SDFFARX1 ctr_reg_3_ ( .D(n85), .SI(n222), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(n252), .QN(n221) );
  SDFFARX1 ctr_reg_2_ ( .D(n84), .SI(n223), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(n251), .QN(n222) );
  SDFFARX1 ctr_reg_1_ ( .D(n83), .SI(n224), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(n249), .QN(n223) );
  SDFFARX1 ctr_reg_0_ ( .D(n82), .SI(n236), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(n248), .QN(n224) );
  SDFFARX1 txr_reg_7_ ( .D(n81), .SI(n242), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(txr[7]), .QN(n243) );
  SDFFARX1 txr_reg_6_ ( .D(n80), .SI(n241), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(txr[6]), .QN(n242) );
  SDFFARX1 txr_reg_5_ ( .D(n79), .SI(n246), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(txr[5]), .QN(n241) );
  SDFFARX1 txr_reg_4_ ( .D(n78), .SI(n245), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(txr[4]), .QN(n246) );
  SDFFARX1 txr_reg_3_ ( .D(n77), .SI(n244), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(txr[3]), .QN(n245) );
  SDFFARX1 txr_reg_2_ ( .D(n76), .SI(n240), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(txr[2]), .QN(n244) );
  SDFFARX1 txr_reg_1_ ( .D(n75), .SI(n239), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(txr[1]), .QN(n240) );
  SDFFASX1 prer_reg_12_ ( .D(n70), .SI(n431), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[12]), .QN(n430) );
  SDFFASX1 prer_reg_11_ ( .D(n69), .SI(n432), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[11]), .QN(n431) );
  SDFFASX1 prer_reg_10_ ( .D(n68), .SI(n433), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[10]), .QN(n432) );
  SDFFASX1 prer_reg_7_ ( .D(n65), .SI(n436), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[7]), .QN(n435) );
  SDFFASX1 prer_reg_5_ ( .D(n63), .SI(n438), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[5]), .QN(n437) );
  SDFFASX1 prer_reg_4_ ( .D(n62), .SI(n439), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[4]), .QN(n438) );
  SDFFARX1 cr_reg_3_ ( .D(n57), .SI(n227), .SE(Scan_En), .CLK(sel_clk), .RSTB(
        a_sel_rst), .Q(cr[3]), .QN(n225) );
  SDFFARX1 cr_reg_7_ ( .D(n53), .SI(n444), .SE(Scan_En), .CLK(sel_clk), .RSTB(
        a_sel_rst), .Q(cr[7]), .QN(n236) );
  SDFFARX1 cr_reg_6_ ( .D(n54), .SI(n104), .SE(Scan_En), .CLK(sel_clk), .RSTB(
        a_sel_rst), .Q(cr[6]), .QN(n444) );
  SDFFX1 wb_dat_o_reg_6_ ( .D(N52), .SI(n477), .SE(Scan_En), .CLK(sel_clk), 
        .Q(n476), .QN(n597) );
  SDFFX1 wb_dat_o_reg_4_ ( .D(N50), .SI(n479), .SE(Scan_En), .CLK(sel_clk), 
        .Q(n478), .QN(n598) );
  SDFFX1 wb_dat_o_reg_3_ ( .D(N49), .SI(n480), .SE(Scan_En), .CLK(sel_clk), 
        .Q(n479), .QN(n599) );
  SDFFARX1 cr_reg_2_ ( .D(n52), .SI(n228), .SE(Scan_En), .CLK(sel_clk), .RSTB(
        a_sel_rst), .Q(n254), .QN(n227) );
  SDFFX1 wb_dat_o_reg_2_ ( .D(N48), .SI(n481), .SE(Scan_En), .CLK(sel_clk), 
        .Q(n480), .QN(n600) );
  SDFFARX1 cr_reg_1_ ( .D(n51), .SI(n445), .SE(Scan_En), .CLK(sel_clk), .RSTB(
        a_sel_rst), .Q(n247), .QN(n228) );
  SDFFARX1 al_reg ( .D(N119), .SI(Scan_Data_In), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(sr[5]), .QN(n447) );
  SDFFX1 wb_dat_o_reg_5_ ( .D(N51), .SI(n478), .SE(Scan_En), .CLK(sel_clk), 
        .Q(n477), .QN(n601) );
  SDFFARX1 rxack_reg ( .D(N120), .SI(n427), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(n426), .QN(n216) );
  SDFFX1 wb_dat_o_reg_7_ ( .D(N53), .SI(n476), .SE(Scan_En), .CLK(sel_clk), 
        .Q(n475), .QN(n584) );
  SDFFARX1 tip_reg ( .D(N121), .SI(n426), .SE(Scan_En), .CLK(sel_clk), .RSTB(
        a_sel_rst), .Q(n425), .QN(n217) );
  SDFFX1 wb_dat_o_reg_1_ ( .D(N47), .SI(n482), .SE(Scan_En), .CLK(sel_clk), 
        .Q(n481), .QN(n602) );
  SDFFX1 wb_dat_o_reg_0_ ( .D(N46), .SI(n235), .SE(Scan_En), .CLK(sel_clk), 
        .Q(n482), .QN(n603) );
  SDFFARX1 ctr_reg_7_ ( .D(n89), .SI(n218), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(ctr_7_), .QN(n229) );
  SDFFARX1 cr_reg_5_ ( .D(n55), .SI(n102), .SE(Scan_En), .CLK(sel_clk), .RSTB(
        a_sel_rst), .Q(n234), .QN(n104) );
  SDFFARX1 cr_reg_4_ ( .D(n56), .SI(n225), .SE(Scan_En), .CLK(sel_clk), .RSTB(
        a_sel_rst), .Q(n237), .QN(n102) );
  SDFFARX1 cr_reg_0_ ( .D(n50), .SI(n446), .SE(Scan_En), .CLK(sel_clk), .RSTB(
        a_sel_rst), .Q(cr[0]), .QN(n445) );
  SDFFARX1 txr_reg_0_ ( .D(n74), .SI(n425), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(txr[0]), .QN(n239) );
  SDFFARX1 irq_flag_reg ( .D(N122), .SI(n229), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(sr_0), .QN(n443) );
  SDFFASX1 prer_reg_15_ ( .D(n73), .SI(n428), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[15]), .QN(n427) );
  SDFFASX1 prer_reg_13_ ( .D(n71), .SI(n430), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[13]), .QN(n429) );
  SDFFASX1 prer_reg_2_ ( .D(n60), .SI(n441), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[2]), .QN(n440) );
  SDFFASX1 prer_reg_3_ ( .D(n61), .SI(n440), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[3]), .QN(n439) );
  INVX32 U374 ( .INP(N92), .ZN(n299) );
  INVX1 U320 ( .INP(N55), .ZN(n519) );
  INVX1 U321 ( .INP(N95), .ZN(n520) );
  AO22X1 U327 ( .IN1(ctr_7_), .IN2(n526), .IN3(wb_dat_i[7]), .IN4(n527), .Q(
        n89) );
  AO22X1 U328 ( .IN1(n238), .IN2(n526), .IN3(wb_dat_i[6]), .IN4(n527), .Q(n88)
         );
  AO22X1 U329 ( .IN1(n250), .IN2(n526), .IN3(wb_dat_i[5]), .IN4(n527), .Q(n87)
         );
  AO22X1 U330 ( .IN1(n253), .IN2(n526), .IN3(wb_dat_i[4]), .IN4(n527), .Q(n86)
         );
  AO22X1 U331 ( .IN1(n252), .IN2(n526), .IN3(wb_dat_i[3]), .IN4(n527), .Q(n85)
         );
  AO22X1 U332 ( .IN1(n251), .IN2(n526), .IN3(wb_dat_i[2]), .IN4(n527), .Q(n84)
         );
  AO22X1 U333 ( .IN1(n249), .IN2(n526), .IN3(wb_dat_i[1]), .IN4(n527), .Q(n83)
         );
  AO22X1 U334 ( .IN1(n248), .IN2(n526), .IN3(wb_dat_i[0]), .IN4(n527), .Q(n82)
         );
  AO22X1 U335 ( .IN1(txr[7]), .IN2(n530), .IN3(n531), .IN4(wb_dat_i[7]), .Q(
        n81) );
  AO22X1 U336 ( .IN1(txr[6]), .IN2(n530), .IN3(n531), .IN4(wb_dat_i[6]), .Q(
        n80) );
  AO22X1 U337 ( .IN1(txr[5]), .IN2(n530), .IN3(n531), .IN4(wb_dat_i[5]), .Q(
        n79) );
  AO22X1 U338 ( .IN1(txr[4]), .IN2(n530), .IN3(n531), .IN4(wb_dat_i[4]), .Q(
        n78) );
  AO22X1 U339 ( .IN1(txr[3]), .IN2(n530), .IN3(n531), .IN4(wb_dat_i[3]), .Q(
        n77) );
  AO22X1 U340 ( .IN1(txr[2]), .IN2(n530), .IN3(n531), .IN4(wb_dat_i[2]), .Q(
        n76) );
  AO22X1 U341 ( .IN1(txr[1]), .IN2(n530), .IN3(n531), .IN4(wb_dat_i[1]), .Q(
        n75) );
  AO22X1 U342 ( .IN1(txr[0]), .IN2(n530), .IN3(n531), .IN4(wb_dat_i[0]), .Q(
        n74) );
  AOI21X1 U343 ( .IN1(n586), .IN2(n592), .IN3(n159), .QN(n530) );
  AO221X1 U344 ( .IN1(n533), .IN2(wb_dat_i[7]), .IN3(prer[15]), .IN4(n591), 
        .IN5(n534), .Q(n73) );
  AO221X1 U345 ( .IN1(n533), .IN2(wb_dat_i[6]), .IN3(prer[14]), .IN4(n591), 
        .IN5(n534), .Q(n72) );
  AO221X1 U346 ( .IN1(n533), .IN2(wb_dat_i[5]), .IN3(prer[13]), .IN4(n591), 
        .IN5(n534), .Q(n71) );
  AO221X1 U347 ( .IN1(n533), .IN2(wb_dat_i[4]), .IN3(prer[12]), .IN4(n591), 
        .IN5(n534), .Q(n70) );
  AO221X1 U348 ( .IN1(n533), .IN2(wb_dat_i[3]), .IN3(prer[11]), .IN4(n591), 
        .IN5(n534), .Q(n69) );
  AO221X1 U349 ( .IN1(n533), .IN2(wb_dat_i[2]), .IN3(prer[10]), .IN4(n591), 
        .IN5(n534), .Q(n68) );
  AO221X1 U350 ( .IN1(n533), .IN2(wb_dat_i[1]), .IN3(prer[9]), .IN4(n591), 
        .IN5(n534), .Q(n67) );
  AO221X1 U351 ( .IN1(n533), .IN2(wb_dat_i[0]), .IN3(prer[8]), .IN4(n591), 
        .IN5(n534), .Q(n66) );
  AND2X1 U352 ( .IN1(n299), .IN2(n535), .Q(n534) );
  AO21X1 U353 ( .IN1(n588), .IN2(n592), .IN3(N55), .Q(n535) );
  AO221X1 U354 ( .IN1(n537), .IN2(wb_dat_i[7]), .IN3(prer[7]), .IN4(n593), 
        .IN5(n159), .Q(n65) );
  AO221X1 U355 ( .IN1(n537), .IN2(wb_dat_i[6]), .IN3(prer[6]), .IN4(n593), 
        .IN5(n159), .Q(n64) );
  AO221X1 U356 ( .IN1(n537), .IN2(wb_dat_i[5]), .IN3(prer[5]), .IN4(n593), 
        .IN5(n159), .Q(n63) );
  AO221X1 U357 ( .IN1(n537), .IN2(wb_dat_i[4]), .IN3(prer[4]), .IN4(n593), 
        .IN5(n159), .Q(n62) );
  AO221X1 U358 ( .IN1(n537), .IN2(wb_dat_i[3]), .IN3(prer[3]), .IN4(n593), 
        .IN5(n159), .Q(n61) );
  AO221X1 U359 ( .IN1(n537), .IN2(wb_dat_i[2]), .IN3(prer[2]), .IN4(n593), 
        .IN5(n159), .Q(n60) );
  AO221X1 U360 ( .IN1(n537), .IN2(wb_dat_i[1]), .IN3(prer[1]), .IN4(n593), 
        .IN5(n159), .Q(n59) );
  AO221X1 U361 ( .IN1(n537), .IN2(wb_dat_i[0]), .IN3(prer[0]), .IN4(n593), 
        .IN5(n159), .Q(n58) );
  NAND3X0 U362 ( .IN1(n421), .IN2(n519), .IN3(wb_we_i), .QN(n528) );
  AO22X1 U363 ( .IN1(cr[3]), .IN2(n596), .IN3(n539), .IN4(n595), .Q(n57) );
  AND2X1 U364 ( .IN1(n541), .IN2(wb_dat_i[3]), .Q(n539) );
  AO22X1 U365 ( .IN1(n237), .IN2(n542), .IN3(n543), .IN4(wb_dat_i[4]), .Q(n56)
         );
  AO22X1 U366 ( .IN1(n542), .IN2(n234), .IN3(n543), .IN4(wb_dat_i[5]), .Q(n55)
         );
  AO22X1 U367 ( .IN1(cr[6]), .IN2(n542), .IN3(n543), .IN4(wb_dat_i[6]), .Q(n54) );
  AO22X1 U368 ( .IN1(cr[7]), .IN2(n542), .IN3(n543), .IN4(wb_dat_i[7]), .Q(n53) );
  OR3X1 U369 ( .IN1(done), .IN2(i2c_al), .IN3(n541), .Q(n545) );
  AO22X1 U370 ( .IN1(n254), .IN2(n594), .IN3(n546), .IN4(wb_dat_i[2]), .Q(n52)
         );
  AO22X1 U371 ( .IN1(n247), .IN2(n594), .IN3(n546), .IN4(wb_dat_i[1]), .Q(n51)
         );
  AO22X1 U372 ( .IN1(cr[0]), .IN2(n594), .IN3(n546), .IN4(wb_dat_i[0]), .Q(n50) );
  NAND3X0 U373 ( .IN1(wb_we_i), .IN2(n421), .IN3(n596), .QN(n544) );
  OR3X1 U375 ( .IN1(n548), .IN2(n229), .IN3(n540), .Q(n547) );
  NAND3X0 U376 ( .IN1(n421), .IN2(n520), .IN3(wb_we_i), .QN(n540) );
  NAND4X0 U377 ( .IN1(n549), .IN2(n550), .IN3(n551), .IN4(n552), .QN(N53) );
  OA222X1 U378 ( .IN1(n243), .IN2(n553), .IN3(n236), .IN4(n554), .IN5(n229), 
        .IN6(n590), .Q(n552) );
  OA22X1 U379 ( .IN1(n538), .IN2(n435), .IN3(n216), .IN4(n548), .Q(n551) );
  AOI221X1 U380 ( .IN1(prer[14]), .IN2(n588), .IN3(rxr[6]), .IN4(n586), .IN5(
        n557), .QN(n556) );
  AO22X1 U381 ( .IN1(sr[6]), .IN2(n607), .IN3(prer[6]), .IN4(n605), .Q(n557)
         );
  OA222X1 U382 ( .IN1(n242), .IN2(n553), .IN3(n444), .IN4(n554), .IN5(n218), 
        .IN6(n590), .Q(n555) );
  NAND4X0 U383 ( .IN1(n558), .IN2(n559), .IN3(n560), .IN4(n561), .QN(N51) );
  OA222X1 U384 ( .IN1(n241), .IN2(n553), .IN3(n104), .IN4(n554), .IN5(n219), 
        .IN6(n590), .Q(n561) );
  AOI22X1 U385 ( .IN1(n605), .IN2(prer[5]), .IN3(n607), .IN4(sr[5]), .QN(n560)
         );
  AOI222X1 U386 ( .IN1(prer[4]), .IN2(n605), .IN3(prer[12]), .IN4(n588), .IN5(
        rxr[4]), .IN6(n586), .QN(n563) );
  OA222X1 U387 ( .IN1(n246), .IN2(n553), .IN3(n102), .IN4(n554), .IN5(n220), 
        .IN6(n590), .Q(n562) );
  AOI222X1 U388 ( .IN1(prer[3]), .IN2(n605), .IN3(prer[11]), .IN4(n588), .IN5(
        rxr[3]), .IN6(n586), .QN(n565) );
  OA222X1 U389 ( .IN1(n245), .IN2(n553), .IN3(n225), .IN4(n554), .IN5(n221), 
        .IN6(n590), .Q(n564) );
  AOI222X1 U390 ( .IN1(prer[2]), .IN2(n605), .IN3(prer[10]), .IN4(n588), .IN5(
        rxr[2]), .IN6(n586), .QN(n567) );
  OA222X1 U391 ( .IN1(n244), .IN2(n553), .IN3(n227), .IN4(n554), .IN5(n222), 
        .IN6(n589), .Q(n566) );
  NAND4X0 U392 ( .IN1(n568), .IN2(n569), .IN3(n570), .IN4(n571), .QN(N47) );
  OA222X1 U393 ( .IN1(n240), .IN2(n553), .IN3(n228), .IN4(n554), .IN5(n223), 
        .IN6(n589), .Q(n571) );
  OA22X1 U394 ( .IN1(n538), .IN2(n441), .IN3(n217), .IN4(n548), .Q(n570) );
  NAND4X0 U395 ( .IN1(n572), .IN2(n573), .IN3(n574), .IN4(n575), .QN(N46) );
  OA222X1 U396 ( .IN1(n239), .IN2(n553), .IN3(n445), .IN4(n554), .IN5(n224), 
        .IN6(n589), .Q(n575) );
  NAND3X0 U398 ( .IN1(wb_adr_i[1]), .IN2(n609), .IN3(wb_adr_i[2]), .QN(n554)
         );
  NAND3X0 U399 ( .IN1(wb_adr_i[0]), .IN2(n608), .IN3(wb_adr_i[2]), .QN(n553)
         );
  AOI22X1 U400 ( .IN1(n605), .IN2(prer[0]), .IN3(n607), .IN4(sr_0), .QN(n574)
         );
  NAND3X0 U401 ( .IN1(n609), .IN2(n608), .IN3(wb_adr_i[2]), .QN(n548) );
  NAND3X0 U402 ( .IN1(n608), .IN2(n606), .IN3(n609), .QN(n538) );
  AND3X1 U405 ( .IN1(wb_cyc_i), .IN2(n235), .IN3(wb_stb_i), .Q(N23) );
  AND3X1 U406 ( .IN1(sr_0), .IN2(n238), .IN3(N124), .Q(N127) );
  NOR3X0 U407 ( .IN1(cr[0]), .IN2(n160), .IN3(n576), .QN(N122) );
  NOR3X0 U408 ( .IN1(i2c_al), .IN2(sr_0), .IN3(done), .QN(n576) );
  AND2X1 U409 ( .IN1(irxack), .IN2(N114), .Q(N120) );
  AOI21X1 U410 ( .IN1(sr[5]), .IN2(n236), .IN3(i2c_al), .QN(n577) );
  i2c_master_byte_ctrl_test_1 byte_controller ( .clk(sel_clk), .rst(wb_rst_i), 
        .nReset(a_sel_rst), .ena(ctr_7_), .clk_cnt(prer), .start(cr[7]), 
        .stop(cr[6]), .read(n234), .write(n237), .ack_in(cr[3]), .din(txr), 
        .cmd_ack(done), .ack_out(irxack), .dout(rxr), .i2c_busy(sr[6]), 
        .i2c_al(i2c_al), .scl_i(scl_pad_i), .scl_oen(scl_padoen_o), .sda_i(
        sda_pad_i), .sda_oen(sda_padoen_o), .VDD(VDD), .VSS(VSS), .test_si(
        n447), .test_so(n446), .test_se(Scan_En) );
  SDFFASX1 prer_reg_0_ ( .D(n58), .SI(n443), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[0]), .QN(n442) );
  SDFFASX1 prer_reg_14_ ( .D(n72), .SI(n429), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[14]), .QN(n428) );
  SDFFASX1 prer_reg_1_ ( .D(n59), .SI(n442), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[1]), .QN(n441) );
  SDFFASX1 prer_reg_6_ ( .D(n64), .SI(n437), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[6]), .QN(n436) );
  SDFFASX1 prer_reg_8_ ( .D(n66), .SI(n435), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[8]), .QN(n434) );
  SDFFASX1 prer_reg_9_ ( .D(n67), .SI(n434), .SE(Scan_En), .CLK(sel_clk), 
        .SETB(a_sel_rst), .Q(prer[9]), .QN(n433) );
  SDFFARX1 wb_inta_o_reg ( .D(N127), .SI(n475), .SE(Scan_En), .CLK(sel_clk), 
        .RSTB(a_sel_rst), .Q(wb_inta_o), .QN(n604) );
  INVX0 U413 ( .INP(1'b1), .ZN(sda_pad_o) );
  INVX0 U415 ( .INP(1'b1), .ZN(scl_pad_o) );
  INVX0 U417 ( .INP(n537), .ZN(n593) );
  INVX0 U418 ( .INP(n538), .ZN(n605) );
  NOR2X0 U419 ( .IN1(n528), .IN2(n591), .QN(n533) );
  INVX0 U420 ( .INP(n535), .ZN(n591) );
  INVX0 U421 ( .INP(n528), .ZN(n592) );
  NOR2X0 U422 ( .IN1(n538), .IN2(n528), .QN(n537) );
  NOR2X0 U423 ( .IN1(n528), .IN2(n526), .QN(n527) );
  NOR2X0 U424 ( .IN1(n528), .IN2(n530), .QN(n531) );
  NOR2X0 U425 ( .IN1(n542), .IN2(n540), .QN(n543) );
  INVX0 U426 ( .INP(n541), .ZN(n596) );
  NOR2X0 U427 ( .IN1(n540), .IN2(n594), .QN(n546) );
  INVX0 U428 ( .INP(n544), .ZN(n594) );
  NBUFFX2 U429 ( .INP(n536), .Z(n587) );
  NBUFFX2 U430 ( .INP(n532), .Z(n585) );
  NBUFFX2 U431 ( .INP(n532), .Z(n586) );
  NBUFFX2 U432 ( .INP(n536), .Z(n588) );
  NBUFFX2 U433 ( .INP(n529), .Z(n590) );
  NBUFFX2 U434 ( .INP(n529), .Z(n589) );
  INVX0 U435 ( .INP(n548), .ZN(n607) );
  OA21X1 U436 ( .IN1(n589), .IN2(n528), .IN3(n519), .Q(n526) );
  NAND2X1 U437 ( .IN1(n544), .IN2(n545), .QN(n542) );
  NAND2X1 U438 ( .IN1(n520), .IN2(n547), .QN(n541) );
  INVX0 U439 ( .INP(n540), .ZN(n595) );
  OA21X1 U440 ( .IN1(n237), .IN2(n234), .IN3(N114), .Q(N121) );
  NOR2X0 U441 ( .IN1(n160), .IN2(n577), .QN(N119) );
  NAND2X1 U442 ( .IN1(n555), .IN2(n556), .QN(N52) );
  NAND2X1 U443 ( .IN1(rxr[0]), .IN2(n585), .QN(n572) );
  NAND2X1 U444 ( .IN1(rxr[1]), .IN2(n585), .QN(n568) );
  NAND2X1 U445 ( .IN1(rxr[7]), .IN2(n585), .QN(n549) );
  NAND2X1 U446 ( .IN1(prer[15]), .IN2(n587), .QN(n550) );
  NAND2X1 U447 ( .IN1(rxr[5]), .IN2(n585), .QN(n558) );
  NAND2X1 U448 ( .IN1(prer[8]), .IN2(n587), .QN(n573) );
  NAND2X1 U449 ( .IN1(prer[9]), .IN2(n587), .QN(n569) );
  NAND2X1 U450 ( .IN1(prer[13]), .IN2(n587), .QN(n559) );
  NAND2X1 U451 ( .IN1(n566), .IN2(n567), .QN(N48) );
  NAND2X1 U452 ( .IN1(n564), .IN2(n565), .QN(N49) );
  NAND2X1 U453 ( .IN1(n562), .IN2(n563), .QN(N50) );
  INVX0 U454 ( .INP(n603), .ZN(wb_dat_o[0]) );
  INVX0 U455 ( .INP(n602), .ZN(wb_dat_o[1]) );
  INVX0 U456 ( .INP(n600), .ZN(wb_dat_o[2]) );
  INVX0 U457 ( .INP(n599), .ZN(wb_dat_o[3]) );
  INVX0 U458 ( .INP(n598), .ZN(wb_dat_o[4]) );
  INVX0 U459 ( .INP(n601), .ZN(wb_dat_o[5]) );
  INVX0 U460 ( .INP(n597), .ZN(wb_dat_o[6]) );
  INVX0 U461 ( .INP(n584), .ZN(wb_dat_o[7]) );
  INVX0 U462 ( .INP(n235), .ZN(wb_ack_o) );
  AND3X1 U463 ( .IN1(n608), .IN2(n606), .IN3(wb_adr_i[0]), .Q(n536) );
  AND3X1 U464 ( .IN1(wb_adr_i[1]), .IN2(n606), .IN3(wb_adr_i[0]), .Q(n532) );
  INVX0 U465 ( .INP(n604), .ZN(Scan_Data_Out) );
  NAND3X0 U466 ( .IN1(n609), .IN2(n606), .IN3(wb_adr_i[1]), .QN(n529) );
  INVX0 U467 ( .INP(wb_adr_i[0]), .ZN(n609) );
  INVX0 U468 ( .INP(wb_adr_i[1]), .ZN(n608) );
  INVX0 U469 ( .INP(wb_adr_i[2]), .ZN(n606) );
endmodule

