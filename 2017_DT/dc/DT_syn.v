/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Tue Mar 23 22:21:16 2021
/////////////////////////////////////////////////////////////


module Forward_DW01_inc_0_DW01_inc_5 ( A, SUM );
  input [9:0] A;
  output [9:0] SUM;

  wire   [9:2] carry;

  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  XOR2X1 U1 ( .A(carry[9]), .B(A[9]), .Y(SUM[9]) );
  CLKINVX1 U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module Forward ( clk, rst, sti_di_i, cnt4_v_i, start, sti_rd_o, sti_addr_o, 
        iswhite_o, fw_addr_o, fw_fin_o );
  input [15:0] sti_di_i;
  output [9:0] sti_addr_o;
  output [13:0] fw_addr_o;
  input clk, rst, cnt4_v_i;
  output start, sti_rd_o, iswhite_o, fw_fin_o;
  wire   N9, n85, N39, N40, N41, N42, N43, N44, N45, N46, N47, N48, N66, N67,
         N69, N70, N71, N72, N73, N74, N75, N76, N77, N78, N79, N80, N117,
         N118, N119, N120, n7, n8, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n1, n2,
         n4, n5, n9, n11, n13, n15, n17, n19, n21, n23, n45, n47, n48, n49,
         n50, n51, n52, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64,
         n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84;

  Forward_DW01_inc_0_DW01_inc_5 r376 ( .A({N79, N78, N77, N76, N75, N74, N73, 
        N72, N71, n45}), .SUM({N48, N47, N46, N45, N44, N43, N42, N41, N40, 
        N39}) );
  EDFFTRX1 \fw_addr_o_reg[3]  ( .RN(start), .D(N69), .E(n34), .CK(clk), .Q(
        fw_addr_o[3]) );
  EDFFTRX1 \fw_addr_o_reg[12]  ( .RN(start), .D(sti_addr_o[8]), .E(n34), .CK(
        clk), .Q(fw_addr_o[12]), .QN(n26) );
  DFFX1 \cnt16_reg[1]  ( .D(N118), .CK(clk), .Q(N67), .QN(n72) );
  DFFRX1 start_reg ( .D(sti_rd_o), .CK(clk), .RN(rst), .Q(n85) );
  EDFFTRX1 \fw_addr_o_reg[11]  ( .RN(start), .D(sti_addr_o[7]), .E(n34), .CK(
        clk), .Q(fw_addr_o[11]), .QN(n25) );
  EDFFTRX1 \fw_addr_o_reg[10]  ( .RN(start), .D(sti_addr_o[6]), .E(n34), .CK(
        clk), .Q(fw_addr_o[10]) );
  EDFFTRX1 \fw_addr_o_reg[9]  ( .RN(start), .D(sti_addr_o[5]), .E(n34), .CK(
        clk), .Q(fw_addr_o[9]) );
  EDFFTRX1 \fw_addr_o_reg[8]  ( .RN(start), .D(sti_addr_o[4]), .E(n34), .CK(
        clk), .Q(fw_addr_o[8]) );
  EDFFTRX1 \fw_addr_o_reg[4]  ( .RN(start), .D(n45), .E(n34), .CK(clk), .Q(
        fw_addr_o[4]), .QN(n29) );
  EDFFTRX1 \fw_addr_o_reg[5]  ( .RN(start), .D(n4), .E(n34), .CK(clk), .Q(
        fw_addr_o[5]), .QN(n30) );
  EDFFTRX1 \fw_addr_o_reg[6]  ( .RN(start), .D(sti_addr_o[2]), .E(n34), .CK(
        clk), .Q(fw_addr_o[6]), .QN(n28) );
  EDFFTRX1 \fw_addr_o_reg[7]  ( .RN(start), .D(sti_addr_o[3]), .E(n34), .CK(
        clk), .Q(fw_addr_o[7]), .QN(n27) );
  EDFFTRX1 \fw_addr_o_reg[2]  ( .RN(start), .D(n1), .E(n34), .CK(clk), .Q(
        fw_addr_o[2]) );
  EDFFTRX1 \fw_addr_o_reg[1]  ( .RN(start), .D(N67), .E(n34), .CK(clk), .Q(
        fw_addr_o[1]), .QN(n31) );
  EDFFTRX1 \fw_addr_o_reg[0]  ( .RN(start), .D(N66), .E(n34), .CK(clk), .Q(
        fw_addr_o[0]), .QN(n32) );
  EDFFTRX1 \fw_addr_o_reg[13]  ( .RN(start), .D(N79), .E(n34), .CK(clk), .Q(
        fw_addr_o[13]), .QN(n24) );
  DFFQXL \sti_addr_o_reg[8]  ( .D(n36), .CK(clk), .Q(N78) );
  DFFQXL \sti_addr_o_reg[7]  ( .D(n37), .CK(clk), .Q(N77) );
  DFFQXL \sti_addr_o_reg[6]  ( .D(n38), .CK(clk), .Q(N76) );
  DFFQXL \sti_addr_o_reg[5]  ( .D(n39), .CK(clk), .Q(N75) );
  DFFQXL \sti_addr_o_reg[4]  ( .D(n40), .CK(clk), .Q(N74) );
  DFFQXL \sti_addr_o_reg[3]  ( .D(n41), .CK(clk), .Q(N73) );
  DFFQXL \sti_addr_o_reg[2]  ( .D(n42), .CK(clk), .Q(N72) );
  DFFQXL \sti_addr_o_reg[1]  ( .D(n43), .CK(clk), .Q(N71) );
  DFFQXL \sti_addr_o_reg[9]  ( .D(n35), .CK(clk), .Q(N79) );
  DFFQXL \sti_addr_o_reg[0]  ( .D(n44), .CK(clk), .Q(N70) );
  DFFQXL iswhite_o_reg ( .D(N80), .CK(clk), .Q(iswhite_o) );
  DFFXL \cnt16_reg[2]  ( .D(N119), .CK(clk), .QN(N9) );
  DFFRX4 fw_fin_o_reg ( .D(n33), .CK(clk), .RN(rst), .Q(fw_fin_o), .QN(n34) );
  DFFX4 \cnt16_reg[3]  ( .D(N120), .CK(clk), .Q(N69), .QN(n69) );
  DFFRX2 sti_rd_o_reg ( .D(n34), .CK(clk), .RN(rst), .Q(sti_rd_o) );
  DFFX4 \cnt16_reg[0]  ( .D(N117), .CK(clk), .Q(N66), .QN(n67) );
  CLKINVX1 U3 ( .A(N9), .Y(n1) );
  INVX12 U4 ( .A(n64), .Y(n75) );
  OAI211X4 U5 ( .A0(n84), .A1(n63), .B0(n78), .C0(n62), .Y(n64) );
  AO21X4 U6 ( .A0(n75), .A1(n72), .B0(n71), .Y(n76) );
  NAND4X1 U7 ( .A(n1), .B(N69), .C(n52), .D(n78), .Y(n79) );
  INVXL U8 ( .A(N71), .Y(n2) );
  INVX3 U9 ( .A(n2), .Y(sti_addr_o[1]) );
  INVXL U10 ( .A(n2), .Y(n4) );
  INVXL U11 ( .A(N72), .Y(n5) );
  INVX3 U12 ( .A(n5), .Y(sti_addr_o[2]) );
  INVXL U13 ( .A(N73), .Y(n9) );
  INVX3 U14 ( .A(n9), .Y(sti_addr_o[3]) );
  INVXL U15 ( .A(N74), .Y(n11) );
  INVX3 U16 ( .A(n11), .Y(sti_addr_o[4]) );
  INVXL U17 ( .A(N75), .Y(n13) );
  INVX3 U18 ( .A(n13), .Y(sti_addr_o[5]) );
  INVXL U19 ( .A(N76), .Y(n15) );
  INVX3 U20 ( .A(n15), .Y(sti_addr_o[6]) );
  INVXL U21 ( .A(N77), .Y(n17) );
  INVX3 U22 ( .A(n17), .Y(sti_addr_o[7]) );
  INVXL U23 ( .A(N78), .Y(n19) );
  INVX3 U24 ( .A(n19), .Y(sti_addr_o[8]) );
  INVXL U25 ( .A(N79), .Y(n21) );
  INVX3 U26 ( .A(n21), .Y(sti_addr_o[9]) );
  INVXL U27 ( .A(N70), .Y(n23) );
  INVXL U28 ( .A(n23), .Y(n45) );
  INVX3 U29 ( .A(n23), .Y(sti_addr_o[0]) );
  INVX4 U30 ( .A(n80), .Y(n81) );
  MX2XL U31 ( .A(n77), .B(n76), .S0(n1), .Y(N119) );
  AO22X1 U32 ( .A0(n75), .A1(n73), .B0(N69), .B1(n76), .Y(N120) );
  AO21X4 U33 ( .A0(n75), .A1(n67), .B0(n74), .Y(n71) );
  NAND4XL U34 ( .A(fw_addr_o[2]), .B(n32), .C(fw_addr_o[8]), .D(fw_addr_o[3]), 
        .Y(n82) );
  NAND2X1 U35 ( .A(n84), .B(n63), .Y(n78) );
  AND2X2 U36 ( .A(start), .B(n80), .Y(n47) );
  CLKINVX1 U37 ( .A(n65), .Y(n62) );
  NOR2X1 U38 ( .A(n66), .B(n65), .Y(n74) );
  XNOR2XL U39 ( .A(n84), .B(cnt4_v_i), .Y(n66) );
  NOR2BXL U40 ( .AN(start), .B(n84), .Y(N80) );
  INVXL U41 ( .A(cnt4_v_i), .Y(n63) );
  AND2X2 U42 ( .A(N69), .B(n1), .Y(n48) );
  AOI221X1 U43 ( .A0(sti_di_i[0]), .A1(n48), .B0(sti_di_i[8]), .B1(n51), .C0(
        n54), .Y(n61) );
  MX2XL U44 ( .A(n75), .B(n74), .S0(N66), .Y(N117) );
  AND2XL U45 ( .A(n75), .B(n52), .Y(n77) );
  MX2XL U46 ( .A(n68), .B(n71), .S0(N67), .Y(N118) );
  AND2XL U47 ( .A(n75), .B(N66), .Y(n68) );
  AO22X1 U48 ( .A0(N39), .A1(n47), .B0(sti_addr_o[0]), .B1(n81), .Y(n44) );
  AO22X1 U49 ( .A0(N47), .A1(n47), .B0(sti_addr_o[8]), .B1(n81), .Y(n36) );
  AO22X1 U50 ( .A0(N46), .A1(n47), .B0(sti_addr_o[7]), .B1(n81), .Y(n37) );
  AO22X1 U51 ( .A0(N45), .A1(n47), .B0(sti_addr_o[6]), .B1(n81), .Y(n38) );
  AO22X1 U52 ( .A0(N44), .A1(n47), .B0(sti_addr_o[5]), .B1(n81), .Y(n39) );
  AO22X1 U53 ( .A0(N43), .A1(n47), .B0(sti_addr_o[4]), .B1(n81), .Y(n40) );
  AO22X1 U54 ( .A0(N42), .A1(n47), .B0(sti_addr_o[3]), .B1(n81), .Y(n41) );
  AO22X1 U55 ( .A0(N41), .A1(n47), .B0(sti_addr_o[2]), .B1(n81), .Y(n42) );
  AO22X1 U56 ( .A0(N40), .A1(n47), .B0(n4), .B1(n81), .Y(n43) );
  AO22X1 U57 ( .A0(N48), .A1(n47), .B0(sti_addr_o[9]), .B1(n81), .Y(n35) );
  AND2X2 U58 ( .A(n52), .B(n69), .Y(n70) );
  AND2X2 U59 ( .A(N9), .B(n69), .Y(n49) );
  AND2X2 U60 ( .A(N9), .B(N69), .Y(n50) );
  NAND2X1 U61 ( .A(n34), .B(start), .Y(n65) );
  AND2X2 U62 ( .A(n69), .B(n1), .Y(n51) );
  CLKBUFX3 U63 ( .A(n85), .Y(start) );
  NOR4X1 U64 ( .A(n28), .B(n29), .C(n30), .D(n31), .Y(n7) );
  OAI21XL U65 ( .A0(n83), .A1(n82), .B0(n34), .Y(n33) );
  NAND4X1 U66 ( .A(fw_addr_o[10]), .B(fw_addr_o[9]), .C(n8), .D(n7), .Y(n83)
         );
  NOR4X1 U67 ( .A(n24), .B(n25), .C(n26), .D(n27), .Y(n8) );
  AND2X2 U68 ( .A(N67), .B(N66), .Y(n52) );
  CLKMX2X2 U69 ( .A(N69), .B(n70), .S0(n1), .Y(n73) );
  AO22X4 U70 ( .A0(sti_di_i[12]), .A1(n49), .B0(sti_di_i[4]), .B1(n50), .Y(n54) );
  AO22X4 U71 ( .A0(sti_di_i[14]), .A1(n49), .B0(sti_di_i[6]), .B1(n50), .Y(n55) );
  AOI221X2 U72 ( .A0(sti_di_i[2]), .A1(n48), .B0(sti_di_i[10]), .B1(n51), .C0(
        n55), .Y(n60) );
  AO22X4 U73 ( .A0(sti_di_i[13]), .A1(n49), .B0(sti_di_i[5]), .B1(n50), .Y(n56) );
  AOI221X2 U74 ( .A0(sti_di_i[1]), .A1(n48), .B0(sti_di_i[9]), .B1(n51), .C0(
        n56), .Y(n59) );
  AO22X4 U75 ( .A0(sti_di_i[15]), .A1(n49), .B0(sti_di_i[7]), .B1(n50), .Y(n57) );
  AOI221X2 U76 ( .A0(sti_di_i[3]), .A1(n48), .B0(sti_di_i[11]), .B1(n51), .C0(
        n57), .Y(n58) );
  MXI4X4 U77 ( .A(n61), .B(n60), .C(n59), .D(n58), .S0(n72), .S1(n67), .Y(n84)
         );
  NAND2X2 U78 ( .A(start), .B(n79), .Y(n80) );
