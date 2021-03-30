/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Mon Mar 22 21:51:25 2021
/////////////////////////////////////////////////////////////


module STI ( clk, rst, load_i, pi_data_i, pi_len_i, pi_fill_i, pi_low_i, 
        pi_msb_i, pi_end_i, send0_o, so_valid_o, so_data_o );
  input [15:0] pi_data_i;
  input [1:0] pi_len_i;
  input clk, rst, load_i, pi_fill_i, pi_low_i, pi_msb_i, pi_end_i;
  output send0_o, so_valid_o, so_data_o;
  wire   N26, N27, N28, N29, N30, N31, N32, N33, N34, N35, n156, read_v, N92,
         N93, N94, N95, N109, N115, N117, n5, n7, n16, n17, n26, n32, n34, n36,
         n39, n40, n41, n42, n44, n47, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, \add_176/carry[4] , \add_176/carry[3] ,
         \add_176/carry[2] , \add_176/carry[1] , \sub_175/carry[4] ,
         \sub_175/carry[3] , \sub_175/carry[2] , \sub_175/carry[1] ,
         \add_167/carry[4] , \add_167/carry[3] , \add_167/carry[2] , n1, n2,
         n3, n4, n9, n10, n11, n12, n13, n14, n15, n18, n19, n20, n21, n22,
         n23, n24, n25, n27, n28, n29, n30, n31, n33, n35, n37, n38, n43, n45,
         n46, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99,
         n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143,
         n144, n145, n146, n147, n148, n149, n150, n151, n152, n153, n154,
         n155;
  wire   [1:0] pi_len;
  wire   [4:0] send_idx;
  wire   [31:0] sti_data;
  wire   [4:0] cnt;
  wire   [1:0] NEXT;

  EDFFX1 send0_o_reg ( .D(n87), .E(n125), .CK(clk), .Q(send0_o) );
  DFFRX1 read_v_reg ( .D(n126), .CK(clk), .RN(n124), .Q(read_v), .QN(n152) );
  DFFRX1 \STATE_reg[1]  ( .D(NEXT[1]), .CK(clk), .RN(n124), .Q(n2), .QN(n47)
         );
  DFFTRX1 \cnt_reg[4]  ( .D(N95), .RN(n88), .CK(clk), .Q(cnt[4]), .QN(n130) );
  DFFRX1 \STATE_reg[0]  ( .D(NEXT[0]), .CK(clk), .RN(n124), .Q(n1), .QN(n89)
         );
  DFFRX1 \pi_data_reg[15]  ( .D(n83), .CK(clk), .RN(n124), .QN(n134) );
  DFFRX1 \pi_data_reg[14]  ( .D(n82), .CK(clk), .RN(n124), .QN(n135) );
  DFFRX1 \pi_data_reg[13]  ( .D(n81), .CK(clk), .RN(n124), .QN(n136) );
  DFFRX1 \pi_data_reg[12]  ( .D(n80), .CK(clk), .RN(n124), .QN(n137) );
  DFFRX1 \pi_data_reg[11]  ( .D(n79), .CK(clk), .RN(n124), .QN(n138) );
  DFFRX1 \pi_data_reg[10]  ( .D(n78), .CK(clk), .RN(n124), .QN(n139) );
  DFFRX1 \pi_data_reg[9]  ( .D(n77), .CK(clk), .RN(n124), .QN(n140) );
  DFFRX1 \pi_data_reg[8]  ( .D(n76), .CK(clk), .RN(n124), .QN(n141) );
  DFFRX1 \pi_data_reg[7]  ( .D(n75), .CK(clk), .RN(n124), .QN(n142) );
  DFFRX1 \pi_data_reg[6]  ( .D(n74), .CK(clk), .RN(n124), .QN(n143) );
  DFFRX1 \pi_data_reg[5]  ( .D(n73), .CK(clk), .RN(n125), .QN(n144) );
  DFFRX1 \pi_data_reg[4]  ( .D(n72), .CK(clk), .RN(n124), .QN(n145) );
  DFFRX1 \pi_data_reg[3]  ( .D(n71), .CK(clk), .RN(n154), .QN(n146) );
  DFFRX1 \pi_data_reg[2]  ( .D(n70), .CK(clk), .RN(n154), .QN(n147) );
  DFFRX1 \pi_data_reg[1]  ( .D(n69), .CK(clk), .RN(n154), .QN(n148) );
  DFFRX1 \pi_data_reg[0]  ( .D(n68), .CK(clk), .RN(n154), .QN(n149) );
  DFFRX1 pi_low_reg ( .D(n85), .CK(clk), .RN(n124), .QN(n133) );
  DFFRX1 pi_fill_reg ( .D(n86), .CK(clk), .RN(n125), .Q(n65), .QN(n132) );
  DFFRX1 pi_msb_reg ( .D(n84), .CK(clk), .RN(n125), .Q(send_idx[2]), .QN(n3)
         );
  DFFTRX1 \cnt_reg[0]  ( .D(n131), .RN(n88), .CK(clk), .Q(cnt[0]), .QN(n131)
         );
  DFFTRX1 \cnt_reg[2]  ( .D(N93), .RN(n88), .CK(clk), .Q(cnt[2]), .QN(n128) );
  DFFTRX1 \cnt_reg[3]  ( .D(N94), .RN(n88), .CK(clk), .Q(cnt[3]), .QN(n44) );
  DFFRX1 \pi_len_reg[0]  ( .D(n66), .CK(clk), .RN(n124), .Q(pi_len[0]), .QN(
        n151) );
  DFFRX1 \pi_len_reg[1]  ( .D(n67), .CK(clk), .RN(n125), .Q(pi_len[1]), .QN(
        n150) );
  DFFQX1 so_data_o_reg ( .D(N117), .CK(clk), .Q(n156) );
  DFFRX1 so_valid_o_reg ( .D(n88), .CK(clk), .RN(n124), .QN(n4) );
  DFFTRX1 \cnt_reg[1]  ( .D(N92), .RN(n88), .CK(clk), .Q(cnt[1]), .QN(n129) );
  OA21X2 U3 ( .A0(pi_len[1]), .A1(n133), .B0(n122), .Y(n17) );
  NAND2X2 U4 ( .A(n115), .B(n116), .Y(n103) );
  NAND2X2 U5 ( .A(n53), .B(n54), .Y(n33) );
  NAND2X2 U6 ( .A(N32), .B(N31), .Y(n106) );
  ADDFX2 U7 ( .A(n123), .B(cnt[1]), .CI(\add_176/carry[1] ), .CO(
        \add_176/carry[2] ), .S(N32) );
  NAND2X2 U8 ( .A(N27), .B(N26), .Y(n38) );
  ADDFX2 U9 ( .A(n123), .B(n129), .CI(\sub_175/carry[1] ), .CO(
        \sub_175/carry[2] ), .S(N27) );
  NAND2X2 U10 ( .A(N32), .B(n115), .Y(n105) );
  NAND2X2 U11 ( .A(N27), .B(n53), .Y(n37) );
  NAND2X2 U12 ( .A(N31), .B(n116), .Y(n104) );
  NAND2X2 U13 ( .A(N26), .B(n54), .Y(n35) );
  INVX12 U14 ( .A(n4), .Y(so_valid_o) );
  BUFX16 U15 ( .A(n156), .Y(so_data_o) );
  CLKINVX1 U16 ( .A(rst), .Y(n154) );
  CLKBUFX3 U17 ( .A(n5), .Y(n120) );
  CLKBUFX3 U18 ( .A(n7), .Y(n121) );
  ADDFXL U19 ( .A(send_idx[3]), .B(cnt[3]), .CI(\add_176/carry[3] ), .CO(
        \add_176/carry[4] ), .S(N34) );
  ADDFXL U20 ( .A(send_idx[3]), .B(n44), .CI(\sub_175/carry[3] ), .CO(
        \sub_175/carry[4] ), .S(N29) );
  CLKINVX1 U21 ( .A(N26), .Y(n53) );
  CLKBUFX3 U22 ( .A(load_i), .Y(n127) );
  CLKBUFX3 U23 ( .A(n154), .Y(n125) );
  CLKINVX1 U24 ( .A(N31), .Y(n115) );
  NOR2BX1 U25 ( .AN(n88), .B(n42), .Y(N117) );
  AOI22X1 U26 ( .A0(N109), .A1(n123), .B0(N115), .B1(n3), .Y(n42) );
  CLKINVX1 U27 ( .A(N27), .Y(n54) );
  CLKINVX1 U28 ( .A(N32), .Y(n116) );
  NAND3X2 U29 ( .A(n151), .B(n150), .C(n133), .Y(n16) );
  OAI22XL U30 ( .A0(n145), .A1(n16), .B0(n17), .B1(n137), .Y(sti_data[28]) );
  OAI22XL U31 ( .A0(n143), .A1(n16), .B0(n17), .B1(n135), .Y(sti_data[30]) );
  OAI22XL U32 ( .A0(n149), .A1(n16), .B0(n17), .B1(n141), .Y(sti_data[24]) );
  OAI22XL U33 ( .A0(n16), .A1(n147), .B0(n17), .B1(n139), .Y(sti_data[26]) );
  OAI22XL U34 ( .A0(n144), .A1(n16), .B0(n17), .B1(n136), .Y(sti_data[29]) );
  OAI22XL U35 ( .A0(n142), .A1(n16), .B0(n17), .B1(n134), .Y(sti_data[31]) );
  OAI22XL U36 ( .A0(n148), .A1(n16), .B0(n17), .B1(n140), .Y(sti_data[25]) );
  OAI22XL U37 ( .A0(n146), .A1(n16), .B0(n17), .B1(n138), .Y(sti_data[27]) );
  OAI22XL U38 ( .A0(n121), .A1(n137), .B0(n145), .B1(n122), .Y(sti_data[20])
         );
  OAI22XL U39 ( .A0(n121), .A1(n135), .B0(n143), .B1(n122), .Y(sti_data[22])
         );
  OAI22XL U40 ( .A0(n121), .A1(n141), .B0(n149), .B1(n122), .Y(sti_data[16])
         );
  OAI22XL U41 ( .A0(n121), .A1(n139), .B0(n147), .B1(n122), .Y(sti_data[18])
         );
  OAI22XL U42 ( .A0(n121), .A1(n136), .B0(n144), .B1(n122), .Y(sti_data[21])
         );
  OAI22XL U43 ( .A0(n121), .A1(n134), .B0(n142), .B1(n122), .Y(sti_data[23])
         );
  OAI22XL U44 ( .A0(n121), .A1(n138), .B0(n146), .B1(n122), .Y(sti_data[19])
         );
  OAI22XL U45 ( .A0(n121), .A1(n140), .B0(n148), .B1(n122), .Y(sti_data[17])
         );
  OAI22XL U46 ( .A0(n120), .A1(n137), .B0(n121), .B1(n145), .Y(sti_data[12])
         );
  OAI22XL U47 ( .A0(n120), .A1(n135), .B0(n121), .B1(n143), .Y(sti_data[14])
         );
  OAI22XL U48 ( .A0(n120), .A1(n141), .B0(n121), .B1(n149), .Y(sti_data[8]) );
  OAI22XL U49 ( .A0(n120), .A1(n139), .B0(n121), .B1(n147), .Y(sti_data[10])
         );
  OAI22XL U50 ( .A0(n120), .A1(n136), .B0(n121), .B1(n144), .Y(sti_data[13])
         );
  OAI22XL U51 ( .A0(n120), .A1(n134), .B0(n121), .B1(n142), .Y(sti_data[15])
         );
  OAI22XL U52 ( .A0(n120), .A1(n138), .B0(n121), .B1(n146), .Y(sti_data[11])
         );
  OAI22XL U53 ( .A0(n120), .A1(n140), .B0(n121), .B1(n148), .Y(sti_data[9]) );
  NOR2X1 U54 ( .A(n148), .B(n120), .Y(sti_data[1]) );
  NOR2X1 U55 ( .A(n120), .B(n145), .Y(sti_data[4]) );
  NOR2X1 U56 ( .A(n120), .B(n143), .Y(sti_data[6]) );
  NOR2X1 U57 ( .A(n120), .B(n149), .Y(sti_data[0]) );
  NOR2X1 U58 ( .A(n120), .B(n147), .Y(sti_data[2]) );
  NOR2X1 U59 ( .A(n120), .B(n144), .Y(sti_data[5]) );
  NOR2X1 U60 ( .A(n120), .B(n142), .Y(sti_data[7]) );
  NOR2X1 U61 ( .A(n120), .B(n146), .Y(sti_data[3]) );
  CLKINVX1 U62 ( .A(N28), .Y(n55) );
  CLKINVX1 U63 ( .A(N33), .Y(n117) );
  CLKINVX1 U64 ( .A(N29), .Y(n56) );
  CLKINVX1 U65 ( .A(N34), .Y(n118) );
  CLKINVX1 U66 ( .A(N30), .Y(n57) );
  CLKINVX1 U67 ( .A(N35), .Y(n119) );
  CLKINVX1 U68 ( .A(n87), .Y(n153) );
  CLKBUFX3 U69 ( .A(n154), .Y(n124) );
  OAI211X1 U70 ( .A0(n89), .A1(n152), .B0(n32), .C0(n153), .Y(NEXT[1]) );
  OAI21XL U71 ( .A0(pi_end_i), .A1(n34), .B0(n2), .Y(n32) );
  OAI2BB2XL U72 ( .B0(n127), .B1(n149), .A0N(pi_data_i[0]), .A1N(n126), .Y(n68) );
  OAI2BB2XL U73 ( .B0(n127), .B1(n146), .A0N(pi_data_i[3]), .A1N(n126), .Y(n71) );
  OAI2BB2XL U74 ( .B0(n127), .B1(n145), .A0N(pi_data_i[4]), .A1N(n126), .Y(n72) );
  OAI2BB2XL U75 ( .B0(n127), .B1(n144), .A0N(pi_data_i[5]), .A1N(n126), .Y(n73) );
  OAI2BB2XL U76 ( .B0(n127), .B1(n143), .A0N(pi_data_i[6]), .A1N(n126), .Y(n74) );
  OAI2BB2XL U77 ( .B0(n127), .B1(n142), .A0N(pi_data_i[7]), .A1N(n126), .Y(n75) );
  OAI2BB2XL U78 ( .B0(load_i), .B1(n148), .A0N(pi_data_i[1]), .A1N(n126), .Y(
        n69) );
  OAI2BB2XL U79 ( .B0(load_i), .B1(n147), .A0N(pi_data_i[2]), .A1N(n126), .Y(
        n70) );
  OAI2BB2XL U80 ( .B0(load_i), .B1(n150), .A0N(pi_len_i[1]), .A1N(n126), .Y(
        n67) );
  OAI2BB2XL U81 ( .B0(load_i), .B1(n151), .A0N(pi_len_i[0]), .A1N(n127), .Y(
        n66) );
  OAI2BB2XL U82 ( .B0(n127), .B1(n141), .A0N(pi_data_i[8]), .A1N(n126), .Y(n76) );
  OAI2BB2XL U83 ( .B0(n127), .B1(n140), .A0N(pi_data_i[9]), .A1N(n126), .Y(n77) );
  OAI2BB2XL U84 ( .B0(n127), .B1(n139), .A0N(pi_data_i[10]), .A1N(n126), .Y(
        n78) );
  OAI2BB2XL U85 ( .B0(n127), .B1(n138), .A0N(pi_data_i[11]), .A1N(n126), .Y(
        n79) );
  OAI2BB2XL U86 ( .B0(n127), .B1(n137), .A0N(pi_data_i[12]), .A1N(n126), .Y(
        n80) );
  OAI2BB2XL U87 ( .B0(n127), .B1(n136), .A0N(pi_data_i[13]), .A1N(n126), .Y(
        n81) );
  OAI2BB2XL U88 ( .B0(n127), .B1(n135), .A0N(pi_data_i[14]), .A1N(n126), .Y(
        n82) );
  OAI2BB2XL U89 ( .B0(load_i), .B1(n134), .A0N(pi_data_i[15]), .A1N(n127), .Y(
        n83) );
  OAI2BB2XL U90 ( .B0(load_i), .B1(n3), .A0N(pi_msb_i), .A1N(n127), .Y(n84) );
  OAI2BB2XL U91 ( .B0(load_i), .B1(n132), .A0N(pi_fill_i), .A1N(n127), .Y(n86)
         );
  OAI2BB2XL U92 ( .B0(load_i), .B1(n133), .A0N(pi_low_i), .A1N(n127), .Y(n85)
         );
  CLKBUFX3 U93 ( .A(load_i), .Y(n126) );
  OAI221XL U94 ( .A0(n36), .A1(n1), .B0(read_v), .B1(n89), .C0(n153), .Y(
        NEXT[0]) );
  OA21XL U95 ( .A0(n155), .A1(n34), .B0(n2), .Y(n36) );
  CLKINVX1 U96 ( .A(pi_end_i), .Y(n155) );
  CLKBUFX3 U97 ( .A(send_idx[2]), .Y(n123) );
  ADDFX2 U98 ( .A(n123), .B(n128), .CI(\sub_175/carry[2] ), .CO(
        \sub_175/carry[3] ), .S(N28) );
  ADDFX2 U99 ( .A(n123), .B(cnt[2]), .CI(\add_176/carry[2] ), .CO(
        \add_176/carry[3] ), .S(N33) );
  NAND3X1 U100 ( .A(pi_len[1]), .B(n132), .C(pi_len[0]), .Y(n5) );
  NAND3X1 U101 ( .A(n132), .B(n151), .C(pi_len[1]), .Y(n7) );
  CLKBUFX3 U102 ( .A(n26), .Y(n122) );
  OAI22XL U103 ( .A0(pi_len[1]), .A1(pi_len[0]), .B0(n65), .B1(n150), .Y(n26)
         );
  NAND2X1 U104 ( .A(pi_len[1]), .B(n3), .Y(send_idx[4]) );
  NAND2X1 U105 ( .A(pi_len[0]), .B(n3), .Y(send_idx[3]) );
  XOR3X1 U106 ( .A(send_idx[4]), .B(n130), .C(\sub_175/carry[4] ), .Y(N30) );
  XOR3X1 U107 ( .A(send_idx[4]), .B(cnt[4]), .C(\add_176/carry[4] ), .Y(N35)
         );
  NOR2X2 U108 ( .A(n1), .B(n47), .Y(n88) );
  NAND4X1 U109 ( .A(n39), .B(n40), .C(n41), .D(cnt[1]), .Y(n34) );
  NOR2X1 U110 ( .A(n128), .B(n131), .Y(n41) );
  XNOR2X1 U111 ( .A(n151), .B(n44), .Y(n39) );
  XNOR2X1 U112 ( .A(n150), .B(n130), .Y(n40) );
  NOR2X1 U113 ( .A(n89), .B(n47), .Y(n87) );
  ADDHXL U114 ( .A(cnt[1]), .B(cnt[0]), .CO(\add_167/carry[2] ), .S(N92) );
  ADDHXL U115 ( .A(cnt[2]), .B(\add_167/carry[2] ), .CO(\add_167/carry[3] ), 
        .S(N93) );
  ADDHXL U116 ( .A(cnt[3]), .B(\add_167/carry[3] ), .CO(\add_167/carry[4] ), 
        .S(N94) );
  OAI22XL U117 ( .A0(sti_data[13]), .A1(n35), .B0(sti_data[12]), .B1(n33), .Y(
        n10) );
  OAI22XL U118 ( .A0(sti_data[15]), .A1(n38), .B0(sti_data[14]), .B1(n37), .Y(
        n9) );
  OAI21XL U119 ( .A0(n10), .A1(n9), .B0(N28), .Y(n14) );
  OAI22XL U120 ( .A0(sti_data[9]), .A1(n35), .B0(sti_data[8]), .B1(n33), .Y(
        n12) );
  OAI22XL U121 ( .A0(sti_data[11]), .A1(n38), .B0(sti_data[10]), .B1(n37), .Y(
        n11) );
  OAI21XL U122 ( .A0(n12), .A1(n11), .B0(n55), .Y(n13) );
  AOI21X1 U123 ( .A0(n14), .A1(n13), .B0(n56), .Y(n52) );
  OAI22XL U124 ( .A0(sti_data[5]), .A1(n35), .B0(sti_data[4]), .B1(n33), .Y(
        n18) );
  OAI22XL U125 ( .A0(sti_data[7]), .A1(n38), .B0(sti_data[6]), .B1(n37), .Y(
        n15) );
  OAI21XL U126 ( .A0(n18), .A1(n15), .B0(N28), .Y(n22) );
  OAI22XL U127 ( .A0(sti_data[1]), .A1(n35), .B0(sti_data[0]), .B1(n33), .Y(
        n20) );
  OAI22XL U128 ( .A0(sti_data[3]), .A1(n38), .B0(sti_data[2]), .B1(n37), .Y(
        n19) );
  OAI21XL U129 ( .A0(n20), .A1(n19), .B0(n55), .Y(n21) );
  AOI21X1 U130 ( .A0(n22), .A1(n21), .B0(N29), .Y(n51) );
  OAI22XL U131 ( .A0(sti_data[21]), .A1(n35), .B0(sti_data[20]), .B1(n33), .Y(
        n24) );
  OAI22XL U132 ( .A0(sti_data[23]), .A1(n38), .B0(sti_data[22]), .B1(n37), .Y(
        n23) );
  OAI21XL U133 ( .A0(n24), .A1(n23), .B0(N28), .Y(n29) );
  OAI22XL U134 ( .A0(sti_data[17]), .A1(n35), .B0(sti_data[16]), .B1(n33), .Y(
        n27) );
  OAI22XL U135 ( .A0(sti_data[19]), .A1(n38), .B0(sti_data[18]), .B1(n37), .Y(
        n25) );
  OAI21XL U136 ( .A0(n27), .A1(n25), .B0(n55), .Y(n28) );
  AOI21X1 U137 ( .A0(n29), .A1(n28), .B0(N29), .Y(n50) );
  OAI22XL U138 ( .A0(sti_data[29]), .A1(n35), .B0(sti_data[28]), .B1(n33), .Y(
        n31) );
  OAI22XL U139 ( .A0(sti_data[31]), .A1(n38), .B0(sti_data[30]), .B1(n37), .Y(
        n30) );
  OAI21XL U140 ( .A0(n31), .A1(n30), .B0(N28), .Y(n48) );
  OAI22XL U141 ( .A0(sti_data[25]), .A1(n35), .B0(sti_data[24]), .B1(n33), .Y(
        n45) );
  OAI22XL U142 ( .A0(sti_data[27]), .A1(n38), .B0(sti_data[26]), .B1(n37), .Y(
        n43) );
  OAI21XL U143 ( .A0(n45), .A1(n43), .B0(n55), .Y(n46) );
  AOI21X1 U144 ( .A0(n48), .A1(n46), .B0(n56), .Y(n49) );
  OAI33X1 U145 ( .A0(n52), .A1(N30), .A2(n51), .B0(n57), .B1(n50), .B2(n49), 
        .Y(N109) );
  OAI22XL U146 ( .A0(sti_data[13]), .A1(n104), .B0(sti_data[12]), .B1(n103), 
        .Y(n59) );
  OAI22XL U147 ( .A0(sti_data[15]), .A1(n106), .B0(sti_data[14]), .B1(n105), 
        .Y(n58) );
  OAI21XL U148 ( .A0(n59), .A1(n58), .B0(N33), .Y(n63) );
  OAI22XL U149 ( .A0(sti_data[9]), .A1(n104), .B0(sti_data[8]), .B1(n103), .Y(
        n61) );
  OAI22XL U150 ( .A0(sti_data[11]), .A1(n106), .B0(sti_data[10]), .B1(n105), 
        .Y(n60) );
  OAI21XL U151 ( .A0(n61), .A1(n60), .B0(n117), .Y(n62) );
  AOI21X1 U152 ( .A0(n63), .A1(n62), .B0(n118), .Y(n114) );
  OAI22XL U153 ( .A0(sti_data[5]), .A1(n104), .B0(sti_data[4]), .B1(n103), .Y(
        n90) );
  OAI22XL U154 ( .A0(sti_data[7]), .A1(n106), .B0(sti_data[6]), .B1(n105), .Y(
        n64) );
  OAI21XL U155 ( .A0(n90), .A1(n64), .B0(N33), .Y(n94) );
  OAI22XL U156 ( .A0(sti_data[1]), .A1(n104), .B0(sti_data[0]), .B1(n103), .Y(
        n92) );
  OAI22XL U157 ( .A0(sti_data[3]), .A1(n106), .B0(sti_data[2]), .B1(n105), .Y(
        n91) );
  OAI21XL U158 ( .A0(n92), .A1(n91), .B0(n117), .Y(n93) );
  AOI21X1 U159 ( .A0(n94), .A1(n93), .B0(N34), .Y(n113) );
  OAI22XL U160 ( .A0(sti_data[21]), .A1(n104), .B0(sti_data[20]), .B1(n103), 
        .Y(n96) );
  OAI22XL U161 ( .A0(sti_data[23]), .A1(n106), .B0(sti_data[22]), .B1(n105), 
        .Y(n95) );
  OAI21XL U162 ( .A0(n96), .A1(n95), .B0(N33), .Y(n100) );
  OAI22XL U163 ( .A0(sti_data[17]), .A1(n104), .B0(sti_data[16]), .B1(n103), 
        .Y(n98) );
  OAI22XL U164 ( .A0(sti_data[19]), .A1(n106), .B0(sti_data[18]), .B1(n105), 
        .Y(n97) );
  OAI21XL U165 ( .A0(n98), .A1(n97), .B0(n117), .Y(n99) );
  AOI21X1 U166 ( .A0(n100), .A1(n99), .B0(N34), .Y(n112) );
  OAI22XL U167 ( .A0(sti_data[29]), .A1(n104), .B0(sti_data[28]), .B1(n103), 
        .Y(n102) );
  OAI22XL U168 ( .A0(sti_data[31]), .A1(n106), .B0(sti_data[30]), .B1(n105), 
        .Y(n101) );
  OAI21XL U169 ( .A0(n102), .A1(n101), .B0(N33), .Y(n110) );
  OAI22XL U170 ( .A0(sti_data[25]), .A1(n104), .B0(sti_data[24]), .B1(n103), 
        .Y(n108) );
  OAI22XL U171 ( .A0(sti_data[27]), .A1(n106), .B0(sti_data[26]), .B1(n105), 
        .Y(n107) );
  OAI21XL U172 ( .A0(n108), .A1(n107), .B0(n117), .Y(n109) );
  AOI21X1 U173 ( .A0(n110), .A1(n109), .B0(n118), .Y(n111) );
  OAI33X1 U174 ( .A0(n114), .A1(N35), .A2(n113), .B0(n119), .B1(n112), .B2(
        n111), .Y(N115) );
  AND2X1 U175 ( .A(n123), .B(cnt[0]), .Y(\add_176/carry[1] ) );
  XOR2X1 U176 ( .A(cnt[0]), .B(n123), .Y(N31) );
  OR2X1 U177 ( .A(n131), .B(n123), .Y(\sub_175/carry[1] ) );
  XNOR2X1 U178 ( .A(n123), .B(n131), .Y(N26) );
  XOR2X1 U179 ( .A(\add_167/carry[4] ), .B(cnt[4]), .Y(N95) );
