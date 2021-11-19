/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Wed Mar 10 02:24:06 2021
/////////////////////////////////////////////////////////////


module ReadGray_DW01_dec_0 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;
  wire   n1, n2, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18;

  OR2X1 U1 ( .A(n11), .B(A[6]), .Y(n10) );
  NAND2BX1 U2 ( .AN(A[1]), .B(SUM[0]), .Y(n15) );
  OR2X1 U3 ( .A(n13), .B(A[4]), .Y(n12) );
  CLKINVX1 U4 ( .A(A[0]), .Y(SUM[0]) );
  OR2X4 U5 ( .A(n9), .B(A[8]), .Y(n7) );
  OR2X1 U6 ( .A(n10), .B(A[7]), .Y(n9) );
  NAND2BXL U7 ( .AN(A[1]), .B(SUM[0]), .Y(n1) );
  NAND2X1 U8 ( .A(n4), .B(n6), .Y(n17) );
  OR2X1 U9 ( .A(n15), .B(A[2]), .Y(n14) );
  OR2X1 U10 ( .A(n7), .B(n2), .Y(n18) );
  NOR2XL U11 ( .A(A[12]), .B(n17), .Y(n16) );
  XNOR2XL U12 ( .A(A[12]), .B(n17), .Y(SUM[12]) );
  OAI2BB1XL U13 ( .A0N(n9), .A1N(A[8]), .B0(n7), .Y(SUM[8]) );
  OAI2BB1XL U14 ( .A0N(n10), .A1N(A[7]), .B0(n9), .Y(SUM[7]) );
  OAI2BB1XL U15 ( .A0N(n11), .A1N(A[6]), .B0(n10), .Y(SUM[6]) );
  AO21XL U16 ( .A0(n7), .A1(A[9]), .B0(n8), .Y(SUM[9]) );
  OAI2BB1XL U17 ( .A0N(n13), .A1N(A[4]), .B0(n12), .Y(SUM[4]) );
  OAI2BB1XL U18 ( .A0N(n12), .A1N(A[5]), .B0(n11), .Y(SUM[5]) );
  OAI2BB1XL U19 ( .A0N(n14), .A1N(A[3]), .B0(n13), .Y(SUM[3]) );
  OAI2BB1XL U20 ( .A0N(n1), .A1N(A[2]), .B0(n14), .Y(SUM[2]) );
  OR2X1 U21 ( .A(A[10]), .B(A[9]), .Y(n2) );
  CLKINVX1 U22 ( .A(n18), .Y(n4) );
  NOR2X1 U23 ( .A(n7), .B(A[9]), .Y(n8) );
  CLKINVX1 U24 ( .A(A[10]), .Y(n5) );
  CLKINVX1 U25 ( .A(A[11]), .Y(n6) );
  OAI2BB1X1 U26 ( .A0N(A[0]), .A1N(A[1]), .B0(n1), .Y(SUM[1]) );
  XOR2X1 U27 ( .A(A[13]), .B(n16), .Y(SUM[13]) );
  OAI21XL U28 ( .A0(n4), .A1(n6), .B0(n17), .Y(SUM[11]) );
  OAI21XL U29 ( .A0(n8), .A1(n5), .B0(n18), .Y(SUM[10]) );
  OR2X1 U30 ( .A(n12), .B(A[5]), .Y(n11) );
  OR2X1 U31 ( .A(n14), .B(A[3]), .Y(n13) );
endmodule