endmodule


module Backward_DW01_dec_0 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15;

  CLKINVX1 U1 ( .A(n15), .Y(n1) );
  OR2X1 U2 ( .A(A[1]), .B(A[0]), .Y(n12) );
  CLKINVX1 U3 ( .A(A[10]), .Y(n2) );
  CLKINVX1 U4 ( .A(A[11]), .Y(n3) );
  AO21X1 U5 ( .A0(n4), .A1(A[9]), .B0(n5), .Y(SUM[9]) );
  OAI2BB1X1 U6 ( .A0N(n6), .A1N(A[8]), .B0(n4), .Y(SUM[8]) );
  OAI2BB1X1 U7 ( .A0N(n7), .A1N(A[7]), .B0(n6), .Y(SUM[7]) );
  OAI2BB1X1 U8 ( .A0N(n8), .A1N(A[6]), .B0(n7), .Y(SUM[6]) );
  OAI2BB1X1 U9 ( .A0N(n9), .A1N(A[5]), .B0(n8), .Y(SUM[5]) );
  OAI2BB1X1 U10 ( .A0N(n10), .A1N(A[4]), .B0(n9), .Y(SUM[4]) );
  OAI2BB1X1 U11 ( .A0N(n11), .A1N(A[3]), .B0(n10), .Y(SUM[3]) );
  OAI2BB1X1 U12 ( .A0N(n12), .A1N(A[2]), .B0(n11), .Y(SUM[2]) );
  OAI2BB1X1 U13 ( .A0N(A[0]), .A1N(A[1]), .B0(n12), .Y(SUM[1]) );
  XOR2X1 U14 ( .A(A[13]), .B(n13), .Y(SUM[13]) );
  NOR2X1 U15 ( .A(A[12]), .B(n14), .Y(n13) );
  XNOR2X1 U16 ( .A(A[12]), .B(n14), .Y(SUM[12]) );
  OAI21XL U17 ( .A0(n1), .A1(n3), .B0(n14), .Y(SUM[11]) );
  NAND2X1 U18 ( .A(n1), .B(n3), .Y(n14) );
  OAI21XL U19 ( .A0(n5), .A1(n2), .B0(n15), .Y(SUM[10]) );
  NAND2X1 U20 ( .A(n5), .B(n2), .Y(n15) );
  NOR2X1 U21 ( .A(n4), .B(A[9]), .Y(n5) );
  OR2X1 U22 ( .A(n6), .B(A[8]), .Y(n4) );
  OR2X1 U23 ( .A(n7), .B(A[7]), .Y(n6) );
  OR2X1 U24 ( .A(n8), .B(A[6]), .Y(n7) );
  OR2X1 U25 ( .A(n9), .B(A[5]), .Y(n8) );
  OR2X1 U26 ( .A(n10), .B(A[4]), .Y(n9) );
  OR2X1 U27 ( .A(n11), .B(A[3]), .Y(n10) );
  OR2X1 U28 ( .A(n12), .B(A[2]), .Y(n11) );
  CLKINVX1 U29 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module Backward ( clk, rst, bw_start_i, cnt4_v_i, res_di_i, iswhite_o, 
        bw_addr_o, bw_wr_o, bw_fin_o );
  input [7:0] res_di_i;
  output [13:0] bw_addr_o;
  input clk, rst, bw_start_i, cnt4_v_i;
  output iswhite_o, bw_wr_o, bw_fin_o;
  wire   N77, N78, N79, N80, N81, N82, N83, N84, N85, N86, N87, N88, N89, N90,
         N121, n1, n2, n3, n4, n5, n7, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n26, n27, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n6, n8, n25, n28, n66;
  wire   [1:0] cnt;
  assign bw_wr_o = N121;

  Backward_DW01_dec_0 r374 ( .A(bw_addr_o), .SUM({N90, N89, N88, N87, N86, N85, 
        N84, N83, N82, N81, N80, N79, N78, N77}) );
  DFFX1 \bw_addr_o_reg[13]  ( .D(n63), .CK(clk), .Q(bw_addr_o[13]), .QN(n34)
         );
  DFFRX1 bw_fin_o_reg ( .D(n33), .CK(clk), .RN(rst), .Q(bw_fin_o), .QN(n32) );
  DFFX1 \bw_addr_o_reg[11]  ( .D(n51), .CK(clk), .Q(bw_addr_o[11]), .QN(n36)
         );
  DFFX1 \bw_addr_o_reg[12]  ( .D(n50), .CK(clk), .Q(bw_addr_o[12]), .QN(n35)
         );
  DFFX1 \bw_addr_o_reg[10]  ( .D(n52), .CK(clk), .Q(bw_addr_o[10]), .QN(n37)
         );
  DFFX1 \bw_addr_o_reg[9]  ( .D(n53), .CK(clk), .Q(bw_addr_o[9]), .QN(n38) );
  DFFX1 \bw_addr_o_reg[7]  ( .D(n55), .CK(clk), .Q(bw_addr_o[7]), .QN(n40) );
  DFFX1 \bw_addr_o_reg[8]  ( .D(n54), .CK(clk), .Q(bw_addr_o[8]), .QN(n39) );
  DFFX1 \bw_addr_o_reg[4]  ( .D(n58), .CK(clk), .Q(bw_addr_o[4]), .QN(n43) );
  DFFX1 \bw_addr_o_reg[5]  ( .D(n57), .CK(clk), .Q(bw_addr_o[5]), .QN(n42) );
  DFFX1 \bw_addr_o_reg[6]  ( .D(n56), .CK(clk), .Q(bw_addr_o[6]), .QN(n41) );
  DFFX1 \bw_addr_o_reg[2]  ( .D(n60), .CK(clk), .Q(bw_addr_o[2]), .QN(n45) );
  DFFX1 \bw_addr_o_reg[3]  ( .D(n59), .CK(clk), .Q(bw_addr_o[3]), .QN(n44) );
  DFFX1 \bw_addr_o_reg[1]  ( .D(n61), .CK(clk), .Q(bw_addr_o[1]), .QN(n46) );
  DFFX1 \bw_addr_o_reg[0]  ( .D(n62), .CK(clk), .Q(bw_addr_o[0]), .QN(n47) );
  DFFX1 \cnt_reg[1]  ( .D(n64), .CK(clk), .Q(cnt[1]), .QN(n66) );
  DFFX1 \cnt_reg[0]  ( .D(n49), .CK(clk), .Q(cnt[0]), .QN(n28) );
  DFFX1 iswhite_o_reg ( .D(n65), .CK(clk), .Q(iswhite_o), .QN(n48) );
  CLKINVX1 U3 ( .A(bw_start_i), .Y(n6) );
  OAI32X1 U4 ( .A0(n28), .A1(n25), .A2(n5), .B0(n66), .B1(n7), .Y(n64) );
  NAND2X1 U5 ( .A(bw_start_i), .B(n66), .Y(n5) );
  CLKINVX1 U6 ( .A(n7), .Y(n25) );
  CLKBUFX3 U7 ( .A(n9), .Y(n8) );
  OAI211X1 U8 ( .A0(n36), .A1(n8), .B0(n11), .C0(bw_start_i), .Y(n51) );
  NAND2X1 U9 ( .A(N88), .B(n8), .Y(n11) );
  OAI211X1 U10 ( .A0(n34), .A1(n8), .B0(n23), .C0(bw_start_i), .Y(n63) );
  NAND2X1 U11 ( .A(N90), .B(n9), .Y(n23) );
  OAI31XL U12 ( .A0(n66), .A1(n48), .A2(n6), .B0(n29), .Y(n65) );
  NOR3XL U13 ( .A(res_di_i[5]), .B(res_di_i[7]), .C(res_di_i[6]), .Y(n30) );
  OAI211X1 U14 ( .A0(n35), .A1(n9), .B0(n10), .C0(bw_start_i), .Y(n50) );
  NAND2X1 U15 ( .A(N89), .B(n9), .Y(n10) );
  OAI211X1 U16 ( .A0(n37), .A1(n8), .B0(n12), .C0(bw_start_i), .Y(n52) );
  NAND2X1 U17 ( .A(N87), .B(n9), .Y(n12) );
  OAI211X1 U18 ( .A0(n38), .A1(n8), .B0(n13), .C0(bw_start_i), .Y(n53) );
  NAND2X1 U19 ( .A(N86), .B(n9), .Y(n13) );
  OAI211X1 U20 ( .A0(n39), .A1(n8), .B0(n14), .C0(bw_start_i), .Y(n54) );
  NAND2X1 U21 ( .A(N85), .B(n9), .Y(n14) );
  OAI211X1 U22 ( .A0(n40), .A1(n8), .B0(n15), .C0(bw_start_i), .Y(n55) );
  NAND2X1 U23 ( .A(N84), .B(n9), .Y(n15) );
  OAI32X1 U24 ( .A0(n5), .A1(cnt[0]), .A2(n25), .B0(n7), .B1(n28), .Y(n49) );
  OAI211X1 U25 ( .A0(n41), .A1(n8), .B0(n16), .C0(bw_start_i), .Y(n56) );
  NAND2X1 U26 ( .A(N83), .B(n9), .Y(n16) );
  OAI211X1 U27 ( .A0(n42), .A1(n8), .B0(n17), .C0(bw_start_i), .Y(n57) );
  NAND2X1 U28 ( .A(N82), .B(n9), .Y(n17) );
  OAI211X1 U29 ( .A0(n43), .A1(n8), .B0(n18), .C0(bw_start_i), .Y(n58) );
  NAND2X1 U30 ( .A(N81), .B(n9), .Y(n18) );
  OAI211X1 U31 ( .A0(n44), .A1(n8), .B0(n19), .C0(bw_start_i), .Y(n59) );
  NAND2X1 U32 ( .A(N80), .B(n9), .Y(n19) );
  OAI211X1 U33 ( .A0(n47), .A1(n8), .B0(n22), .C0(bw_start_i), .Y(n62) );
  NAND2X1 U34 ( .A(N77), .B(n9), .Y(n22) );
  NAND2X1 U35 ( .A(bw_start_i), .B(n26), .Y(n7) );
  XNOR2XL U36 ( .A(cnt4_v_i), .B(n27), .Y(n26) );
  NAND2X1 U37 ( .A(n48), .B(cnt[1]), .Y(n27) );
  AND3X2 U38 ( .A(cnt[1]), .B(n32), .C(n24), .Y(n9) );
  XNOR2XL U39 ( .A(cnt4_v_i), .B(n48), .Y(n24) );
  NOR2X1 U40 ( .A(cnt[0]), .B(n66), .Y(N121) );
  OAI211X1 U41 ( .A0(n46), .A1(n8), .B0(n21), .C0(bw_start_i), .Y(n61) );
  NAND2X1 U42 ( .A(N78), .B(n8), .Y(n21) );
  OAI211X1 U43 ( .A0(n45), .A1(n8), .B0(n20), .C0(bw_start_i), .Y(n60) );
  NAND2X1 U44 ( .A(N79), .B(n8), .Y(n20) );
  OAI21XL U45 ( .A0(n1), .A1(n2), .B0(n32), .Y(n33) );
  NAND4X1 U46 ( .A(n42), .B(n43), .C(n41), .D(n4), .Y(n1) );
  NAND4X1 U47 ( .A(n35), .B(n36), .C(n34), .D(n3), .Y(n2) );
  AND4X1 U48 ( .A(n47), .B(n46), .C(n45), .D(n44), .Y(n4) );
  AND4X1 U49 ( .A(n40), .B(n39), .C(n38), .D(n37), .Y(n3) );
  NOR4XL U50 ( .A(res_di_i[2]), .B(res_di_i[1]), .C(res_di_i[0]), .D(n5), .Y(
        n31) );
  NAND4BBXL U51 ( .AN(res_di_i[4]), .BN(res_di_i[3]), .C(n30), .D(n31), .Y(n29) );