endmodule


module DAC ( clk, rst, so_valid_i, so_data_i, send0_i, oem_wr_o, o1_wr_o, 
        o2_wr_o, o3_wr_o, o4_wr_o, e1_wr_o, e2_wr_o, e3_wr_o, e4_wr_o, 
        oem_finish_o, oem_addr_o, oem_dataout_o );
  output [7:0] oem_wr_o;
  output [4:0] oem_addr_o;
  output [7:0] oem_dataout_o;
  input clk, rst, so_valid_i, so_data_i, send0_i;
  output o1_wr_o, o2_wr_o, o3_wr_o, o4_wr_o, e1_wr_o, e2_wr_o, e3_wr_o,
         e4_wr_o, oem_finish_o;
  wire   n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, n158, n159, nxt_addr, wr_sig, N131, N146, N147, N148,
         N153, N154, N155, N156, N220, N227, n3, n4, n5, n6, n8, n11, n13, n15,
         n17, n18, n20, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n34,
         n35, n36, n37, n38, n39, n41, n42, n43, n46, n47, n48, n51, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n87, n89, n90, n91, n92, n93, n94, n95, n96, n98, n99,
         n100, n101, n102, n103, n104, n105, n106, n107, \add_328/carry[4] ,
         \add_328/carry[3] , \add_328/carry[2] , n1, n2, n7, n9, n10, n12, n14,
         n16, n19, n49, n52, n88, n108, n121, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140, n141, n142, n143, n144;
  wire   [3:0] NEXT;

  DFFRX1 \data_reg[4]  ( .D(n104), .CK(clk), .RN(n125), .QN(n58) );
  DFFRX1 \data_reg[2]  ( .D(n102), .CK(clk), .RN(n125), .QN(n56) );
  DFFRX1 \data_reg[1]  ( .D(n101), .CK(clk), .RN(n125), .QN(n55) );
  DFFRX1 \data_reg[0]  ( .D(n100), .CK(clk), .RN(n125), .QN(n54) );
  DFFRX1 \data_reg[3]  ( .D(n103), .CK(clk), .RN(n125), .Q(n123), .QN(n57) );
  DFFRX1 \data_reg[6]  ( .D(n106), .CK(clk), .RN(n125), .QN(n60) );
  DFFRX1 \data_reg[5]  ( .D(n105), .CK(clk), .RN(n125), .QN(n59) );
  DFFRX1 \data_reg[7]  ( .D(n107), .CK(clk), .RN(n125), .QN(n61) );
  DFFRX1 wr_sig_reg ( .D(n135), .CK(clk), .RN(n144), .Q(wr_sig), .QN(n7) );
  DFFRX1 nxt_addr_reg ( .D(n85), .CK(clk), .RN(n125), .Q(nxt_addr) );
  DFFRX1 \STATE_reg[1]  ( .D(NEXT[1]), .CK(clk), .RN(n144), .Q(n2), .QN(n90)
         );
  DFFRX1 \STATE_reg[2]  ( .D(NEXT[2]), .CK(clk), .RN(n144), .QN(n89) );
  DFFRX1 \STATE_reg[3]  ( .D(NEXT[3]), .CK(clk), .RN(n125), .Q(n1), .QN(n87)
         );
  DFFRX1 \oem_addr_o_reg[0]  ( .D(n84), .CK(clk), .RN(n125), .Q(n151), .QN(
        n121) );
  DFFTRX1 \oem_wr_reg[1]  ( .D(n96), .RN(n124), .CK(clk), .QN(n9) );
  DFFRX1 \oem_dataout_o_reg[0]  ( .D(n72), .CK(clk), .RN(n144), .Q(n159), .QN(
        n71) );
  DFFRX1 \oem_dataout_o_reg[1]  ( .D(n73), .CK(clk), .RN(n144), .Q(n158), .QN(
        n70) );
  DFFRX1 \oem_dataout_o_reg[2]  ( .D(n74), .CK(clk), .RN(n144), .Q(n157), .QN(
        n69) );
  DFFRX1 \oem_dataout_o_reg[3]  ( .D(n75), .CK(clk), .RN(n144), .Q(n156), .QN(
        n68) );
  DFFRX1 \oem_dataout_o_reg[4]  ( .D(n76), .CK(clk), .RN(n144), .Q(n155), .QN(
        n67) );
  DFFRX1 \oem_dataout_o_reg[5]  ( .D(n77), .CK(clk), .RN(n125), .Q(n154), .QN(
        n66) );
  DFFRX1 \oem_dataout_o_reg[6]  ( .D(n78), .CK(clk), .RN(n125), .Q(n153), .QN(
        n65) );
  DFFRX1 \oem_dataout_o_reg[7]  ( .D(n79), .CK(clk), .RN(n125), .Q(n152), .QN(
        n64) );
  DFFQX1 \oem_wr_reg[0]  ( .D(n137), .CK(clk), .Q(n146) );
  DFFQX1 \oem_wr_reg[6]  ( .D(N220), .CK(clk), .Q(n145) );
  DFFRX1 \oem_addr_o_reg[1]  ( .D(n83), .CK(clk), .RN(n125), .Q(n150), .QN(
        n108) );
  DFFTRX1 \oem_wr_reg[2]  ( .D(n143), .RN(n124), .CK(clk), .QN(n10) );
  DFFRX1 \oem_addr_o_reg[4]  ( .D(n80), .CK(clk), .RN(n144), .Q(n147), .QN(n88) );
  DFFTRX1 \oem_wr_reg[3]  ( .D(n98), .RN(n124), .CK(clk), .QN(n12) );
  DFFRX1 \oem_addr_o_reg[2]  ( .D(n82), .CK(clk), .RN(n144), .Q(n149), .QN(n52) );
  DFFTRX1 \oem_wr_reg[4]  ( .D(n124), .RN(n140), .CK(clk), .QN(n14) );
  DFFRX1 \oem_addr_o_reg[3]  ( .D(n81), .CK(clk), .RN(n144), .Q(n148), .QN(n49) );
  DFFTRX1 \oem_wr_reg[5]  ( .D(n95), .RN(n124), .CK(clk), .QN(n16) );
  DFFTRX1 \oem_wr_reg[7]  ( .D(n99), .RN(n124), .CK(clk), .QN(n19) );
  DFFSX1 \cnt_reg[0]  ( .D(N146), .CK(clk), .SN(n144), .Q(n127), .QN(n94) );
  DFFSX1 \cnt_reg[1]  ( .D(N147), .CK(clk), .SN(n144), .Q(n133), .QN(n93) );
  DFFRX1 ch_addr_reg ( .D(N131), .CK(clk), .RN(n144), .Q(n139), .QN(n63) );
  DFFSX2 \cnt_reg[2]  ( .D(N148), .CK(clk), .SN(n144), .QN(n92) );
  DFFRX2 data_rdy_reg ( .D(n130), .CK(clk), .RN(n144), .Q(n135), .QN(n62) );
  DFFRX2 \STATE_reg[0]  ( .D(NEXT[0]), .CK(clk), .RN(n144), .Q(n142), .QN(n91)
         );
  INVX3 U3 ( .A(rst), .Y(n144) );
  INVX12 U4 ( .A(n19), .Y(o1_wr_o) );
  INVX12 U5 ( .A(n16), .Y(o3_wr_o) );
  INVX12 U6 ( .A(n14), .Y(o4_wr_o) );
  INVX12 U7 ( .A(n12), .Y(e1_wr_o) );
  INVX12 U8 ( .A(n10), .Y(e2_wr_o) );
  INVX12 U9 ( .A(n9), .Y(e3_wr_o) );
  INVX12 U10 ( .A(n49), .Y(oem_addr_o[3]) );
  INVX12 U11 ( .A(n52), .Y(oem_addr_o[2]) );
  INVX12 U12 ( .A(n88), .Y(oem_addr_o[4]) );
  XOR2XL U13 ( .A(\add_328/carry[4] ), .B(n147), .Y(N156) );
  INVX12 U14 ( .A(n108), .Y(oem_addr_o[1]) );
  BUFX12 U15 ( .A(n145), .Y(o2_wr_o) );
  BUFX12 U16 ( .A(n146), .Y(e4_wr_o) );
  BUFX12 U17 ( .A(n152), .Y(oem_dataout_o[7]) );
  BUFX12 U18 ( .A(n153), .Y(oem_dataout_o[6]) );
  BUFX12 U19 ( .A(n154), .Y(oem_dataout_o[5]) );
  BUFX12 U20 ( .A(n155), .Y(oem_dataout_o[4]) );
  BUFX12 U21 ( .A(n156), .Y(oem_dataout_o[3]) );
  BUFX12 U22 ( .A(n157), .Y(oem_dataout_o[2]) );
  BUFX12 U23 ( .A(n158), .Y(oem_dataout_o[1]) );
  BUFX12 U24 ( .A(n159), .Y(oem_dataout_o[0]) );
  BUFX12 U25 ( .A(N227), .Y(oem_finish_o) );
  NOR3X1 U26 ( .A(n51), .B(n87), .C(n91), .Y(N227) );
  INVX12 U27 ( .A(n121), .Y(oem_addr_o[0]) );
  OAI32XL U28 ( .A0(n15), .A1(n58), .A2(n4), .B0(n5), .B1(n132), .Y(n104) );
  OAI32XL U29 ( .A0(n126), .A1(n55), .A2(n4), .B0(n5), .B1(n8), .Y(n101) );
  OAI32XL U30 ( .A0(n128), .A1(n56), .A2(n4), .B0(n5), .B1(n11), .Y(n102) );
  OAI21XL U31 ( .A0(n91), .A1(n48), .B0(n23), .Y(n38) );
  XOR2X1 U32 ( .A(so_valid_i), .B(send0_i), .Y(n53) );
  CLKINVX1 U33 ( .A(n28), .Y(n137) );
  CLKINVX1 U34 ( .A(n23), .Y(n140) );
  NOR2X1 U35 ( .A(n7), .B(n27), .Y(n26) );
  OAI211X1 U36 ( .A0(n27), .A1(n28), .B0(n29), .C0(n30), .Y(NEXT[2]) );
  AOI2BB2X1 U37 ( .B0(N220), .B1(n31), .A0N(n3), .A1N(n26), .Y(n29) );
  AOI211X1 U38 ( .A0(n140), .A1(n22), .B0(n96), .C0(n95), .Y(n30) );
  OAI211X1 U39 ( .A0(n37), .A1(n136), .B0(n41), .C0(n42), .Y(NEXT[0]) );
  AOI2BB1X1 U40 ( .A0N(n27), .A1N(n34), .B0(n43), .Y(n42) );
  CLKINVX1 U41 ( .A(n26), .Y(n136) );
  OAI2BB2XL U42 ( .B0(n36), .B1(n38), .A0N(n39), .A1N(n26), .Y(n41) );
  NAND2X1 U43 ( .A(n27), .B(n39), .Y(n31) );
  NAND2X1 U44 ( .A(n124), .B(n31), .Y(n22) );
  NAND3X1 U45 ( .A(n17), .B(n13), .C(n53), .Y(N147) );
  NAND2X1 U46 ( .A(n53), .B(n127), .Y(N146) );
  OAI221XL U47 ( .A0(n138), .A1(n141), .B0(n27), .B1(n34), .C0(n35), .Y(
        NEXT[1]) );
  CLKINVX1 U48 ( .A(n38), .Y(n141) );
  AOI2BB2X1 U49 ( .B0(n138), .B1(n36), .A0N(n37), .A1N(n26), .Y(n35) );
  CLKINVX1 U50 ( .A(n22), .Y(n138) );
  NAND2X1 U51 ( .A(n127), .B(n133), .Y(n13) );
  NOR2X1 U52 ( .A(n142), .B(n51), .Y(n25) );
  AOI2BB1X1 U53 ( .A0N(n7), .A1N(n3), .B0(n137), .Y(n34) );
  NAND3X1 U54 ( .A(n124), .B(n1), .C(n25), .Y(n28) );
  XOR2X1 U55 ( .A(n1), .B(n25), .Y(n43) );
  NAND3X1 U56 ( .A(n142), .B(n2), .C(n46), .Y(n23) );
  NOR2X1 U57 ( .A(n142), .B(n48), .Y(n98) );
  NOR2X1 U58 ( .A(n98), .B(n96), .Y(n37) );
  CLKINVX1 U59 ( .A(n17), .Y(n131) );
  CLKINVX1 U60 ( .A(n6), .Y(n130) );
  OR2X1 U61 ( .A(n99), .B(n95), .Y(n36) );
  CLKINVX1 U62 ( .A(n3), .Y(n143) );
  CLKBUFX3 U63 ( .A(n144), .Y(n125) );
  AO22X1 U64 ( .A0(n63), .A1(n147), .B0(N156), .B1(n139), .Y(n80) );
  NAND2BX1 U65 ( .AN(n4), .B(so_data_i), .Y(n5) );
  NAND4XL U66 ( .A(n151), .B(n150), .C(n47), .D(n149), .Y(n39) );
  AND2XL U67 ( .A(n147), .B(n148), .Y(n47) );
  OAI32X1 U68 ( .A0(n4), .A1(n54), .A2(n130), .B0(n5), .B1(n6), .Y(n100) );
  CLKINVX1 U69 ( .A(n8), .Y(n126) );
  NAND3X1 U70 ( .A(n93), .B(n127), .C(n92), .Y(n8) );
  CLKINVX1 U71 ( .A(n11), .Y(n128) );
  NAND3X1 U72 ( .A(n94), .B(n133), .C(n92), .Y(n11) );
  CLKINVX1 U73 ( .A(n15), .Y(n132) );
  NOR2X1 U74 ( .A(n17), .B(n92), .Y(n15) );
  OAI22XL U75 ( .A0(n59), .A1(n18), .B0(n5), .B1(n129), .Y(n105) );
  CLKINVX1 U76 ( .A(n18), .Y(n129) );
  NOR2X1 U77 ( .A(n92), .B(n94), .Y(n18) );
  OAI22XL U78 ( .A0(n60), .A1(n20), .B0(n5), .B1(n134), .Y(n106) );
  CLKINVX1 U79 ( .A(n20), .Y(n134) );
  NOR2X1 U80 ( .A(n92), .B(n93), .Y(n20) );
  NAND2X1 U81 ( .A(n89), .B(n90), .Y(n51) );
  OAI211X1 U82 ( .A0(n92), .A1(n131), .B0(n6), .C0(n53), .Y(N148) );
  OAI2BB2XL U83 ( .B0(n13), .B1(n5), .A0N(n123), .A1N(n13), .Y(n103) );
  OAI22XL U84 ( .A0(n22), .A1(n23), .B0(n87), .B1(n24), .Y(NEXT[3]) );
  AND2X2 U85 ( .A(n25), .B(n26), .Y(n24) );
  AND3X1 U86 ( .A(n151), .B(n150), .C(nxt_addr), .Y(n27) );
  ADDHXL U87 ( .A(n150), .B(n151), .CO(\add_328/carry[2] ), .S(N153) );
  ADDHXL U88 ( .A(n149), .B(\add_328/carry[2] ), .CO(\add_328/carry[3] ), .S(
        N154) );
  AO22X1 U89 ( .A0(n63), .A1(n151), .B0(n121), .B1(n139), .Y(n84) );
  AO22X1 U90 ( .A0(n63), .A1(n150), .B0(N153), .B1(n139), .Y(n83) );
  AO22X1 U91 ( .A0(n63), .A1(n149), .B0(N154), .B1(n139), .Y(n82) );
  AO22X1 U92 ( .A0(n63), .A1(n148), .B0(N155), .B1(n139), .Y(n81) );
  ADDHXL U93 ( .A(n148), .B(\add_328/carry[3] ), .CO(\add_328/carry[4] ), .S(
        N155) );
  NOR2X2 U94 ( .A(n13), .B(n92), .Y(n4) );
  NOR2X1 U95 ( .A(n1), .B(n89), .Y(n46) );
  NAND3X1 U96 ( .A(n90), .B(n46), .C(n91), .Y(n3) );
  OAI2BB2XL U97 ( .B0(n61), .B1(n4), .A0N(so_data_i), .A1N(n4), .Y(n107) );
  NOR3BX1 U98 ( .AN(n46), .B(n91), .C(n2), .Y(n95) );
  NAND2X1 U99 ( .A(n93), .B(n94), .Y(n17) );
  NAND2X1 U100 ( .A(n92), .B(n131), .Y(n6) );
  NAND3X1 U101 ( .A(n87), .B(n2), .C(n89), .Y(n48) );
  OAI22XL U102 ( .A0(n135), .A1(n71), .B0(n54), .B1(n62), .Y(n72) );
  OAI22XL U103 ( .A0(n135), .A1(n70), .B0(n55), .B1(n62), .Y(n73) );
  OAI22XL U104 ( .A0(n135), .A1(n69), .B0(n56), .B1(n62), .Y(n74) );
  OAI22XL U105 ( .A0(n135), .A1(n68), .B0(n57), .B1(n62), .Y(n75) );
  OAI22XL U106 ( .A0(n135), .A1(n67), .B0(n58), .B1(n62), .Y(n76) );
  OAI22XL U107 ( .A0(n135), .A1(n66), .B0(n59), .B1(n62), .Y(n77) );
  OAI22XL U108 ( .A0(n135), .A1(n65), .B0(n60), .B1(n62), .Y(n78) );
  OAI22XL U109 ( .A0(n135), .A1(n64), .B0(n61), .B1(n62), .Y(n79) );
  NOR3X1 U110 ( .A(n7), .B(n91), .C(n48), .Y(N220) );
  NOR3X1 U111 ( .A(n1), .B(n91), .C(n51), .Y(n99) );
  XOR2X1 U112 ( .A(n124), .B(nxt_addr), .Y(n85) );
  AND3X2 U113 ( .A(n46), .B(n2), .C(n91), .Y(n96) );
  NOR2BX1 U114 ( .AN(nxt_addr), .B(n7), .Y(N131) );
  CLKBUFX3 U115 ( .A(wr_sig), .Y(n124) );