module ReadGray_DW01_inc_0_DW01_inc_1 ( A, SUM );
  input [13:0] A;
  output [13:0] SUM;
  wire   n1;
  wire   [13:2] carry;

  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_11 ( .A(A[11]), .B(n1), .CO(carry[12]), .S(SUM[11]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  AND2X2 U1 ( .A(A[10]), .B(carry[10]), .Y(n1) );
  INVXL U2 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U3 ( .A(A[10]), .B(carry[10]), .Y(SUM[10]) );
  XOR2X1 U4 ( .A(carry[13]), .B(A[13]), .Y(SUM[13]) );
endmodule


module ReadGray ( clk, rst, gray_ready_i, gray_req_o, gray_addr_o, cnt_o, 
        white_o, addr_o );
  output [13:0] gray_addr_o;
  output [3:0] cnt_o;
  output [13:0] addr_o;
  input clk, rst, gray_ready_i;
  output gray_req_o, white_o;
  wire   n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, N57, N58, N59, N60, N61,
         N62, N63, N64, N65, N66, N67, N68, N69, N70, N116, N117, N118, N119,
         N120, N121, N122, N123, N124, N125, N126, N127, N128, N130, N131,
         N132, N133, N134, N135, N137, N138, N139, N140, N141, N142, N144,
         N145, N146, N147, N148, N149, N150, N151, N152, N153, N154, N155,
         N156, N157, N158, N159, N160, N161, N162, N163, N164, N165, N166,
         N167, N168, N169, N170, N186, N187, N188, N189, N190, N191, N192,
         N193, N194, N195, N196, N197, N198, N207, N208, N209, N210, N211,
         N212, N214, N215, N216, N217, N218, N219, N220, N221, N222, N223,
         N224, N225, N226, n15, n17, n18, n19, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85,
         n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99,
         n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, \add_50/carry[2] ,
         \add_50/carry[3] , \add_50/carry[4] , \add_50/carry[5] ,
         \add_50/carry[6] , \add_50/carry[7] , \add_50/carry[8] ,
         \add_50/carry[9] , \add_50/carry[10] , \add_50/carry[11] ,
         \add_50/carry[12] , \add_50/carry[13] , \add_49/carry[13] ,
         \add_49/carry[12] , \add_49/carry[11] , \add_49/carry[10] ,
         \add_49/carry[9] , \add_48/carry[2] , \add_48/carry[3] ,
         \add_48/carry[4] , \add_48/carry[5] , \add_48/carry[6] ,
         \add_48/carry[7] , \add_48/carry[8] , \add_48/carry[9] ,
         \add_48/carry[10] , \add_48/carry[11] , \add_48/carry[12] ,
         \add_48/carry[13] , \sub_45/carry[2] , \sub_45/carry[3] ,
         \sub_45/carry[4] , \sub_45/carry[5] , \sub_45/carry[6] ,
         \sub_45/carry[7] , \sub_45/carry[8] , \sub_45/carry[9] ,
         \sub_45/carry[10] , \sub_45/carry[11] , \sub_45/carry[12] ,
         \sub_45/carry[13] , \sub_44/carry[13] , \sub_44/carry[12] ,
         \sub_44/carry[11] , \sub_44/carry[10] , \sub_44/carry[9] ,
         \sub_43/carry[2] , \sub_43/carry[3] , \sub_43/carry[4] ,
         \sub_43/carry[5] , \sub_43/carry[6] , \sub_43/carry[7] ,
         \sub_43/carry[8] , \sub_43/carry[9] , \sub_43/carry[10] ,
         \sub_43/carry[11] , \sub_43/carry[12] , \sub_43/carry[13] , n1, n2,
         n3, n4, n5, n6, n7, n8, n9, n16, n20, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n147, n148, n149, n150, n151;

  DFFRX1 \addr_o_reg[13]  ( .D(n116), .CK(clk), .RN(n151), .Q(n163) );
  DFFRX1 \addr_o_reg[12]  ( .D(n111), .CK(clk), .RN(n151), .Q(n164) );
  DFFRX1 \addr_o_reg[9]  ( .D(n108), .CK(clk), .RN(n151), .Q(n167) );
  DFFRX1 \addr_o_reg[10]  ( .D(n109), .CK(clk), .RN(n151), .Q(n166) );
  DFFRX1 \addr_o_reg[11]  ( .D(n110), .CK(clk), .RN(n151), .Q(n165) );
  DFFRX1 \addr_o_reg[6]  ( .D(n105), .CK(clk), .RN(n151), .Q(N135) );
  DFFRX1 \addr_o_reg[7]  ( .D(n106), .CK(clk), .RN(n151), .Q(n169), .QN(n4) );
  DFFRX1 \addr_o_reg[8]  ( .D(n107), .CK(clk), .RN(n151), .Q(n168) );
  DFFRX1 \addr_o_reg[4]  ( .D(n103), .CK(clk), .RN(n151), .Q(N133) );
  DFFRX1 \addr_o_reg[5]  ( .D(n104), .CK(clk), .RN(n151), .Q(N134) );
  DFFRX1 \cnt_o_reg[3]  ( .D(n112), .CK(clk), .RN(n151), .Q(cnt_o[3]), .QN(n15) );
  DFFRX1 \cnt_o_reg[2]  ( .D(n113), .CK(clk), .RN(n151), .Q(cnt_o[2]), .QN(n17) );
  DFFRX1 \addr_o_reg[3]  ( .D(n102), .CK(clk), .RN(n151), .Q(N132) );
  DFFRX1 \addr_o_reg[2]  ( .D(n101), .CK(clk), .RN(n151), .Q(N131) );
  DFFRX1 \addr_o_reg[1]  ( .D(n100), .CK(clk), .RN(n151), .Q(N130) );
  DFFRX2 \addr_o_reg[0]  ( .D(n117), .CK(clk), .RN(n151), .Q(n6), .QN(n147) );
  DFFRX2 \cnt_o_reg[0]  ( .D(n115), .CK(clk), .RN(n151), .Q(cnt_o[0]), .QN(n19) );
  AOI222XL U3 ( .A0(addr_o[0]), .A1(n130), .B0(addr_o[0]), .B1(n131), .C0(n147), .C1(n132), .Y(n97) );
  AOI222XL U4 ( .A0(addr_o[1]), .A1(n130), .B0(addr_o[1]), .B1(n131), .C0(N214), .C1(n132), .Y(n77) );
  AOI222XL U5 ( .A0(addr_o[3]), .A1(n130), .B0(addr_o[3]), .B1(n131), .C0(N216), .C1(n132), .Y(n69) );
  AOI222XL U6 ( .A0(addr_o[4]), .A1(n130), .B0(addr_o[4]), .B1(n131), .C0(N217), .C1(n132), .Y(n65) );
  AOI222XL U7 ( .A0(addr_o[5]), .A1(n130), .B0(addr_o[5]), .B1(n131), .C0(N218), .C1(n132), .Y(n61) );
  AOI222XL U8 ( .A0(addr_o[6]), .A1(n130), .B0(addr_o[6]), .B1(n131), .C0(N219), .C1(n132), .Y(n57) );
  AOI222XL U9 ( .A0(n4), .A1(n130), .B0(addr_o[7]), .B1(n131), .C0(N220), .C1(
        n132), .Y(n53) );
  AOI222XL U10 ( .A0(N207), .A1(n130), .B0(addr_o[8]), .B1(n131), .C0(N221), 
        .C1(n132), .Y(n49) );
  AOI222XL U11 ( .A0(N210), .A1(n130), .B0(addr_o[11]), .B1(n131), .C0(N224), 
        .C1(n132), .Y(n89) );
  AOI22X1 U12 ( .A0(N140), .A1(n125), .B0(N126), .B1(n126), .Y(n86) );
  OR2X1 U13 ( .A(n7), .B(n2), .Y(n1) );
  AO22X1 U14 ( .A0(addr_o[2]), .A1(n125), .B0(N117), .B1(n126), .Y(n2) );
  OR2X1 U15 ( .A(n20), .B(n8), .Y(n3) );
  CLKBUFX3 U16 ( .A(n169), .Y(addr_o[7]) );
  AND4X1 U17 ( .A(n86), .B(n87), .C(n88), .D(n89), .Y(n5) );
  AO22X1 U18 ( .A0(N159), .A1(n127), .B0(N145), .B1(n150), .Y(n7) );
  AO22X1 U19 ( .A0(N187), .A1(n128), .B0(N59), .B1(n129), .Y(n8) );
  INVX16 U21 ( .A(n9), .Y(gray_req_o) );
  AND4X1 U22 ( .A(n54), .B(n55), .C(n56), .D(n57), .Y(n157) );
  INVX12 U23 ( .A(n157), .Y(gray_addr_o[6]) );
  AND4X1 U24 ( .A(n58), .B(n59), .C(n60), .D(n61), .Y(n158) );
  INVX12 U25 ( .A(n158), .Y(gray_addr_o[5]) );
  AND4X1 U26 ( .A(n62), .B(n63), .C(n64), .D(n65), .Y(n159) );
  INVX12 U27 ( .A(n159), .Y(gray_addr_o[4]) );
  AND4X1 U28 ( .A(n66), .B(n67), .C(n68), .D(n69), .Y(n160) );
  INVX12 U29 ( .A(n160), .Y(gray_addr_o[3]) );
  INVX12 U30 ( .A(n16), .Y(gray_addr_o[2]) );
  INVX1 U31 ( .A(n73), .Y(n20) );
  NOR2X1 U32 ( .A(n3), .B(n1), .Y(n16) );
  AND4X1 U33 ( .A(n74), .B(n75), .C(n76), .D(n77), .Y(n161) );
  INVX12 U34 ( .A(n161), .Y(gray_addr_o[1]) );
  AND4X1 U35 ( .A(n94), .B(n95), .C(n96), .D(n97), .Y(n162) );
  INVX12 U36 ( .A(n162), .Y(gray_addr_o[0]) );
  AND4X1 U37 ( .A(n46), .B(n47), .C(n48), .D(n49), .Y(n155) );
  INVX12 U38 ( .A(n155), .Y(gray_addr_o[8]) );
  AND4X1 U39 ( .A(n50), .B(n51), .C(n52), .D(n53), .Y(n156) );
  INVX12 U40 ( .A(n156), .Y(gray_addr_o[7]) );
  AOI222XL U41 ( .A0(N208), .A1(n130), .B0(addr_o[9]), .B1(n131), .C0(N222), 
        .C1(n132), .Y(n38) );
  BUFX4 U42 ( .A(N130), .Y(addr_o[1]) );
  AOI222XL U43 ( .A0(N209), .A1(n130), .B0(addr_o[10]), .B1(n131), .C0(N223), 
        .C1(n132), .Y(n93) );
  CLKBUFX3 U44 ( .A(N132), .Y(addr_o[3]) );
  CLKBUFX3 U45 ( .A(N131), .Y(addr_o[2]) );
  INVX3 U46 ( .A(n147), .Y(addr_o[0]) );
  BUFX12 U47 ( .A(n154), .Y(gray_addr_o[9]) );
  NAND4X1 U48 ( .A(n35), .B(n36), .C(n37), .D(n38), .Y(n154) );
  AOI222XL U49 ( .A0(N212), .A1(n130), .B0(addr_o[13]), .B1(n131), .C0(N226), 
        .C1(n132), .Y(n81) );
  OR2XL U50 ( .A(addr_o[1]), .B(n6), .Y(\sub_43/carry[2] ) );
  BUFX12 U51 ( .A(n153), .Y(gray_addr_o[10]) );
  NAND4X1 U52 ( .A(n90), .B(n91), .C(n92), .D(n93), .Y(n153) );
  INVX12 U53 ( .A(n5), .Y(gray_addr_o[11]) );
  CLKBUFX3 U54 ( .A(N133), .Y(addr_o[4]) );
  AO22XL U55 ( .A0(addr_o[13]), .A1(n148), .B0(n133), .B1(N70), .Y(n116) );
  CLKBUFX3 U56 ( .A(n166), .Y(addr_o[10]) );
  AND2X1 U57 ( .A(addr_o[0]), .B(addr_o[1]), .Y(\add_50/carry[2] ) );
  BUFX12 U58 ( .A(n152), .Y(gray_addr_o[13]) );
  NAND4X1 U59 ( .A(n78), .B(n79), .C(n80), .D(n81), .Y(n152) );
  XNOR2XL U60 ( .A(\sub_45/carry[9] ), .B(addr_o[9]), .Y(N152) );
  XNOR2XL U61 ( .A(\sub_43/carry[9] ), .B(addr_o[9]), .Y(N124) );
  XNOR2XL U62 ( .A(\sub_43/carry[12] ), .B(addr_o[12]), .Y(N127) );
  XNOR2XL U63 ( .A(\sub_45/carry[10] ), .B(addr_o[10]), .Y(N153) );
  AND2X2 U64 ( .A(\add_50/carry[12] ), .B(addr_o[12]), .Y(\add_50/carry[13] )
         );
  XOR2XL U65 ( .A(addr_o[12]), .B(\add_50/carry[12] ), .Y(N225) );
  OR2XL U66 ( .A(addr_o[11]), .B(\sub_45/carry[11] ), .Y(\sub_45/carry[12] )
         );
  AND2X2 U67 ( .A(\add_48/carry[8] ), .B(addr_o[8]), .Y(\add_48/carry[9] ) );
  AND2X2 U68 ( .A(\add_48/carry[10] ), .B(addr_o[10]), .Y(\add_48/carry[11] )
         );
  AND2XL U69 ( .A(\add_48/carry[11] ), .B(addr_o[11]), .Y(\add_48/carry[12] )
         );
  AND2X2 U70 ( .A(\sub_45/carry[5] ), .B(addr_o[5]), .Y(\sub_45/carry[6] ) );
  AND2X2 U71 ( .A(\sub_45/carry[3] ), .B(addr_o[3]), .Y(\sub_45/carry[4] ) );
  AOI22XL U72 ( .A0(N157), .A1(n127), .B0(n147), .B1(n150), .Y(n95) );
  XNOR2XL U73 ( .A(\add_48/carry[5] ), .B(addr_o[5]), .Y(N190) );
  XNOR2XL U74 ( .A(\add_48/carry[6] ), .B(addr_o[6]), .Y(N191) );
  XOR2XL U75 ( .A(addr_o[7]), .B(\add_48/carry[7] ), .Y(N192) );
  XOR2XL U76 ( .A(addr_o[5]), .B(\sub_45/carry[5] ), .Y(N148) );
  XOR2XL U77 ( .A(addr_o[6]), .B(\sub_45/carry[6] ), .Y(N149) );
  XNOR2XL U78 ( .A(\add_48/carry[4] ), .B(addr_o[4]), .Y(N189) );
  XNOR2XL U79 ( .A(\add_48/carry[3] ), .B(addr_o[3]), .Y(N188) );
  XOR2XL U80 ( .A(addr_o[3]), .B(\sub_45/carry[3] ), .Y(N146) );
  XOR2XL U81 ( .A(addr_o[4]), .B(\sub_45/carry[4] ), .Y(N147) );
  CLKBUFX3 U82 ( .A(N134), .Y(addr_o[5]) );
  CLKBUFX3 U83 ( .A(N135), .Y(addr_o[6]) );
  CLKBUFX3 U84 ( .A(n167), .Y(addr_o[9]) );
  CLKBUFX3 U85 ( .A(n168), .Y(addr_o[8]) );
  CLKBUFX3 U86 ( .A(n165), .Y(addr_o[11]) );
  CLKBUFX3 U87 ( .A(n21), .Y(n133) );
  CLKBUFX3 U88 ( .A(n44), .Y(n125) );
  CLKBUFX3 U89 ( .A(n45), .Y(n126) );
  CLKBUFX3 U90 ( .A(n43), .Y(n127) );
  CLKBUFX3 U91 ( .A(n41), .Y(n128) );
  CLKBUFX3 U92 ( .A(n42), .Y(n129) );
  CLKBUFX3 U93 ( .A(n164), .Y(addr_o[12]) );
  OR2XL U94 ( .A(addr_o[1]), .B(n6), .Y(\add_48/carry[2] ) );
  AND2XL U95 ( .A(n6), .B(addr_o[1]), .Y(\sub_45/carry[2] ) );
  INVX3 U96 ( .A(n23), .Y(n150) );
  CLKINVX1 U97 ( .A(white_o), .Y(n149) );
  AOI22X1 U98 ( .A0(N168), .A1(n127), .B0(N154), .B1(n150), .Y(n87) );
  AOI22X1 U99 ( .A0(N196), .A1(n128), .B0(N68), .B1(n129), .Y(n88) );
  AOI22X1 U100 ( .A0(N166), .A1(n127), .B0(N152), .B1(n150), .Y(n36) );
  AOI22X1 U101 ( .A0(N194), .A1(n128), .B0(N66), .B1(n129), .Y(n37) );
  AOI22X1 U102 ( .A0(N167), .A1(n127), .B0(N153), .B1(n150), .Y(n91) );
  AOI22X1 U103 ( .A0(N195), .A1(n128), .B0(N67), .B1(n129), .Y(n92) );
  AOI22X1 U104 ( .A0(N198), .A1(n128), .B0(N70), .B1(n129), .Y(n80) );
  AOI22X1 U105 ( .A0(N170), .A1(n127), .B0(N156), .B1(n150), .Y(n79) );
  AOI22X1 U106 ( .A0(N169), .A1(n127), .B0(N155), .B1(n150), .Y(n83) );
  AOI22X1 U107 ( .A0(N197), .A1(n128), .B0(N69), .B1(n129), .Y(n84) );
  AOI22X1 U108 ( .A0(N142), .A1(n125), .B0(N128), .B1(n126), .Y(n78) );
  AOI22X1 U109 ( .A0(N138), .A1(n125), .B0(N124), .B1(n126), .Y(n35) );
  AOI22X1 U110 ( .A0(N139), .A1(n125), .B0(N125), .B1(n126), .Y(n90) );
  AOI22X1 U111 ( .A0(N141), .A1(n125), .B0(N127), .B1(n126), .Y(n82) );
  AOI22X1 U112 ( .A0(n4), .A1(n125), .B0(N122), .B1(n126), .Y(n50) );
  AOI22X1 U113 ( .A0(N192), .A1(n128), .B0(N64), .B1(n129), .Y(n52) );
  AOI22X1 U114 ( .A0(N137), .A1(n125), .B0(N123), .B1(n126), .Y(n46) );
  AOI22X1 U115 ( .A0(N193), .A1(n128), .B0(N65), .B1(n129), .Y(n48) );
  AOI222XL U116 ( .A0(N211), .A1(n130), .B0(addr_o[12]), .B1(n131), .C0(N225), 
        .C1(n132), .Y(n85) );
  AOI22X1 U117 ( .A0(N164), .A1(n127), .B0(N150), .B1(n150), .Y(n51) );
  AOI22X1 U118 ( .A0(N165), .A1(n127), .B0(N151), .B1(n150), .Y(n47) );
  AOI22X1 U119 ( .A0(N161), .A1(n127), .B0(N147), .B1(n150), .Y(n63) );
  AOI22X1 U120 ( .A0(addr_o[4]), .A1(n125), .B0(N119), .B1(n126), .Y(n62) );
  AOI22X1 U121 ( .A0(N189), .A1(n128), .B0(N61), .B1(n129), .Y(n64) );
  AOI22X1 U122 ( .A0(N162), .A1(n127), .B0(N148), .B1(n150), .Y(n59) );
  AOI22X1 U123 ( .A0(addr_o[5]), .A1(n125), .B0(N120), .B1(n126), .Y(n58) );
  AOI22X1 U124 ( .A0(N190), .A1(n128), .B0(N62), .B1(n129), .Y(n60) );
  AOI22X1 U125 ( .A0(N163), .A1(n127), .B0(N149), .B1(n150), .Y(n55) );
  AOI22X1 U126 ( .A0(addr_o[6]), .A1(n125), .B0(N121), .B1(n126), .Y(n54) );
  AOI22X1 U127 ( .A0(N191), .A1(n128), .B0(N63), .B1(n129), .Y(n56) );
  AOI22X1 U128 ( .A0(addr_o[0]), .A1(n125), .B0(n147), .B1(n126), .Y(n94) );
  AOI22X1 U129 ( .A0(n147), .A1(n128), .B0(N57), .B1(n129), .Y(n96) );
  AOI22X1 U130 ( .A0(addr_o[1]), .A1(n125), .B0(N116), .B1(n126), .Y(n74) );
  AOI22X1 U131 ( .A0(N158), .A1(n127), .B0(N144), .B1(n150), .Y(n75) );
  AOI22X1 U132 ( .A0(N186), .A1(n128), .B0(N58), .B1(n129), .Y(n76) );
  AOI22X1 U133 ( .A0(N160), .A1(n127), .B0(N146), .B1(n150), .Y(n67) );
  AOI22X1 U134 ( .A0(addr_o[3]), .A1(n125), .B0(N118), .B1(n126), .Y(n66) );
  AOI22X1 U135 ( .A0(N188), .A1(n128), .B0(N60), .B1(n129), .Y(n68) );
  AOI222XL U136 ( .A0(addr_o[2]), .A1(n130), .B0(addr_o[2]), .B1(n131), .C0(
        N215), .C1(n132), .Y(n73) );
  CLKBUFX3 U137 ( .A(n22), .Y(n130) );
  NOR2BX1 U138 ( .AN(n24), .B(n25), .Y(n22) );
  NAND2X1 U139 ( .A(n99), .B(n24), .Y(n23) );
  NAND4X1 U140 ( .A(n27), .B(n28), .C(n29), .D(n30), .Y(white_o) );
  NAND4X1 U141 ( .A(addr_o[8]), .B(addr_o[7]), .C(addr_o[9]), .D(n34), .Y(n27)
         );
  NAND4X1 U142 ( .A(addr_o[5]), .B(addr_o[4]), .C(addr_o[6]), .D(n32), .Y(n29)
         );
  OR4X1 U143 ( .A(addr_o[11]), .B(addr_o[12]), .C(addr_o[10]), .D(n33), .Y(n28) );
  AND4X1 U144 ( .A(n6), .B(addr_o[1]), .C(addr_o[2]), .D(addr_o[3]), .Y(n32)
         );
  AND4X1 U145 ( .A(addr_o[10]), .B(addr_o[11]), .C(addr_o[12]), .D(addr_o[13]), 
        .Y(n34) );
  INVX3 U146 ( .A(n133), .Y(n148) );
  OR4X1 U147 ( .A(addr_o[1]), .B(addr_o[2]), .C(n6), .D(n31), .Y(n30) );
  OR4X1 U148 ( .A(addr_o[6]), .B(addr_o[5]), .C(addr_o[4]), .D(addr_o[3]), .Y(
        n31) );
  OR4X1 U149 ( .A(addr_o[9]), .B(addr_o[8]), .C(addr_o[7]), .D(addr_o[13]), 
        .Y(n33) );
  AO22X1 U150 ( .A0(addr_o[0]), .A1(n148), .B0(n133), .B1(N57), .Y(n117) );
  NAND2X1 U151 ( .A(cnt_o[2]), .B(n15), .Y(n25) );
  NOR3X1 U152 ( .A(cnt_o[1]), .B(cnt_o[2]), .C(cnt_o[0]), .Y(n98) );
  NOR2X1 U153 ( .A(n18), .B(n19), .Y(n24) );
  NOR2X1 U154 ( .A(cnt_o[3]), .B(cnt_o[2]), .Y(n99) );
  NOR3BXL U155 ( .AN(n99), .B(n18), .C(cnt_o[0]), .Y(n44) );
  NOR3X1 U156 ( .A(n18), .B(cnt_o[0]), .C(n25), .Y(n41) );
  NOR3X1 U157 ( .A(cnt_o[0]), .B(cnt_o[1]), .C(n25), .Y(n43) );
  NOR3BXL U158 ( .AN(n99), .B(n19), .C(cnt_o[1]), .Y(n45) );
  NOR3X1 U159 ( .A(n19), .B(cnt_o[1]), .C(n25), .Y(n42) );
  CLKBUFX3 U160 ( .A(n39), .Y(n131) );
  XOR2X1 U161 ( .A(cnt_o[3]), .B(n98), .Y(n39) );
  CLKBUFX3 U162 ( .A(n40), .Y(n132) );
  NOR2BX1 U163 ( .AN(n98), .B(n15), .Y(n40) );
  CLKBUFX3 U164 ( .A(n163), .Y(addr_o[13]) );
  AO22X1 U165 ( .A0(addr_o[12]), .A1(n148), .B0(n133), .B1(N69), .Y(n111) );
  AO22X1 U166 ( .A0(addr_o[11]), .A1(n148), .B0(n133), .B1(N68), .Y(n110) );
  OAI222XL U167 ( .A0(white_o), .A1(n23), .B0(n24), .B1(n25), .C0(n149), .C1(
        n17), .Y(n113) );
  OAI32X1 U168 ( .A0(n19), .A1(cnt_o[1]), .A2(n133), .B0(n26), .B1(n18), .Y(
        n114) );
  AOI2BB1X1 U169 ( .A0N(cnt_o[0]), .A1N(cnt_o[3]), .B0(white_o), .Y(n26) );
  OAI22XL U170 ( .A0(n149), .A1(n19), .B0(cnt_o[0]), .B1(n133), .Y(n115) );
  OAI2BB2XL U171 ( .B0(n149), .B1(n15), .A0N(n149), .A1N(n130), .Y(n112) );
  NAND2X1 U172 ( .A(n149), .B(n15), .Y(n21) );
  AO22X1 U173 ( .A0(n133), .A1(N66), .B0(addr_o[9]), .B1(n148), .Y(n108) );
  AO22X1 U174 ( .A0(n133), .A1(N65), .B0(addr_o[8]), .B1(n148), .Y(n107) );
  AO22X1 U175 ( .A0(n133), .A1(N64), .B0(addr_o[7]), .B1(n148), .Y(n106) );
  AO22X1 U176 ( .A0(n133), .A1(N63), .B0(addr_o[6]), .B1(n148), .Y(n105) );
  AO22X1 U177 ( .A0(n133), .A1(N62), .B0(addr_o[5]), .B1(n148), .Y(n104) );
  AO22X1 U178 ( .A0(n133), .A1(N61), .B0(addr_o[4]), .B1(n148), .Y(n103) );
  AO22X1 U179 ( .A0(addr_o[10]), .A1(n148), .B0(n133), .B1(N67), .Y(n109) );
  AO22X1 U180 ( .A0(addr_o[3]), .A1(n148), .B0(n133), .B1(N60), .Y(n102) );
  AO22X1 U181 ( .A0(addr_o[2]), .A1(n148), .B0(n133), .B1(N59), .Y(n101) );
  AO22X1 U182 ( .A0(addr_o[1]), .A1(n148), .B0(n133), .B1(N58), .Y(n100) );
  INVX4 U183 ( .A(rst), .Y(n151) );
  NAND4X1 U184 ( .A(n82), .B(n83), .C(n84), .D(n85), .Y(gray_addr_o[12]) );
  XOR2X1 U185 ( .A(addr_o[13]), .B(\add_50/carry[13] ), .Y(N226) );
  AND2X1 U186 ( .A(\add_50/carry[11] ), .B(addr_o[11]), .Y(\add_50/carry[12] )
         );
  XOR2X1 U187 ( .A(addr_o[11]), .B(\add_50/carry[11] ), .Y(N224) );
  AND2X1 U188 ( .A(\add_50/carry[10] ), .B(addr_o[10]), .Y(\add_50/carry[11] )
         );
  XOR2X1 U189 ( .A(addr_o[10]), .B(\add_50/carry[10] ), .Y(N223) );
  AND2X1 U190 ( .A(\add_50/carry[9] ), .B(addr_o[9]), .Y(\add_50/carry[10] )
         );
  XOR2X1 U191 ( .A(addr_o[9]), .B(\add_50/carry[9] ), .Y(N222) );
  AND2X1 U192 ( .A(\add_50/carry[8] ), .B(addr_o[8]), .Y(\add_50/carry[9] ) );
  XOR2X1 U193 ( .A(addr_o[8]), .B(\add_50/carry[8] ), .Y(N221) );
  OR2X1 U194 ( .A(addr_o[7]), .B(\add_50/carry[7] ), .Y(\add_50/carry[8] ) );
  XNOR2X1 U195 ( .A(\add_50/carry[7] ), .B(addr_o[7]), .Y(N220) );
  AND2X1 U196 ( .A(\add_50/carry[6] ), .B(addr_o[6]), .Y(\add_50/carry[7] ) );
  XOR2X1 U197 ( .A(addr_o[6]), .B(\add_50/carry[6] ), .Y(N219) );
  AND2X1 U198 ( .A(\add_50/carry[5] ), .B(addr_o[5]), .Y(\add_50/carry[6] ) );
  XOR2X1 U199 ( .A(addr_o[5]), .B(\add_50/carry[5] ), .Y(N218) );
  AND2X1 U200 ( .A(\add_50/carry[4] ), .B(addr_o[4]), .Y(\add_50/carry[5] ) );
  XOR2X1 U201 ( .A(addr_o[4]), .B(\add_50/carry[4] ), .Y(N217) );
  AND2X1 U202 ( .A(\add_50/carry[3] ), .B(addr_o[3]), .Y(\add_50/carry[4] ) );
  XOR2X1 U203 ( .A(addr_o[3]), .B(\add_50/carry[3] ), .Y(N216) );
  AND2X1 U204 ( .A(\add_50/carry[2] ), .B(addr_o[2]), .Y(\add_50/carry[3] ) );
  XOR2X1 U205 ( .A(addr_o[2]), .B(\add_50/carry[2] ), .Y(N215) );
  XOR2X1 U206 ( .A(addr_o[1]), .B(addr_o[0]), .Y(N214) );
  XOR2X1 U207 ( .A(addr_o[13]), .B(\add_49/carry[13] ), .Y(N212) );
  AND2X1 U208 ( .A(\add_49/carry[12] ), .B(addr_o[12]), .Y(\add_49/carry[13] )
         );
  XOR2X1 U209 ( .A(addr_o[12]), .B(\add_49/carry[12] ), .Y(N211) );
  AND2X1 U210 ( .A(\add_49/carry[11] ), .B(addr_o[11]), .Y(\add_49/carry[12] )
         );
  XOR2X1 U211 ( .A(addr_o[11]), .B(\add_49/carry[11] ), .Y(N210) );
  AND2X1 U212 ( .A(\add_49/carry[10] ), .B(addr_o[10]), .Y(\add_49/carry[11] )
         );
  XOR2X1 U213 ( .A(addr_o[10]), .B(\add_49/carry[10] ), .Y(N209) );
  AND2X1 U214 ( .A(\add_49/carry[9] ), .B(addr_o[9]), .Y(\add_49/carry[10] )
         );
  XOR2X1 U215 ( .A(addr_o[9]), .B(\add_49/carry[9] ), .Y(N208) );
  AND2X1 U216 ( .A(addr_o[7]), .B(addr_o[8]), .Y(\add_49/carry[9] ) );
  XOR2X1 U217 ( .A(addr_o[8]), .B(addr_o[7]), .Y(N207) );
  XOR2X1 U218 ( .A(addr_o[13]), .B(\add_48/carry[13] ), .Y(N198) );
  AND2X1 U219 ( .A(\add_48/carry[12] ), .B(addr_o[12]), .Y(\add_48/carry[13] )
         );
  XOR2X1 U220 ( .A(addr_o[12]), .B(\add_48/carry[12] ), .Y(N197) );
  XOR2X1 U221 ( .A(addr_o[11]), .B(\add_48/carry[11] ), .Y(N196) );
  XOR2X1 U222 ( .A(addr_o[10]), .B(\add_48/carry[10] ), .Y(N195) );
  AND2X1 U223 ( .A(\add_48/carry[9] ), .B(addr_o[9]), .Y(\add_48/carry[10] )
         );
  XOR2X1 U224 ( .A(addr_o[9]), .B(\add_48/carry[9] ), .Y(N194) );
  XOR2X1 U225 ( .A(addr_o[8]), .B(\add_48/carry[8] ), .Y(N193) );
  AND2X1 U226 ( .A(\add_48/carry[7] ), .B(addr_o[7]), .Y(\add_48/carry[8] ) );
  OR2X1 U227 ( .A(addr_o[6]), .B(\add_48/carry[6] ), .Y(\add_48/carry[7] ) );
  OR2X1 U228 ( .A(addr_o[5]), .B(\add_48/carry[5] ), .Y(\add_48/carry[6] ) );
  OR2X1 U229 ( .A(addr_o[4]), .B(\add_48/carry[4] ), .Y(\add_48/carry[5] ) );
  OR2X1 U230 ( .A(addr_o[3]), .B(\add_48/carry[3] ), .Y(\add_48/carry[4] ) );
  OR2X1 U231 ( .A(addr_o[2]), .B(\add_48/carry[2] ), .Y(\add_48/carry[3] ) );
  XNOR2X1 U232 ( .A(\add_48/carry[2] ), .B(addr_o[2]), .Y(N187) );
  XNOR2X1 U233 ( .A(addr_o[0]), .B(addr_o[1]), .Y(N186) );
  XNOR2X1 U234 ( .A(addr_o[13]), .B(\sub_45/carry[13] ), .Y(N156) );
  OR2X1 U235 ( .A(addr_o[12]), .B(\sub_45/carry[12] ), .Y(\sub_45/carry[13] )
         );
  XNOR2X1 U236 ( .A(\sub_45/carry[12] ), .B(addr_o[12]), .Y(N155) );
  XNOR2X1 U237 ( .A(\sub_45/carry[11] ), .B(addr_o[11]), .Y(N154) );
  OR2X1 U238 ( .A(addr_o[10]), .B(\sub_45/carry[10] ), .Y(\sub_45/carry[11] )
         );
  OR2X1 U239 ( .A(addr_o[9]), .B(\sub_45/carry[9] ), .Y(\sub_45/carry[10] ) );
  OR2X1 U240 ( .A(addr_o[8]), .B(\sub_45/carry[8] ), .Y(\sub_45/carry[9] ) );
  XNOR2X1 U241 ( .A(\sub_45/carry[8] ), .B(addr_o[8]), .Y(N151) );
  OR2X1 U242 ( .A(addr_o[7]), .B(\sub_45/carry[7] ), .Y(\sub_45/carry[8] ) );
  XNOR2X1 U243 ( .A(\sub_45/carry[7] ), .B(addr_o[7]), .Y(N150) );
  AND2X1 U244 ( .A(\sub_45/carry[6] ), .B(addr_o[6]), .Y(\sub_45/carry[7] ) );
  AND2X1 U245 ( .A(\sub_45/carry[4] ), .B(addr_o[4]), .Y(\sub_45/carry[5] ) );
  AND2X1 U246 ( .A(\sub_45/carry[2] ), .B(addr_o[2]), .Y(\sub_45/carry[3] ) );
  XOR2X1 U247 ( .A(addr_o[2]), .B(\sub_45/carry[2] ), .Y(N145) );
  XOR2X1 U248 ( .A(addr_o[1]), .B(n6), .Y(N144) );
  XNOR2X1 U249 ( .A(addr_o[13]), .B(\sub_43/carry[13] ), .Y(N128) );
  OR2X1 U250 ( .A(addr_o[12]), .B(\sub_43/carry[12] ), .Y(\sub_43/carry[13] )
         );
  OR2X1 U251 ( .A(addr_o[11]), .B(\sub_43/carry[11] ), .Y(\sub_43/carry[12] )
         );
  XNOR2X1 U252 ( .A(\sub_43/carry[11] ), .B(addr_o[11]), .Y(N126) );
  OR2X1 U253 ( .A(addr_o[10]), .B(\sub_43/carry[10] ), .Y(\sub_43/carry[11] )
         );
  XNOR2X1 U254 ( .A(\sub_43/carry[10] ), .B(addr_o[10]), .Y(N125) );
  OR2X1 U255 ( .A(addr_o[9]), .B(\sub_43/carry[9] ), .Y(\sub_43/carry[10] ) );
  OR2X1 U256 ( .A(addr_o[8]), .B(\sub_43/carry[8] ), .Y(\sub_43/carry[9] ) );
  XNOR2X1 U257 ( .A(\sub_43/carry[8] ), .B(addr_o[8]), .Y(N123) );
  AND2X1 U258 ( .A(\sub_43/carry[7] ), .B(addr_o[7]), .Y(\sub_43/carry[8] ) );
  XOR2X1 U259 ( .A(addr_o[7]), .B(\sub_43/carry[7] ), .Y(N122) );
  OR2X1 U260 ( .A(addr_o[6]), .B(\sub_43/carry[6] ), .Y(\sub_43/carry[7] ) );
  XNOR2X1 U261 ( .A(\sub_43/carry[6] ), .B(addr_o[6]), .Y(N121) );
  OR2X1 U262 ( .A(addr_o[5]), .B(\sub_43/carry[5] ), .Y(\sub_43/carry[6] ) );
  XNOR2X1 U263 ( .A(\sub_43/carry[5] ), .B(addr_o[5]), .Y(N120) );
  OR2X1 U264 ( .A(addr_o[4]), .B(\sub_43/carry[4] ), .Y(\sub_43/carry[5] ) );
  XNOR2X1 U265 ( .A(\sub_43/carry[4] ), .B(addr_o[4]), .Y(N119) );
  OR2X1 U266 ( .A(addr_o[3]), .B(\sub_43/carry[3] ), .Y(\sub_43/carry[4] ) );
  XNOR2X1 U267 ( .A(\sub_43/carry[3] ), .B(addr_o[3]), .Y(N118) );
  OR2X1 U268 ( .A(addr_o[2]), .B(\sub_43/carry[2] ), .Y(\sub_43/carry[3] ) );
  XNOR2X1 U269 ( .A(\sub_43/carry[2] ), .B(addr_o[2]), .Y(N117) );
  XNOR2X1 U270 ( .A(addr_o[0]), .B(addr_o[1]), .Y(N116) );
  XNOR2X1 U271 ( .A(addr_o[13]), .B(\sub_44/carry[13] ), .Y(N142) );
  OR2X1 U272 ( .A(addr_o[12]), .B(\sub_44/carry[12] ), .Y(\sub_44/carry[13] )
         );
  XNOR2X1 U273 ( .A(\sub_44/carry[12] ), .B(addr_o[12]), .Y(N141) );
  OR2X1 U274 ( .A(addr_o[11]), .B(\sub_44/carry[11] ), .Y(\sub_44/carry[12] )
         );
  XNOR2X1 U275 ( .A(\sub_44/carry[11] ), .B(addr_o[11]), .Y(N140) );
  OR2X1 U276 ( .A(addr_o[10]), .B(\sub_44/carry[10] ), .Y(\sub_44/carry[11] )
         );
  XNOR2X1 U277 ( .A(\sub_44/carry[10] ), .B(addr_o[10]), .Y(N139) );
  OR2X1 U278 ( .A(addr_o[9]), .B(\sub_44/carry[9] ), .Y(\sub_44/carry[10] ) );
  XNOR2X1 U279 ( .A(\sub_44/carry[9] ), .B(addr_o[9]), .Y(N138) );
  OR2X1 U280 ( .A(addr_o[8]), .B(addr_o[7]), .Y(\sub_44/carry[9] ) );
  XNOR2X1 U281 ( .A(addr_o[7]), .B(addr_o[8]), .Y(N137) );
  ReadGray_DW01_dec_0 sub_46 ( .A({addr_o[13:1], n6}), .SUM({N170, N169, N168, 
        N167, N166, N165, N164, N163, N162, N161, N160, N159, N158, N157}) );
  ReadGray_DW01_inc_0_DW01_inc_1 r383 ( .A(addr_o), .SUM({N70, N69, N68, N67, 
        N66, N65, N64, N63, N62, N61, N60, N59, N58, N57}) );
  DFFRX1 gray_req_o_reg ( .D(gray_ready_i), .CK(clk), .RN(n151), .QN(n9) );
  DFFRX2 \cnt_o_reg[1]  ( .D(n114), .CK(clk), .RN(n151), .Q(cnt_o[1]), .QN(n18) );
endmodule


module ALU ( clk, rst, graydata_i, cnt_i, white_i, addr_i, waddr_o, wdata_o );
  input [7:0] graydata_i;
  input [3:0] cnt_i;
  input [13:0] addr_i;
  output [13:0] waddr_o;
  output [7:0] wdata_o;
  input clk, rst, white_i;
  wire   n120, n121, n122, n123, N14, n11, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n2, n7, n8, n10, n13, n15,
         n46, n48, n50, n52, n54, n56, n58, n60, n62, n134, n137, n136, n135,
         n138, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n124, n126, n128,
         n130, n132;
  wire   [7:0] gc;

  DFFRX1 \gc_reg[5]  ( .D(n42), .CK(clk), .RN(n90), .Q(gc[5]) );
  DFFRX1 \gc_reg[0]  ( .D(n37), .CK(clk), .RN(n90), .Q(gc[0]), .QN(n2) );
  DFFRX1 \gc_reg[2]  ( .D(n39), .CK(clk), .RN(n90), .Q(gc[2]) );
  DFFRX1 \gc_reg[1]  ( .D(n38), .CK(clk), .RN(n90), .Q(gc[1]) );
  DFFRX1 \gc_reg[3]  ( .D(n40), .CK(clk), .RN(n90), .Q(gc[3]) );
  DFFRX1 \wdata_o_reg[3]  ( .D(n31), .CK(clk), .RN(n90), .Q(n123), .QN(n89) );
  DFFRX1 \wdata_o_reg[6]  ( .D(n34), .CK(clk), .RN(n90), .Q(n120), .QN(n86) );
  DFFRX1 \wdata_o_reg[5]  ( .D(n33), .CK(clk), .RN(n90), .Q(n121), .QN(n87) );
  DFFRX1 \wdata_o_reg[4]  ( .D(n32), .CK(clk), .RN(n90), .Q(n122), .QN(n88) );
  INVX3 U3 ( .A(graydata_i[1]), .Y(n105) );
  OAI22XL U4 ( .A0(n110), .A1(n17), .B0(n88), .B1(n22), .Y(n32) );
  OAI22XL U5 ( .A0(n111), .A1(n17), .B0(n87), .B1(n23), .Y(n33) );
  OAI22XL U6 ( .A0(n112), .A1(n17), .B0(n86), .B1(n24), .Y(n34) );
  OAI22XL U7 ( .A0(n109), .A1(n17), .B0(n89), .B1(n20), .Y(n31) );
  INVX12 U9 ( .A(n8), .Y(waddr_o[2]) );
  INVX12 U11 ( .A(n10), .Y(waddr_o[0]) );
  INVX12 U13 ( .A(n13), .Y(waddr_o[3]) );
  INVX12 U15 ( .A(n15), .Y(waddr_o[7]) );
  INVX12 U17 ( .A(n46), .Y(waddr_o[13]) );
  INVX12 U19 ( .A(n48), .Y(waddr_o[1]) );
  INVX12 U21 ( .A(n50), .Y(waddr_o[8]) );
  INVX12 U23 ( .A(n52), .Y(waddr_o[4]) );
  INVX12 U25 ( .A(n54), .Y(waddr_o[10]) );
  INVX12 U27 ( .A(n56), .Y(waddr_o[5]) );
  INVX12 U29 ( .A(n58), .Y(waddr_o[11]) );
  INVX12 U31 ( .A(n60), .Y(waddr_o[6]) );
  INVX12 U33 ( .A(n62), .Y(waddr_o[12]) );
  OAI222X1 U41 ( .A0(gc[5]), .A1(n107), .B0(gc[5]), .B1(n91), .C0(n107), .C1(
        n91), .Y(n92) );
  BUFX12 U42 ( .A(n122), .Y(wdata_o[4]) );
  BUFX12 U43 ( .A(n121), .Y(wdata_o[5]) );
  BUFX12 U44 ( .A(n120), .Y(wdata_o[6]) );
  BUFX12 U45 ( .A(n123), .Y(wdata_o[3]) );
  OAI2BB2XL U46 ( .B0(n16), .B1(n17), .A0N(wdata_o[1]), .A1N(n16), .Y(n29) );
  OAI2BB2XL U47 ( .B0(n19), .B1(n17), .A0N(wdata_o[2]), .A1N(n19), .Y(n30) );
  OAI2BB2XL U48 ( .B0(n25), .B1(n17), .A0N(wdata_o[7]), .A1N(n25), .Y(n35) );
  OAI2BB2XL U49 ( .B0(n27), .B1(n17), .A0N(wdata_o[0]), .A1N(n27), .Y(n36) );
  NAND3X4 U50 ( .A(n28), .B(n11), .C(N14), .Y(n17) );
  OAI21X2 U51 ( .A0(gc[7]), .A1(n108), .B0(n104), .Y(N14) );
  OAI22XL U52 ( .A0(n95), .A1(n106), .B0(gc[3]), .B1(n95), .Y(n96) );
  OAI222XL U53 ( .A0(graydata_i[6]), .A1(n92), .B0(n7), .B1(n92), .C0(
        graydata_i[6]), .C1(n7), .Y(n103) );
  INVXL U54 ( .A(n24), .Y(n112) );
  INVXL U55 ( .A(n23), .Y(n111) );
  INVXL U56 ( .A(n22), .Y(n110) );
  INVXL U57 ( .A(n20), .Y(n109) );
  INVX1 U58 ( .A(graydata_i[3]), .Y(n106) );
  AO22XL U59 ( .A0(graydata_i[3]), .A1(n26), .B0(gc[3]), .B1(n113), .Y(n40) );
  AO22XL U60 ( .A0(graydata_i[0]), .A1(n26), .B0(gc[0]), .B1(n113), .Y(n37) );
  AO22XL U61 ( .A0(graydata_i[1]), .A1(n26), .B0(gc[1]), .B1(n113), .Y(n38) );
  AO22XL U62 ( .A0(graydata_i[2]), .A1(n26), .B0(gc[2]), .B1(n113), .Y(n39) );
  AO22XL U63 ( .A0(graydata_i[4]), .A1(n26), .B0(gc[4]), .B1(n113), .Y(n41) );
  NAND2X2 U64 ( .A(n28), .B(n11), .Y(n26) );
  CLKINVX1 U65 ( .A(cnt_i[1]), .Y(n114) );
  CLKINVX1 U66 ( .A(cnt_i[0]), .Y(n117) );
  AO22X4 U67 ( .A0(n108), .A1(gc[7]), .B0(n103), .B1(n102), .Y(n104) );
  INVX1 U68 ( .A(graydata_i[5]), .Y(n107) );
  NAND4X1 U69 ( .A(n117), .B(n114), .C(n115), .D(n116), .Y(n28) );
  INVX3 U70 ( .A(n26), .Y(n113) );
  NAND2BX1 U72 ( .AN(gc[4]), .B(graydata_i[4]), .Y(n91) );
  CLKINVX1 U73 ( .A(graydata_i[7]), .Y(n108) );
  AOI31X1 U74 ( .A0(n114), .A1(n116), .A2(n115), .B0(n26), .Y(n27) );
  AOI31X1 U75 ( .A0(n117), .A1(n115), .A2(n114), .B0(n26), .Y(n25) );
  OAI31XL U76 ( .A0(n21), .A1(n114), .A2(n117), .B0(n113), .Y(n24) );
  OAI31XL U77 ( .A0(n21), .A1(cnt_i[0]), .A2(n114), .B0(n113), .Y(n23) );
  OAI31XL U78 ( .A0(n21), .A1(cnt_i[1]), .A2(n117), .B0(n113), .Y(n22) );
  OAI31XL U79 ( .A0(n21), .A1(cnt_i[1]), .A2(cnt_i[0]), .B0(n113), .Y(n20) );
  OA21XL U80 ( .A0(n18), .A1(n117), .B0(n113), .Y(n19) );
  OA21XL U81 ( .A0(cnt_i[0]), .A1(n18), .B0(n113), .Y(n16) );
  AO22X1 U82 ( .A0(graydata_i[5]), .A1(n26), .B0(gc[5]), .B1(n113), .Y(n42) );
  AO22X1 U83 ( .A0(graydata_i[6]), .A1(n26), .B0(gc[6]), .B1(n113), .Y(n43) );
  AO22X1 U84 ( .A0(graydata_i[7]), .A1(n26), .B0(gc[7]), .B1(n113), .Y(n44) );
  CLKINVX1 U85 ( .A(cnt_i[2]), .Y(n115) );
  CLKINVX1 U86 ( .A(cnt_i[3]), .Y(n116) );
  NAND2X1 U87 ( .A(cnt_i[2]), .B(n116), .Y(n21) );
  NAND3X1 U88 ( .A(n115), .B(n116), .C(cnt_i[1]), .Y(n18) );
  OAI221X2 U89 ( .A0(gc[3]), .A1(n99), .B0(gc[3]), .B1(n106), .C0(n98), .Y(
        n100) );
  NOR2BX1 U90 ( .AN(gc[4]), .B(graydata_i[4]), .Y(n93) );
  OAI22XL U91 ( .A0(n93), .A1(n107), .B0(gc[5]), .B1(n93), .Y(n101) );
  NAND2BX1 U92 ( .AN(gc[2]), .B(graydata_i[2]), .Y(n99) );
  OAI2BB2XL U93 ( .B0(graydata_i[0]), .B1(n2), .A0N(n105), .A1N(gc[1]), .Y(n94) );
  OAI21XL U94 ( .A0(gc[1]), .A1(n105), .B0(n94), .Y(n97) );
  NOR2BX1 U95 ( .AN(gc[2]), .B(graydata_i[2]), .Y(n95) );
  AOI2BB2X1 U96 ( .B0(n97), .B1(n96), .A0N(n99), .A1N(n106), .Y(n98) );
  OAI211X1 U97 ( .A0(graydata_i[6]), .A1(n7), .B0(n101), .C0(n100), .Y(n102)
         );
  DFFRXL white_reg ( .D(white_i), .CK(clk), .RN(n118), .QN(n11) );
  DFFRXL \waddr_o_reg[10]  ( .D(addr_i[10]), .CK(clk), .RN(n118), .QN(n54) );
  DFFRXL \waddr_o_reg[8]  ( .D(addr_i[8]), .CK(clk), .RN(n118), .QN(n50) );
  DFFRXL \waddr_o_reg[7]  ( .D(addr_i[7]), .CK(clk), .RN(n118), .QN(n15) );
  DFFRXL \waddr_o_reg[12]  ( .D(addr_i[12]), .CK(clk), .RN(n118), .QN(n62) );
  DFFRXL \waddr_o_reg[11]  ( .D(addr_i[11]), .CK(clk), .RN(n118), .QN(n58) );
  DFFRXL \waddr_o_reg[5]  ( .D(addr_i[5]), .CK(clk), .RN(n118), .QN(n56) );
  DFFRXL \waddr_o_reg[4]  ( .D(addr_i[4]), .CK(clk), .RN(n118), .QN(n52) );
  DFFRXL \waddr_o_reg[6]  ( .D(addr_i[6]), .CK(clk), .RN(n118), .QN(n60) );
  DFFRXL \waddr_o_reg[3]  ( .D(addr_i[3]), .CK(clk), .RN(n118), .QN(n13) );
  DFFRXL \waddr_o_reg[2]  ( .D(addr_i[2]), .CK(clk), .RN(n118), .QN(n8) );
  DFFRXL \waddr_o_reg[13]  ( .D(addr_i[13]), .CK(clk), .RN(n118), .QN(n46) );
  DFFRXL \waddr_o_reg[1]  ( .D(addr_i[1]), .CK(clk), .RN(n118), .QN(n48) );
  DFFRXL \waddr_o_reg[0]  ( .D(addr_i[0]), .CK(clk), .RN(n118), .QN(n10) );
  DFFRXL \gc_reg[7]  ( .D(n44), .CK(clk), .RN(n118), .Q(gc[7]) );
  DFFRXL \gc_reg[6]  ( .D(n43), .CK(clk), .RN(n118), .Q(gc[6]), .QN(n7) );
  DFFRXL \gc_reg[4]  ( .D(n41), .CK(clk), .RN(n118), .Q(gc[4]) );
  DFFRHQX1 \waddr_o_reg[9]  ( .D(addr_i[9]), .CK(clk), .RN(n118), .Q(n134) );
  DFFRHQX1 \wdata_o_reg[0]  ( .D(n36), .CK(clk), .RN(n118), .Q(n138) );
  DFFRHQX1 \wdata_o_reg[1]  ( .D(n29), .CK(clk), .RN(n118), .Q(n137) );
  DFFRHQX1 \wdata_o_reg[2]  ( .D(n30), .CK(clk), .RN(n118), .Q(n136) );
  DFFRHQX1 \wdata_o_reg[7]  ( .D(n35), .CK(clk), .RN(n118), .Q(n135) );
  INVXL U8 ( .A(n135), .Y(n124) );
  INVX12 U10 ( .A(n124), .Y(wdata_o[7]) );
  INVXL U12 ( .A(n136), .Y(n126) );
  INVX12 U14 ( .A(n126), .Y(wdata_o[2]) );
  INVXL U16 ( .A(n137), .Y(n128) );
  INVX12 U18 ( .A(n128), .Y(wdata_o[1]) );
  INVXL U20 ( .A(n138), .Y(n130) );
  INVX12 U22 ( .A(n130), .Y(wdata_o[0]) );
  INVXL U24 ( .A(n134), .Y(n132) );
  INVX12 U26 ( .A(n132), .Y(waddr_o[9]) );
  CLKBUFX2 U28 ( .A(n118), .Y(n90) );
  INVX4 U30 ( .A(rst), .Y(n118) );
endmodule


module LBP ( clk, reset, gray_addr, gray_req, gray_ready, gray_data, lbp_addr, 
        lbp_valid, lbp_data, finish );
  output [13:0] gray_addr;
  input [7:0] gray_data;
  output [13:0] lbp_addr;
  output [7:0] lbp_data;
  input clk, reset, gray_ready;
  output gray_req, lbp_valid, finish;
  wire   n8, white, N12, n1, n2, n3, n4;
  wire   [3:0] cnt;
  wire   [13:0] addr;

  OR4X1 U6 ( .A(n1), .B(n2), .C(n3), .D(n4), .Y(N12) );
  INVX12 U7 ( .A(N12), .Y(finish) );
  NAND4XL U8 ( .A(lbp_addr[12]), .B(lbp_addr[11]), .C(lbp_addr[10]), .D(
        lbp_addr[0]), .Y(n1) );
  NAND3XL U9 ( .A(lbp_addr[1]), .B(lbp_addr[13]), .C(lbp_addr[2]), .Y(n2) );
  NAND3XL U10 ( .A(lbp_addr[8]), .B(lbp_addr[7]), .C(lbp_addr[9]), .Y(n4) );
  NAND4XL U11 ( .A(lbp_addr[6]), .B(lbp_addr[5]), .C(lbp_addr[4]), .D(
        lbp_addr[3]), .Y(n3) );
  BUFX12 U12 ( .A(gray_req), .Y(lbp_valid) );
  BUFX12 U13 ( .A(n8), .Y(gray_addr[12]) );
  ReadGray RdG ( .clk(clk), .rst(reset), .gray_ready_i(gray_ready), 
        .gray_req_o(gray_req), .gray_addr_o({gray_addr[13], n8, 
        gray_addr[11:0]}), .cnt_o(cnt), .white_o(white), .addr_o(addr) );
  ALU Alu ( .clk(clk), .rst(reset), .graydata_i(gray_data), .cnt_i(cnt), 
        .white_i(white), .addr_i(addr), .waddr_o(lbp_addr), .wdata_o(lbp_data)
         );
endmodule