endmodule


module RES_DW01_sub_0_DW01_sub_1 ( A, B, CI, DIFF, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5;
  wire   [14:0] carry;

  ADDFXL U2_2 ( .A(A[2]), .B(n5), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2]) );
  ADDFX2 U2_3 ( .A(A[3]), .B(n5), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3]) );
  ADDFHX2 U2_7 ( .A(A[7]), .B(n3), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  ADDFX1 U2_1 ( .A(A[1]), .B(n5), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1]) );
  ADDFHX2 U2_4 ( .A(A[4]), .B(n5), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  ADDFHX2 U2_5 ( .A(A[5]), .B(n5), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFHX2 U2_6 ( .A(A[6]), .B(n5), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  XNOR2XL U1 ( .A(A[11]), .B(carry[11]), .Y(DIFF[11]) );
  CLKINVX1 U2 ( .A(A[0]), .Y(n2) );
  XNOR2X1 U3 ( .A(A[13]), .B(carry[13]), .Y(DIFF[13]) );
  CLKINVX1 U4 ( .A(B[0]), .Y(n4) );
  INVX8 U5 ( .A(B[6]), .Y(n5) );
  INVXL U6 ( .A(B[7]), .Y(n3) );
  OR2X2 U7 ( .A(A[8]), .B(carry[8]), .Y(carry[9]) );
  OR2X2 U8 ( .A(A[10]), .B(carry[10]), .Y(carry[11]) );
  OR2X2 U9 ( .A(A[11]), .B(carry[11]), .Y(carry[12]) );
  OR2XL U10 ( .A(A[12]), .B(carry[12]), .Y(carry[13]) );
  XNOR2XL U11 ( .A(A[10]), .B(carry[10]), .Y(DIFF[10]) );
  XNOR2XL U12 ( .A(A[9]), .B(carry[9]), .Y(DIFF[9]) );
  XNOR2XL U13 ( .A(A[8]), .B(carry[8]), .Y(DIFF[8]) );
  XNOR2XL U14 ( .A(n4), .B(A[0]), .Y(DIFF[0]) );
  XNOR2X1 U15 ( .A(A[12]), .B(carry[12]), .Y(DIFF[12]) );
  OR2X1 U16 ( .A(A[9]), .B(carry[9]), .Y(carry[10]) );
  NAND2X1 U17 ( .A(n1), .B(n2), .Y(carry[1]) );
  CLKINVX1 U18 ( .A(n4), .Y(n1) );
endmodule


module RES_DW01_add_0_DW01_add_1 ( A, B, CI, SUM, CO );
  input [13:0] A;
  input [13:0] B;
  output [13:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6;
  wire   [13:1] carry;

  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFHX1 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFHX1 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFHX1 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFHX2 U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7])
         );
  ADDFHX1 U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  CLKAND2X3 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  CLKAND2X3 U2 ( .A(A[11]), .B(n4), .Y(n5) );
  AND2X2 U3 ( .A(A[12]), .B(n5), .Y(n6) );
  XOR2XL U4 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
  AND2X4 U5 ( .A(A[9]), .B(n2), .Y(n3) );
  AND2X4 U6 ( .A(A[10]), .B(n3), .Y(n4) );
  XOR2XL U7 ( .A(A[9]), .B(n2), .Y(SUM[9]) );
  XOR2XL U8 ( .A(A[8]), .B(carry[8]), .Y(SUM[8]) );
  XOR2X1 U9 ( .A(A[13]), .B(n6), .Y(SUM[13]) );
  XOR2X1 U10 ( .A(A[10]), .B(n3), .Y(SUM[10]) );
  XOR2X1 U11 ( .A(A[11]), .B(n4), .Y(SUM[11]) );
  XOR2X1 U12 ( .A(A[12]), .B(n5), .Y(SUM[12]) );
  AND2X2 U13 ( .A(A[8]), .B(carry[8]), .Y(n2) );
endmodule


module RES_DW01_inc_2 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;
  wire   n1, n3, n4, n5, n6, n7, n8, n9, n11, n12, n14, n15, n16, n17, n18,
         n20, n21, n22, n24, n45, n46;
  assign n9 = A[5];
  assign n12 = A[4];
  assign n15 = A[3];
  assign n18 = A[2];
  assign n22 = A[1];
  assign n24 = A[0];

  NAND2X8 U28 ( .A(n22), .B(n24), .Y(n21) );
  INVX1 U35 ( .A(n24), .Y(SUM[0]) );
  NAND2X8 U36 ( .A(n15), .B(n18), .Y(n14) );
  INVX3 U37 ( .A(n21), .Y(n20) );
  BUFX8 U38 ( .A(n18), .Y(n45) );
  NOR2X6 U39 ( .A(n21), .B(n14), .Y(n46) );
  NOR2X8 U40 ( .A(n21), .B(n14), .Y(n1) );
  XOR2X4 U41 ( .A(n24), .B(n22), .Y(SUM[1]) );
  NAND2X2 U42 ( .A(n20), .B(n45), .Y(n17) );
  NAND2X6 U43 ( .A(n12), .B(n9), .Y(n8) );
  INVX4 U44 ( .A(n8), .Y(n7) );
  NAND2X2 U45 ( .A(n7), .B(n46), .Y(n6) );
  CLKINVX1 U46 ( .A(n15), .Y(n16) );
  XNOR2X4 U47 ( .A(n11), .B(n9), .Y(SUM[5]) );
  NOR2X4 U48 ( .A(n8), .B(n5), .Y(n4) );
  NAND2X4 U49 ( .A(n1), .B(n12), .Y(n11) );
  XOR2X4 U50 ( .A(n20), .B(n45), .Y(SUM[2]) );
  XOR2X4 U51 ( .A(n17), .B(n16), .Y(SUM[3]) );
  XOR2X4 U52 ( .A(n1), .B(n12), .Y(SUM[4]) );
  INVX8 U53 ( .A(A[6]), .Y(n5) );
  XNOR2X4 U54 ( .A(n3), .B(A[7]), .Y(SUM[7]) );
  XOR2X4 U55 ( .A(n6), .B(n5), .Y(SUM[6]) );
  NAND2X2 U56 ( .A(n46), .B(n4), .Y(n3) );
endmodule


module RES_DW01_inc_5 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n12, n14, n15, n17, n18, n20, n21,
         n22, n23, n24, n45;
  assign n9 = A[5];
  assign n12 = A[4];
  assign n15 = A[3];
  assign n18 = A[2];
  assign n22 = A[1];
  assign n24 = A[0];

  CLKXOR2X1 U35 ( .A(n20), .B(n18), .Y(SUM[2]) );
  INVX3 U36 ( .A(n22), .Y(n23) );
  INVX6 U37 ( .A(n21), .Y(n20) );
  XNOR2X2 U38 ( .A(n17), .B(n15), .Y(SUM[3]) );
  AND2X4 U39 ( .A(n1), .B(n12), .Y(n45) );
  NAND2X2 U40 ( .A(n1), .B(n7), .Y(n6) );
  NAND2X2 U41 ( .A(n4), .B(n1), .Y(n3) );
  NOR2X6 U42 ( .A(n21), .B(n14), .Y(n1) );
  XOR2X2 U43 ( .A(n6), .B(n5), .Y(SUM[6]) );
  NAND2X2 U44 ( .A(n18), .B(n15), .Y(n14) );
  XOR2X4 U45 ( .A(n45), .B(n9), .Y(SUM[5]) );
  XNOR2X4 U46 ( .A(n23), .B(n24), .Y(SUM[1]) );
  CLKINVX2 U47 ( .A(A[6]), .Y(n5) );
  INVX2 U48 ( .A(n8), .Y(n7) );
  NAND2X6 U49 ( .A(n22), .B(n24), .Y(n21) );
  INVX1 U50 ( .A(n24), .Y(SUM[0]) );
  NAND2X1 U51 ( .A(n20), .B(n18), .Y(n17) );
  NOR2X2 U52 ( .A(n8), .B(n5), .Y(n4) );
  NAND2X2 U53 ( .A(n12), .B(n9), .Y(n8) );
  XOR2X1 U54 ( .A(n1), .B(n12), .Y(SUM[4]) );
  INVXL U55 ( .A(A[7]), .Y(n2) );
  XOR2X4 U56 ( .A(n3), .B(n2), .Y(SUM[7]) );
endmodule


module RES ( clk, rst, iswhite_i, fw_start_i, fw_fin_i, fw_addr_i, bw_fin_i, 
        bw_wr_i, bw_addr_i, res_di_i, bw_start_o, cnt4_v_o, res_wr_o, res_rd_o, 
        res_do_o, res_addr_o, done_o );
  input [1:0] iswhite_i;
  input [13:0] fw_addr_i;
  input [13:0] bw_addr_i;
  input [7:0] res_di_i;
  output [7:0] res_do_o;
  output [13:0] res_addr_o;
  input clk, rst, fw_start_i, fw_fin_i, bw_fin_i, bw_wr_i;
  output bw_start_o, cnt4_v_o, res_wr_o, res_rd_o, done_o;
  wire   \pos[6] , N130, N131, N132, N133, N134, N135, N136, N137, N138, N139,
         N140, N141, N142, N143, N160, N161, N162, N163, N164, N165, N166,
         N167, N168, N169, N170, N171, N172, N173, N344, N345, N346, N347,
         N348, N349, N350, N351, N478, n39, n40, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, N477, N476, N475,
         N474, N473, N472, N471, N470, n1, n2, n3, n4, n5, n6, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83,
         n84, n85, n86, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102,
         n103, n104, n106, n107, n108, n109, n110, n111, n112, n113, n114,
         n115, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125,
         n126, n127, n128, n129, n130, n131, n132, n133, n134, n135, n136,
         n137, n138, n139, n140, n141, n142, n143, n157, n158, n159, n160,
         n161, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178, n179, n180, n181, n182,
         n183, n184, n185, n186, n187, n188, n189, n190, n191, n192, n193,
         n194, n195, n196, n197, n198, n199, n200, n201, n202, n203, n204,
         n205, n206, n207, n208, n209, n210, n211, n212, n213, n214, n215,
         n216, n217, n218, n219, n220, n221, n222, n223, n224, n225, n226,
         n227, n228, n229, n230, n231, n232, n233, n234, n235, n236, n237,
         n238, n239, n240, n241, n242, n243, n244, n245, n246, n247, n248,
         n249, n250, n251, n252, n253, n254, n255, n256, n257, n258, n259,
         n260, n261, n262, n263, n264, n265, n266, n267, n268, n269, n270,
         n271, n272, n273, n274, n275, n276, n277, n278, n279, n280, n281,
         n282, n283, n284, n285, n286, n287, n288, n289, n290, n291, n292,
         n293, n294, n295, n296, n297, n298, n299, n300, n301, n302, n303,
         n304, n305, n306, n307, n308, n309;
  wire   [1:0] NEXT;
  wire   [2:0] cnt4;
  wire   [7:0] bw_cp;
  wire   [7:0] cp_data;
  wire   [7:0] bw_init;

  RES_DW01_sub_0_DW01_sub_1 sub_299 ( .A(fw_addr_i), .B({1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, n242, \pos[6] , \pos[6] , \pos[6] , \pos[6] , 
        \pos[6] , \pos[6] , n6}), .CI(1'b0), .DIFF({N143, N142, N141, N140, 
        N139, N138, N137, N136, N135, N134, N133, N132, N131, N130}) );
  RES_DW01_add_0_DW01_add_1 add_305_aco ( .A(bw_addr_i), .B({1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, N477, N476, N475, N474, N473, N472, N471, N470}), 
        .CI(1'b0), .SUM({N173, N172, N171, N170, N169, N168, N167, N166, N165, 
        N164, N163, N162, N161, N160}) );
  RES_DW01_inc_2 add_367 ( .A(res_di_i), .SUM(bw_cp) );
  RES_DW01_inc_5 add_393 ( .A({n95, n100, n52, n97, n25, cp_data[2], n239, n72}), .SUM({N351, N350, N349, N348, N347, N346, N345, N344}) );
  DFFRX1 bw_fin_reg ( .D(bw_fin_i), .CK(clk), .RN(rst), .QN(n296) );
  EDFFTRX1 \bw_init_reg[4]  ( .RN(bw_start_o), .D(res_di_i[4]), .E(n240), .CK(
        clk), .Q(bw_init[4]) );
  EDFFTRX1 \bw_init_reg[2]  ( .RN(bw_start_o), .D(n58), .E(n240), .CK(clk), 
        .Q(bw_init[2]), .QN(n10) );
  EDFFTRX1 \bw_init_reg[5]  ( .RN(bw_start_o), .D(res_di_i[5]), .E(n240), .CK(
        clk), .Q(bw_init[5]), .QN(n9) );
  EDFFTRX1 \bw_init_reg[1]  ( .RN(bw_start_o), .D(n59), .E(n240), .CK(clk), 
        .Q(bw_init[1]), .QN(n8) );
  EDFFTRX1 \bw_init_reg[0]  ( .RN(bw_start_o), .D(n67), .E(n240), .CK(clk), 
        .QN(n143) );
  EDFFTRX1 \bw_init_reg[3]  ( .RN(bw_start_o), .D(n1), .E(n240), .CK(clk), .Q(
        bw_init[3]), .QN(n3) );
  EDFFTRX1 \bw_init_reg[7]  ( .RN(bw_start_o), .D(res_di_i[7]), .E(n240), .CK(
        clk), .Q(bw_init[7]), .QN(n49) );
  DFFQX2 \cnt4_reg[0]  ( .D(n156), .CK(clk), .Q(cnt4[0]) );
  DFFQX2 \cnt4_reg[1]  ( .D(n154), .CK(clk), .Q(cnt4[1]) );
  DFFQX2 \res_addr_o_reg[13]  ( .D(n5), .CK(clk), .Q(res_addr_o[13]) );
  DFFQX2 \res_addr_o_reg[12]  ( .D(n297), .CK(clk), .Q(res_addr_o[12]) );
  DFFQX2 \res_addr_o_reg[11]  ( .D(n298), .CK(clk), .Q(res_addr_o[11]) );
  DFFRHQX8 \res_do_o_reg[0]  ( .D(n151), .CK(clk), .RN(1'b1), .Q(res_do_o[0])
         );
  DFFRX1 fw_fin_reg ( .D(fw_fin_i), .CK(clk), .RN(rst), .Q(n106) );
  DFFTRX1 \cnt4_reg[2]  ( .D(1'b1), .RN(n155), .CK(clk), .Q(cnt4[2]), .QN(n249) );
  DFFRX4 \STATE_reg[1]  ( .D(NEXT[1]), .CK(clk), .RN(rst), .Q(n247), .QN(n39)
         );
  DFFRX4 \STATE_reg[0]  ( .D(NEXT[0]), .CK(clk), .RN(rst), .Q(n107), .QN(n40)
         );
  DFFQX2 res_rd_o_reg ( .D(n152), .CK(clk), .Q(res_rd_o) );
  DFFQX2 res_wr_o_reg ( .D(n153), .CK(clk), .Q(res_wr_o) );
  DFFHQX8 \res_addr_o_reg[8]  ( .D(n301), .CK(clk), .Q(res_addr_o[8]) );
  DFFHQX8 \res_addr_o_reg[9]  ( .D(n300), .CK(clk), .Q(res_addr_o[9]) );
  DFFHQX8 \res_addr_o_reg[10]  ( .D(n299), .CK(clk), .Q(res_addr_o[10]) );
  DFFQX2 \res_addr_o_reg[0]  ( .D(n309), .CK(clk), .Q(res_addr_o[0]) );
  DFFQX2 \res_addr_o_reg[1]  ( .D(n308), .CK(clk), .Q(res_addr_o[1]) );
  DFFQX2 \res_addr_o_reg[2]  ( .D(n307), .CK(clk), .Q(res_addr_o[2]) );
  DFFQX2 \res_addr_o_reg[3]  ( .D(n306), .CK(clk), .Q(res_addr_o[3]) );
  DFFQX2 \res_addr_o_reg[4]  ( .D(n305), .CK(clk), .Q(res_addr_o[4]) );
  DFFQX2 \res_addr_o_reg[5]  ( .D(n304), .CK(clk), .Q(res_addr_o[5]) );
  DFFHQX8 \res_do_o_reg[5]  ( .D(n146), .CK(clk), .Q(res_do_o[5]) );
  DFFHQX8 \res_do_o_reg[7]  ( .D(n144), .CK(clk), .Q(res_do_o[7]) );
  DFFRHQX8 \res_do_o_reg[3]  ( .D(n148), .CK(clk), .RN(1'b1), .Q(res_do_o[3])
         );
  EDFFTRX1 \bw_init_reg[6]  ( .RN(bw_start_o), .D(res_di_i[6]), .E(n240), .CK(
        clk), .Q(bw_init[6]), .QN(n11) );
  DFFQX2 \res_addr_o_reg[7]  ( .D(n302), .CK(clk), .Q(res_addr_o[7]) );
  DFFQX2 \res_addr_o_reg[6]  ( .D(n303), .CK(clk), .Q(res_addr_o[6]) );
  DFFRHQX8 \res_do_o_reg[4]  ( .D(n147), .CK(clk), .RN(1'b1), .Q(res_do_o[4])
         );
  DFFRHQX8 \res_do_o_reg[6]  ( .D(n145), .CK(clk), .RN(1'b1), .Q(res_do_o[6])
         );
  DFFRHQX8 \res_do_o_reg[2]  ( .D(n149), .CK(clk), .RN(1'b1), .Q(res_do_o[2])
         );
  DFFRHQX8 \res_do_o_reg[1]  ( .D(n150), .CK(clk), .RN(1'b1), .Q(res_do_o[1])
         );
  OA22XL U3 ( .A0(n227), .A1(n206), .B0(n251), .B1(n205), .Y(n209) );
  CLKINVX2 U4 ( .A(res_di_i[1]), .Y(n204) );
  BUFX4 U5 ( .A(res_di_i[0]), .Y(n67) );
  NAND2X4 U6 ( .A(n74), .B(bw_init[5]), .Y(n192) );
  NAND3X4 U7 ( .A(n208), .B(n207), .C(n4), .Y(n150) );
  INVXL U8 ( .A(n211), .Y(n1) );
  INVX8 U9 ( .A(res_di_i[2]), .Y(n195) );
  INVXL U10 ( .A(bw_cp[3]), .Y(n212) );
  OR2X6 U11 ( .A(n164), .B(n190), .Y(n41) );
  INVX3 U12 ( .A(n165), .Y(n19) );
  OR2X6 U13 ( .A(n164), .B(n213), .Y(n24) );
  OR2X4 U14 ( .A(n164), .B(n197), .Y(n46) );
  AOI2BB2X4 U15 ( .B0(n2), .B1(bw_cp[3]), .A0N(n196), .A1N(res_do_o[2]), .Y(
        n114) );
  CLKINVX20 U17 ( .A(res_do_o[3]), .Y(n2) );
  NAND2X8 U18 ( .A(n68), .B(n115), .Y(n133) );
  BUFX16 U19 ( .A(n235), .Y(n18) );
  INVX6 U20 ( .A(n84), .Y(n73) );
  AND2X2 U21 ( .A(n104), .B(n173), .Y(n84) );
  INVX6 U22 ( .A(bw_cp[1]), .Y(n205) );
  NAND3BXL U23 ( .AN(cnt4[0]), .B(n86), .C(n256), .Y(n175) );
  CLKAND2X8 U24 ( .A(res_do_o[7]), .B(n225), .Y(n85) );
  BUFX4 U25 ( .A(n129), .Y(n71) );
  CLKINVX1 U26 ( .A(res_do_o[5]), .Y(n190) );
  INVX1 U27 ( .A(iswhite_i[0]), .Y(n108) );
  BUFX20 U28 ( .A(n244), .Y(bw_start_o) );
  INVX3 U29 ( .A(n281), .Y(n244) );
  AND2X2 U30 ( .A(n209), .B(n210), .Y(n4) );
  INVX3 U31 ( .A(iswhite_i[1]), .Y(N478) );
  OR3X2 U32 ( .A(n80), .B(n81), .C(n82), .Y(n5) );
  AND2X4 U33 ( .A(n78), .B(n79), .Y(n6) );
  CLKINVX1 U34 ( .A(res_do_o[3]), .Y(n213) );
  CLKINVX1 U35 ( .A(res_do_o[7]), .Y(n226) );
  OAI21X4 U36 ( .A0(n254), .A1(n245), .B0(n248), .Y(n253) );
  AO22X1 U37 ( .A0(n240), .A1(n256), .B0(n138), .B1(n245), .Y(n232) );
  OAI211X4 U38 ( .A0(bw_wr_i), .A1(n245), .B0(n256), .C0(n278), .Y(n272) );
  AOI222X1 U39 ( .A0(N171), .A1(bw_start_o), .B0(fw_addr_i[11]), .B1(n257), 
        .C0(N141), .C1(n245), .Y(n259) );
  INVX4 U40 ( .A(n250), .Y(n245) );
  OR2X6 U41 ( .A(n93), .B(bw_init[3]), .Y(n42) );
  INVX12 U42 ( .A(n93), .Y(n94) );
  BUFX6 U43 ( .A(n94), .Y(n25) );
  CLKAND2X12 U44 ( .A(n47), .B(n8), .Y(n158) );
  INVX3 U45 ( .A(n59), .Y(n12) );
  NAND2X4 U46 ( .A(res_di_i[4]), .B(n183), .Y(n124) );
  INVX12 U47 ( .A(n99), .Y(n100) );
  NAND2X4 U48 ( .A(n74), .B(bw_init[6]), .Y(n178) );
  INVX3 U49 ( .A(n47), .Y(n202) );
  INVX12 U50 ( .A(n20), .Y(cp_data[2]) );
  OR2X2 U51 ( .A(n182), .B(res_do_o[4]), .Y(n53) );
  BUFX4 U52 ( .A(n182), .Y(n66) );
  CLKINVX2 U53 ( .A(n96), .Y(n97) );
  CLKBUFX2 U54 ( .A(n225), .Y(n13) );
  INVX4 U55 ( .A(bw_cp[4]), .Y(n182) );
  AOI2BB1X4 U56 ( .A0N(bw_cp[4]), .A1N(n183), .B0(res_do_o[5]), .Y(n117) );
  INVX3 U57 ( .A(n57), .Y(n14) );
  CLKINVX3 U58 ( .A(n189), .Y(n57) );
  OA22XL U59 ( .A0(n227), .A1(n190), .B0(n251), .B1(n14), .Y(n193) );
  NOR2X4 U60 ( .A(n51), .B(n183), .Y(n69) );
  INVX16 U61 ( .A(n101), .Y(n165) );
  NAND2X4 U62 ( .A(n50), .B(n134), .Y(n16) );
  CLKAND2X12 U63 ( .A(n71), .B(n128), .Y(n15) );
  NAND2X2 U64 ( .A(n56), .B(n133), .Y(n17) );
  NAND2X4 U65 ( .A(n16), .B(n17), .Y(n136) );
  AND3X6 U66 ( .A(n53), .B(n54), .C(n110), .Y(n50) );
  AND3X6 U67 ( .A(n118), .B(n61), .C(n62), .Y(n56) );
  OR2X8 U68 ( .A(n141), .B(res_do_o[6]), .Y(n62) );
  NAND2X6 U69 ( .A(n135), .B(n246), .Y(n218) );
  AOI22X2 U70 ( .A0(n226), .A1(bw_cp[7]), .B0(bw_cp[6]), .B1(n142), .Y(n110)
         );
  OR2X4 U71 ( .A(bw_cp[2]), .B(n197), .Y(n29) );
  NAND2X6 U72 ( .A(n60), .B(res_do_o[7]), .Y(n34) );
  INVX6 U73 ( .A(n164), .Y(n60) );
  OR2X4 U74 ( .A(n165), .B(n13), .Y(n32) );
  OR2X6 U75 ( .A(n100), .B(n11), .Y(n36) );
  INVX6 U76 ( .A(cp_data[4]), .Y(n96) );
  AOI2BB2X4 U77 ( .B0(n11), .B1(n100), .A0N(n96), .A1N(bw_init[4]), .Y(n75) );
  INVX16 U78 ( .A(n98), .Y(n164) );
  AOI2BB2X4 U79 ( .B0(N350), .B1(n27), .A0N(n224), .A1N(n139), .Y(n180) );
  OR2X6 U80 ( .A(n52), .B(n9), .Y(n35) );
  OR2X8 U81 ( .A(res_do_o[7]), .B(n225), .Y(n61) );
  CLKINVX8 U82 ( .A(n141), .Y(n65) );
  INVX6 U83 ( .A(n65), .Y(n55) );
  INVX4 U84 ( .A(n203), .Y(n159) );
  AND3X8 U85 ( .A(n44), .B(n46), .C(n45), .Y(n20) );
  CLKINVX6 U86 ( .A(res_di_i[3]), .Y(n211) );
  CLKINVX2 U87 ( .A(n132), .Y(n21) );
  AO22X1 U88 ( .A0(res_di_i[6]), .A1(n142), .B0(res_di_i[7]), .B1(n226), .Y(
        n132) );
  NOR2X4 U89 ( .A(res_do_o[5]), .B(n189), .Y(n51) );
  OR2X1 U90 ( .A(bw_cp[1]), .B(n206), .Y(n30) );
  OR2X4 U91 ( .A(n165), .B(n196), .Y(n44) );
  AOI2BB2X1 U92 ( .B0(N345), .B1(n27), .A0N(n224), .A1N(n12), .Y(n210) );
  INVX1 U93 ( .A(n258), .Y(n297) );
  OR2X4 U94 ( .A(n165), .B(n212), .Y(n22) );
  OR2X2 U95 ( .A(n211), .B(n218), .Y(n23) );
  NAND3X8 U96 ( .A(n22), .B(n23), .C(n24), .Y(cp_data[3]) );
  INVX12 U97 ( .A(cp_data[3]), .Y(n93) );
  NAND3X4 U98 ( .A(n42), .B(n43), .C(n160), .Y(n161) );
  NAND3X4 U99 ( .A(n35), .B(n36), .C(n167), .Y(n168) );
  INVX4 U100 ( .A(n48), .Y(n52) );
  OAI2BB2X4 U101 ( .B0(n49), .B1(n95), .A0N(n76), .A1N(n75), .Y(n170) );
  INVX8 U102 ( .A(n95), .Y(n166) );
  NAND2X2 U103 ( .A(n18), .B(cp_data[2]), .Y(n198) );
  NAND2X2 U104 ( .A(n18), .B(n100), .Y(n177) );
  INVX1 U105 ( .A(n260), .Y(n299) );
  INVX1 U106 ( .A(n261), .Y(n300) );
  INVX1 U107 ( .A(n262), .Y(n301) );
  INVX1 U108 ( .A(n263), .Y(n302) );
  AND2XL U109 ( .A(res_wr_o), .B(n247), .Y(n287) );
  NAND2XL U110 ( .A(res_rd_o), .B(n247), .Y(n291) );
  INVXL U111 ( .A(n83), .Y(n26) );
  INVX3 U112 ( .A(n26), .Y(n27) );
  NAND3X2 U114 ( .A(n29), .B(n30), .C(n112), .Y(n113) );
  OA22X4 U115 ( .A0(bw_init[7]), .A1(n166), .B0(bw_init[6]), .B1(n99), .Y(n169) );
  CLKBUFX2 U116 ( .A(n25), .Y(n31) );
  AOI2BB2X4 U117 ( .B0(n49), .B1(n95), .A0N(n48), .A1N(bw_init[5]), .Y(n76) );
  NAND4X4 U118 ( .A(n184), .B(n186), .C(n185), .D(n187), .Y(n147) );
  CLKAND2X12 U119 ( .A(n27), .B(N349), .Y(n63) );
  INVX6 U120 ( .A(cp_data[6]), .Y(n99) );
  NAND2X2 U121 ( .A(n18), .B(n97), .Y(n184) );
  OR2X1 U122 ( .A(n223), .B(n218), .Y(n33) );
  NAND3X6 U123 ( .A(n34), .B(n33), .C(n32), .Y(cp_data[7]) );
  BUFX20 U124 ( .A(cp_data[7]), .Y(n95) );
  AOI2BB2X4 U125 ( .B0(n166), .B1(bw_init[7]), .A0N(n94), .A1N(n3), .Y(n162)
         );
  NAND4X4 U126 ( .A(n194), .B(n192), .C(n193), .D(n191), .Y(n146) );
  NOR2X6 U127 ( .A(n63), .B(n64), .Y(n194) );
  OA21X2 U128 ( .A0(n206), .A1(res_di_i[1]), .B0(n67), .Y(n121) );
  OR2X4 U129 ( .A(n165), .B(n14), .Y(n37) );
  OR2X2 U130 ( .A(n188), .B(n218), .Y(n38) );
  NAND3X6 U131 ( .A(n41), .B(n38), .C(n37), .Y(cp_data[5]) );
  INVX3 U132 ( .A(res_di_i[5]), .Y(n188) );
  INVX8 U133 ( .A(cp_data[5]), .Y(n48) );
  OR2X8 U134 ( .A(n20), .B(bw_init[2]), .Y(n43) );
  OR2X2 U135 ( .A(n195), .B(n218), .Y(n45) );
  BUFX8 U136 ( .A(n220), .Y(n101) );
  NOR2X8 U137 ( .A(n205), .B(n165), .Y(n47) );
  BUFX8 U138 ( .A(n222), .Y(n98) );
  OAI222X2 U139 ( .A0(n165), .A1(n66), .B0(n181), .B1(n218), .C0(n164), .C1(
        n183), .Y(cp_data[4]) );
  CLKMX2X6 U140 ( .A(n19), .B(n219), .S0(n67), .Y(n221) );
  NAND2X4 U141 ( .A(n95), .B(n18), .Y(n228) );
  NAND2X4 U142 ( .A(n31), .B(n18), .Y(n214) );
  NAND2X4 U143 ( .A(n52), .B(n18), .Y(n191) );
  AOI2BB2X4 U144 ( .B0(N351), .B1(n27), .A0N(n224), .A1N(n223), .Y(n231) );
  AOI2BB2X4 U145 ( .B0(n18), .B1(n72), .A0N(n73), .A1N(n143), .Y(n236) );
  AOI2BB2X2 U146 ( .B0(N348), .B1(n27), .A0N(n224), .A1N(n181), .Y(n187) );
  NOR3X2 U147 ( .A(n164), .B(bw_init[1]), .C(n206), .Y(n157) );
  NOR3BX4 U148 ( .AN(n123), .B(n122), .C(n121), .Y(n127) );
  AND3X1 U149 ( .A(res_do_o[3]), .B(n211), .C(n124), .Y(n126) );
  NAND2X6 U150 ( .A(n60), .B(res_do_o[1]), .Y(n203) );
  INVX6 U151 ( .A(res_di_i[4]), .Y(n181) );
  OR2X4 U152 ( .A(res_do_o[5]), .B(n189), .Y(n54) );
  NAND2X6 U153 ( .A(n69), .B(n66), .Y(n115) );
  CLKINVX8 U154 ( .A(n189), .Y(n102) );
  INVX12 U155 ( .A(bw_cp[5]), .Y(n189) );
  INVXL U156 ( .A(n195), .Y(n58) );
  INVXL U157 ( .A(n204), .Y(n59) );
  INVX8 U158 ( .A(bw_cp[6]), .Y(n141) );
  INVX3 U159 ( .A(n218), .Y(n219) );
  OAI2BB2X4 U160 ( .B0(n213), .B1(bw_cp[3]), .A0N(n114), .A1N(n113), .Y(n134)
         );
  OA21X4 U161 ( .A0(n57), .A1(n190), .B0(n65), .Y(n68) );
  AND2XL U162 ( .A(n232), .B(res_di_i[5]), .Y(n64) );
  AND2XL U163 ( .A(n245), .B(n172), .Y(n83) );
  NAND4X4 U164 ( .A(n198), .B(n201), .C(n199), .D(n200), .Y(n149) );
  AOI2BB2X2 U165 ( .B0(N346), .B1(n27), .A0N(n224), .A1N(n195), .Y(n201) );
  NAND2X4 U166 ( .A(n74), .B(bw_init[7]), .Y(n229) );
  AO21X2 U167 ( .A0(n60), .A1(res_do_o[0]), .B0(n221), .Y(n238) );
  NAND4X4 U168 ( .A(n178), .B(n177), .C(n180), .D(n179), .Y(n145) );
  NAND4X4 U169 ( .A(n217), .B(n216), .C(n215), .D(n214), .Y(n148) );
  NAND3BX4 U170 ( .AN(n163), .B(n161), .C(n162), .Y(n171) );
  NAND3BX4 U171 ( .AN(n70), .B(n236), .C(n237), .Y(n151) );
  AO22X1 U172 ( .A0(n232), .A1(n67), .B0(N344), .B1(n27), .Y(n70) );
  NAND2X2 U173 ( .A(n18), .B(n239), .Y(n207) );
  NAND2X4 U174 ( .A(n74), .B(bw_init[2]), .Y(n199) );
  NAND2X4 U175 ( .A(n74), .B(bw_init[3]), .Y(n215) );
  NAND2X4 U176 ( .A(n74), .B(bw_init[4]), .Y(n185) );
  NAND2X2 U177 ( .A(n74), .B(bw_init[1]), .Y(n208) );
  NAND4X4 U178 ( .A(n231), .B(n230), .C(n229), .D(n228), .Y(n144) );
  INVX1 U179 ( .A(n134), .Y(n120) );
  NAND2X1 U180 ( .A(res_di_i[3]), .B(n213), .Y(n123) );
  CLKINVX12 U181 ( .A(n73), .Y(n74) );
  AND4X2 U182 ( .A(n124), .B(n195), .C(res_do_o[2]), .D(n123), .Y(n125) );
  AOI2BB2X4 U183 ( .B0(N347), .B1(n27), .A0N(n224), .A1N(n211), .Y(n217) );
  AO22X4 U184 ( .A0(res_do_o[5]), .A1(n188), .B0(res_do_o[4]), .B1(n181), .Y(
        n128) );
  INVX8 U185 ( .A(bw_cp[2]), .Y(n196) );
  OAI221X4 U186 ( .A0(res_di_i[7]), .A1(n226), .B0(n132), .B1(n131), .C0(n130), 
        .Y(n135) );
  OAI221X2 U187 ( .A0(res_do_o[1]), .A1(n204), .B0(res_do_o[2]), .B1(n195), 
        .C0(n124), .Y(n122) );
  OA22XL U188 ( .A0(n227), .A1(n183), .B0(n251), .B1(n66), .Y(n186) );
  NAND3X6 U189 ( .A(n182), .B(res_do_o[5]), .C(res_do_o[4]), .Y(n116) );
  BUFX6 U190 ( .A(n238), .Y(n72) );
  OAI33X2 U191 ( .A0(n159), .A1(n47), .A2(n8), .B0(n158), .B1(n157), .B2(n143), 
        .Y(n160) );
  NOR2X2 U192 ( .A(n39), .B(n40), .Y(done_o) );
  OAI32X2 U193 ( .A0(n136), .A1(n281), .A2(n85), .B0(n135), .B1(n288), .Y(n222) );
  CLKINVX12 U194 ( .A(n288), .Y(n246) );
  AND2X2 U195 ( .A(N143), .B(n245), .Y(n82) );
  NAND2X2 U196 ( .A(n253), .B(n241), .Y(n79) );
  AND2XL U197 ( .A(n6), .B(N478), .Y(N470) );
  INVX1 U198 ( .A(cnt4[1]), .Y(n248) );
  NAND2X2 U199 ( .A(n250), .B(n255), .Y(n256) );
  CLKINVX3 U200 ( .A(n255), .Y(n243) );
  INVX3 U201 ( .A(n241), .Y(n77) );
  INVX1 U202 ( .A(res_di_i[6]), .Y(n139) );
  NAND2X8 U203 ( .A(n39), .B(n107), .Y(n288) );
  CLKINVX4 U204 ( .A(n109), .Y(n138) );
  NAND3BXL U205 ( .AN(cnt4[1]), .B(cnt4[0]), .C(n249), .Y(n109) );
  INVXL U206 ( .A(n251), .Y(n234) );
  INVX8 U207 ( .A(bw_cp[7]), .Y(n225) );
  NAND3BXL U208 ( .AN(cnt4[2]), .B(cnt4[1]), .C(n256), .Y(n174) );
  NAND2XL U209 ( .A(n86), .B(cnt4[0]), .Y(n292) );
  AND2X1 U210 ( .A(cnt4[2]), .B(n248), .Y(n86) );
  AOI31XL U211 ( .A0(cnt4[1]), .A1(n249), .A2(cnt4[0]), .B0(n86), .Y(n274) );
  OAI31XL U212 ( .A0(n279), .A1(bw_start_o), .A2(n246), .B0(n140), .Y(n233) );
  NAND4XL U213 ( .A(cnt4[2]), .B(cnt4[1]), .C(n243), .D(n241), .Y(n140) );
  NOR2XL U214 ( .A(n282), .B(iswhite_i[1]), .Y(n280) );
  NAND3BXL U215 ( .AN(cnt4[0]), .B(n248), .C(n249), .Y(n137) );
  MXI2XL U216 ( .A(n272), .B(n271), .S0(cnt4[0]), .Y(n156) );
  NAND2BXL U217 ( .AN(n272), .B(cnt4[0]), .Y(n275) );
  NAND2XL U218 ( .A(n40), .B(n39), .Y(n277) );
  AOI21XL U219 ( .A0(fw_start_i), .A1(n279), .B0(done_o), .Y(n295) );
  AO21XL U220 ( .A0(n107), .A1(n106), .B0(n247), .Y(NEXT[1]) );
  NAND2X2 U221 ( .A(n252), .B(n77), .Y(n78) );
  INVX1 U222 ( .A(cnt4[0]), .Y(n241) );
  AND2XL U223 ( .A(N173), .B(bw_start_o), .Y(n80) );
  AND2X2 U224 ( .A(fw_addr_i[13]), .B(n257), .Y(n81) );
  OAI211XL U225 ( .A0(n278), .A1(n288), .B0(n250), .C0(n289), .Y(n152) );
  OA21X1 U226 ( .A0(n288), .A1(n292), .B0(n293), .Y(n278) );
  OAI32X4 U227 ( .A0(n294), .A1(cnt4[0]), .A2(n288), .B0(n281), .B1(n292), .Y(
        cnt4_v_o) );
  INVX3 U228 ( .A(bw_cp[0]), .Y(n111) );
  NAND2X1 U229 ( .A(n243), .B(n172), .Y(n176) );
  CLKINVX1 U230 ( .A(n232), .Y(n224) );
  NAND2X2 U231 ( .A(n138), .B(n243), .Y(n251) );
  CLKINVX1 U232 ( .A(n174), .Y(n242) );
  CLKINVX1 U233 ( .A(n233), .Y(n227) );
  CLKINVX1 U234 ( .A(n292), .Y(n172) );
  CLKINVX1 U235 ( .A(n277), .Y(n279) );
  AOI22XL U236 ( .A0(n234), .A1(bw_cp[0]), .B0(n233), .B1(res_do_o[0]), .Y(
        n237) );
  OA22XL U237 ( .A0(n227), .A1(n197), .B0(n251), .B1(n196), .Y(n200) );
  OA22XL U238 ( .A0(n227), .A1(n213), .B0(n251), .B1(n212), .Y(n216) );
  OA22XL U239 ( .A0(n227), .A1(n226), .B0(n251), .B1(n13), .Y(n230) );
  NAND2XL U240 ( .A(res_di_i[5]), .B(n190), .Y(n129) );
  INVXL U241 ( .A(res_di_i[7]), .Y(n223) );
  CLKINVX1 U242 ( .A(res_do_o[6]), .Y(n142) );
  CLKINVX1 U243 ( .A(res_do_o[4]), .Y(n183) );
  CLKINVX1 U244 ( .A(res_do_o[1]), .Y(n206) );
  CLKAND2X3 U245 ( .A(iswhite_i[0]), .B(n246), .Y(n257) );
  CLKINVX1 U246 ( .A(res_do_o[2]), .Y(n197) );
  OAI221XL U247 ( .A0(n106), .A1(n40), .B0(n296), .B1(n39), .C0(n295), .Y(
        NEXT[0]) );
  INVX3 U248 ( .A(n137), .Y(n240) );
  AOI211X2 U255 ( .A0(n94), .A1(n3), .B0(cp_data[2]), .C0(n10), .Y(n163) );
  OAI211X4 U256 ( .A0(n12), .A1(n218), .B0(n203), .C0(n202), .Y(n239) );
  OAI222X2 U257 ( .A0(n165), .A1(n55), .B0(n139), .B1(n218), .C0(n164), .C1(
        n142), .Y(cp_data[6]) );
  INVX1 U258 ( .A(n50), .Y(n103) );
  AOI32X2 U259 ( .A0(n56), .A1(n133), .A2(bw_start_o), .B0(n85), .B1(
        bw_start_o), .Y(n119) );
  OAI211X2 U260 ( .A0(n104), .A1(n176), .B0(n175), .C0(n174), .Y(n235) );
  OAI31X2 U261 ( .A0(n120), .A1(n281), .A2(n103), .B0(n119), .Y(n220) );
  OA22X1 U262 ( .A0(n227), .A1(n142), .B0(n251), .B1(n55), .Y(n179) );
  AOI22X4 U263 ( .A0(n170), .A1(n171), .B0(n168), .B1(n169), .Y(n104) );
  OAI31X4 U264 ( .A0(n250), .A1(cnt4[2]), .A2(cnt4[1]), .B0(n251), .Y(\pos[6] ) );
  NAND2X2 U265 ( .A(n246), .B(n108), .Y(n250) );
  NAND2X2 U266 ( .A(n40), .B(n247), .Y(n281) );
  NAND2X2 U267 ( .A(bw_start_o), .B(N478), .Y(n255) );
  OAI211X2 U268 ( .A0(res_do_o[1]), .A1(n205), .B0(res_do_o[0]), .C0(n111), 
        .Y(n112) );
  OAI211X2 U269 ( .A0(n117), .A1(n102), .B0(n116), .C0(n142), .Y(n118) );
  OAI31X2 U270 ( .A0(n127), .A1(n126), .A2(n125), .B0(n71), .Y(n131) );
  OAI221X2 U271 ( .A0(res_do_o[6]), .A1(n15), .B0(n15), .B1(n139), .C0(n21), 
        .Y(n130) );
  OAI211X2 U272 ( .A0(n48), .A1(bw_init[5]), .B0(n96), .C0(bw_init[4]), .Y(
        n167) );
  CLKINVX6 U273 ( .A(n176), .Y(n173) );
  AND2X1 U274 ( .A(\pos[6] ), .B(N478), .Y(N471) );
  AND2X1 U275 ( .A(\pos[6] ), .B(N478), .Y(N472) );
  AND2X1 U276 ( .A(\pos[6] ), .B(N478), .Y(N473) );
  AND2X1 U277 ( .A(\pos[6] ), .B(N478), .Y(N474) );
  AND2X1 U278 ( .A(\pos[6] ), .B(N478), .Y(N475) );
  AND2X1 U279 ( .A(\pos[6] ), .B(N478), .Y(N476) );
  AND2X1 U280 ( .A(N478), .B(n242), .Y(N477) );
  NOR2X1 U281 ( .A(n255), .B(n249), .Y(n254) );
  NAND2X1 U282 ( .A(n256), .B(n249), .Y(n252) );
  AOI222XL U283 ( .A0(N172), .A1(bw_start_o), .B0(fw_addr_i[12]), .B1(n257), 
        .C0(N142), .C1(n245), .Y(n258) );
  CLKINVX1 U284 ( .A(n259), .Y(n298) );
  AOI222XL U285 ( .A0(N170), .A1(bw_start_o), .B0(fw_addr_i[10]), .B1(n257), 
        .C0(N140), .C1(n245), .Y(n260) );
  AOI222XL U286 ( .A0(N169), .A1(bw_start_o), .B0(fw_addr_i[9]), .B1(n257), 
        .C0(N139), .C1(n245), .Y(n261) );
  AOI222XL U287 ( .A0(N168), .A1(bw_start_o), .B0(fw_addr_i[8]), .B1(n257), 
        .C0(N138), .C1(n245), .Y(n262) );
  AOI222XL U288 ( .A0(N167), .A1(bw_start_o), .B0(fw_addr_i[7]), .B1(n257), 
        .C0(N137), .C1(n245), .Y(n263) );
  CLKINVX1 U289 ( .A(n264), .Y(n303) );
  AOI222XL U290 ( .A0(N166), .A1(bw_start_o), .B0(fw_addr_i[6]), .B1(n257), 
        .C0(N136), .C1(n245), .Y(n264) );
  CLKINVX1 U291 ( .A(n265), .Y(n304) );
  AOI222XL U292 ( .A0(N165), .A1(bw_start_o), .B0(fw_addr_i[5]), .B1(n257), 
        .C0(N135), .C1(n245), .Y(n265) );
  CLKINVX1 U293 ( .A(n266), .Y(n305) );
  AOI222XL U294 ( .A0(N164), .A1(bw_start_o), .B0(fw_addr_i[4]), .B1(n257), 
        .C0(N134), .C1(n245), .Y(n266) );
  CLKINVX1 U295 ( .A(n267), .Y(n306) );
  AOI222XL U296 ( .A0(N163), .A1(bw_start_o), .B0(fw_addr_i[3]), .B1(n257), 
        .C0(N133), .C1(n245), .Y(n267) );
  CLKINVX1 U297 ( .A(n268), .Y(n307) );
  AOI222XL U298 ( .A0(N162), .A1(bw_start_o), .B0(fw_addr_i[2]), .B1(n257), 
        .C0(N132), .C1(n245), .Y(n268) );
  CLKINVX1 U299 ( .A(n269), .Y(n308) );
  AOI222XL U300 ( .A0(N161), .A1(bw_start_o), .B0(fw_addr_i[1]), .B1(n257), 
        .C0(N131), .C1(n245), .Y(n269) );
  CLKINVX1 U301 ( .A(n270), .Y(n309) );
  AOI222XL U302 ( .A0(N160), .A1(bw_start_o), .B0(fw_addr_i[0]), .B1(n257), 
        .C0(N130), .C1(n245), .Y(n270) );
  OAI22XL U303 ( .A0(n273), .A1(n249), .B0(n274), .B1(n272), .Y(n155) );
  MXI2X1 U304 ( .A(n273), .B(n275), .S0(n248), .Y(n154) );
  OA21XL U305 ( .A0(cnt4[0]), .A1(n272), .B0(n271), .Y(n273) );
  OAI211X1 U306 ( .A0(n257), .A1(n276), .B0(n277), .C0(n278), .Y(n271) );
  MXI2X1 U307 ( .A(n280), .B(n246), .S0(n281), .Y(n276) );
  OAI211X1 U308 ( .A0(n282), .A1(n283), .B0(n284), .C0(n285), .Y(n153) );
  MXI2X1 U309 ( .A(n286), .B(n287), .S0(n281), .Y(n285) );
  MXI2X1 U310 ( .A(n245), .B(n257), .S0(n278), .Y(n284) );
  NAND2X1 U311 ( .A(n243), .B(cnt4_v_o), .Y(n283) );
  CLKMX2X2 U312 ( .A(n290), .B(n291), .S0(n281), .Y(n289) );
  AO21X1 U313 ( .A0(cnt4_v_o), .A1(n280), .B0(n286), .Y(n290) );
  NOR3X1 U314 ( .A(N478), .B(cnt4_v_o), .C(n282), .Y(n286) );
  CLKINVX1 U315 ( .A(bw_wr_i), .Y(n282) );
  NAND4X1 U316 ( .A(cnt4[2]), .B(cnt4[1]), .C(bw_start_o), .D(n241), .Y(n293)
         );
  CLKINVX1 U317 ( .A(n86), .Y(n294) );
endmodule


module DT ( clk, reset, done, sti_rd, sti_addr, sti_di, res_wr, res_rd, 
        res_addr, res_do, res_di );
  output [9:0] sti_addr;
  input [15:0] sti_di;
  output [13:0] res_addr;
  output [7:0] res_do;
  input [7:0] res_di;
  input clk, reset;
  output done, sti_rd, res_wr, res_rd;
  wire   cnt4_v, fw_start, fw_fin, bw_start, bw_wr, bw_fin, n1, n2, n3, n4, n5,
         n6;
  wire   [1:0] iswhite;
  wire   [13:0] fw_addr;
  wire   [13:0] bw_addr;

  Forward FW ( .clk(clk), .rst(reset), .sti_di_i(sti_di), .cnt4_v_i(cnt4_v), 
        .start(fw_start), .sti_rd_o(sti_rd), .sti_addr_o(sti_addr), 
        .iswhite_o(iswhite[0]), .fw_addr_o(fw_addr), .fw_fin_o(fw_fin) );
  Backward BW ( .clk(clk), .rst(reset), .bw_start_i(n6), .cnt4_v_i(cnt4_v), 
        .res_di_i({res_di[7:3], n3, n1, n5}), .iswhite_o(iswhite[1]), 
        .bw_addr_o(bw_addr), .bw_wr_o(bw_wr), .bw_fin_o(bw_fin) );
  RES res ( .clk(clk), .rst(reset), .iswhite_i(iswhite), .fw_start_i(fw_start), 
        .fw_fin_i(fw_fin), .fw_addr_i(fw_addr), .bw_fin_i(bw_fin), .bw_wr_i(
        bw_wr), .bw_addr_i(bw_addr), .res_di_i(res_di), .bw_start_o(bw_start), 
        .cnt4_v_o(cnt4_v), .res_wr_o(res_wr), .res_rd_o(res_rd), .res_do_o(
        res_do), .res_addr_o(res_addr), .done_o(done) );
  INVXL U1 ( .A(res_di[0]), .Y(n4) );
  CLKBUFX2 U2 ( .A(res_di[1]), .Y(n1) );
  INVXL U3 ( .A(res_di[2]), .Y(n2) );
  CLKINVX1 U4 ( .A(n2), .Y(n3) );
  INVX1 U5 ( .A(n4), .Y(n5) );
  CLKBUFX3 U6 ( .A(bw_start), .Y(n6) );
endmodule