endmodule


module STI_DAC ( clk, reset, load, pi_data, pi_length, pi_fill, pi_msb, pi_low, 
        pi_end, so_data, so_valid, oem_finish, oem_dataout, oem_addr, odd1_wr, 
        odd2_wr, odd3_wr, odd4_wr, even1_wr, even2_wr, even3_wr, even4_wr );
  input [15:0] pi_data;
  input [1:0] pi_length;
  output [7:0] oem_dataout;
  output [4:0] oem_addr;
  input clk, reset, load, pi_fill, pi_msb, pi_low, pi_end;
  output so_data, so_valid, oem_finish, odd1_wr, odd2_wr, odd3_wr, odd4_wr,
         even1_wr, even2_wr, even3_wr, even4_wr;
  wire   send0;

  STI sti ( .clk(clk), .rst(reset), .load_i(load), .pi_data_i(pi_data), 
        .pi_len_i(pi_length), .pi_fill_i(pi_fill), .pi_low_i(pi_low), 
        .pi_msb_i(pi_msb), .pi_end_i(pi_end), .send0_o(send0), .so_valid_o(
        so_valid), .so_data_o(so_data) );
  DAC dac ( .clk(clk), .rst(reset), .so_valid_i(so_valid), .so_data_i(so_data), 
        .send0_i(send0), .o1_wr_o(odd1_wr), .o2_wr_o(odd2_wr), .o3_wr_o(
        odd3_wr), .o4_wr_o(odd4_wr), .e1_wr_o(even1_wr), .e2_wr_o(even2_wr), 
        .e3_wr_o(even3_wr), .e4_wr_o(even4_wr), .oem_finish_o(oem_finish), 
        .oem_addr_o(oem_addr), .oem_dataout_o(oem_dataout) );
endmodule

