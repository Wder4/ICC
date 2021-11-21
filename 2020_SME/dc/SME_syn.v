/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Mon Apr 12 16:59:17 2021
/////////////////////////////////////////////////////////////


module Controller ( clk, rst, isstr, ispat, ctrlsig, valid );
  output [1:0] ctrlsig;
  input clk, rst, isstr, ispat, valid;
  wire   \STATE[1] , n3, n4, n5, n1, n2;
  wire   [1:0] NEXT;

  DFFRX1 \STATE_reg[0]  ( .D(NEXT[0]), .CK(clk), .RN(n2), .QN(n3) );
  DFFRX1 \STATE_reg[1]  ( .D(NEXT[1]), .CK(clk), .RN(n2), .Q(\STATE[1] ), .QN(
        n1) );
  OAI21X1 U3 ( .A0(\STATE[1] ), .A1(n3), .B0(n4), .Y(ctrlsig[0]) );
  CLKINVX1 U4 ( .A(n4), .Y(ctrlsig[1]) );
  OAI2BB2XL U5 ( .B0(valid), .B1(n4), .A0N(n1), .A1N(n5), .Y(NEXT[1]) );
  NOR3X1 U6 ( .A(isstr), .B(ispat), .C(n3), .Y(n5) );
  OAI2BB2XL U7 ( .B0(\STATE[1] ), .B1(n5), .A0N(n3), .A1N(valid), .Y(NEXT[0])
         );
  NAND2X1 U8 ( .A(\STATE[1] ), .B(n3), .Y(n4) );
  CLKINVX1 U9 ( .A(rst), .Y(n2) );
endmodule


module LenCounter ( clk, rst, ctrlsig, pcnt_clr, isstr, ispat, scnt, plen );
  output [5:0] scnt;
  output [3:0] plen;
  input clk, rst, ctrlsig, pcnt_clr, isstr, ispat;
  wire   N9, N10, N11, N12, N13, N20, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, \add_12/carry[5] , \add_12/carry[4] ,
         \add_12/carry[3] , \add_12/carry[2] , n1, n2, n3, n4, n5, n6, n7;

  DFFTRX1 \scnt_reg[5]  ( .D(N13), .RN(n3), .CK(clk), .Q(scnt[5]) );
  DFFTRX1 \scnt_reg[4]  ( .D(N12), .RN(n3), .CK(clk), .Q(scnt[4]) );
  DFFTRX1 \scnt_reg[3]  ( .D(N11), .RN(n3), .CK(clk), .Q(scnt[3]) );
  DFFQX1 \plen_reg[3]  ( .D(n18), .CK(clk), .Q(plen[3]) );
  DFFQX4 \plen_reg[0]  ( .D(n21), .CK(clk), .Q(plen[0]) );
  DFFQX4 \plen_reg[1]  ( .D(n20), .CK(clk), .Q(plen[1]) );
  DFFQX2 \scnt_reg[0]  ( .D(N20), .CK(clk), .Q(scnt[0]) );
  DFFQX2 \plen_reg[2]  ( .D(n19), .CK(clk), .Q(plen[2]) );
  DFFTRX2 \scnt_reg[1]  ( .D(N9), .RN(n3), .CK(clk), .Q(scnt[1]) );
  DFFTRX2 \scnt_reg[2]  ( .D(N10), .RN(n3), .CK(clk), .Q(scnt[2]) );
  CLKINVX1 U3 ( .A(n10), .Y(n2) );
  NAND2X1 U4 ( .A(n11), .B(n16), .Y(n15) );
  CLKINVX1 U5 ( .A(n17), .Y(n3) );
  NOR3BX1 U6 ( .AN(ctrlsig), .B(pcnt_clr), .C(rst), .Y(n11) );
  OAI32X1 U7 ( .A0(n2), .A1(plen[1]), .A2(n4), .B0(n14), .B1(n5), .Y(n20) );
  CLKINVX1 U8 ( .A(plen[1]), .Y(n5) );
  NOR2X1 U9 ( .A(n16), .B(plen[3]), .Y(n10) );
  OAI31XL U10 ( .A0(n6), .A1(ispat), .A2(n1), .B0(n9), .Y(n18) );
  CLKINVX1 U11 ( .A(plen[3]), .Y(n6) );
  CLKINVX1 U12 ( .A(n11), .Y(n1) );
  NAND4X1 U13 ( .A(plen[2]), .B(n10), .C(plen[1]), .D(plen[0]), .Y(n9) );
  OAI22XL U14 ( .A0(n4), .A1(n15), .B0(plen[0]), .B1(n2), .Y(n21) );
  NAND2X1 U15 ( .A(ispat), .B(n11), .Y(n16) );
  OA21XL U16 ( .A0(plen[0]), .A1(n2), .B0(n15), .Y(n14) );
  OAI2BB1X1 U17 ( .A0N(plen[2]), .A1N(n12), .B0(n13), .Y(n19) );
  NAND4BX1 U18 ( .AN(plen[2]), .B(n10), .C(plen[1]), .D(plen[0]), .Y(n13) );
  OAI21XL U19 ( .A0(plen[1]), .A1(n2), .B0(n14), .Y(n12) );
  OAI211X1 U20 ( .A0(n17), .A1(scnt[0]), .B0(n7), .C0(isstr), .Y(N20) );
  NAND3BX1 U21 ( .AN(scnt[5]), .B(n7), .C(isstr), .Y(n17) );
  CLKINVX1 U22 ( .A(rst), .Y(n7) );
  CLKINVX1 U23 ( .A(plen[0]), .Y(n4) );
  ADDHXL U24 ( .A(scnt[1]), .B(scnt[0]), .CO(\add_12/carry[2] ), .S(N9) );
  ADDHXL U25 ( .A(scnt[2]), .B(\add_12/carry[2] ), .CO(\add_12/carry[3] ), .S(
        N10) );
  ADDHXL U26 ( .A(scnt[3]), .B(\add_12/carry[3] ), .CO(\add_12/carry[4] ), .S(
        N11) );
  ADDHXL U27 ( .A(scnt[4]), .B(\add_12/carry[4] ), .CO(\add_12/carry[5] ), .S(
        N12) );
  XOR2X1 U28 ( .A(\add_12/carry[5] ), .B(scnt[5]), .Y(N13) );
endmodule


module String ( clk, rst, isstr, scnt, slen, data, .str({\str[39][7] , 
        \str[39][6] , \str[39][5] , \str[39][4] , \str[39][3] , \str[39][2] , 
        \str[39][1] , \str[39][0] , \str[38][7] , \str[38][6] , \str[38][5] , 
        \str[38][4] , \str[38][3] , \str[38][2] , \str[38][1] , \str[38][0] , 
        \str[37][7] , \str[37][6] , \str[37][5] , \str[37][4] , \str[37][3] , 
        \str[37][2] , \str[37][1] , \str[37][0] , \str[36][7] , \str[36][6] , 
        \str[36][5] , \str[36][4] , \str[36][3] , \str[36][2] , \str[36][1] , 
        \str[36][0] , \str[35][7] , \str[35][6] , \str[35][5] , \str[35][4] , 
        \str[35][3] , \str[35][2] , \str[35][1] , \str[35][0] , \str[34][7] , 
        \str[34][6] , \str[34][5] , \str[34][4] , \str[34][3] , \str[34][2] , 
        \str[34][1] , \str[34][0] , \str[33][7] , \str[33][6] , \str[33][5] , 
        \str[33][4] , \str[33][3] , \str[33][2] , \str[33][1] , \str[33][0] , 
        \str[32][7] , \str[32][6] , \str[32][5] , \str[32][4] , \str[32][3] , 
        \str[32][2] , \str[32][1] , \str[32][0] , \str[31][7] , \str[31][6] , 
        \str[31][5] , \str[31][4] , \str[31][3] , \str[31][2] , \str[31][1] , 
        \str[31][0] , \str[30][7] , \str[30][6] , \str[30][5] , \str[30][4] , 
        \str[30][3] , \str[30][2] , \str[30][1] , \str[30][0] , \str[29][7] , 
        \str[29][6] , \str[29][5] , \str[29][4] , \str[29][3] , \str[29][2] , 
        \str[29][1] , \str[29][0] , \str[28][7] , \str[28][6] , \str[28][5] , 
        \str[28][4] , \str[28][3] , \str[28][2] , \str[28][1] , \str[28][0] , 
        \str[27][7] , \str[27][6] , \str[27][5] , \str[27][4] , \str[27][3] , 
        \str[27][2] , \str[27][1] , \str[27][0] , \str[26][7] , \str[26][6] , 
        \str[26][5] , \str[26][4] , \str[26][3] , \str[26][2] , \str[26][1] , 
        \str[26][0] , \str[25][7] , \str[25][6] , \str[25][5] , \str[25][4] , 
        \str[25][3] , \str[25][2] , \str[25][1] , \str[25][0] , \str[24][7] , 
        \str[24][6] , \str[24][5] , \str[24][4] , \str[24][3] , \str[24][2] , 
        \str[24][1] , \str[24][0] , \str[23][7] , \str[23][6] , \str[23][5] , 
        \str[23][4] , \str[23][3] , \str[23][2] , \str[23][1] , \str[23][0] , 
        \str[22][7] , \str[22][6] , \str[22][5] , \str[22][4] , \str[22][3] , 
        \str[22][2] , \str[22][1] , \str[22][0] , \str[21][7] , \str[21][6] , 
        \str[21][5] , \str[21][4] , \str[21][3] , \str[21][2] , \str[21][1] , 
        \str[21][0] , \str[20][7] , \str[20][6] , \str[20][5] , \str[20][4] , 
        \str[20][3] , \str[20][2] , \str[20][1] , \str[20][0] , \str[19][7] , 
        \str[19][6] , \str[19][5] , \str[19][4] , \str[19][3] , \str[19][2] , 
        \str[19][1] , \str[19][0] , \str[18][7] , \str[18][6] , \str[18][5] , 
        \str[18][4] , \str[18][3] , \str[18][2] , \str[18][1] , \str[18][0] , 
        \str[17][7] , \str[17][6] , \str[17][5] , \str[17][4] , \str[17][3] , 
        \str[17][2] , \str[17][1] , \str[17][0] , \str[16][7] , \str[16][6] , 
        \str[16][5] , \str[16][4] , \str[16][3] , \str[16][2] , \str[16][1] , 
        \str[16][0] , \str[15][7] , \str[15][6] , \str[15][5] , \str[15][4] , 
        \str[15][3] , \str[15][2] , \str[15][1] , \str[15][0] , \str[14][7] , 
        \str[14][6] , \str[14][5] , \str[14][4] , \str[14][3] , \str[14][2] , 
        \str[14][1] , \str[14][0] , \str[13][7] , \str[13][6] , \str[13][5] , 
        \str[13][4] , \str[13][3] , \str[13][2] , \str[13][1] , \str[13][0] , 
        \str[12][7] , \str[12][6] , \str[12][5] , \str[12][4] , \str[12][3] , 
        \str[12][2] , \str[12][1] , \str[12][0] , \str[11][7] , \str[11][6] , 
        \str[11][5] , \str[11][4] , \str[11][3] , \str[11][2] , \str[11][1] , 
        \str[11][0] , \str[10][7] , \str[10][6] , \str[10][5] , \str[10][4] , 
        \str[10][3] , \str[10][2] , \str[10][1] , \str[10][0] , \str[9][7] , 
        \str[9][6] , \str[9][5] , \str[9][4] , \str[9][3] , \str[9][2] , 
        \str[9][1] , \str[9][0] , \str[8][7] , \str[8][6] , \str[8][5] , 
        \str[8][4] , \str[8][3] , \str[8][2] , \str[8][1] , \str[8][0] , 
        \str[7][7] , \str[7][6] , \str[7][5] , \str[7][4] , \str[7][3] , 
        \str[7][2] , \str[7][1] , \str[7][0] , \str[6][7] , \str[6][6] , 
        \str[6][5] , \str[6][4] , \str[6][3] , \str[6][2] , \str[6][1] , 
        \str[6][0] , \str[5][7] , \str[5][6] , \str[5][5] , \str[5][4] , 
        \str[5][3] , \str[5][2] , \str[5][1] , \str[5][0] , \str[4][7] , 
        \str[4][6] , \str[4][5] , \str[4][4] , \str[4][3] , \str[4][2] , 
        \str[4][1] , \str[4][0] , \str[3][7] , \str[3][6] , \str[3][5] , 
        \str[3][4] , \str[3][3] , \str[3][2] , \str[3][1] , \str[3][0] , 
        \str[2][7] , \str[2][6] , \str[2][5] , \str[2][4] , \str[2][3] , 
        \str[2][2] , \str[2][1] , \str[2][0] , \str[1][7] , \str[1][6] , 
        \str[1][5] , \str[1][4] , \str[1][3] , \str[1][2] , \str[1][1] , 
        \str[1][0] , \str[0][7] , \str[0][6] , \str[0][5] , \str[0][4] , 
        \str[0][3] , \str[0][2] , \str[0][1] , \str[0][0] }) );
  input [5:0] scnt;
  output [5:0] slen;
  input [7:0] data;
  input clk, rst, isstr;
  output \str[39][7] , \str[39][6] , \str[39][5] , \str[39][4] , \str[39][3] ,
         \str[39][2] , \str[39][1] , \str[39][0] , \str[38][7] , \str[38][6] ,
         \str[38][5] , \str[38][4] , \str[38][3] , \str[38][2] , \str[38][1] ,
         \str[38][0] , \str[37][7] , \str[37][6] , \str[37][5] , \str[37][4] ,
         \str[37][3] , \str[37][2] , \str[37][1] , \str[37][0] , \str[36][7] ,
         \str[36][6] , \str[36][5] , \str[36][4] , \str[36][3] , \str[36][2] ,
         \str[36][1] , \str[36][0] , \str[35][7] , \str[35][6] , \str[35][5] ,
         \str[35][4] , \str[35][3] , \str[35][2] , \str[35][1] , \str[35][0] ,
         \str[34][7] , \str[34][6] , \str[34][5] , \str[34][4] , \str[34][3] ,
         \str[34][2] , \str[34][1] , \str[34][0] , \str[33][7] , \str[33][6] ,
         \str[33][5] , \str[33][4] , \str[33][3] , \str[33][2] , \str[33][1] ,
         \str[33][0] , \str[32][7] , \str[32][6] , \str[32][5] , \str[32][4] ,
         \str[32][3] , \str[32][2] , \str[32][1] , \str[32][0] , \str[31][7] ,
         \str[31][6] , \str[31][5] , \str[31][4] , \str[31][3] , \str[31][2] ,
         \str[31][1] , \str[31][0] , \str[30][7] , \str[30][6] , \str[30][5] ,
         \str[30][4] , \str[30][3] , \str[30][2] , \str[30][1] , \str[30][0] ,
         \str[29][7] , \str[29][6] , \str[29][5] , \str[29][4] , \str[29][3] ,
         \str[29][2] , \str[29][1] , \str[29][0] , \str[28][7] , \str[28][6] ,
         \str[28][5] , \str[28][4] , \str[28][3] , \str[28][2] , \str[28][1] ,
         \str[28][0] , \str[27][7] , \str[27][6] , \str[27][5] , \str[27][4] ,
         \str[27][3] , \str[27][2] , \str[27][1] , \str[27][0] , \str[26][7] ,
         \str[26][6] , \str[26][5] , \str[26][4] , \str[26][3] , \str[26][2] ,
         \str[26][1] , \str[26][0] , \str[25][7] , \str[25][6] , \str[25][5] ,
         \str[25][4] , \str[25][3] , \str[25][2] , \str[25][1] , \str[25][0] ,
         \str[24][7] , \str[24][6] , \str[24][5] , \str[24][4] , \str[24][3] ,
         \str[24][2] , \str[24][1] , \str[24][0] , \str[23][7] , \str[23][6] ,
         \str[23][5] , \str[23][4] , \str[23][3] , \str[23][2] , \str[23][1] ,
         \str[23][0] , \str[22][7] , \str[22][6] , \str[22][5] , \str[22][4] ,
         \str[22][3] , \str[22][2] , \str[22][1] , \str[22][0] , \str[21][7] ,
         \str[21][6] , \str[21][5] , \str[21][4] , \str[21][3] , \str[21][2] ,
         \str[21][1] , \str[21][0] , \str[20][7] , \str[20][6] , \str[20][5] ,
         \str[20][4] , \str[20][3] , \str[20][2] , \str[20][1] , \str[20][0] ,
         \str[19][7] , \str[19][6] , \str[19][5] , \str[19][4] , \str[19][3] ,
         \str[19][2] , \str[19][1] , \str[19][0] , \str[18][7] , \str[18][6] ,
         \str[18][5] , \str[18][4] , \str[18][3] , \str[18][2] , \str[18][1] ,
         \str[18][0] , \str[17][7] , \str[17][6] , \str[17][5] , \str[17][4] ,
         \str[17][3] , \str[17][2] , \str[17][1] , \str[17][0] , \str[16][7] ,
         \str[16][6] , \str[16][5] , \str[16][4] , \str[16][3] , \str[16][2] ,
         \str[16][1] , \str[16][0] , \str[15][7] , \str[15][6] , \str[15][5] ,
         \str[15][4] , \str[15][3] , \str[15][2] , \str[15][1] , \str[15][0] ,
         \str[14][7] , \str[14][6] , \str[14][5] , \str[14][4] , \str[14][3] ,
         \str[14][2] , \str[14][1] , \str[14][0] , \str[13][7] , \str[13][6] ,
         \str[13][5] , \str[13][4] , \str[13][3] , \str[13][2] , \str[13][1] ,
         \str[13][0] , \str[12][7] , \str[12][6] , \str[12][5] , \str[12][4] ,
         \str[12][3] , \str[12][2] , \str[12][1] , \str[12][0] , \str[11][7] ,
         \str[11][6] , \str[11][5] , \str[11][4] , \str[11][3] , \str[11][2] ,
         \str[11][1] , \str[11][0] , \str[10][7] , \str[10][6] , \str[10][5] ,
         \str[10][4] , \str[10][3] , \str[10][2] , \str[10][1] , \str[10][0] ,
         \str[9][7] , \str[9][6] , \str[9][5] , \str[9][4] , \str[9][3] ,
         \str[9][2] , \str[9][1] , \str[9][0] , \str[8][7] , \str[8][6] ,
         \str[8][5] , \str[8][4] , \str[8][3] , \str[8][2] , \str[8][1] ,
         \str[8][0] , \str[7][7] , \str[7][6] , \str[7][5] , \str[7][4] ,
         \str[7][3] , \str[7][2] , \str[7][1] , \str[7][0] , \str[6][7] ,
         \str[6][6] , \str[6][5] , \str[6][4] , \str[6][3] , \str[6][2] ,
         \str[6][1] , \str[6][0] , \str[5][7] , \str[5][6] , \str[5][5] ,
         \str[5][4] , \str[5][3] , \str[5][2] , \str[5][1] , \str[5][0] ,
         \str[4][7] , \str[4][6] , \str[4][5] , \str[4][4] , \str[4][3] ,
         \str[4][2] , \str[4][1] , \str[4][0] , \str[3][7] , \str[3][6] ,
         \str[3][5] , \str[3][4] , \str[3][3] , \str[3][2] , \str[3][1] ,
         \str[3][0] , \str[2][7] , \str[2][6] , \str[2][5] , \str[2][4] ,
         \str[2][3] , \str[2][2] , \str[2][1] , \str[2][0] , \str[1][7] ,
         \str[1][6] , \str[1][5] , \str[1][4] , \str[1][3] , \str[1][2] ,
         \str[1][1] , \str[1][0] , \str[0][7] , \str[0][6] , \str[0][5] ,
         \str[0][4] , \str[0][3] , \str[0][2] , \str[0][1] , \str[0][0] ;
  wire   N61, N62, N63, N64, N65, n11, n12, n13, n14, n15, n16, n26, n27, n33,
         n36, n37, n38, n39, n40, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64,
         n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78,
         n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92,
         n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         \add_18/carry[5] , \add_18/carry[4] , \add_18/carry[3] ,
         \add_18/carry[2] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n28, n29, n30, n31, n32, n34, n35,
         n41, n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116;

  OAI221X2 U15 ( .A0(n37), .A1(n38), .B0(n39), .B1(n40), .C0(n35), .Y(n36) );
  OAI221X2 U16 ( .A0(n37), .A1(n43), .B0(n39), .B1(n44), .C0(n35), .Y(n42) );
  OAI221X2 U17 ( .A0(n37), .A1(n46), .B0(n39), .B1(n47), .C0(n35), .Y(n45) );
  OAI221X2 U18 ( .A0(n37), .A1(n49), .B0(n39), .B1(n50), .C0(n35), .Y(n48) );
  OAI221X2 U19 ( .A0(n37), .A1(n52), .B0(n39), .B1(n53), .C0(n35), .Y(n51) );
  OAI221X2 U20 ( .A0(n37), .A1(n55), .B0(n39), .B1(n56), .C0(n35), .Y(n54) );
  OAI221X2 U21 ( .A0(n37), .A1(n58), .B0(n39), .B1(n59), .C0(n35), .Y(n57) );
  OAI221X2 U22 ( .A0(n37), .A1(n61), .B0(n39), .B1(n62), .C0(n35), .Y(n60) );
  OAI221X2 U25 ( .A0(n38), .A1(n65), .B0(n40), .B1(n66), .C0(n35), .Y(n64) );
  OAI221X2 U26 ( .A0(n43), .A1(n65), .B0(n44), .B1(n66), .C0(n41), .Y(n67) );
  OAI221X2 U27 ( .A0(n46), .A1(n65), .B0(n47), .B1(n66), .C0(n35), .Y(n68) );
  OAI221X2 U28 ( .A0(n49), .A1(n65), .B0(n50), .B1(n66), .C0(n35), .Y(n69) );
  OAI221X2 U29 ( .A0(n52), .A1(n65), .B0(n53), .B1(n66), .C0(n35), .Y(n70) );
  OAI221X2 U30 ( .A0(n55), .A1(n65), .B0(n56), .B1(n66), .C0(n41), .Y(n71) );
  OAI221X2 U31 ( .A0(n58), .A1(n65), .B0(n59), .B1(n66), .C0(n41), .Y(n72) );
  OAI221X2 U32 ( .A0(n61), .A1(n65), .B0(n62), .B1(n66), .C0(n41), .Y(n73) );
  OAI221X2 U35 ( .A0(n38), .A1(n75), .B0(n40), .B1(n76), .C0(n41), .Y(n74) );
  OAI221X2 U36 ( .A0(n43), .A1(n75), .B0(n44), .B1(n76), .C0(n41), .Y(n77) );
  OAI221X2 U37 ( .A0(n46), .A1(n75), .B0(n47), .B1(n76), .C0(n41), .Y(n78) );
  OAI221X2 U38 ( .A0(n49), .A1(n75), .B0(n50), .B1(n76), .C0(n41), .Y(n79) );
  OAI221X2 U39 ( .A0(n52), .A1(n75), .B0(n53), .B1(n76), .C0(n41), .Y(n80) );
  OAI221X2 U40 ( .A0(n55), .A1(n75), .B0(n56), .B1(n76), .C0(n41), .Y(n81) );
  OAI221X2 U41 ( .A0(n58), .A1(n75), .B0(n59), .B1(n76), .C0(n41), .Y(n82) );
  OAI221X2 U42 ( .A0(n61), .A1(n75), .B0(n62), .B1(n76), .C0(n41), .Y(n83) );
  OAI221X2 U45 ( .A0(n38), .A1(n85), .B0(n40), .B1(n86), .C0(n41), .Y(n84) );
  OAI221X2 U46 ( .A0(n43), .A1(n85), .B0(n44), .B1(n86), .C0(n41), .Y(n87) );
  OAI221X2 U47 ( .A0(n46), .A1(n85), .B0(n47), .B1(n86), .C0(n41), .Y(n88) );
  OAI221X2 U48 ( .A0(n49), .A1(n85), .B0(n50), .B1(n86), .C0(n105), .Y(n89) );
  OAI221X2 U49 ( .A0(n52), .A1(n85), .B0(n53), .B1(n86), .C0(n105), .Y(n90) );
  OAI221X2 U50 ( .A0(n55), .A1(n85), .B0(n56), .B1(n86), .C0(n105), .Y(n91) );
  OAI221X2 U51 ( .A0(n58), .A1(n85), .B0(n59), .B1(n86), .C0(n105), .Y(n92) );
  OAI221X2 U52 ( .A0(n61), .A1(n85), .B0(n62), .B1(n86), .C0(n105), .Y(n93) );
  OAI221X2 U55 ( .A0(n38), .A1(n95), .B0(n40), .B1(n96), .C0(n105), .Y(n94) );
  OAI221X2 U58 ( .A0(n43), .A1(n95), .B0(n44), .B1(n96), .C0(n105), .Y(n97) );
  OAI221X2 U61 ( .A0(n46), .A1(n95), .B0(n47), .B1(n96), .C0(n105), .Y(n98) );
  OAI221X2 U64 ( .A0(n49), .A1(n95), .B0(n50), .B1(n96), .C0(n105), .Y(n99) );
  OAI221X2 U67 ( .A0(n52), .A1(n95), .B0(n53), .B1(n96), .C0(n105), .Y(n100)
         );
  OAI221X2 U70 ( .A0(n55), .A1(n95), .B0(n56), .B1(n96), .C0(n105), .Y(n101)
         );
  OAI221X2 U73 ( .A0(n58), .A1(n95), .B0(n59), .B1(n96), .C0(n105), .Y(n102)
         );
  OAI221X2 U84 ( .A0(n61), .A1(n95), .B0(n62), .B1(n96), .C0(n35), .Y(n103) );
  EDFFX1 \slen_reg[4]  ( .D(N64), .E(n114), .CK(clk), .Q(slen[4]), .QN(n12) );
  EDFFX1 \str_reg[39][2]  ( .D(n21), .E(n103), .CK(clk), .Q(\str[39][2] ) );
  EDFFX1 \str_reg[36][2]  ( .D(n20), .E(n100), .CK(clk), .Q(\str[36][2] ) );
  EDFFX1 \str_reg[36][0]  ( .D(n17), .E(n100), .CK(clk), .Q(\str[36][0] ) );
  EDFFX1 \str_reg[38][2]  ( .D(n21), .E(n102), .CK(clk), .Q(\str[38][2] ) );
  EDFFX1 \str_reg[38][0]  ( .D(n10), .E(n102), .CK(clk), .Q(\str[38][0] ) );
  EDFFX1 \str_reg[39][7]  ( .D(n34), .E(n103), .CK(clk), .Q(\str[39][7] ) );
  EDFFX1 \str_reg[39][6]  ( .D(n31), .E(n103), .CK(clk), .Q(\str[39][6] ) );
  EDFFX1 \str_reg[39][5]  ( .D(n28), .E(n103), .CK(clk), .Q(\str[39][5] ) );
  EDFFX1 \str_reg[39][4]  ( .D(n25), .E(n103), .CK(clk), .Q(\str[39][4] ) );
  EDFFX1 \str_reg[39][3]  ( .D(n23), .E(n103), .CK(clk), .Q(\str[39][3] ) );
  EDFFX1 \str_reg[39][1]  ( .D(n19), .E(n103), .CK(clk), .Q(\str[39][1] ) );
  EDFFX1 \str_reg[39][0]  ( .D(n17), .E(n103), .CK(clk), .Q(\str[39][0] ) );
  EDFFX1 \str_reg[34][7]  ( .D(n32), .E(n98), .CK(clk), .Q(\str[34][7] ) );
  EDFFX1 \str_reg[34][6]  ( .D(n30), .E(n98), .CK(clk), .Q(\str[34][6] ) );
  EDFFX1 \str_reg[34][5]  ( .D(n29), .E(n98), .CK(clk), .Q(\str[34][5] ) );
  EDFFX1 \str_reg[34][4]  ( .D(n24), .E(n98), .CK(clk), .Q(\str[34][4] ) );
  EDFFX1 \str_reg[34][3]  ( .D(n22), .E(n98), .CK(clk), .Q(\str[34][3] ) );
  EDFFX1 \str_reg[34][2]  ( .D(n5), .E(n98), .CK(clk), .Q(\str[34][2] ) );
  EDFFX1 \str_reg[34][1]  ( .D(n18), .E(n98), .CK(clk), .Q(\str[34][1] ) );
  EDFFX1 \str_reg[34][0]  ( .D(n10), .E(n98), .CK(clk), .Q(\str[34][0] ) );
  EDFFX1 \str_reg[33][7]  ( .D(n34), .E(n97), .CK(clk), .Q(\str[33][7] ) );
  EDFFX1 \str_reg[33][6]  ( .D(n31), .E(n97), .CK(clk), .Q(\str[33][6] ) );
  EDFFX1 \str_reg[33][5]  ( .D(n28), .E(n97), .CK(clk), .Q(\str[33][5] ) );
  EDFFX1 \str_reg[33][4]  ( .D(n25), .E(n97), .CK(clk), .Q(\str[33][4] ) );
  EDFFX1 \str_reg[33][3]  ( .D(n23), .E(n97), .CK(clk), .Q(\str[33][3] ) );
  EDFFX1 \str_reg[33][2]  ( .D(n5), .E(n97), .CK(clk), .Q(\str[33][2] ) );
  EDFFX1 \str_reg[33][1]  ( .D(n19), .E(n97), .CK(clk), .Q(\str[33][1] ) );
  EDFFX1 \str_reg[33][0]  ( .D(n17), .E(n97), .CK(clk), .Q(\str[33][0] ) );
  EDFFX1 \str_reg[35][7]  ( .D(n9), .E(n99), .CK(clk), .Q(\str[35][7] ) );
  EDFFX1 \str_reg[35][6]  ( .D(n8), .E(n99), .CK(clk), .Q(\str[35][6] ) );
  EDFFX1 \str_reg[35][5]  ( .D(n29), .E(n99), .CK(clk), .Q(\str[35][5] ) );
  EDFFX1 \str_reg[35][4]  ( .D(n7), .E(n99), .CK(clk), .Q(\str[35][4] ) );
  EDFFX1 \str_reg[35][3]  ( .D(n6), .E(n99), .CK(clk), .Q(\str[35][3] ) );
  EDFFX1 \str_reg[35][2]  ( .D(n5), .E(n99), .CK(clk), .Q(\str[35][2] ) );
  EDFFX1 \str_reg[35][1]  ( .D(n4), .E(n99), .CK(clk), .Q(\str[35][1] ) );
  EDFFX1 \str_reg[35][0]  ( .D(n1), .E(n99), .CK(clk), .Q(\str[35][0] ) );
  EDFFX1 \str_reg[37][7]  ( .D(n9), .E(n101), .CK(clk), .Q(\str[37][7] ) );
  EDFFX1 \str_reg[37][6]  ( .D(n8), .E(n101), .CK(clk), .Q(\str[37][6] ) );
  EDFFX1 \str_reg[37][5]  ( .D(n113), .E(n101), .CK(clk), .Q(\str[37][5] ) );
  EDFFX1 \str_reg[37][4]  ( .D(n7), .E(n101), .CK(clk), .Q(\str[37][4] ) );
  EDFFX1 \str_reg[37][3]  ( .D(n6), .E(n101), .CK(clk), .Q(\str[37][3] ) );
  EDFFX1 \str_reg[37][2]  ( .D(n5), .E(n101), .CK(clk), .Q(\str[37][2] ) );
  EDFFX1 \str_reg[37][1]  ( .D(n4), .E(n101), .CK(clk), .Q(\str[37][1] ) );
  EDFFX1 \str_reg[37][0]  ( .D(n1), .E(n101), .CK(clk), .Q(\str[37][0] ) );
  EDFFX1 \str_reg[36][7]  ( .D(n9), .E(n100), .CK(clk), .Q(\str[36][7] ) );
  EDFFX1 \str_reg[36][6]  ( .D(n8), .E(n100), .CK(clk), .Q(\str[36][6] ) );
  EDFFX1 \str_reg[36][5]  ( .D(n113), .E(n100), .CK(clk), .Q(\str[36][5] ) );
  EDFFX1 \str_reg[36][4]  ( .D(n7), .E(n100), .CK(clk), .Q(\str[36][4] ) );
  EDFFX1 \str_reg[36][3]  ( .D(n6), .E(n100), .CK(clk), .Q(\str[36][3] ) );
  EDFFX1 \str_reg[36][1]  ( .D(n4), .E(n100), .CK(clk), .Q(\str[36][1] ) );
  EDFFX1 \str_reg[38][7]  ( .D(n9), .E(n102), .CK(clk), .Q(\str[38][7] ) );
  EDFFX1 \str_reg[38][6]  ( .D(n8), .E(n102), .CK(clk), .Q(\str[38][6] ) );
  EDFFX1 \str_reg[38][5]  ( .D(n113), .E(n102), .CK(clk), .Q(\str[38][5] ) );
  EDFFX1 \str_reg[38][4]  ( .D(n7), .E(n102), .CK(clk), .Q(\str[38][4] ) );
  EDFFX1 \str_reg[38][3]  ( .D(n6), .E(n102), .CK(clk), .Q(\str[38][3] ) );
  EDFFX1 \str_reg[38][1]  ( .D(n4), .E(n102), .CK(clk), .Q(\str[38][1] ) );
  EDFFX1 \str_reg[0][7]  ( .D(n9), .E(n36), .CK(clk), .Q(\str[0][7] ) );
  EDFFX1 \str_reg[0][6]  ( .D(n8), .E(n36), .CK(clk), .Q(\str[0][6] ) );
  EDFFX1 \str_reg[0][5]  ( .D(n3), .E(n36), .CK(clk), .Q(\str[0][5] ) );
  EDFFX1 \str_reg[0][4]  ( .D(n7), .E(n36), .CK(clk), .Q(\str[0][4] ) );
  EDFFX1 \str_reg[0][3]  ( .D(n6), .E(n36), .CK(clk), .Q(\str[0][3] ) );
  EDFFX1 \str_reg[0][2]  ( .D(n5), .E(n36), .CK(clk), .Q(\str[0][2] ) );
  EDFFX1 \str_reg[0][1]  ( .D(n4), .E(n36), .CK(clk), .Q(\str[0][1] ) );
  EDFFX1 \str_reg[4][7]  ( .D(n34), .E(n51), .CK(clk), .Q(\str[4][7] ) );
  EDFFX1 \str_reg[4][6]  ( .D(n31), .E(n51), .CK(clk), .Q(\str[4][6] ) );
  EDFFX1 \str_reg[4][5]  ( .D(n29), .E(n51), .CK(clk), .Q(\str[4][5] ) );
  EDFFX1 \str_reg[4][4]  ( .D(n25), .E(n51), .CK(clk), .Q(\str[4][4] ) );
  EDFFX1 \str_reg[4][3]  ( .D(n23), .E(n51), .CK(clk), .Q(\str[4][3] ) );
  EDFFX1 \str_reg[4][2]  ( .D(n21), .E(n51), .CK(clk), .Q(\str[4][2] ) );
  EDFFX1 \str_reg[4][1]  ( .D(n19), .E(n51), .CK(clk), .Q(\str[4][1] ) );
  EDFFX1 \str_reg[4][0]  ( .D(n17), .E(n51), .CK(clk), .Q(\str[4][0] ) );
  EDFFX1 \str_reg[6][7]  ( .D(n34), .E(n57), .CK(clk), .Q(\str[6][7] ) );
  EDFFX1 \str_reg[6][6]  ( .D(n31), .E(n57), .CK(clk), .Q(\str[6][6] ) );
  EDFFX1 \str_reg[6][5]  ( .D(n29), .E(n57), .CK(clk), .Q(\str[6][5] ) );
  EDFFX1 \str_reg[6][4]  ( .D(n25), .E(n57), .CK(clk), .Q(\str[6][4] ) );
  EDFFX1 \str_reg[6][3]  ( .D(n23), .E(n57), .CK(clk), .Q(\str[6][3] ) );
  EDFFX1 \str_reg[6][2]  ( .D(n21), .E(n57), .CK(clk), .Q(\str[6][2] ) );
  EDFFX1 \str_reg[6][1]  ( .D(n19), .E(n57), .CK(clk), .Q(\str[6][1] ) );
  EDFFX1 \str_reg[6][0]  ( .D(n17), .E(n57), .CK(clk), .Q(\str[6][0] ) );
  EDFFX1 \str_reg[5][7]  ( .D(n34), .E(n54), .CK(clk), .Q(\str[5][7] ) );
  EDFFX1 \str_reg[5][6]  ( .D(n31), .E(n54), .CK(clk), .Q(\str[5][6] ) );
  EDFFX1 \str_reg[5][5]  ( .D(n29), .E(n54), .CK(clk), .Q(\str[5][5] ) );
  EDFFX1 \str_reg[5][4]  ( .D(n25), .E(n54), .CK(clk), .Q(\str[5][4] ) );
  EDFFX1 \str_reg[5][3]  ( .D(n23), .E(n54), .CK(clk), .Q(\str[5][3] ) );
  EDFFX1 \str_reg[5][2]  ( .D(n21), .E(n54), .CK(clk), .Q(\str[5][2] ) );
  EDFFX1 \str_reg[5][1]  ( .D(n19), .E(n54), .CK(clk), .Q(\str[5][1] ) );
  EDFFX1 \str_reg[5][0]  ( .D(n17), .E(n54), .CK(clk), .Q(\str[5][0] ) );
  EDFFX1 \str_reg[1][7]  ( .D(n9), .E(n42), .CK(clk), .Q(\str[1][7] ) );
  EDFFX1 \str_reg[1][6]  ( .D(n8), .E(n42), .CK(clk), .Q(\str[1][6] ) );
  EDFFX1 \str_reg[1][5]  ( .D(n29), .E(n42), .CK(clk), .Q(\str[1][5] ) );
  EDFFX1 \str_reg[1][4]  ( .D(n7), .E(n42), .CK(clk), .Q(\str[1][4] ) );
  EDFFX1 \str_reg[1][3]  ( .D(n6), .E(n42), .CK(clk), .Q(\str[1][3] ) );
  EDFFX1 \str_reg[1][2]  ( .D(n5), .E(n42), .CK(clk), .Q(\str[1][2] ) );
  EDFFX1 \str_reg[1][1]  ( .D(n4), .E(n42), .CK(clk), .Q(\str[1][1] ) );
  EDFFX1 \str_reg[1][0]  ( .D(n17), .E(n42), .CK(clk), .Q(\str[1][0] ) );
  EDFFX1 \str_reg[3][7]  ( .D(n9), .E(n48), .CK(clk), .Q(\str[3][7] ) );
  EDFFX1 \str_reg[3][6]  ( .D(n8), .E(n48), .CK(clk), .Q(\str[3][6] ) );
  EDFFX1 \str_reg[3][5]  ( .D(n28), .E(n48), .CK(clk), .Q(\str[3][5] ) );
  EDFFX1 \str_reg[3][4]  ( .D(n7), .E(n48), .CK(clk), .Q(\str[3][4] ) );
  EDFFX1 \str_reg[3][3]  ( .D(n6), .E(n48), .CK(clk), .Q(\str[3][3] ) );
  EDFFX1 \str_reg[3][2]  ( .D(n5), .E(n48), .CK(clk), .Q(\str[3][2] ) );
  EDFFX1 \str_reg[3][1]  ( .D(n4), .E(n48), .CK(clk), .Q(\str[3][1] ) );
  EDFFX1 \str_reg[3][0]  ( .D(n10), .E(n48), .CK(clk), .Q(\str[3][0] ) );
  EDFFX1 \str_reg[2][7]  ( .D(n9), .E(n45), .CK(clk), .Q(\str[2][7] ) );
  EDFFX1 \str_reg[2][6]  ( .D(n8), .E(n45), .CK(clk), .Q(\str[2][6] ) );
  EDFFX1 \str_reg[2][5]  ( .D(n29), .E(n45), .CK(clk), .Q(\str[2][5] ) );
  EDFFX1 \str_reg[2][4]  ( .D(n7), .E(n45), .CK(clk), .Q(\str[2][4] ) );
  EDFFX1 \str_reg[2][3]  ( .D(n6), .E(n45), .CK(clk), .Q(\str[2][3] ) );
  EDFFX1 \str_reg[2][2]  ( .D(n5), .E(n45), .CK(clk), .Q(\str[2][2] ) );
  EDFFX1 \str_reg[2][1]  ( .D(n4), .E(n45), .CK(clk), .Q(\str[2][1] ) );
  EDFFX1 \str_reg[2][0]  ( .D(n17), .E(n45), .CK(clk), .Q(\str[2][0] ) );
  DFFQX1 \str_reg[0][0]  ( .D(n104), .CK(clk), .Q(\str[0][0] ) );
  EDFFX1 \str_reg[28][7]  ( .D(n9), .E(n90), .CK(clk), .Q(\str[28][7] ) );
  EDFFX1 \str_reg[28][6]  ( .D(n8), .E(n90), .CK(clk), .Q(\str[28][6] ) );
  EDFFX1 \str_reg[28][5]  ( .D(n113), .E(n90), .CK(clk), .Q(\str[28][5] ) );
  EDFFX1 \str_reg[28][4]  ( .D(n7), .E(n90), .CK(clk), .Q(\str[28][4] ) );
  EDFFX1 \str_reg[28][3]  ( .D(n6), .E(n90), .CK(clk), .Q(\str[28][3] ) );
  EDFFX1 \str_reg[28][2]  ( .D(n5), .E(n90), .CK(clk), .Q(\str[28][2] ) );
  EDFFX1 \str_reg[28][1]  ( .D(n4), .E(n90), .CK(clk), .Q(\str[28][1] ) );
  EDFFX1 \str_reg[28][0]  ( .D(n1), .E(n90), .CK(clk), .Q(\str[28][0] ) );
  EDFFX1 \str_reg[12][7]  ( .D(n34), .E(n70), .CK(clk), .Q(\str[12][7] ) );
  EDFFX1 \str_reg[12][6]  ( .D(n31), .E(n70), .CK(clk), .Q(\str[12][6] ) );
  EDFFX1 \str_reg[12][5]  ( .D(n29), .E(n70), .CK(clk), .Q(\str[12][5] ) );
  EDFFX1 \str_reg[12][4]  ( .D(n25), .E(n70), .CK(clk), .Q(\str[12][4] ) );
  EDFFX1 \str_reg[12][3]  ( .D(n23), .E(n70), .CK(clk), .Q(\str[12][3] ) );
  EDFFX1 \str_reg[12][2]  ( .D(n21), .E(n70), .CK(clk), .Q(\str[12][2] ) );
  EDFFX1 \str_reg[12][1]  ( .D(n19), .E(n70), .CK(clk), .Q(\str[12][1] ) );
  EDFFX1 \str_reg[12][0]  ( .D(n17), .E(n70), .CK(clk), .Q(\str[12][0] ) );
  EDFFX1 \str_reg[17][7]  ( .D(n32), .E(n77), .CK(clk), .Q(\str[17][7] ) );
  EDFFX1 \str_reg[17][6]  ( .D(n30), .E(n77), .CK(clk), .Q(\str[17][6] ) );
  EDFFX1 \str_reg[17][5]  ( .D(n28), .E(n77), .CK(clk), .Q(\str[17][5] ) );
  EDFFX1 \str_reg[17][4]  ( .D(n24), .E(n77), .CK(clk), .Q(\str[17][4] ) );
  EDFFX1 \str_reg[17][3]  ( .D(n22), .E(n77), .CK(clk), .Q(\str[17][3] ) );
  EDFFX1 \str_reg[17][2]  ( .D(n20), .E(n77), .CK(clk), .Q(\str[17][2] ) );
  EDFFX1 \str_reg[17][1]  ( .D(n18), .E(n77), .CK(clk), .Q(\str[17][1] ) );
  EDFFX1 \str_reg[17][0]  ( .D(n10), .E(n77), .CK(clk), .Q(\str[17][0] ) );
  EDFFX1 \str_reg[25][7]  ( .D(n32), .E(n87), .CK(clk), .Q(\str[25][7] ) );
  EDFFX1 \str_reg[25][6]  ( .D(n30), .E(n87), .CK(clk), .Q(\str[25][6] ) );
  EDFFX1 \str_reg[25][5]  ( .D(n28), .E(n87), .CK(clk), .Q(\str[25][5] ) );
  EDFFX1 \str_reg[25][4]  ( .D(n24), .E(n87), .CK(clk), .Q(\str[25][4] ) );
  EDFFX1 \str_reg[25][3]  ( .D(n22), .E(n87), .CK(clk), .Q(\str[25][3] ) );
  EDFFX1 \str_reg[25][2]  ( .D(n20), .E(n87), .CK(clk), .Q(\str[25][2] ) );
  EDFFX1 \str_reg[25][1]  ( .D(n18), .E(n87), .CK(clk), .Q(\str[25][1] ) );
  EDFFX1 \str_reg[25][0]  ( .D(n10), .E(n87), .CK(clk), .Q(\str[25][0] ) );
  EDFFX1 \str_reg[22][7]  ( .D(n32), .E(n82), .CK(clk), .Q(\str[22][7] ) );
  EDFFX1 \str_reg[22][6]  ( .D(n30), .E(n82), .CK(clk), .Q(\str[22][6] ) );
  EDFFX1 \str_reg[22][5]  ( .D(n28), .E(n82), .CK(clk), .Q(\str[22][5] ) );
  EDFFX1 \str_reg[22][4]  ( .D(n24), .E(n82), .CK(clk), .Q(\str[22][4] ) );
  EDFFX1 \str_reg[22][3]  ( .D(n22), .E(n82), .CK(clk), .Q(\str[22][3] ) );
  EDFFX1 \str_reg[22][2]  ( .D(n20), .E(n82), .CK(clk), .Q(\str[22][2] ) );
  EDFFX1 \str_reg[22][1]  ( .D(n18), .E(n82), .CK(clk), .Q(\str[22][1] ) );
  EDFFX1 \str_reg[22][0]  ( .D(n10), .E(n82), .CK(clk), .Q(\str[22][0] ) );
  EDFFX1 \str_reg[14][7]  ( .D(n34), .E(n72), .CK(clk), .Q(\str[14][7] ) );
  EDFFX1 \str_reg[14][6]  ( .D(n31), .E(n72), .CK(clk), .Q(\str[14][6] ) );
  EDFFX1 \str_reg[14][5]  ( .D(n29), .E(n72), .CK(clk), .Q(\str[14][5] ) );
  EDFFX1 \str_reg[14][4]  ( .D(n25), .E(n72), .CK(clk), .Q(\str[14][4] ) );
  EDFFX1 \str_reg[14][3]  ( .D(n23), .E(n72), .CK(clk), .Q(\str[14][3] ) );
  EDFFX1 \str_reg[14][2]  ( .D(n21), .E(n72), .CK(clk), .Q(\str[14][2] ) );
  EDFFX1 \str_reg[14][1]  ( .D(n19), .E(n72), .CK(clk), .Q(\str[14][1] ) );
  EDFFX1 \str_reg[14][0]  ( .D(n17), .E(n72), .CK(clk), .Q(\str[14][0] ) );
  EDFFX1 \str_reg[29][7]  ( .D(n9), .E(n91), .CK(clk), .Q(\str[29][7] ) );
  EDFFX1 \str_reg[29][6]  ( .D(n8), .E(n91), .CK(clk), .Q(\str[29][6] ) );
  EDFFX1 \str_reg[29][5]  ( .D(n113), .E(n91), .CK(clk), .Q(\str[29][5] ) );
  EDFFX1 \str_reg[29][4]  ( .D(n7), .E(n91), .CK(clk), .Q(\str[29][4] ) );
  EDFFX1 \str_reg[29][3]  ( .D(n6), .E(n91), .CK(clk), .Q(\str[29][3] ) );
  EDFFX1 \str_reg[29][2]  ( .D(n5), .E(n91), .CK(clk), .Q(\str[29][2] ) );
  EDFFX1 \str_reg[29][1]  ( .D(n4), .E(n91), .CK(clk), .Q(\str[29][1] ) );
  EDFFX1 \str_reg[29][0]  ( .D(n1), .E(n91), .CK(clk), .Q(\str[29][0] ) );
  EDFFX1 \str_reg[21][7]  ( .D(n32), .E(n81), .CK(clk), .Q(\str[21][7] ) );
  EDFFX1 \str_reg[21][6]  ( .D(n30), .E(n81), .CK(clk), .Q(\str[21][6] ) );
  EDFFX1 \str_reg[21][5]  ( .D(n28), .E(n81), .CK(clk), .Q(\str[21][5] ) );
  EDFFX1 \str_reg[21][4]  ( .D(n24), .E(n81), .CK(clk), .Q(\str[21][4] ) );
  EDFFX1 \str_reg[21][3]  ( .D(n22), .E(n81), .CK(clk), .Q(\str[21][3] ) );
  EDFFX1 \str_reg[21][2]  ( .D(n20), .E(n81), .CK(clk), .Q(\str[21][2] ) );
  EDFFX1 \str_reg[21][1]  ( .D(n18), .E(n81), .CK(clk), .Q(\str[21][1] ) );
  EDFFX1 \str_reg[21][0]  ( .D(n10), .E(n81), .CK(clk), .Q(\str[21][0] ) );
  EDFFX1 \str_reg[30][7]  ( .D(n9), .E(n92), .CK(clk), .Q(\str[30][7] ) );
  EDFFX1 \str_reg[30][6]  ( .D(n8), .E(n92), .CK(clk), .Q(\str[30][6] ) );
  EDFFX1 \str_reg[30][5]  ( .D(n28), .E(n92), .CK(clk), .Q(\str[30][5] ) );
  EDFFX1 \str_reg[30][4]  ( .D(n7), .E(n92), .CK(clk), .Q(\str[30][4] ) );
  EDFFX1 \str_reg[30][3]  ( .D(n6), .E(n92), .CK(clk), .Q(\str[30][3] ) );
  EDFFX1 \str_reg[30][2]  ( .D(n5), .E(n92), .CK(clk), .Q(\str[30][2] ) );
  EDFFX1 \str_reg[30][1]  ( .D(n4), .E(n92), .CK(clk), .Q(\str[30][1] ) );
  EDFFX1 \str_reg[30][0]  ( .D(n10), .E(n92), .CK(clk), .Q(\str[30][0] ) );
  EDFFX1 \str_reg[13][7]  ( .D(n34), .E(n71), .CK(clk), .Q(\str[13][7] ) );
  EDFFX1 \str_reg[13][6]  ( .D(n31), .E(n71), .CK(clk), .Q(\str[13][6] ) );
  EDFFX1 \str_reg[13][5]  ( .D(n29), .E(n71), .CK(clk), .Q(\str[13][5] ) );
  EDFFX1 \str_reg[13][4]  ( .D(n25), .E(n71), .CK(clk), .Q(\str[13][4] ) );
  EDFFX1 \str_reg[13][3]  ( .D(n23), .E(n71), .CK(clk), .Q(\str[13][3] ) );
  EDFFX1 \str_reg[13][2]  ( .D(n21), .E(n71), .CK(clk), .Q(\str[13][2] ) );
  EDFFX1 \str_reg[13][1]  ( .D(n19), .E(n71), .CK(clk), .Q(\str[13][1] ) );
  EDFFX1 \str_reg[13][0]  ( .D(n17), .E(n71), .CK(clk), .Q(\str[13][0] ) );
  EDFFX1 \str_reg[9][7]  ( .D(n34), .E(n67), .CK(clk), .Q(\str[9][7] ) );
  EDFFX1 \str_reg[9][6]  ( .D(n31), .E(n67), .CK(clk), .Q(\str[9][6] ) );
  EDFFX1 \str_reg[9][5]  ( .D(n29), .E(n67), .CK(clk), .Q(\str[9][5] ) );
  EDFFX1 \str_reg[9][4]  ( .D(n25), .E(n67), .CK(clk), .Q(\str[9][4] ) );
  EDFFX1 \str_reg[9][3]  ( .D(n23), .E(n67), .CK(clk), .Q(\str[9][3] ) );
  EDFFX1 \str_reg[9][2]  ( .D(n21), .E(n67), .CK(clk), .Q(\str[9][2] ) );
  EDFFX1 \str_reg[9][1]  ( .D(n19), .E(n67), .CK(clk), .Q(\str[9][1] ) );
  EDFFX1 \str_reg[9][0]  ( .D(n17), .E(n67), .CK(clk), .Q(\str[9][0] ) );
  EDFFX1 \str_reg[10][7]  ( .D(n34), .E(n68), .CK(clk), .Q(\str[10][7] ) );
  EDFFX1 \str_reg[10][6]  ( .D(n31), .E(n68), .CK(clk), .Q(\str[10][6] ) );
  EDFFX1 \str_reg[10][5]  ( .D(n29), .E(n68), .CK(clk), .Q(\str[10][5] ) );
  EDFFX1 \str_reg[10][4]  ( .D(n25), .E(n68), .CK(clk), .Q(\str[10][4] ) );
  EDFFX1 \str_reg[10][3]  ( .D(n23), .E(n68), .CK(clk), .Q(\str[10][3] ) );
  EDFFX1 \str_reg[10][2]  ( .D(n21), .E(n68), .CK(clk), .Q(\str[10][2] ) );
  EDFFX1 \str_reg[10][1]  ( .D(n19), .E(n68), .CK(clk), .Q(\str[10][1] ) );
  EDFFX1 \str_reg[10][0]  ( .D(n17), .E(n68), .CK(clk), .Q(\str[10][0] ) );
  EDFFX1 \str_reg[26][7]  ( .D(n32), .E(n88), .CK(clk), .Q(\str[26][7] ) );
  EDFFX1 \str_reg[26][6]  ( .D(n30), .E(n88), .CK(clk), .Q(\str[26][6] ) );
  EDFFX1 \str_reg[26][5]  ( .D(n28), .E(n88), .CK(clk), .Q(\str[26][5] ) );
  EDFFX1 \str_reg[26][4]  ( .D(n24), .E(n88), .CK(clk), .Q(\str[26][4] ) );
  EDFFX1 \str_reg[26][3]  ( .D(n22), .E(n88), .CK(clk), .Q(\str[26][3] ) );
  EDFFX1 \str_reg[26][2]  ( .D(n20), .E(n88), .CK(clk), .Q(\str[26][2] ) );
  EDFFX1 \str_reg[26][1]  ( .D(n18), .E(n88), .CK(clk), .Q(\str[26][1] ) );
  EDFFX1 \str_reg[26][0]  ( .D(n10), .E(n88), .CK(clk), .Q(\str[26][0] ) );
  EDFFX1 \str_reg[18][7]  ( .D(n32), .E(n78), .CK(clk), .Q(\str[18][7] ) );
  EDFFX1 \str_reg[18][6]  ( .D(n30), .E(n78), .CK(clk), .Q(\str[18][6] ) );
  EDFFX1 \str_reg[18][5]  ( .D(n28), .E(n78), .CK(clk), .Q(\str[18][5] ) );
  EDFFX1 \str_reg[18][4]  ( .D(n24), .E(n78), .CK(clk), .Q(\str[18][4] ) );
  EDFFX1 \str_reg[18][3]  ( .D(n22), .E(n78), .CK(clk), .Q(\str[18][3] ) );
  EDFFX1 \str_reg[18][2]  ( .D(n20), .E(n78), .CK(clk), .Q(\str[18][2] ) );
  EDFFX1 \str_reg[18][1]  ( .D(n18), .E(n78), .CK(clk), .Q(\str[18][1] ) );
  EDFFX1 \str_reg[18][0]  ( .D(n10), .E(n78), .CK(clk), .Q(\str[18][0] ) );
  EDFFX1 \str_reg[20][7]  ( .D(n32), .E(n80), .CK(clk), .Q(\str[20][7] ) );
  EDFFX1 \str_reg[20][6]  ( .D(n30), .E(n80), .CK(clk), .Q(\str[20][6] ) );
  EDFFX1 \str_reg[20][5]  ( .D(n28), .E(n80), .CK(clk), .Q(\str[20][5] ) );
  EDFFX1 \str_reg[20][4]  ( .D(n24), .E(n80), .CK(clk), .Q(\str[20][4] ) );
  EDFFX1 \str_reg[20][3]  ( .D(n22), .E(n80), .CK(clk), .Q(\str[20][3] ) );
  EDFFX1 \str_reg[20][2]  ( .D(n20), .E(n80), .CK(clk), .Q(\str[20][2] ) );
  EDFFX1 \str_reg[20][1]  ( .D(n18), .E(n80), .CK(clk), .Q(\str[20][1] ) );
  EDFFX1 \str_reg[20][0]  ( .D(n10), .E(n80), .CK(clk), .Q(\str[20][0] ) );
  EDFFX1 \str_reg[32][7]  ( .D(n9), .E(n94), .CK(clk), .Q(\str[32][7] ) );
  EDFFX1 \str_reg[32][6]  ( .D(n8), .E(n94), .CK(clk), .Q(\str[32][6] ) );
  EDFFX1 \str_reg[32][5]  ( .D(n29), .E(n94), .CK(clk), .Q(\str[32][5] ) );
  EDFFX1 \str_reg[32][4]  ( .D(n7), .E(n94), .CK(clk), .Q(\str[32][4] ) );
  EDFFX1 \str_reg[32][3]  ( .D(n6), .E(n94), .CK(clk), .Q(\str[32][3] ) );
  EDFFX1 \str_reg[32][2]  ( .D(n5), .E(n94), .CK(clk), .Q(\str[32][2] ) );
  EDFFX1 \str_reg[32][1]  ( .D(n4), .E(n94), .CK(clk), .Q(\str[32][1] ) );
  EDFFX1 \str_reg[32][0]  ( .D(n17), .E(n94), .CK(clk), .Q(\str[32][0] ) );
  EDFFX1 \str_reg[23][7]  ( .D(n32), .E(n83), .CK(clk), .Q(\str[23][7] ) );
  EDFFX1 \str_reg[23][6]  ( .D(n30), .E(n83), .CK(clk), .Q(\str[23][6] ) );
  EDFFX1 \str_reg[23][5]  ( .D(n28), .E(n83), .CK(clk), .Q(\str[23][5] ) );
  EDFFX1 \str_reg[23][4]  ( .D(n24), .E(n83), .CK(clk), .Q(\str[23][4] ) );
  EDFFX1 \str_reg[23][3]  ( .D(n22), .E(n83), .CK(clk), .Q(\str[23][3] ) );
  EDFFX1 \str_reg[23][2]  ( .D(n20), .E(n83), .CK(clk), .Q(\str[23][2] ) );
  EDFFX1 \str_reg[23][1]  ( .D(n18), .E(n83), .CK(clk), .Q(\str[23][1] ) );
  EDFFX1 \str_reg[23][0]  ( .D(n10), .E(n83), .CK(clk), .Q(\str[23][0] ) );
  EDFFX1 \str_reg[7][7]  ( .D(n34), .E(n60), .CK(clk), .Q(\str[7][7] ) );
  EDFFX1 \str_reg[7][6]  ( .D(n31), .E(n60), .CK(clk), .Q(\str[7][6] ) );
  EDFFX1 \str_reg[7][5]  ( .D(n29), .E(n60), .CK(clk), .Q(\str[7][5] ) );
  EDFFX1 \str_reg[7][4]  ( .D(n25), .E(n60), .CK(clk), .Q(\str[7][4] ) );
  EDFFX1 \str_reg[7][3]  ( .D(n23), .E(n60), .CK(clk), .Q(\str[7][3] ) );
  EDFFX1 \str_reg[7][2]  ( .D(n21), .E(n60), .CK(clk), .Q(\str[7][2] ) );
  EDFFX1 \str_reg[7][1]  ( .D(n19), .E(n60), .CK(clk), .Q(\str[7][1] ) );
  EDFFX1 \str_reg[7][0]  ( .D(n17), .E(n60), .CK(clk), .Q(\str[7][0] ) );
  EDFFX1 \str_reg[16][7]  ( .D(n32), .E(n74), .CK(clk), .Q(\str[16][7] ) );
  EDFFX1 \str_reg[16][6]  ( .D(n30), .E(n74), .CK(clk), .Q(\str[16][6] ) );
  EDFFX1 \str_reg[16][5]  ( .D(n28), .E(n74), .CK(clk), .Q(\str[16][5] ) );
  EDFFX1 \str_reg[16][4]  ( .D(n24), .E(n74), .CK(clk), .Q(\str[16][4] ) );
  EDFFX1 \str_reg[16][3]  ( .D(n22), .E(n74), .CK(clk), .Q(\str[16][3] ) );
  EDFFX1 \str_reg[16][2]  ( .D(n20), .E(n74), .CK(clk), .Q(\str[16][2] ) );
  EDFFX1 \str_reg[16][1]  ( .D(n18), .E(n74), .CK(clk), .Q(\str[16][1] ) );
  EDFFX1 \str_reg[16][0]  ( .D(n10), .E(n74), .CK(clk), .Q(\str[16][0] ) );
  EDFFX1 \str_reg[31][7]  ( .D(n9), .E(n93), .CK(clk), .Q(\str[31][7] ) );
  EDFFX1 \str_reg[31][6]  ( .D(n8), .E(n93), .CK(clk), .Q(\str[31][6] ) );
  EDFFX1 \str_reg[31][5]  ( .D(n28), .E(n93), .CK(clk), .Q(\str[31][5] ) );
  EDFFX1 \str_reg[31][4]  ( .D(n7), .E(n93), .CK(clk), .Q(\str[31][4] ) );
  EDFFX1 \str_reg[31][3]  ( .D(n6), .E(n93), .CK(clk), .Q(\str[31][3] ) );
  EDFFX1 \str_reg[31][2]  ( .D(n5), .E(n93), .CK(clk), .Q(\str[31][2] ) );
  EDFFX1 \str_reg[31][1]  ( .D(n4), .E(n93), .CK(clk), .Q(\str[31][1] ) );
  EDFFX1 \str_reg[31][0]  ( .D(n10), .E(n93), .CK(clk), .Q(\str[31][0] ) );
  EDFFX1 \str_reg[24][7]  ( .D(n32), .E(n84), .CK(clk), .Q(\str[24][7] ) );
  EDFFX1 \str_reg[24][6]  ( .D(n30), .E(n84), .CK(clk), .Q(\str[24][6] ) );
  EDFFX1 \str_reg[24][5]  ( .D(n28), .E(n84), .CK(clk), .Q(\str[24][5] ) );
  EDFFX1 \str_reg[24][4]  ( .D(n24), .E(n84), .CK(clk), .Q(\str[24][4] ) );
  EDFFX1 \str_reg[24][3]  ( .D(n22), .E(n84), .CK(clk), .Q(\str[24][3] ) );
  EDFFX1 \str_reg[24][2]  ( .D(n20), .E(n84), .CK(clk), .Q(\str[24][2] ) );
  EDFFX1 \str_reg[24][1]  ( .D(n18), .E(n84), .CK(clk), .Q(\str[24][1] ) );
  EDFFX1 \str_reg[24][0]  ( .D(n10), .E(n84), .CK(clk), .Q(\str[24][0] ) );
  EDFFX1 \str_reg[15][7]  ( .D(n34), .E(n73), .CK(clk), .Q(\str[15][7] ) );
  EDFFX1 \str_reg[15][6]  ( .D(n31), .E(n73), .CK(clk), .Q(\str[15][6] ) );
  EDFFX1 \str_reg[15][5]  ( .D(n29), .E(n73), .CK(clk), .Q(\str[15][5] ) );
  EDFFX1 \str_reg[15][4]  ( .D(n25), .E(n73), .CK(clk), .Q(\str[15][4] ) );
  EDFFX1 \str_reg[15][3]  ( .D(n23), .E(n73), .CK(clk), .Q(\str[15][3] ) );
  EDFFX1 \str_reg[15][2]  ( .D(n21), .E(n73), .CK(clk), .Q(\str[15][2] ) );
  EDFFX1 \str_reg[15][1]  ( .D(n19), .E(n73), .CK(clk), .Q(\str[15][1] ) );
  EDFFX1 \str_reg[15][0]  ( .D(n17), .E(n73), .CK(clk), .Q(\str[15][0] ) );
  EDFFX1 \str_reg[8][7]  ( .D(n34), .E(n64), .CK(clk), .Q(\str[8][7] ) );
  EDFFX1 \str_reg[8][6]  ( .D(n31), .E(n64), .CK(clk), .Q(\str[8][6] ) );
  EDFFX1 \str_reg[8][5]  ( .D(n29), .E(n64), .CK(clk), .Q(\str[8][5] ) );
  EDFFX1 \str_reg[8][4]  ( .D(n25), .E(n64), .CK(clk), .Q(\str[8][4] ) );
  EDFFX1 \str_reg[8][3]  ( .D(n23), .E(n64), .CK(clk), .Q(\str[8][3] ) );
  EDFFX1 \str_reg[8][2]  ( .D(n21), .E(n64), .CK(clk), .Q(\str[8][2] ) );
  EDFFX1 \str_reg[8][1]  ( .D(n19), .E(n64), .CK(clk), .Q(\str[8][1] ) );
  EDFFX1 \str_reg[8][0]  ( .D(n17), .E(n64), .CK(clk), .Q(\str[8][0] ) );
  EDFFX1 \str_reg[27][7]  ( .D(n32), .E(n89), .CK(clk), .Q(\str[27][7] ) );
  EDFFX1 \str_reg[27][6]  ( .D(n30), .E(n89), .CK(clk), .Q(\str[27][6] ) );
  EDFFX1 \str_reg[27][5]  ( .D(n28), .E(n89), .CK(clk), .Q(\str[27][5] ) );
  EDFFX1 \str_reg[27][4]  ( .D(n24), .E(n89), .CK(clk), .Q(\str[27][4] ) );
  EDFFX1 \str_reg[27][3]  ( .D(n22), .E(n89), .CK(clk), .Q(\str[27][3] ) );
  EDFFX1 \str_reg[27][2]  ( .D(n20), .E(n89), .CK(clk), .Q(\str[27][2] ) );
  EDFFX1 \str_reg[27][1]  ( .D(n18), .E(n89), .CK(clk), .Q(\str[27][1] ) );
  EDFFX1 \str_reg[27][0]  ( .D(n10), .E(n89), .CK(clk), .Q(\str[27][0] ) );
  EDFFX1 \str_reg[11][7]  ( .D(n34), .E(n69), .CK(clk), .Q(\str[11][7] ) );
  EDFFX1 \str_reg[11][6]  ( .D(n31), .E(n69), .CK(clk), .Q(\str[11][6] ) );
  EDFFX1 \str_reg[11][5]  ( .D(n29), .E(n69), .CK(clk), .Q(\str[11][5] ) );
  EDFFX1 \str_reg[11][4]  ( .D(n25), .E(n69), .CK(clk), .Q(\str[11][4] ) );
  EDFFX1 \str_reg[11][3]  ( .D(n23), .E(n69), .CK(clk), .Q(\str[11][3] ) );
  EDFFX1 \str_reg[11][2]  ( .D(n21), .E(n69), .CK(clk), .Q(\str[11][2] ) );
  EDFFX1 \str_reg[11][1]  ( .D(n19), .E(n69), .CK(clk), .Q(\str[11][1] ) );
  EDFFX1 \str_reg[11][0]  ( .D(n17), .E(n69), .CK(clk), .Q(\str[11][0] ) );
  EDFFX1 \str_reg[19][7]  ( .D(n32), .E(n79), .CK(clk), .Q(\str[19][7] ) );
  EDFFX1 \str_reg[19][6]  ( .D(n30), .E(n79), .CK(clk), .Q(\str[19][6] ) );
  EDFFX1 \str_reg[19][5]  ( .D(n28), .E(n79), .CK(clk), .Q(\str[19][5] ) );
  EDFFX1 \str_reg[19][4]  ( .D(n24), .E(n79), .CK(clk), .Q(\str[19][4] ) );
  EDFFX1 \str_reg[19][3]  ( .D(n22), .E(n79), .CK(clk), .Q(\str[19][3] ) );
  EDFFX1 \str_reg[19][2]  ( .D(n20), .E(n79), .CK(clk), .Q(\str[19][2] ) );
  EDFFX1 \str_reg[19][1]  ( .D(n18), .E(n79), .CK(clk), .Q(\str[19][1] ) );
  EDFFX1 \str_reg[19][0]  ( .D(n10), .E(n79), .CK(clk), .Q(\str[19][0] ) );
  EDFFX1 \slen_reg[5]  ( .D(N65), .E(n114), .CK(clk), .Q(slen[5]), .QN(n11) );
  EDFFX1 \slen_reg[3]  ( .D(N63), .E(n114), .CK(clk), .Q(slen[3]), .QN(n13) );
  EDFFX1 \slen_reg[1]  ( .D(N61), .E(n114), .CK(clk), .Q(slen[1]), .QN(n15) );
  EDFFX1 \slen_reg[2]  ( .D(N62), .E(n114), .CK(clk), .Q(slen[2]), .QN(n14) );
  CLKMX2X2 \slen_reg[0]/U3  ( .A(slen[0]), .B(n107), .S0(n114), .Y(n2) );
  DFFX2 \slen_reg[0]  ( .D(n2), .CK(clk), .Q(slen[0]), .QN(n16) );
  OAI21X1 U3 ( .A0(n26), .A1(n116), .B0(n105), .Y(n1) );
  CLKINVX1 U4 ( .A(n33), .Y(n113) );
  CLKINVX1 U5 ( .A(rst), .Y(n115) );
  CLKINVX1 U6 ( .A(scnt[5]), .Y(n108) );
  CLKBUFX3 U7 ( .A(n113), .Y(n29) );
  CLKBUFX3 U8 ( .A(n113), .Y(n28) );
  CLKBUFX3 U9 ( .A(n1), .Y(n17) );
  CLKBUFX3 U10 ( .A(n1), .Y(n10) );
  NAND4X2 U11 ( .A(n114), .B(n110), .C(n109), .D(n108), .Y(n39) );
  INVX3 U12 ( .A(n26), .Y(n114) );
  CLKBUFX3 U13 ( .A(n115), .Y(n35) );
  CLKBUFX3 U14 ( .A(n115), .Y(n41) );
  CLKBUFX3 U23 ( .A(n115), .Y(n105) );
  CLKBUFX3 U24 ( .A(n4), .Y(n19) );
  CLKBUFX3 U33 ( .A(n5), .Y(n21) );
  CLKBUFX3 U34 ( .A(n6), .Y(n23) );
  CLKBUFX3 U43 ( .A(n7), .Y(n25) );
  CLKBUFX3 U44 ( .A(n8), .Y(n31) );
  CLKBUFX3 U53 ( .A(n9), .Y(n34) );
  CLKBUFX3 U54 ( .A(n4), .Y(n18) );
  CLKBUFX3 U56 ( .A(n5), .Y(n20) );
  CLKBUFX3 U57 ( .A(n6), .Y(n22) );
  CLKBUFX3 U59 ( .A(n7), .Y(n24) );
  CLKBUFX3 U60 ( .A(n8), .Y(n30) );
  CLKBUFX3 U62 ( .A(n9), .Y(n32) );
  NAND2X1 U63 ( .A(n33), .B(n35), .Y(n3) );
  NAND3X1 U65 ( .A(n112), .B(n111), .C(n107), .Y(n40) );
  NAND4X2 U66 ( .A(slen[3]), .B(n63), .C(n12), .D(n11), .Y(n65) );
  NAND4X2 U68 ( .A(slen[4]), .B(n63), .C(n13), .D(n11), .Y(n75) );
  NAND4X2 U69 ( .A(slen[5]), .B(n63), .C(n13), .D(n12), .Y(n95) );
  NAND4X2 U71 ( .A(slen[4]), .B(slen[3]), .C(n63), .D(n11), .Y(n85) );
  NAND4X2 U72 ( .A(scnt[4]), .B(scnt[3]), .C(n114), .D(n108), .Y(n86) );
  NAND4X2 U74 ( .A(scnt[3]), .B(n114), .C(n109), .D(n108), .Y(n66) );
  NAND4X2 U75 ( .A(scnt[4]), .B(n114), .C(n110), .D(n108), .Y(n76) );
  NAND4X2 U76 ( .A(scnt[5]), .B(n114), .C(n110), .D(n109), .Y(n96) );
  NAND4X2 U77 ( .A(n63), .B(n13), .C(n12), .D(n11), .Y(n37) );
  NOR2X2 U78 ( .A(isstr), .B(rst), .Y(n63) );
  NAND2X1 U79 ( .A(isstr), .B(n35), .Y(n26) );
  OAI31XL U80 ( .A0(n116), .A1(n106), .A2(n26), .B0(n27), .Y(n104) );
  NAND2X1 U81 ( .A(\str[0][0] ), .B(n106), .Y(n27) );
  CLKINVX1 U82 ( .A(n36), .Y(n106) );
  AND2X2 U83 ( .A(data[1]), .B(n114), .Y(n4) );
  AND2X2 U85 ( .A(data[2]), .B(n114), .Y(n5) );
  AND2X2 U86 ( .A(data[3]), .B(n114), .Y(n6) );
  AND2X2 U87 ( .A(data[4]), .B(n114), .Y(n7) );
  AND2X2 U88 ( .A(data[6]), .B(n114), .Y(n8) );
  AND2X2 U89 ( .A(data[7]), .B(n114), .Y(n9) );
  AOI21X1 U90 ( .A0(data[5]), .A1(n114), .B0(n63), .Y(n33) );
  CLKINVX1 U91 ( .A(data[0]), .Y(n116) );
  CLKINVX1 U92 ( .A(scnt[0]), .Y(n107) );
  CLKINVX1 U93 ( .A(scnt[2]), .Y(n111) );
  CLKINVX1 U94 ( .A(scnt[1]), .Y(n112) );
  NAND3X1 U95 ( .A(scnt[0]), .B(n111), .C(scnt[1]), .Y(n50) );
  NAND3X1 U96 ( .A(scnt[0]), .B(n112), .C(scnt[2]), .Y(n56) );
  NAND3X1 U97 ( .A(scnt[1]), .B(n107), .C(scnt[2]), .Y(n59) );
  NAND3X1 U98 ( .A(scnt[1]), .B(scnt[0]), .C(scnt[2]), .Y(n62) );
  NAND3X1 U99 ( .A(n112), .B(n111), .C(scnt[0]), .Y(n44) );
  NAND3X1 U100 ( .A(n107), .B(n112), .C(scnt[2]), .Y(n53) );
  NAND3X1 U101 ( .A(n107), .B(n111), .C(scnt[1]), .Y(n47) );
  NAND3X1 U102 ( .A(slen[0]), .B(n14), .C(slen[1]), .Y(n49) );
  NAND3X1 U103 ( .A(slen[0]), .B(n15), .C(slen[2]), .Y(n55) );
  NAND3X1 U104 ( .A(slen[1]), .B(n16), .C(slen[2]), .Y(n58) );
  NAND3X1 U105 ( .A(slen[1]), .B(slen[0]), .C(slen[2]), .Y(n61) );
  NAND3X1 U106 ( .A(n15), .B(n14), .C(slen[0]), .Y(n43) );
  NAND3X1 U107 ( .A(n16), .B(n15), .C(slen[2]), .Y(n52) );
  NAND3X1 U108 ( .A(n16), .B(n14), .C(slen[1]), .Y(n46) );
  NAND3X1 U109 ( .A(n15), .B(n14), .C(n16), .Y(n38) );
  CLKINVX1 U110 ( .A(scnt[4]), .Y(n109) );
  CLKINVX1 U111 ( .A(scnt[3]), .Y(n110) );
  ADDHXL U112 ( .A(scnt[1]), .B(scnt[0]), .CO(\add_18/carry[2] ), .S(N61) );
  ADDHXL U113 ( .A(scnt[2]), .B(\add_18/carry[2] ), .CO(\add_18/carry[3] ), 
        .S(N62) );
  ADDHXL U114 ( .A(scnt[3]), .B(\add_18/carry[3] ), .CO(\add_18/carry[4] ), 
        .S(N63) );
  ADDHXL U115 ( .A(scnt[4]), .B(\add_18/carry[4] ), .CO(\add_18/carry[5] ), 
        .S(N64) );
  XOR2X1 U116 ( .A(\add_18/carry[5] ), .B(scnt[5]), .Y(N65) );
endmodule


module Pattern ( clk, ctrlsig, ispat, plen, data, .pat({\pat[7][7] , 
        \pat[7][6] , \pat[7][5] , \pat[7][4] , \pat[7][3] , \pat[7][2] , 
        \pat[7][1] , \pat[7][0] , \pat[6][7] , \pat[6][6] , \pat[6][5] , 
        \pat[6][4] , \pat[6][3] , \pat[6][2] , \pat[6][1] , \pat[6][0] , 
        \pat[5][7] , \pat[5][6] , \pat[5][5] , \pat[5][4] , \pat[5][3] , 
        \pat[5][2] , \pat[5][1] , \pat[5][0] , \pat[4][7] , \pat[4][6] , 
        \pat[4][5] , \pat[4][4] , \pat[4][3] , \pat[4][2] , \pat[4][1] , 
        \pat[4][0] , \pat[3][7] , \pat[3][6] , \pat[3][5] , \pat[3][4] , 
        \pat[3][3] , \pat[3][2] , \pat[3][1] , \pat[3][0] , \pat[2][7] , 
        \pat[2][6] , \pat[2][5] , \pat[2][4] , \pat[2][3] , \pat[2][2] , 
        \pat[2][1] , \pat[2][0] , \pat[1][7] , \pat[1][6] , \pat[1][5] , 
        \pat[1][4] , \pat[1][3] , \pat[1][2] , \pat[1][1] , \pat[1][0] , 
        \pat[0][7] , \pat[0][6] , \pat[0][5] , \pat[0][4] , \pat[0][3] , 
        \pat[0][2] , \pat[0][1] , \pat[0][0] }), patmask, starsig, staridx, 
        pcnt_clr );
  input [3:0] plen;
  input [7:0] data;
  output [7:0] patmask;
  output [3:0] staridx;
  input clk, ctrlsig, ispat, pcnt_clr;
  output \pat[7][7] , \pat[7][6] , \pat[7][5] , \pat[7][4] , \pat[7][3] ,
         \pat[7][2] , \pat[7][1] , \pat[7][0] , \pat[6][7] , \pat[6][6] ,
         \pat[6][5] , \pat[6][4] , \pat[6][3] , \pat[6][2] , \pat[6][1] ,
         \pat[6][0] , \pat[5][7] , \pat[5][6] , \pat[5][5] , \pat[5][4] ,
         \pat[5][3] , \pat[5][2] , \pat[5][1] , \pat[5][0] , \pat[4][7] ,
         \pat[4][6] , \pat[4][5] , \pat[4][4] , \pat[4][3] , \pat[4][2] ,
         \pat[4][1] , \pat[4][0] , \pat[3][7] , \pat[3][6] , \pat[3][5] ,
         \pat[3][4] , \pat[3][3] , \pat[3][2] , \pat[3][1] , \pat[3][0] ,
         \pat[2][7] , \pat[2][6] , \pat[2][5] , \pat[2][4] , \pat[2][3] ,
         \pat[2][2] , \pat[2][1] , \pat[2][0] , \pat[1][7] , \pat[1][6] ,
         \pat[1][5] , \pat[1][4] , \pat[1][3] , \pat[1][2] , \pat[1][1] ,
         \pat[1][0] , \pat[0][7] , \pat[0][6] , \pat[0][5] , \pat[0][4] ,
         \pat[0][3] , \pat[0][2] , \pat[0][1] , \pat[0][0] , starsig;
  wire   n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n36,
         n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n1,
         n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n28, n29,
         n30, n31, n32, n33;

  DFFQX1 \staridx_reg[3]  ( .D(n49), .CK(clk), .Q(staridx[3]) );
  DFFQX1 \staridx_reg[2]  ( .D(n48), .CK(clk), .Q(staridx[2]) );
  DFFQX1 \staridx_reg[1]  ( .D(n47), .CK(clk), .Q(staridx[1]) );
  DFFQX1 \staridx_reg[0]  ( .D(n46), .CK(clk), .Q(staridx[0]) );
  EDFFX1 \patmask_reg[7]  ( .D(n28), .E(n27), .CK(clk), .Q(patmask[7]) );
  EDFFX1 \patmask_reg[3]  ( .D(n28), .E(n23), .CK(clk), .Q(patmask[3]) );
  EDFFX1 \patmask_reg[6]  ( .D(n28), .E(n10), .CK(clk), .Q(patmask[6]) );
  EDFFX1 \patmask_reg[2]  ( .D(n28), .E(n13), .CK(clk), .Q(patmask[2]) );
  EDFFX1 \patmask_reg[5]  ( .D(n28), .E(n11), .CK(clk), .Q(patmask[5]) );
  EDFFX1 \patmask_reg[4]  ( .D(n28), .E(n12), .CK(clk), .Q(patmask[4]) );
  EDFFX1 \patmask_reg[1]  ( .D(n28), .E(n14), .CK(clk), .Q(patmask[1]) );
  EDFFX1 \patmask_reg[0]  ( .D(n28), .E(n20), .CK(clk), .Q(patmask[0]) );
  DFFQX1 starsig_reg ( .D(n45), .CK(clk), .Q(starsig) );
  EDFFX1 \pat_reg[1][3]  ( .D(n6), .E(n14), .CK(clk), .Q(\pat[1][3] ) );
  EDFFX1 \pat_reg[4][0]  ( .D(n2), .E(n12), .CK(clk), .Q(\pat[4][0] ) );
  EDFFX1 \pat_reg[5][0]  ( .D(n2), .E(n11), .CK(clk), .Q(\pat[5][0] ) );
  EDFFX1 \pat_reg[6][0]  ( .D(n2), .E(n10), .CK(clk), .Q(\pat[6][0] ) );
  EDFFX1 \pat_reg[7][0]  ( .D(n2), .E(n27), .CK(clk), .Q(\pat[7][0] ) );
  EDFFX1 \pat_reg[3][5]  ( .D(n1), .E(n23), .CK(clk), .Q(\pat[3][5] ) );
  EDFFX1 \pat_reg[4][5]  ( .D(n1), .E(n12), .CK(clk), .Q(\pat[4][5] ) );
  EDFFX1 \pat_reg[5][5]  ( .D(n1), .E(n11), .CK(clk), .Q(\pat[5][5] ) );
  EDFFX1 \pat_reg[6][5]  ( .D(n1), .E(n10), .CK(clk), .Q(\pat[6][5] ) );
  EDFFX1 \pat_reg[3][3]  ( .D(n6), .E(n23), .CK(clk), .Q(\pat[3][3] ) );
  EDFFX1 \pat_reg[7][5]  ( .D(n1), .E(n27), .CK(clk), .Q(\pat[7][5] ) );
  EDFFX1 \pat_reg[4][1]  ( .D(n4), .E(n12), .CK(clk), .Q(\pat[4][1] ) );
  EDFFX1 \pat_reg[5][1]  ( .D(n4), .E(n11), .CK(clk), .Q(\pat[5][1] ) );
  EDFFX1 \pat_reg[6][1]  ( .D(n4), .E(n10), .CK(clk), .Q(\pat[6][1] ) );
  EDFFX1 \pat_reg[5][2]  ( .D(n5), .E(n11), .CK(clk), .Q(\pat[5][2] ) );
  EDFFX1 \pat_reg[7][1]  ( .D(n4), .E(n27), .CK(clk), .Q(\pat[7][1] ) );
  EDFFX1 \pat_reg[4][3]  ( .D(n6), .E(n12), .CK(clk), .Q(\pat[4][3] ) );
  EDFFX1 \pat_reg[5][3]  ( .D(n6), .E(n11), .CK(clk), .Q(\pat[5][3] ) );
  EDFFX1 \pat_reg[6][3]  ( .D(n6), .E(n10), .CK(clk), .Q(\pat[6][3] ) );
  EDFFX1 \pat_reg[7][3]  ( .D(n6), .E(n27), .CK(clk), .Q(\pat[7][3] ) );
  EDFFX1 \pat_reg[1][0]  ( .D(n2), .E(n14), .CK(clk), .Q(\pat[1][0] ) );
  EDFFX1 \pat_reg[1][6]  ( .D(n8), .E(n14), .CK(clk), .Q(\pat[1][6] ) );
  EDFFX1 \pat_reg[1][7]  ( .D(n3), .E(n14), .CK(clk), .Q(\pat[1][7] ) );
  EDFFX1 \pat_reg[1][4]  ( .D(n7), .E(n14), .CK(clk), .Q(\pat[1][4] ) );
  EDFFX1 \pat_reg[2][0]  ( .D(n2), .E(n13), .CK(clk), .Q(\pat[2][0] ) );
  EDFFX1 \pat_reg[2][6]  ( .D(n8), .E(n13), .CK(clk), .Q(\pat[2][6] ) );
  EDFFX1 \pat_reg[2][7]  ( .D(n3), .E(n13), .CK(clk), .Q(\pat[2][7] ) );
  EDFFX1 \pat_reg[2][4]  ( .D(n7), .E(n13), .CK(clk), .Q(\pat[2][4] ) );
  EDFFX1 \pat_reg[1][5]  ( .D(n1), .E(n14), .CK(clk), .Q(\pat[1][5] ) );
  EDFFX1 \pat_reg[1][1]  ( .D(n4), .E(n14), .CK(clk), .Q(\pat[1][1] ) );
  EDFFX1 \pat_reg[3][0]  ( .D(n2), .E(n23), .CK(clk), .Q(\pat[3][0] ) );
  EDFFX1 \pat_reg[1][2]  ( .D(n5), .E(n14), .CK(clk), .Q(\pat[1][2] ) );
  EDFFX1 \pat_reg[2][5]  ( .D(n1), .E(n13), .CK(clk), .Q(\pat[2][5] ) );
  EDFFX1 \pat_reg[3][6]  ( .D(n8), .E(n23), .CK(clk), .Q(\pat[3][6] ) );
  EDFFX1 \pat_reg[3][7]  ( .D(n3), .E(n23), .CK(clk), .Q(\pat[3][7] ) );
  EDFFX1 \pat_reg[3][4]  ( .D(n7), .E(n23), .CK(clk), .Q(\pat[3][4] ) );
  EDFFX1 \pat_reg[2][1]  ( .D(n4), .E(n13), .CK(clk), .Q(\pat[2][1] ) );
  EDFFX1 \pat_reg[2][2]  ( .D(n5), .E(n13), .CK(clk), .Q(\pat[2][2] ) );
  EDFFX1 \pat_reg[4][6]  ( .D(n8), .E(n12), .CK(clk), .Q(\pat[4][6] ) );
  EDFFX1 \pat_reg[5][6]  ( .D(n8), .E(n11), .CK(clk), .Q(\pat[5][6] ) );
  EDFFX1 \pat_reg[6][6]  ( .D(n8), .E(n10), .CK(clk), .Q(\pat[6][6] ) );
  EDFFX1 \pat_reg[4][7]  ( .D(n3), .E(n12), .CK(clk), .Q(\pat[4][7] ) );
  EDFFX1 \pat_reg[2][3]  ( .D(n6), .E(n13), .CK(clk), .Q(\pat[2][3] ) );
  EDFFX1 \pat_reg[5][7]  ( .D(n3), .E(n11), .CK(clk), .Q(\pat[5][7] ) );
  EDFFX1 \pat_reg[4][4]  ( .D(n7), .E(n12), .CK(clk), .Q(\pat[4][4] ) );
  EDFFX1 \pat_reg[5][4]  ( .D(n7), .E(n11), .CK(clk), .Q(\pat[5][4] ) );
  EDFFX1 \pat_reg[6][7]  ( .D(n3), .E(n10), .CK(clk), .Q(\pat[6][7] ) );
  EDFFX1 \pat_reg[6][4]  ( .D(n7), .E(n10), .CK(clk), .Q(\pat[6][4] ) );
  EDFFX1 \pat_reg[7][6]  ( .D(n8), .E(n27), .CK(clk), .Q(\pat[7][6] ) );
  EDFFX1 \pat_reg[7][7]  ( .D(n3), .E(n27), .CK(clk), .Q(\pat[7][7] ) );
  EDFFX1 \pat_reg[7][4]  ( .D(n7), .E(n27), .CK(clk), .Q(\pat[7][4] ) );
  EDFFX1 \pat_reg[3][1]  ( .D(n4), .E(n23), .CK(clk), .Q(\pat[3][1] ) );
  EDFFX1 \pat_reg[3][2]  ( .D(n5), .E(n23), .CK(clk), .Q(\pat[3][2] ) );
  EDFFX1 \pat_reg[4][2]  ( .D(n5), .E(n12), .CK(clk), .Q(\pat[4][2] ) );
  EDFFX1 \pat_reg[6][2]  ( .D(n5), .E(n10), .CK(clk), .Q(\pat[6][2] ) );
  EDFFX1 \pat_reg[7][2]  ( .D(n5), .E(n27), .CK(clk), .Q(\pat[7][2] ) );
  EDFFX1 \pat_reg[0][1]  ( .D(n4), .E(n20), .CK(clk), .Q(\pat[0][1] ) );
  EDFFX1 \pat_reg[0][7]  ( .D(n3), .E(n20), .CK(clk), .Q(\pat[0][7] ) );
  EDFFX1 \pat_reg[0][6]  ( .D(n8), .E(n20), .CK(clk), .Q(\pat[0][6] ) );
  EDFFX1 \pat_reg[0][5]  ( .D(n1), .E(n20), .CK(clk), .Q(\pat[0][5] ) );
  EDFFX1 \pat_reg[0][4]  ( .D(n7), .E(n20), .CK(clk), .Q(\pat[0][4] ) );
  EDFFX1 \pat_reg[0][3]  ( .D(n6), .E(n20), .CK(clk), .Q(\pat[0][3] ) );
  EDFFX1 \pat_reg[0][2]  ( .D(n5), .E(n20), .CK(clk), .Q(\pat[0][2] ) );
  EDFFX1 \pat_reg[0][0]  ( .D(n2), .E(n20), .CK(clk), .Q(\pat[0][0] ) );
  OA21X2 U3 ( .A0(n40), .A1(data[5]), .B0(n28), .Y(n1) );
  OAI31X4 U4 ( .A0(n36), .A1(plen[1]), .A2(plen[0]), .B0(n9), .Y(n20) );
  NOR2X2 U5 ( .A(n41), .B(n40), .Y(n39) );
  NOR2BX1 U6 ( .AN(n9), .B(n16), .Y(n15) );
  INVX3 U7 ( .A(n41), .Y(n28) );
  CLKBUFX3 U8 ( .A(n17), .Y(n9) );
  NOR2BX1 U9 ( .AN(ctrlsig), .B(pcnt_clr), .Y(n17) );
  NOR4BBX1 U10 ( .AN(n42), .BN(data[2]), .C(data[7]), .D(data[0]), .Y(n40) );
  OAI33X1 U11 ( .A0(n43), .A1(n33), .A2(n31), .B0(n44), .B1(data[1]), .B2(n32), 
        .Y(n42) );
  NAND3X1 U12 ( .A(data[1]), .B(n32), .C(data[3]), .Y(n43) );
  CLKINVX1 U13 ( .A(data[5]), .Y(n32) );
  AND2X2 U14 ( .A(data[0]), .B(n39), .Y(n2) );
  AND2X2 U15 ( .A(data[7]), .B(n39), .Y(n3) );
  NAND3BX1 U16 ( .AN(data[3]), .B(n33), .C(n31), .Y(n44) );
  CLKINVX1 U17 ( .A(data[6]), .Y(n31) );
  NOR4BBX2 U18 ( .AN(n18), .BN(n19), .C(data[2]), .D(data[0]), .Y(n16) );
  NOR3X1 U19 ( .A(data[4]), .B(data[7]), .C(data[6]), .Y(n18) );
  AND4X1 U20 ( .A(n9), .B(data[1]), .C(data[3]), .D(data[5]), .Y(n19) );
  NAND2X1 U21 ( .A(ispat), .B(n9), .Y(n41) );
  NAND2X1 U22 ( .A(n37), .B(plen[2]), .Y(n38) );
  NAND2BX1 U23 ( .AN(plen[2]), .B(n37), .Y(n36) );
  AND2X2 U24 ( .A(n39), .B(data[1]), .Y(n4) );
  AND2X2 U25 ( .A(n39), .B(data[2]), .Y(n5) );
  AND2X2 U26 ( .A(n39), .B(data[3]), .Y(n6) );
  AND2X2 U27 ( .A(n39), .B(data[4]), .Y(n7) );
  AND2X2 U28 ( .A(n39), .B(data[6]), .Y(n8) );
  NOR2X1 U29 ( .A(n41), .B(plen[3]), .Y(n37) );
  CLKINVX1 U30 ( .A(data[4]), .Y(n33) );
  AO22X1 U31 ( .A0(n16), .A1(plen[0]), .B0(staridx[0]), .B1(n15), .Y(n46) );
  AO22X1 U32 ( .A0(n16), .A1(plen[1]), .B0(staridx[1]), .B1(n15), .Y(n47) );
  AO22X1 U33 ( .A0(n16), .A1(plen[2]), .B0(staridx[2]), .B1(n15), .Y(n48) );
  AO22X1 U34 ( .A0(n16), .A1(plen[3]), .B0(staridx[3]), .B1(n15), .Y(n49) );
  AO21X1 U35 ( .A0(starsig), .A1(n15), .B0(n16), .Y(n45) );
  CLKBUFX3 U36 ( .A(n22), .Y(n13) );
  OAI31XL U37 ( .A0(n36), .A1(plen[0]), .A2(n30), .B0(n9), .Y(n22) );
  CLKBUFX3 U38 ( .A(n26), .Y(n10) );
  OAI31XL U39 ( .A0(n38), .A1(plen[0]), .A2(n30), .B0(n9), .Y(n26) );
  CLKBUFX3 U40 ( .A(n24), .Y(n12) );
  OAI31XL U41 ( .A0(n38), .A1(plen[1]), .A2(plen[0]), .B0(n9), .Y(n24) );
  CLKBUFX3 U42 ( .A(n21), .Y(n14) );
  OAI31XL U43 ( .A0(n36), .A1(plen[1]), .A2(n29), .B0(n9), .Y(n21) );
  CLKBUFX3 U44 ( .A(n25), .Y(n11) );
  OAI31XL U45 ( .A0(n38), .A1(plen[1]), .A2(n29), .B0(n9), .Y(n25) );
  CLKINVX1 U46 ( .A(plen[0]), .Y(n29) );
  CLKINVX1 U47 ( .A(plen[1]), .Y(n30) );
  OAI31X4 U48 ( .A0(n38), .A1(n29), .A2(n30), .B0(n9), .Y(n27) );
  OAI31X4 U49 ( .A0(n36), .A1(n29), .A2(n30), .B0(n9), .Y(n23) );
endmodule


module Match ( clk, ctrlsig, starsig, .str({\str[39][7] , \str[39][6] , 
        \str[39][5] , \str[39][4] , \str[39][3] , \str[39][2] , \str[39][1] , 
        \str[39][0] , \str[38][7] , \str[38][6] , \str[38][5] , \str[38][4] , 
        \str[38][3] , \str[38][2] , \str[38][1] , \str[38][0] , \str[37][7] , 
        \str[37][6] , \str[37][5] , \str[37][4] , \str[37][3] , \str[37][2] , 
        \str[37][1] , \str[37][0] , \str[36][7] , \str[36][6] , \str[36][5] , 
        \str[36][4] , \str[36][3] , \str[36][2] , \str[36][1] , \str[36][0] , 
        \str[35][7] , \str[35][6] , \str[35][5] , \str[35][4] , \str[35][3] , 
        \str[35][2] , \str[35][1] , \str[35][0] , \str[34][7] , \str[34][6] , 
        \str[34][5] , \str[34][4] , \str[34][3] , \str[34][2] , \str[34][1] , 
        \str[34][0] , \str[33][7] , \str[33][6] , \str[33][5] , \str[33][4] , 
        \str[33][3] , \str[33][2] , \str[33][1] , \str[33][0] , \str[32][7] , 
        \str[32][6] , \str[32][5] , \str[32][4] , \str[32][3] , \str[32][2] , 
        \str[32][1] , \str[32][0] , \str[31][7] , \str[31][6] , \str[31][5] , 
        \str[31][4] , \str[31][3] , \str[31][2] , \str[31][1] , \str[31][0] , 
        \str[30][7] , \str[30][6] , \str[30][5] , \str[30][4] , \str[30][3] , 
        \str[30][2] , \str[30][1] , \str[30][0] , \str[29][7] , \str[29][6] , 
        \str[29][5] , \str[29][4] , \str[29][3] , \str[29][2] , \str[29][1] , 
        \str[29][0] , \str[28][7] , \str[28][6] , \str[28][5] , \str[28][4] , 
        \str[28][3] , \str[28][2] , \str[28][1] , \str[28][0] , \str[27][7] , 
        \str[27][6] , \str[27][5] , \str[27][4] , \str[27][3] , \str[27][2] , 
        \str[27][1] , \str[27][0] , \str[26][7] , \str[26][6] , \str[26][5] , 
        \str[26][4] , \str[26][3] , \str[26][2] , \str[26][1] , \str[26][0] , 
        \str[25][7] , \str[25][6] , \str[25][5] , \str[25][4] , \str[25][3] , 
        \str[25][2] , \str[25][1] , \str[25][0] , \str[24][7] , \str[24][6] , 
        \str[24][5] , \str[24][4] , \str[24][3] , \str[24][2] , \str[24][1] , 
        \str[24][0] , \str[23][7] , \str[23][6] , \str[23][5] , \str[23][4] , 
        \str[23][3] , \str[23][2] , \str[23][1] , \str[23][0] , \str[22][7] , 
        \str[22][6] , \str[22][5] , \str[22][4] , \str[22][3] , \str[22][2] , 
        \str[22][1] , \str[22][0] , \str[21][7] , \str[21][6] , \str[21][5] , 
        \str[21][4] , \str[21][3] , \str[21][2] , \str[21][1] , \str[21][0] , 
        \str[20][7] , \str[20][6] , \str[20][5] , \str[20][4] , \str[20][3] , 
        \str[20][2] , \str[20][1] , \str[20][0] , \str[19][7] , \str[19][6] , 
        \str[19][5] , \str[19][4] , \str[19][3] , \str[19][2] , \str[19][1] , 
        \str[19][0] , \str[18][7] , \str[18][6] , \str[18][5] , \str[18][4] , 
        \str[18][3] , \str[18][2] , \str[18][1] , \str[18][0] , \str[17][7] , 
        \str[17][6] , \str[17][5] , \str[17][4] , \str[17][3] , \str[17][2] , 
        \str[17][1] , \str[17][0] , \str[16][7] , \str[16][6] , \str[16][5] , 
        \str[16][4] , \str[16][3] , \str[16][2] , \str[16][1] , \str[16][0] , 
        \str[15][7] , \str[15][6] , \str[15][5] , \str[15][4] , \str[15][3] , 
        \str[15][2] , \str[15][1] , \str[15][0] , \str[14][7] , \str[14][6] , 
        \str[14][5] , \str[14][4] , \str[14][3] , \str[14][2] , \str[14][1] , 
        \str[14][0] , \str[13][7] , \str[13][6] , \str[13][5] , \str[13][4] , 
        \str[13][3] , \str[13][2] , \str[13][1] , \str[13][0] , \str[12][7] , 
        \str[12][6] , \str[12][5] , \str[12][4] , \str[12][3] , \str[12][2] , 
        \str[12][1] , \str[12][0] , \str[11][7] , \str[11][6] , \str[11][5] , 
        \str[11][4] , \str[11][3] , \str[11][2] , \str[11][1] , \str[11][0] , 
        \str[10][7] , \str[10][6] , \str[10][5] , \str[10][4] , \str[10][3] , 
        \str[10][2] , \str[10][1] , \str[10][0] , \str[9][7] , \str[9][6] , 
        \str[9][5] , \str[9][4] , \str[9][3] , \str[9][2] , \str[9][1] , 
        \str[9][0] , \str[8][7] , \str[8][6] , \str[8][5] , \str[8][4] , 
        \str[8][3] , \str[8][2] , \str[8][1] , \str[8][0] , \str[7][7] , 
        \str[7][6] , \str[7][5] , \str[7][4] , \str[7][3] , \str[7][2] , 
        \str[7][1] , \str[7][0] , \str[6][7] , \str[6][6] , \str[6][5] , 
        \str[6][4] , \str[6][3] , \str[6][2] , \str[6][1] , \str[6][0] , 
        \str[5][7] , \str[5][6] , \str[5][5] , \str[5][4] , \str[5][3] , 
        \str[5][2] , \str[5][1] , \str[5][0] , \str[4][7] , \str[4][6] , 
        \str[4][5] , \str[4][4] , \str[4][3] , \str[4][2] , \str[4][1] , 
        \str[4][0] , \str[3][7] , \str[3][6] , \str[3][5] , \str[3][4] , 
        \str[3][3] , \str[3][2] , \str[3][1] , \str[3][0] , \str[2][7] , 
        \str[2][6] , \str[2][5] , \str[2][4] , \str[2][3] , \str[2][2] , 
        \str[2][1] , \str[2][0] , \str[1][7] , \str[1][6] , \str[1][5] , 
        \str[1][4] , \str[1][3] , \str[1][2] , \str[1][1] , \str[1][0] , 
        \str[0][7] , \str[0][6] , \str[0][5] , \str[0][4] , \str[0][3] , 
        \str[0][2] , \str[0][1] , \str[0][0] }), .pat({\pat[7][7] , 
        \pat[7][6] , \pat[7][5] , \pat[7][4] , \pat[7][3] , \pat[7][2] , 
        \pat[7][1] , \pat[7][0] , \pat[6][7] , \pat[6][6] , \pat[6][5] , 
        \pat[6][4] , \pat[6][3] , \pat[6][2] , \pat[6][1] , \pat[6][0] , 
        \pat[5][7] , \pat[5][6] , \pat[5][5] , \pat[5][4] , \pat[5][3] , 
        \pat[5][2] , \pat[5][1] , \pat[5][0] , \pat[4][7] , \pat[4][6] , 
        \pat[4][5] , \pat[4][4] , \pat[4][3] , \pat[4][2] , \pat[4][1] , 
        \pat[4][0] , \pat[3][7] , \pat[3][6] , \pat[3][5] , \pat[3][4] , 
        \pat[3][3] , \pat[3][2] , \pat[3][1] , \pat[3][0] , \pat[2][7] , 
        \pat[2][6] , \pat[2][5] , \pat[2][4] , \pat[2][3] , \pat[2][2] , 
        \pat[2][1] , \pat[2][0] , \pat[1][7] , \pat[1][6] , \pat[1][5] , 
        \pat[1][4] , \pat[1][3] , \pat[1][2] , \pat[1][1] , \pat[1][0] , 
        \pat[0][7] , \pat[0][6] , \pat[0][5] , \pat[0][4] , \pat[0][3] , 
        \pat[0][2] , \pat[0][1] , \pat[0][0] }), slen, plen, patmask, m_done, 
        match_v, m_idx, head20, head2e );
  input [1:0] ctrlsig;
  input [5:0] slen;
  input [3:0] plen;
  input [7:0] patmask;
  output [4:0] m_idx;
  input clk, starsig, \str[39][7] , \str[39][6] , \str[39][5] , \str[39][4] ,
         \str[39][3] , \str[39][2] , \str[39][1] , \str[39][0] , \str[38][7] ,
         \str[38][6] , \str[38][5] , \str[38][4] , \str[38][3] , \str[38][2] ,
         \str[38][1] , \str[38][0] , \str[37][7] , \str[37][6] , \str[37][5] ,
         \str[37][4] , \str[37][3] , \str[37][2] , \str[37][1] , \str[37][0] ,
         \str[36][7] , \str[36][6] , \str[36][5] , \str[36][4] , \str[36][3] ,
         \str[36][2] , \str[36][1] , \str[36][0] , \str[35][7] , \str[35][6] ,
         \str[35][5] , \str[35][4] , \str[35][3] , \str[35][2] , \str[35][1] ,
         \str[35][0] , \str[34][7] , \str[34][6] , \str[34][5] , \str[34][4] ,
         \str[34][3] , \str[34][2] , \str[34][1] , \str[34][0] , \str[33][7] ,
         \str[33][6] , \str[33][5] , \str[33][4] , \str[33][3] , \str[33][2] ,
         \str[33][1] , \str[33][0] , \str[32][7] , \str[32][6] , \str[32][5] ,
         \str[32][4] , \str[32][3] , \str[32][2] , \str[32][1] , \str[32][0] ,
         \str[31][7] , \str[31][6] , \str[31][5] , \str[31][4] , \str[31][3] ,
         \str[31][2] , \str[31][1] , \str[31][0] , \str[30][7] , \str[30][6] ,
         \str[30][5] , \str[30][4] , \str[30][3] , \str[30][2] , \str[30][1] ,
         \str[30][0] , \str[29][7] , \str[29][6] , \str[29][5] , \str[29][4] ,
         \str[29][3] , \str[29][2] , \str[29][1] , \str[29][0] , \str[28][7] ,
         \str[28][6] , \str[28][5] , \str[28][4] , \str[28][3] , \str[28][2] ,
         \str[28][1] , \str[28][0] , \str[27][7] , \str[27][6] , \str[27][5] ,
         \str[27][4] , \str[27][3] , \str[27][2] , \str[27][1] , \str[27][0] ,
         \str[26][7] , \str[26][6] , \str[26][5] , \str[26][4] , \str[26][3] ,
         \str[26][2] , \str[26][1] , \str[26][0] , \str[25][7] , \str[25][6] ,
         \str[25][5] , \str[25][4] , \str[25][3] , \str[25][2] , \str[25][1] ,
         \str[25][0] , \str[24][7] , \str[24][6] , \str[24][5] , \str[24][4] ,
         \str[24][3] , \str[24][2] , \str[24][1] , \str[24][0] , \str[23][7] ,
         \str[23][6] , \str[23][5] , \str[23][4] , \str[23][3] , \str[23][2] ,
         \str[23][1] , \str[23][0] , \str[22][7] , \str[22][6] , \str[22][5] ,
         \str[22][4] , \str[22][3] , \str[22][2] , \str[22][1] , \str[22][0] ,
         \str[21][7] , \str[21][6] , \str[21][5] , \str[21][4] , \str[21][3] ,
         \str[21][2] , \str[21][1] , \str[21][0] , \str[20][7] , \str[20][6] ,
         \str[20][5] , \str[20][4] , \str[20][3] , \str[20][2] , \str[20][1] ,
         \str[20][0] , \str[19][7] , \str[19][6] , \str[19][5] , \str[19][4] ,
         \str[19][3] , \str[19][2] , \str[19][1] , \str[19][0] , \str[18][7] ,
         \str[18][6] , \str[18][5] , \str[18][4] , \str[18][3] , \str[18][2] ,
         \str[18][1] , \str[18][0] , \str[17][7] , \str[17][6] , \str[17][5] ,
         \str[17][4] , \str[17][3] , \str[17][2] , \str[17][1] , \str[17][0] ,
         \str[16][7] , \str[16][6] , \str[16][5] , \str[16][4] , \str[16][3] ,
         \str[16][2] , \str[16][1] , \str[16][0] , \str[15][7] , \str[15][6] ,
         \str[15][5] , \str[15][4] , \str[15][3] , \str[15][2] , \str[15][1] ,
         \str[15][0] , \str[14][7] , \str[14][6] , \str[14][5] , \str[14][4] ,
         \str[14][3] , \str[14][2] , \str[14][1] , \str[14][0] , \str[13][7] ,
         \str[13][6] , \str[13][5] , \str[13][4] , \str[13][3] , \str[13][2] ,
         \str[13][1] , \str[13][0] , \str[12][7] , \str[12][6] , \str[12][5] ,
         \str[12][4] , \str[12][3] , \str[12][2] , \str[12][1] , \str[12][0] ,
         \str[11][7] , \str[11][6] , \str[11][5] , \str[11][4] , \str[11][3] ,
         \str[11][2] , \str[11][1] , \str[11][0] , \str[10][7] , \str[10][6] ,
         \str[10][5] , \str[10][4] , \str[10][3] , \str[10][2] , \str[10][1] ,
         \str[10][0] , \str[9][7] , \str[9][6] , \str[9][5] , \str[9][4] ,
         \str[9][3] , \str[9][2] , \str[9][1] , \str[9][0] , \str[8][7] ,
         \str[8][6] , \str[8][5] , \str[8][4] , \str[8][3] , \str[8][2] ,
         \str[8][1] , \str[8][0] , \str[7][7] , \str[7][6] , \str[7][5] ,
         \str[7][4] , \str[7][3] , \str[7][2] , \str[7][1] , \str[7][0] ,
         \str[6][7] , \str[6][6] , \str[6][5] , \str[6][4] , \str[6][3] ,
         \str[6][2] , \str[6][1] , \str[6][0] , \str[5][7] , \str[5][6] ,
         \str[5][5] , \str[5][4] , \str[5][3] , \str[5][2] , \str[5][1] ,
         \str[5][0] , \str[4][7] , \str[4][6] , \str[4][5] , \str[4][4] ,
         \str[4][3] , \str[4][2] , \str[4][1] , \str[4][0] , \str[3][7] ,
         \str[3][6] , \str[3][5] , \str[3][4] , \str[3][3] , \str[3][2] ,
         \str[3][1] , \str[3][0] , \str[2][7] , \str[2][6] , \str[2][5] ,
         \str[2][4] , \str[2][3] , \str[2][2] , \str[2][1] , \str[2][0] ,
         \str[1][7] , \str[1][6] , \str[1][5] , \str[1][4] , \str[1][3] ,
         \str[1][2] , \str[1][1] , \str[1][0] , \str[0][7] , \str[0][6] ,
         \str[0][5] , \str[0][4] , \str[0][3] , \str[0][2] , \str[0][1] ,
         \str[0][0] , \pat[7][7] , \pat[7][6] , \pat[7][5] , \pat[7][4] ,
         \pat[7][3] , \pat[7][2] , \pat[7][1] , \pat[7][0] , \pat[6][7] ,
         \pat[6][6] , \pat[6][5] , \pat[6][4] , \pat[6][3] , \pat[6][2] ,
         \pat[6][1] , \pat[6][0] , \pat[5][7] , \pat[5][6] , \pat[5][5] ,
         \pat[5][4] , \pat[5][3] , \pat[5][2] , \pat[5][1] , \pat[5][0] ,
         \pat[4][7] , \pat[4][6] , \pat[4][5] , \pat[4][4] , \pat[4][3] ,
         \pat[4][2] , \pat[4][1] , \pat[4][0] , \pat[3][7] , \pat[3][6] ,
         \pat[3][5] , \pat[3][4] , \pat[3][3] , \pat[3][2] , \pat[3][1] ,
         \pat[3][0] , \pat[2][7] , \pat[2][6] , \pat[2][5] , \pat[2][4] ,
         \pat[2][3] , \pat[2][2] , \pat[2][1] , \pat[2][0] , \pat[1][7] ,
         \pat[1][6] , \pat[1][5] , \pat[1][4] , \pat[1][3] , \pat[1][2] ,
         \pat[1][1] , \pat[1][0] , \pat[0][7] , \pat[0][6] , \pat[0][5] ,
         \pat[0][4] , \pat[0][3] , \pat[0][2] , \pat[0][1] , \pat[0][0] ;
  output m_done, match_v, head20, head2e;
  wire   N294, N295, N296, N297, N308, N309, N310, N311, N312, N315, N423,
         N424, N425, N426, N427, N428, N429, N430, N465, N466, N467, N468,
         N469, N470, N471, N472, N507, N508, N509, N510, N511, N512, N513,
         N514, N549, N550, N551, N552, N553, N554, N555, N556, N591, N592,
         N593, N594, N595, N596, N597, N598, N633, N634, N635, N636, N637,
         N638, N639, N640, N675, N676, N677, N678, N679, N680, N681, N682, n65,
         n67, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127, n128, n129, n130,
         n131, n132, n133, n134, n135, n136, n137, n138, n139, n140, n141,
         n142, n143, n144, n145, n146, n147, n148, n149, n150, n151, n152,
         n153, n154, n155, n156, n157, n158, n159, n160, n161, n162, n163,
         n164, n165, n166, n167, n168, n169, n170, n171, n172, n173, n174,
         n175, n176, n177, n178, n179, n180, n181, n182, n183, n184, n185,
         n186, n187, n188, n189, n190, n191, n192, n193, n194, n195, n196,
         n197, n198, n199, n200, n201, n202, n203, n204, n205, n206, n207,
         n208, n209, n210, n211, n212, n213, n214, n215, n216, n217, n218,
         n219, n220, n221, n222, n223, n224, n225, n226, n227, n228, n229,
         n230, n231, n232, n233, n234, n235, n236, n237, n238, n239, n240,
         n241, n242, n243, n244, n245, n246, n247, n248, n249, n250, n251,
         n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262,
         n263, n264, n265, n266, n267, n268, n269, n270, n271, n272, n273,
         n274, n275, n276, n277, n278, n279, n280, n281, n282, n283, n284,
         n285, n286, n287, n288, n289, n290, n291, n292, n293, n294, n295,
         n296, n297, n298, n299, n300, n301, n302, n303, n304, n305, n306,
         n307, n308, n309, n310, n311, n312, n313, n314, n315, n316, n317,
         n318, n319, n320, n321, n322, n323, n324, n325, n326, n327, n328,
         n329, n330, n331, n332, n333, n334, n335, n336, n337, n338, n339,
         n340, n341, n342, n343, n344, n345, n346, n347, n348, n349, n350,
         n351, n352, n353, n354, n355, n356, n357, n358, n359, n360, n361,
         n362, n363, n364, n365, n366, n367, n368, n369, n370, n371, n372,
         n373, n374, n375, n376, n377, n378, n379, n380, n381, n382, n383,
         n384, n385, n386, n387, n388, n389, n390, n391, n392, n393, n394,
         n395, n396, n397, n398, N307, N306, N305, N304, N303, \r434/carry[4] ,
         \r434/carry[3] , \r434/carry[2] , \add_0_root_add_90/carry[4] ,
         \add_0_root_add_90/carry[3] , \add_0_root_add_90/carry[2] ,
         \sub_1_root_add_90/carry[4] , \sub_1_root_add_90/carry[3] ,
         \sub_1_root_add_90/carry[2] , \sub_1_root_add_90/carry[1] , n1, n2,
         n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n66, n68, n69, n399, n400, n401, n402, n403,
         n404, n405, n406, n407, n408, n409, n410, n411, n412, n413, n414,
         n415, n416, n417, n418, n419, n420, n421, n422, n423, n424, n425,
         n426, n427, n428, n429, n430, n431, n432, n433, n434, n435, n436,
         n437, n438, n439, n440, n441, n442, n443, n444, n445, n446, n447,
         n448, n449, n450, n451, n452, n453, n454, n455, n456, n457, n458,
         n459, n460, n461, n462, n463, n464, n465, n466, n467, n468, n469,
         n470, n471, n472, n473, n474, n475, n476, n477, n478, n479, n480,
         n481, n482, n483, n484, n485, n486, n487, n488, n489, n490, n491,
         n492, n493, n494, n495, n496, n497, n498, n499, n500, n501, n502,
         n503, n504, n505, n506, n507, n508, n509, n510, n511, n512, n513,
         n514, n515, n516, n517, n518, n519, n520, n521, n522, n523, n524,
         n525, n526, n527, n528, n529, n530, n531, n532, n533, n534, n535,
         n536, n537, n538, n539, n540, n541, n542, n543, n544, n545, n546,
         n547, n548, n549, n550, n551, n552, n553, n554, n555, n556, n557,
         n558, n559, n560, n561, n562, n563, n564, n565, n566, n567, n568,
         n569, n570, n571, n572, n573, n574, n575, n576, n577, n578, n579,
         n580, n581, n582, n583, n584, n585, n586, n587, n588, n589, n590,
         n591, n592, n593, n594, n595, n596, n597, n598, n599, n600, n601,
         n602, n603, n604, n605, n606, n607, n608, n609, n610, n611, n612,
         n613, n614, n615, n616, n617, n618, n619, n620, n621, n622, n623,
         n624, n625, n626, n627, n628, n629, n630, n631, n632, n633, n634,
         n635, n636, n637, n638, n639, n640, n641, n642, n643, n644, n645,
         n646, n647, n648, n649, n650, n651, n652, n653, n654, n655, n656,
         n657, n658, n659, n660, n661, n662, n663, n664, n665, n666, n667,
         n668, n669, n670, n671, n672, n673, n674, n675, n676, n677, n678,
         n679, n680, n681, n682, n683, n684, n685, n686, n687, n688, n689,
         n690, n691, n692, n693, n694, n695, n696, n697, n698, n699, n700,
         n701, n702, n703, n704, n705, n706, n707, n708, n709, n710, n711,
         n712, n713, n714, n715, n716, n717, n718, n719, n720, n721, n722,
         n723, n724, n725, n726, n727, n728, n729, n730, n731, n732, n733,
         n734, n735, n736, n737, n738, n739, n740, n741, n742, n743, n744,
         n745, n746, n747, n748, n749, n750, n751, n752, n753, n754, n755,
         n756, n757, n758, n759, n760, n761, n762, n763, n764, n765, n766,
         n767, n768, n769, n770, n771, n772, n773, n774, n775, n776, n777,
         n778, n779, n780, n781, n782, n783, n784, n785, n786, n787, n788,
         n789, n790, n791, n792, n793, n794, n795, n796, n797;
  wire   [4:0] m_cnt;

  EDFFTRX1 \m_idx_reg[1]  ( .RN(n775), .D(N294), .E(n74), .CK(clk), .Q(
        m_idx[1]) );
  EDFFTRX1 \m_idx_reg[4]  ( .RN(n775), .D(N297), .E(n74), .CK(clk), .Q(
        m_idx[4]) );
  EDFFTRX1 \m_idx_reg[3]  ( .RN(n775), .D(N296), .E(n74), .CK(clk), .Q(
        m_idx[3]) );
  EDFFTRX1 \m_idx_reg[2]  ( .RN(n775), .D(N295), .E(n74), .CK(clk), .Q(
        m_idx[2]) );
  EDFFTRX1 \m_idx_reg[0]  ( .RN(n775), .D(n789), .E(n74), .CK(clk), .Q(
        m_idx[0]) );
  DFFQX1 m_done_reg ( .D(N315), .CK(clk), .Q(m_done) );
  DFFTRX1 \m_cnt_reg[0]  ( .D(n789), .RN(n82), .CK(clk), .Q(m_cnt[0]), .QN(n1)
         );
  DFFTRX1 \m_cnt_reg[1]  ( .D(N294), .RN(n82), .CK(clk), .Q(m_cnt[1]), .QN(n67) );
  DFFTRX1 \m_cnt_reg[2]  ( .D(N295), .RN(n82), .CK(clk), .Q(m_cnt[2]), .QN(n2)
         );
  DFFTRX1 \m_cnt_reg[4]  ( .D(N297), .RN(n82), .CK(clk), .Q(m_cnt[4]), .QN(n65) );
  DFFTRX1 \m_cnt_reg[3]  ( .D(N296), .RN(n82), .CK(clk), .Q(m_cnt[3]), .QN(
        n709) );
  OAI221X1 U3 ( .A0(\str[5][3] ), .A1(n761), .B0(\str[13][3] ), .B1(n766), 
        .C0(n467), .Y(n630) );
  NOR2X1 U4 ( .A(m_cnt[2]), .B(n732), .Y(n3) );
  NOR2X1 U5 ( .A(n2), .B(n732), .Y(n4) );
  NOR4X1 U6 ( .A(n71), .B(n72), .C(\pat[0][3] ), .D(\pat[0][2] ), .Y(head20)
         );
  AOI222X1 U7 ( .A0(n565), .A1(n743), .B0(n744), .B1(n427), .C0(n734), .C1(
        n480), .Y(n457) );
  OAI221X1 U8 ( .A0(\str[9][7] ), .A1(n759), .B0(\str[17][7] ), .B1(n763), 
        .C0(n419), .Y(n565) );
  OAI221X1 U9 ( .A0(\str[6][7] ), .A1(n759), .B0(\str[14][7] ), .B1(n763), 
        .C0(n455), .Y(n605) );
  OAI221X1 U10 ( .A0(\str[5][0] ), .A1(n759), .B0(\str[13][0] ), .B1(n763), 
        .C0(n458), .Y(n612) );
  OAI221X1 U11 ( .A0(\str[5][5] ), .A1(n759), .B0(\str[13][5] ), .B1(n766), 
        .C0(n473), .Y(n642) );
  XOR2XL U12 ( .A(\r434/carry[4] ), .B(m_cnt[4]), .Y(N297) );
  NOR2XL U13 ( .A(m_cnt[3]), .B(m_cnt[4]), .Y(n396) );
  OR3XL U14 ( .A(\pat[0][6] ), .B(\pat[0][7] ), .C(\pat[0][4] ), .Y(n72) );
  NOR4XL U15 ( .A(\pat[0][7] ), .B(\pat[0][6] ), .C(\pat[0][4] ), .D(
        \pat[0][0] ), .Y(n196) );
  OAI221X1 U16 ( .A0(\str[10][7] ), .A1(n760), .B0(\str[18][7] ), .B1(n764), 
        .C0(n416), .Y(n520) );
  OAI221X1 U17 ( .A0(\str[5][1] ), .A1(n759), .B0(\str[13][1] ), .B1(n763), 
        .C0(n461), .Y(n618) );
  OAI221X1 U18 ( .A0(\str[10][3] ), .A1(n761), .B0(\str[18][3] ), .B1(n710), 
        .C0(n41), .Y(n500) );
  OAI221X1 U19 ( .A0(\str[10][0] ), .A1(n760), .B0(\str[18][0] ), .B1(n764), 
        .C0(n8), .Y(n485) );
  OAI221X1 U20 ( .A0(\str[5][2] ), .A1(n759), .B0(\str[13][2] ), .B1(n766), 
        .C0(n464), .Y(n624) );
  OAI221X1 U21 ( .A0(\str[10][5] ), .A1(n760), .B0(\str[18][5] ), .B1(n764), 
        .C0(n63), .Y(n510) );
  OAI221X1 U22 ( .A0(\str[6][4] ), .A1(n759), .B0(\str[14][4] ), .B1(n763), 
        .C0(n446), .Y(n590) );
  NAND2X2 U23 ( .A(n758), .B(n740), .Y(n652) );
  OAI221X1 U24 ( .A0(\str[10][4] ), .A1(n761), .B0(\str[18][4] ), .B1(n764), 
        .C0(n52), .Y(n505) );
  BUFX2 U25 ( .A(n766), .Y(n764) );
  OAI221X1 U26 ( .A0(\str[10][1] ), .A1(n762), .B0(\str[18][1] ), .B1(n765), 
        .C0(n19), .Y(n490) );
  OAI221X1 U27 ( .A0(\str[6][5] ), .A1(n759), .B0(\str[14][5] ), .B1(n763), 
        .C0(n449), .Y(n595) );
  BUFX2 U28 ( .A(n766), .Y(n763) );
  NAND2X2 U29 ( .A(n757), .B(n740), .Y(n658) );
  OAI221X1 U30 ( .A0(\str[10][2] ), .A1(n761), .B0(\str[18][2] ), .B1(n765), 
        .C0(n30), .Y(n495) );
  OAI221X1 U31 ( .A0(\str[9][6] ), .A1(n760), .B0(\str[17][6] ), .B1(n764), 
        .C0(n408), .Y(n555) );
  AOI222X1 U32 ( .A0(n757), .A1(n600), .B0(n758), .B1(n599), .C0(n732), .C1(
        n598), .Y(n645) );
  OAI221X1 U33 ( .A0(\str[6][6] ), .A1(n759), .B0(\str[14][6] ), .B1(n763), 
        .C0(n452), .Y(n600) );
  NAND2X2 U34 ( .A(m_cnt[1]), .B(n740), .Y(n656) );
  OAI221X1 U35 ( .A0(\str[10][6] ), .A1(n760), .B0(\str[18][6] ), .B1(n764), 
        .C0(n405), .Y(n515) );
  OAI221X1 U36 ( .A0(\str[6][0] ), .A1(n759), .B0(\str[14][0] ), .B1(n763), 
        .C0(n434), .Y(n570) );
  OAI221X1 U37 ( .A0(\str[9][1] ), .A1(n762), .B0(\str[17][1] ), .B1(n765), 
        .C0(n22), .Y(n530) );
  NAND2X2 U38 ( .A(n744), .B(n737), .Y(n429) );
  OAI221X1 U39 ( .A0(\str[5][7] ), .A1(n708), .B0(\str[13][7] ), .B1(n766), 
        .C0(n479), .Y(n659) );
  OAI221X1 U40 ( .A0(\str[6][1] ), .A1(n759), .B0(\str[14][1] ), .B1(n763), 
        .C0(n437), .Y(n575) );
  AOI222X1 U41 ( .A0(n742), .A1(n540), .B0(n744), .B1(n48), .C0(n733), .C1(
        n468), .Y(n445) );
  OAI221X1 U42 ( .A0(\str[9][3] ), .A1(n761), .B0(\str[17][3] ), .B1(n710), 
        .C0(n44), .Y(n540) );
  NAND2X2 U43 ( .A(n743), .B(n737), .Y(n433) );
  OAI221X1 U44 ( .A0(\str[5][6] ), .A1(n761), .B0(\str[13][6] ), .B1(n766), 
        .C0(n476), .Y(n648) );
  OAI221X1 U45 ( .A0(\str[6][2] ), .A1(n759), .B0(\str[14][2] ), .B1(n763), 
        .C0(n440), .Y(n580) );
  OAI221X1 U46 ( .A0(\str[9][0] ), .A1(n761), .B0(\str[17][0] ), .B1(n765), 
        .C0(n11), .Y(n525) );
  OAI221X1 U47 ( .A0(\str[9][4] ), .A1(n760), .B0(\str[17][4] ), .B1(n764), 
        .C0(n55), .Y(n545) );
  NAND2X2 U48 ( .A(n738), .B(n734), .Y(n432) );
  OAI221X1 U49 ( .A0(\str[5][4] ), .A1(n760), .B0(\str[13][4] ), .B1(n766), 
        .C0(n470), .Y(n636) );
  AOI222X1 U50 ( .A0(n757), .A1(n585), .B0(n758), .B1(n584), .C0(n731), .C1(
        n583), .Y(n627) );
  OAI221X1 U51 ( .A0(\str[6][3] ), .A1(n759), .B0(\str[14][3] ), .B1(n763), 
        .C0(n443), .Y(n585) );
  OAI221X1 U52 ( .A0(\str[9][2] ), .A1(n761), .B0(\str[17][2] ), .B1(n765), 
        .C0(n33), .Y(n535) );
  OAI221X1 U53 ( .A0(\str[9][5] ), .A1(n760), .B0(\str[17][5] ), .B1(n764), 
        .C0(n68), .Y(n550) );
  AOI2BB2XL U54 ( .B0(n454), .B1(n740), .A0N(n429), .A1N(n414), .Y(n415) );
  AOI2BB2XL U55 ( .B0(n451), .B1(n740), .A0N(n429), .A1N(n403), .Y(n404) );
  AOI2BB2XL U56 ( .B0(n448), .B1(n740), .A0N(n429), .A1N(n61), .Y(n62) );
  AOI2BB2XL U57 ( .B0(n442), .B1(n740), .A0N(n429), .A1N(n39), .Y(n40) );
  AOI2BB2XL U58 ( .B0(n439), .B1(n740), .A0N(n429), .A1N(n28), .Y(n29) );
  AOI2BB2XL U59 ( .B0(n436), .B1(n740), .A0N(n429), .A1N(n17), .Y(n18) );
  AOI2BB2XL U60 ( .B0(n737), .B1(n621), .A0N(n652), .A1N(n620), .Y(n622) );
  AOI2BB2XL U61 ( .B0(n737), .B1(n615), .A0N(n652), .A1N(n614), .Y(n616) );
  AOI2BB2XL U62 ( .B0(n737), .B1(n609), .A0N(n652), .A1N(n608), .Y(n610) );
  AOI2BB2XL U63 ( .B0(n737), .B1(n639), .A0N(n652), .A1N(n638), .Y(n640) );
  AOI2BB2XL U64 ( .B0(n737), .B1(n633), .A0N(n652), .A1N(n632), .Y(n634) );
  AOI2BB2XL U65 ( .B0(n735), .B1(n654), .A0N(n653), .A1N(n652), .Y(n655) );
  CLKINVX1 U66 ( .A(m_cnt[0]), .Y(n789) );
  CLKBUFX3 U67 ( .A(n73), .Y(n775) );
  CLKBUFX3 U68 ( .A(n204), .Y(n743) );
  CLKBUFX3 U69 ( .A(n204), .Y(n742) );
  CLKBUFX3 U70 ( .A(n560), .Y(n774) );
  NOR2X1 U71 ( .A(n750), .B(n791), .Y(n560) );
  CLKBUFX3 U72 ( .A(n558), .Y(n773) );
  NOR2X1 U73 ( .A(n710), .B(m_cnt[2]), .Y(n558) );
  CLKBUFX3 U74 ( .A(n564), .Y(n744) );
  CLKBUFX3 U75 ( .A(n4), .Y(n757) );
  CLKBUFX3 U76 ( .A(n3), .Y(n758) );
  INVX3 U77 ( .A(n741), .Y(n740) );
  INVX3 U78 ( .A(n738), .Y(n739) );
  INVX3 U79 ( .A(n753), .Y(n755) );
  NAND2X4 U80 ( .A(m_cnt[2]), .B(n746), .Y(n426) );
  CLKBUFX3 U81 ( .A(n423), .Y(n770) );
  NOR2X1 U82 ( .A(n728), .B(n762), .Y(n423) );
  CLKBUFX3 U83 ( .A(n424), .Y(n769) );
  NOR2X1 U84 ( .A(n728), .B(n756), .Y(n424) );
  CLKBUFX3 U85 ( .A(n422), .Y(n771) );
  NOR2X1 U86 ( .A(n729), .B(n765), .Y(n422) );
  CLKBUFX3 U87 ( .A(n708), .Y(n762) );
  CLKBUFX3 U88 ( .A(n761), .Y(n760) );
  CLKBUFX3 U89 ( .A(n708), .Y(n761) );
  CLKBUFX3 U90 ( .A(n762), .Y(n759) );
  INVX3 U91 ( .A(n745), .Y(n750) );
  INVX3 U92 ( .A(n752), .Y(n756) );
  INVX3 U93 ( .A(n746), .Y(n747) );
  INVX3 U94 ( .A(n746), .Y(n749) );
  INVX3 U95 ( .A(n746), .Y(n748) );
  INVX3 U96 ( .A(n753), .Y(n754) );
  CLKBUFX3 U97 ( .A(n563), .Y(n772) );
  NAND2X1 U98 ( .A(n753), .B(n2), .Y(n563) );
  INVX3 U99 ( .A(n732), .Y(n734) );
  OR2X1 U100 ( .A(n734), .B(n2), .Y(n5) );
  CLKINVX1 U101 ( .A(n5), .Y(n564) );
  CLKBUFX3 U102 ( .A(n741), .Y(n738) );
  CLKBUFX3 U103 ( .A(n741), .Y(n737) );
  INVX3 U104 ( .A(n728), .Y(n730) );
  INVX3 U105 ( .A(n790), .Y(n733) );
  CLKBUFX3 U106 ( .A(n738), .Y(n736) );
  CLKBUFX3 U107 ( .A(n738), .Y(n735) );
  CLKBUFX3 U108 ( .A(n751), .Y(n753) );
  CLKBUFX3 U109 ( .A(n7), .Y(n746) );
  CLKBUFX3 U110 ( .A(n6), .Y(n752) );
  CLKBUFX3 U111 ( .A(n7), .Y(n745) );
  CLKBUFX3 U112 ( .A(n765), .Y(n766) );
  CLKBUFX3 U113 ( .A(n727), .Y(n728) );
  CLKBUFX3 U114 ( .A(n727), .Y(n729) );
  CLKBUFX3 U115 ( .A(m_cnt[1]), .Y(n732) );
  CLKBUFX3 U116 ( .A(n788), .Y(n741) );
  CLKBUFX3 U117 ( .A(n211), .Y(n786) );
  CLKBUFX3 U118 ( .A(n216), .Y(n779) );
  CLKBUFX3 U119 ( .A(n215), .Y(n780) );
  CLKBUFX3 U120 ( .A(n220), .Y(n776) );
  CLKBUFX3 U121 ( .A(n212), .Y(n784) );
  CLKBUFX3 U122 ( .A(n212), .Y(n785) );
  CLKBUFX3 U123 ( .A(n217), .Y(n778) );
  CLKBUFX3 U124 ( .A(n211), .Y(n787) );
  CLKBUFX3 U125 ( .A(n214), .Y(n783) );
  CLKBUFX3 U126 ( .A(n219), .Y(n777) );
  CLKBUFX3 U127 ( .A(n214), .Y(n782) );
  CLKBUFX3 U128 ( .A(n215), .Y(n781) );
  CLKBUFX3 U129 ( .A(n790), .Y(n731) );
  CLKINVX1 U130 ( .A(n81), .Y(match_v) );
  CLKBUFX3 U131 ( .A(n6), .Y(n751) );
  CLKINVX1 U132 ( .A(n767), .Y(n708) );
  CLKBUFX3 U133 ( .A(n710), .Y(n765) );
  CLKINVX1 U134 ( .A(n768), .Y(n710) );
  NAND2X4 U135 ( .A(n767), .B(n2), .Y(n557) );
  NOR4X1 U136 ( .A(n75), .B(n76), .C(n77), .D(n78), .Y(N315) );
  XOR2X1 U137 ( .A(n788), .B(N308), .Y(n77) );
  XOR2X1 U138 ( .A(n790), .B(N309), .Y(n78) );
  XOR2X1 U139 ( .A(n791), .B(N310), .Y(n76) );
  AND2X2 U140 ( .A(n74), .B(n775), .Y(n82) );
  CLKINVX1 U141 ( .A(n791), .Y(n727) );
  INVX3 U142 ( .A(n789), .Y(n788) );
  AOI211X1 U143 ( .A0(n204), .A1(n282), .B0(n283), .C0(n284), .Y(n281) );
  NAND4X1 U144 ( .A(n299), .B(n300), .C(n301), .D(n302), .Y(n282) );
  OAI22XL U145 ( .A0(n289), .A1(n222), .B0(n290), .B1(n224), .Y(n283) );
  AOI21X1 U146 ( .A0(n285), .A1(n286), .B0(n210), .Y(n284) );
  NOR2BX1 U147 ( .AN(n398), .B(n788), .Y(n215) );
  NOR2BX1 U148 ( .AN(n397), .B(n788), .Y(n214) );
  NOR2BX1 U149 ( .AN(n395), .B(n788), .Y(n212) );
  NOR2BX1 U150 ( .AN(n396), .B(n788), .Y(n211) );
  OAI21XL U151 ( .A0(n194), .A1(n796), .B0(n775), .Y(n193) );
  CLKINVX1 U152 ( .A(n70), .Y(n796) );
  NOR2X1 U153 ( .A(n197), .B(n198), .Y(n194) );
  NAND4X1 U154 ( .A(n303), .B(n304), .C(n305), .D(n306), .Y(n197) );
  AOI211X1 U155 ( .A0(n204), .A1(n238), .B0(n239), .C0(n240), .Y(n237) );
  NAND4X1 U156 ( .A(n255), .B(n256), .C(n257), .D(n258), .Y(n238) );
  OAI22XL U157 ( .A0(n245), .A1(n222), .B0(n246), .B1(n224), .Y(n239) );
  AOI21X1 U158 ( .A0(n241), .A1(n242), .B0(n210), .Y(n240) );
  AOI211X1 U159 ( .A0(n204), .A1(n260), .B0(n261), .C0(n262), .Y(n259) );
  NAND4X1 U160 ( .A(n277), .B(n278), .C(n279), .D(n280), .Y(n260) );
  OAI22XL U161 ( .A0(n267), .A1(n222), .B0(n268), .B1(n224), .Y(n261) );
  AOI21X1 U162 ( .A0(n263), .A1(n264), .B0(n210), .Y(n262) );
  AND2X2 U163 ( .A(n396), .B(n788), .Y(n216) );
  AND2X2 U164 ( .A(n398), .B(n788), .Y(n220) );
  AND2X2 U165 ( .A(n395), .B(n788), .Y(n217) );
  AND2X2 U166 ( .A(n397), .B(n788), .Y(n219) );
  NAND2X2 U167 ( .A(n791), .B(n790), .Y(n222) );
  OR2X2 U168 ( .A(n791), .B(n790), .Y(n210) );
  CLKINVX1 U169 ( .A(ctrlsig[0]), .Y(n797) );
  ADDHXL U170 ( .A(N304), .B(N303), .CO(\add_0_root_add_90/carry[2] ), .S(N309) );
  ADDHXL U171 ( .A(N305), .B(\add_0_root_add_90/carry[2] ), .CO(
        \add_0_root_add_90/carry[3] ), .S(N310) );
  ADDHXL U172 ( .A(N306), .B(\add_0_root_add_90/carry[3] ), .CO(
        \add_0_root_add_90/carry[4] ), .S(N311) );
  NOR2X1 U173 ( .A(n797), .B(n70), .Y(head2e) );
  ADDHXL U174 ( .A(n791), .B(\r434/carry[2] ), .CO(\r434/carry[3] ), .S(N295)
         );
  ADDHXL U175 ( .A(n790), .B(n788), .CO(\r434/carry[2] ), .S(N294) );
  CLKINVX1 U176 ( .A(n559), .Y(n711) );
  CLKINVX1 U177 ( .A(\str[19][7] ), .Y(n683) );
  CLKINVX1 U178 ( .A(n552), .Y(n713) );
  CLKINVX1 U179 ( .A(\str[19][6] ), .Y(n682) );
  CLKINVX1 U180 ( .A(n547), .Y(n715) );
  CLKINVX1 U181 ( .A(\str[19][5] ), .Y(n681) );
  CLKINVX1 U182 ( .A(n542), .Y(n717) );
  CLKINVX1 U183 ( .A(\str[19][4] ), .Y(n680) );
  CLKINVX1 U184 ( .A(n537), .Y(n719) );
  CLKINVX1 U185 ( .A(\str[19][3] ), .Y(n679) );
  CLKINVX1 U186 ( .A(n532), .Y(n721) );
  CLKINVX1 U187 ( .A(\str[19][2] ), .Y(n678) );
  CLKINVX1 U188 ( .A(n527), .Y(n723) );
  CLKINVX1 U189 ( .A(\str[19][1] ), .Y(n677) );
  XNOR2X1 U190 ( .A(\pat[7][7] ), .B(N682), .Y(n128) );
  XNOR2X1 U191 ( .A(\pat[7][3] ), .B(N678), .Y(n132) );
  NAND4X1 U192 ( .A(n83), .B(n84), .C(n85), .D(n86), .Y(n81) );
  XOR2X1 U193 ( .A(n193), .B(patmask[0]), .Y(n83) );
  AOI211X1 U194 ( .A0(n147), .A1(n148), .B0(n149), .C0(n150), .Y(n85) );
  XOR2X1 U195 ( .A(n179), .B(patmask[1]), .Y(n84) );
  XNOR2X1 U196 ( .A(patmask[7]), .B(n119), .Y(n88) );
  NAND2X1 U197 ( .A(n775), .B(n120), .Y(n119) );
  OAI22XL U198 ( .A0(n121), .A1(n122), .B0(n123), .B1(n124), .Y(n120) );
  NAND4X1 U199 ( .A(\pat[7][5] ), .B(\pat[7][1] ), .C(\pat[7][2] ), .D(
        \pat[7][3] ), .Y(n122) );
  NOR4X1 U200 ( .A(n87), .B(n88), .C(n89), .D(n90), .Y(n86) );
  XNOR2X1 U201 ( .A(patmask[5]), .B(n133), .Y(n87) );
  XNOR2X1 U202 ( .A(patmask[6]), .B(n105), .Y(n89) );
  XNOR2X1 U203 ( .A(patmask[4]), .B(n91), .Y(n90) );
  NAND4X1 U204 ( .A(n129), .B(n130), .C(n131), .D(n132), .Y(n123) );
  XNOR2X1 U205 ( .A(\pat[7][0] ), .B(N675), .Y(n129) );
  XNOR2X1 U206 ( .A(\pat[7][1] ), .B(N676), .Y(n130) );
  XNOR2X1 U207 ( .A(\pat[7][2] ), .B(N677), .Y(n131) );
  NAND4X1 U208 ( .A(n125), .B(n126), .C(n127), .D(n128), .Y(n124) );
  XNOR2X1 U209 ( .A(\pat[7][4] ), .B(N679), .Y(n125) );
  XNOR2X1 U210 ( .A(\pat[7][5] ), .B(N680), .Y(n126) );
  XNOR2X1 U211 ( .A(\pat[7][6] ), .B(N681), .Y(n127) );
  AND2X2 U212 ( .A(m_cnt[4]), .B(n709), .Y(n6) );
  CLKINVX1 U213 ( .A(n522), .Y(n725) );
  CLKINVX1 U214 ( .A(\str[19][0] ), .Y(n676) );
  XNOR2X1 U215 ( .A(\pat[1][3] ), .B(N426), .Y(n192) );
  XNOR2X1 U216 ( .A(\pat[1][6] ), .B(N429), .Y(n187) );
  XNOR2X1 U217 ( .A(\pat[3][6] ), .B(N513), .Y(n173) );
  XNOR2X1 U218 ( .A(\pat[6][3] ), .B(N636), .Y(n118) );
  XNOR2X1 U219 ( .A(\pat[5][7] ), .B(N598), .Y(n142) );
  XNOR2X1 U220 ( .A(\pat[5][3] ), .B(N594), .Y(n146) );
  XNOR2X1 U221 ( .A(\pat[2][3] ), .B(N468), .Y(n164) );
  XNOR2X1 U222 ( .A(\pat[4][7] ), .B(N556), .Y(n100) );
  XNOR2X1 U223 ( .A(\pat[4][3] ), .B(N552), .Y(n104) );
  XNOR2X1 U224 ( .A(\pat[3][3] ), .B(N510), .Y(n178) );
  XNOR2X1 U225 ( .A(\pat[6][7] ), .B(N640), .Y(n114) );
  XNOR2X1 U226 ( .A(\pat[2][6] ), .B(N471), .Y(n159) );
  CLKINVX1 U227 ( .A(n517), .Y(n712) );
  CLKINVX1 U228 ( .A(\str[20][7] ), .Y(n691) );
  CLKINVX1 U229 ( .A(n512), .Y(n714) );
  CLKINVX1 U230 ( .A(\str[20][6] ), .Y(n690) );
  CLKINVX1 U231 ( .A(n507), .Y(n716) );
  CLKINVX1 U232 ( .A(\str[20][5] ), .Y(n689) );
  CLKINVX1 U233 ( .A(n502), .Y(n718) );
  CLKINVX1 U234 ( .A(\str[20][4] ), .Y(n688) );
  CLKINVX1 U235 ( .A(n497), .Y(n720) );
  CLKINVX1 U236 ( .A(\str[20][3] ), .Y(n687) );
  CLKINVX1 U237 ( .A(n492), .Y(n722) );
  CLKINVX1 U238 ( .A(\str[20][2] ), .Y(n686) );
  CLKINVX1 U239 ( .A(n487), .Y(n724) );
  CLKINVX1 U240 ( .A(\str[20][1] ), .Y(n685) );
  CLKINVX1 U241 ( .A(n482), .Y(n726) );
  CLKINVX1 U242 ( .A(\str[20][0] ), .Y(n684) );
  XNOR2X1 U243 ( .A(patmask[2]), .B(n151), .Y(n150) );
  NAND2X1 U244 ( .A(n775), .B(n152), .Y(n151) );
  OAI22XL U245 ( .A0(n153), .A1(n154), .B0(n155), .B1(n156), .Y(n152) );
  NAND4X1 U246 ( .A(\pat[2][5] ), .B(\pat[2][1] ), .C(\pat[2][2] ), .D(
        \pat[2][3] ), .Y(n154) );
  NAND4X1 U247 ( .A(n189), .B(n190), .C(n191), .D(n192), .Y(n183) );
  XNOR2X1 U248 ( .A(\pat[1][0] ), .B(N423), .Y(n189) );
  XNOR2X1 U249 ( .A(\pat[1][1] ), .B(N424), .Y(n190) );
  XNOR2X1 U250 ( .A(\pat[1][2] ), .B(N425), .Y(n191) );
  NAND4X1 U251 ( .A(n185), .B(n186), .C(n187), .D(n188), .Y(n184) );
  XNOR2X1 U252 ( .A(\pat[1][7] ), .B(N430), .Y(n188) );
  XNOR2X1 U253 ( .A(\pat[1][4] ), .B(N427), .Y(n185) );
  XNOR2X1 U254 ( .A(\pat[1][5] ), .B(N428), .Y(n186) );
  NAND4X1 U255 ( .A(n101), .B(n102), .C(n103), .D(n104), .Y(n95) );
  XNOR2X1 U256 ( .A(\pat[4][0] ), .B(N549), .Y(n101) );
  XNOR2X1 U257 ( .A(\pat[4][1] ), .B(N550), .Y(n102) );
  XNOR2X1 U258 ( .A(\pat[4][2] ), .B(N551), .Y(n103) );
  NAND4X1 U259 ( .A(n115), .B(n116), .C(n117), .D(n118), .Y(n109) );
  XNOR2X1 U260 ( .A(\pat[6][0] ), .B(N633), .Y(n115) );
  XNOR2X1 U261 ( .A(\pat[6][1] ), .B(N634), .Y(n116) );
  XNOR2X1 U262 ( .A(\pat[6][2] ), .B(N635), .Y(n117) );
  NAND4X1 U263 ( .A(n143), .B(n144), .C(n145), .D(n146), .Y(n137) );
  XNOR2X1 U264 ( .A(\pat[5][0] ), .B(N591), .Y(n143) );
  XNOR2X1 U265 ( .A(\pat[5][1] ), .B(N592), .Y(n144) );
  XNOR2X1 U266 ( .A(\pat[5][2] ), .B(N593), .Y(n145) );
  NAND4X1 U267 ( .A(n161), .B(n162), .C(n163), .D(n164), .Y(n155) );
  XNOR2X1 U268 ( .A(\pat[2][0] ), .B(N465), .Y(n161) );
  XNOR2X1 U269 ( .A(\pat[2][1] ), .B(N466), .Y(n162) );
  XNOR2X1 U270 ( .A(\pat[2][2] ), .B(N467), .Y(n163) );
  NAND4X1 U271 ( .A(n175), .B(n176), .C(n177), .D(n178), .Y(n169) );
  XNOR2X1 U272 ( .A(\pat[3][0] ), .B(N507), .Y(n175) );
  XNOR2X1 U273 ( .A(\pat[3][1] ), .B(N508), .Y(n176) );
  XNOR2X1 U274 ( .A(\pat[3][2] ), .B(N509), .Y(n177) );
  NAND4X1 U275 ( .A(n97), .B(n98), .C(n99), .D(n100), .Y(n96) );
  XNOR2X1 U276 ( .A(\pat[4][4] ), .B(N553), .Y(n97) );
  XNOR2X1 U277 ( .A(\pat[4][5] ), .B(N554), .Y(n98) );
  XNOR2X1 U278 ( .A(\pat[4][6] ), .B(N555), .Y(n99) );
  NAND4X1 U279 ( .A(n111), .B(n112), .C(n113), .D(n114), .Y(n110) );
  XNOR2X1 U280 ( .A(\pat[6][4] ), .B(N637), .Y(n111) );
  XNOR2X1 U281 ( .A(\pat[6][5] ), .B(N638), .Y(n112) );
  XNOR2X1 U282 ( .A(\pat[6][6] ), .B(N639), .Y(n113) );
  NAND4X1 U283 ( .A(n139), .B(n140), .C(n141), .D(n142), .Y(n138) );
  XNOR2X1 U284 ( .A(\pat[5][4] ), .B(N595), .Y(n139) );
  XNOR2X1 U285 ( .A(\pat[5][5] ), .B(N596), .Y(n140) );
  XNOR2X1 U286 ( .A(\pat[5][6] ), .B(N597), .Y(n141) );
  NAND4X1 U287 ( .A(n157), .B(n158), .C(n159), .D(n160), .Y(n156) );
  XNOR2X1 U288 ( .A(\pat[2][7] ), .B(N472), .Y(n160) );
  XNOR2X1 U289 ( .A(\pat[2][4] ), .B(N469), .Y(n157) );
  XNOR2X1 U290 ( .A(\pat[2][5] ), .B(N470), .Y(n158) );
  NAND4X1 U291 ( .A(n171), .B(n172), .C(n173), .D(n174), .Y(n170) );
  XNOR2X1 U292 ( .A(\pat[3][7] ), .B(N514), .Y(n174) );
  XNOR2X1 U293 ( .A(\pat[3][4] ), .B(N511), .Y(n171) );
  XNOR2X1 U294 ( .A(\pat[3][5] ), .B(N512), .Y(n172) );
  AND2X2 U295 ( .A(m_cnt[4]), .B(m_cnt[3]), .Y(n7) );
  CLKBUFX3 U296 ( .A(n651), .Y(n767) );
  NOR2X1 U297 ( .A(m_cnt[3]), .B(m_cnt[4]), .Y(n651) );
  NAND2X1 U298 ( .A(n775), .B(n92), .Y(n91) );
  OAI22XL U299 ( .A0(n93), .A1(n94), .B0(n95), .B1(n96), .Y(n92) );
  NAND4X1 U300 ( .A(\pat[4][5] ), .B(\pat[4][1] ), .C(\pat[4][2] ), .D(
        \pat[4][3] ), .Y(n94) );
  OR4X1 U301 ( .A(\pat[4][0] ), .B(\pat[4][4] ), .C(\pat[4][6] ), .D(
        \pat[4][7] ), .Y(n93) );
  NAND2X1 U302 ( .A(n775), .B(n106), .Y(n105) );
  OAI22XL U303 ( .A0(n107), .A1(n108), .B0(n109), .B1(n110), .Y(n106) );
  NAND4X1 U304 ( .A(\pat[6][5] ), .B(\pat[6][1] ), .C(\pat[6][2] ), .D(
        \pat[6][3] ), .Y(n108) );
  OR4X1 U305 ( .A(\pat[6][0] ), .B(\pat[6][4] ), .C(\pat[6][6] ), .D(
        \pat[6][7] ), .Y(n107) );
  NAND2X1 U306 ( .A(n775), .B(n134), .Y(n133) );
  OAI22XL U307 ( .A0(n135), .A1(n136), .B0(n137), .B1(n138), .Y(n134) );
  NAND4X1 U308 ( .A(\pat[5][5] ), .B(\pat[5][1] ), .C(\pat[5][2] ), .D(
        \pat[5][3] ), .Y(n136) );
  OR4X1 U309 ( .A(\pat[5][0] ), .B(\pat[5][4] ), .C(\pat[5][6] ), .D(
        \pat[5][7] ), .Y(n135) );
  XNOR2X1 U310 ( .A(patmask[3]), .B(n165), .Y(n149) );
  NAND2X1 U311 ( .A(n775), .B(n166), .Y(n165) );
  OAI22XL U312 ( .A0(n167), .A1(n168), .B0(n169), .B1(n170), .Y(n166) );
  NAND4X1 U313 ( .A(\pat[3][5] ), .B(\pat[3][1] ), .C(\pat[3][2] ), .D(
        \pat[3][3] ), .Y(n168) );
  CLKBUFX3 U314 ( .A(n650), .Y(n768) );
  NOR2X1 U315 ( .A(n709), .B(m_cnt[4]), .Y(n650) );
  NAND2X1 U316 ( .A(n775), .B(n180), .Y(n179) );
  OAI22XL U317 ( .A0(n181), .A1(n182), .B0(n183), .B1(n184), .Y(n180) );
  NAND4X1 U318 ( .A(\pat[1][5] ), .B(\pat[1][1] ), .C(\pat[1][2] ), .D(
        \pat[1][3] ), .Y(n182) );
  OR4X1 U319 ( .A(\pat[1][0] ), .B(\pat[1][4] ), .C(\pat[1][6] ), .D(
        \pat[1][7] ), .Y(n181) );
  NOR2X2 U320 ( .A(m_done), .B(match_v), .Y(n74) );
  NAND4X1 U321 ( .A(n79), .B(n80), .C(n775), .D(n81), .Y(n75) );
  XOR2X1 U322 ( .A(n709), .B(N311), .Y(n79) );
  XOR2X1 U323 ( .A(n65), .B(N312), .Y(n80) );
  CLKBUFX3 U324 ( .A(m_cnt[2]), .Y(n791) );
  CLKINVX1 U325 ( .A(\str[27][7] ), .Y(n699) );
  CLKINVX1 U326 ( .A(\str[27][6] ), .Y(n698) );
  CLKINVX1 U327 ( .A(\str[27][5] ), .Y(n697) );
  CLKINVX1 U328 ( .A(\str[27][4] ), .Y(n696) );
  CLKINVX1 U329 ( .A(\str[27][3] ), .Y(n695) );
  CLKINVX1 U330 ( .A(\str[27][2] ), .Y(n694) );
  CLKINVX1 U331 ( .A(\str[27][1] ), .Y(n693) );
  CLKINVX1 U332 ( .A(\str[27][0] ), .Y(n692) );
  CLKINVX1 U333 ( .A(\str[11][7] ), .Y(n667) );
  CLKINVX1 U334 ( .A(\str[11][6] ), .Y(n666) );
  CLKINVX1 U335 ( .A(\str[11][5] ), .Y(n665) );
  CLKINVX1 U336 ( .A(\str[11][4] ), .Y(n664) );
  CLKINVX1 U337 ( .A(\str[11][3] ), .Y(n663) );
  CLKINVX1 U338 ( .A(\str[11][2] ), .Y(n662) );
  CLKINVX1 U339 ( .A(\str[11][1] ), .Y(n661) );
  CLKINVX1 U340 ( .A(\str[11][0] ), .Y(n660) );
  CLKBUFX3 U341 ( .A(m_cnt[1]), .Y(n790) );
  CLKINVX1 U342 ( .A(\str[28][3] ), .Y(n703) );
  CLKINVX1 U343 ( .A(\str[28][2] ), .Y(n702) );
  CLKINVX1 U344 ( .A(\str[28][1] ), .Y(n701) );
  CLKINVX1 U345 ( .A(\str[28][0] ), .Y(n700) );
  CLKINVX1 U346 ( .A(\str[28][6] ), .Y(n706) );
  CLKINVX1 U347 ( .A(\str[28][5] ), .Y(n705) );
  CLKINVX1 U348 ( .A(\str[28][4] ), .Y(n704) );
  CLKINVX1 U349 ( .A(\str[28][7] ), .Y(n707) );
  CLKINVX1 U350 ( .A(\str[12][3] ), .Y(n671) );
  CLKINVX1 U351 ( .A(\str[12][2] ), .Y(n670) );
  CLKINVX1 U352 ( .A(\str[12][1] ), .Y(n669) );
  CLKINVX1 U353 ( .A(\str[12][0] ), .Y(n668) );
  CLKINVX1 U354 ( .A(\str[12][6] ), .Y(n674) );
  CLKINVX1 U355 ( .A(\str[12][5] ), .Y(n673) );
  CLKINVX1 U356 ( .A(\str[12][4] ), .Y(n672) );
  CLKINVX1 U357 ( .A(\str[12][7] ), .Y(n675) );
  AOI221XL U358 ( .A0(\str[1][6] ), .A1(n779), .B0(\str[9][6] ), .B1(n217), 
        .C0(n244), .Y(n241) );
  AO22X1 U359 ( .A0(\str[25][6] ), .A1(n777), .B0(\str[17][6] ), .B1(n220), 
        .Y(n244) );
  AOI221XL U360 ( .A0(\str[0][6] ), .A1(n786), .B0(\str[8][6] ), .B1(n784), 
        .C0(n243), .Y(n242) );
  AO22X1 U361 ( .A0(\str[24][6] ), .A1(n782), .B0(\str[16][6] ), .B1(n780), 
        .Y(n243) );
  AOI221XL U362 ( .A0(\str[0][5] ), .A1(n786), .B0(\str[8][5] ), .B1(n784), 
        .C0(n265), .Y(n264) );
  AO22X1 U363 ( .A0(\str[24][5] ), .A1(n783), .B0(\str[16][5] ), .B1(n780), 
        .Y(n265) );
  AOI221XL U364 ( .A0(\str[0][4] ), .A1(n786), .B0(\str[8][4] ), .B1(n784), 
        .C0(n287), .Y(n286) );
  AO22X1 U365 ( .A0(\str[24][4] ), .A1(n783), .B0(\str[16][4] ), .B1(n781), 
        .Y(n287) );
  AOI21X1 U366 ( .A0(n208), .A1(n209), .B0(n210), .Y(n207) );
  AOI221XL U367 ( .A0(\str[1][7] ), .A1(n779), .B0(\str[9][7] ), .B1(n778), 
        .C0(n218), .Y(n208) );
  AOI221XL U368 ( .A0(\str[0][7] ), .A1(n786), .B0(\str[8][7] ), .B1(n784), 
        .C0(n213), .Y(n209) );
  AO22X1 U369 ( .A0(\str[25][7] ), .A1(n777), .B0(\str[17][7] ), .B1(n220), 
        .Y(n218) );
  AOI21X1 U370 ( .A0(n311), .A1(n312), .B0(n210), .Y(n310) );
  AOI221XL U371 ( .A0(\str[1][3] ), .A1(n779), .B0(\str[9][3] ), .B1(n217), 
        .C0(n314), .Y(n311) );
  AOI221XL U372 ( .A0(\str[0][3] ), .A1(n786), .B0(\str[8][3] ), .B1(n784), 
        .C0(n313), .Y(n312) );
  AO22X1 U373 ( .A0(\str[25][3] ), .A1(n777), .B0(\str[17][3] ), .B1(n220), 
        .Y(n314) );
  AOI21X1 U374 ( .A0(n333), .A1(n334), .B0(n210), .Y(n332) );
  AOI221XL U375 ( .A0(\str[1][2] ), .A1(n779), .B0(\str[9][2] ), .B1(n217), 
        .C0(n336), .Y(n333) );
  AOI221XL U376 ( .A0(\str[0][2] ), .A1(n786), .B0(\str[8][2] ), .B1(n784), 
        .C0(n335), .Y(n334) );
  AO22X1 U377 ( .A0(\str[25][2] ), .A1(n777), .B0(\str[17][2] ), .B1(n220), 
        .Y(n336) );
  AOI21X1 U378 ( .A0(n355), .A1(n356), .B0(n210), .Y(n354) );
  AOI221XL U379 ( .A0(\str[1][1] ), .A1(n779), .B0(\str[9][1] ), .B1(n778), 
        .C0(n358), .Y(n355) );
  AOI221XL U380 ( .A0(\str[0][1] ), .A1(n787), .B0(\str[8][1] ), .B1(n785), 
        .C0(n357), .Y(n356) );
  AO22X1 U381 ( .A0(\str[25][1] ), .A1(n777), .B0(\str[17][1] ), .B1(n220), 
        .Y(n358) );
  AOI21X1 U382 ( .A0(n377), .A1(n378), .B0(n210), .Y(n376) );
  AOI221XL U383 ( .A0(\str[1][0] ), .A1(n779), .B0(\str[9][0] ), .B1(n778), 
        .C0(n380), .Y(n377) );
  AOI221XL U384 ( .A0(\str[0][0] ), .A1(n787), .B0(\str[8][0] ), .B1(n785), 
        .C0(n379), .Y(n378) );
  AO22X1 U385 ( .A0(\str[25][0] ), .A1(n777), .B0(\str[17][0] ), .B1(n220), 
        .Y(n380) );
  XOR2X1 U386 ( .A(\pat[0][1] ), .B(n351), .Y(n304) );
  AOI211X1 U387 ( .A0(n204), .A1(n352), .B0(n353), .C0(n354), .Y(n351) );
  NAND4X1 U388 ( .A(n369), .B(n370), .C(n371), .D(n372), .Y(n352) );
  OAI22XL U389 ( .A0(n359), .A1(n222), .B0(n360), .B1(n224), .Y(n353) );
  XOR2X1 U390 ( .A(\pat[0][7] ), .B(n203), .Y(n202) );
  AOI211X1 U391 ( .A0(n204), .A1(n205), .B0(n206), .C0(n207), .Y(n203) );
  NAND4X1 U392 ( .A(n233), .B(n234), .C(n235), .D(n236), .Y(n205) );
  OAI22XL U393 ( .A0(n221), .A1(n222), .B0(n223), .B1(n224), .Y(n206) );
  XOR2X1 U394 ( .A(\pat[0][3] ), .B(n307), .Y(n306) );
  AOI211X1 U395 ( .A0(n204), .A1(n308), .B0(n309), .C0(n310), .Y(n307) );
  NAND4X1 U396 ( .A(n325), .B(n326), .C(n327), .D(n328), .Y(n308) );
  OAI22XL U397 ( .A0(n315), .A1(n222), .B0(n316), .B1(n224), .Y(n309) );
  XOR2X1 U398 ( .A(\pat[0][2] ), .B(n329), .Y(n305) );
  AOI211X1 U399 ( .A0(n204), .A1(n330), .B0(n331), .C0(n332), .Y(n329) );
  NAND4X1 U400 ( .A(n347), .B(n348), .C(n349), .D(n350), .Y(n330) );
  OAI22XL U401 ( .A0(n337), .A1(n222), .B0(n338), .B1(n224), .Y(n331) );
  XOR2X1 U402 ( .A(\pat[0][0] ), .B(n373), .Y(n303) );
  AOI211X1 U403 ( .A0(n204), .A1(n374), .B0(n375), .C0(n376), .Y(n373) );
  NAND4X1 U404 ( .A(n391), .B(n392), .C(n393), .D(n394), .Y(n374) );
  OAI22XL U405 ( .A0(n381), .A1(n222), .B0(n382), .B1(n224), .Y(n375) );
  NOR4X1 U406 ( .A(n229), .B(n230), .C(n231), .D(n232), .Y(n221) );
  AO22X1 U407 ( .A0(\str[14][7] ), .A1(n785), .B0(\str[6][7] ), .B1(n787), .Y(
        n229) );
  AO22X1 U408 ( .A0(\str[15][7] ), .A1(n778), .B0(\str[7][7] ), .B1(n216), .Y(
        n231) );
  AO22X1 U409 ( .A0(\str[31][7] ), .A1(n777), .B0(\str[23][7] ), .B1(n220), 
        .Y(n232) );
  NOR4X1 U410 ( .A(n251), .B(n252), .C(n253), .D(n254), .Y(n245) );
  AO22X1 U411 ( .A0(\str[14][6] ), .A1(n785), .B0(\str[6][6] ), .B1(n787), .Y(
        n251) );
  AO22X1 U412 ( .A0(\str[15][6] ), .A1(n778), .B0(\str[7][6] ), .B1(n216), .Y(
        n253) );
  AO22X1 U413 ( .A0(\str[30][6] ), .A1(n782), .B0(\str[22][6] ), .B1(n780), 
        .Y(n252) );
  NOR4X1 U414 ( .A(n273), .B(n274), .C(n275), .D(n276), .Y(n267) );
  AO22X1 U415 ( .A0(\str[14][5] ), .A1(n785), .B0(\str[6][5] ), .B1(n787), .Y(
        n273) );
  AO22X1 U416 ( .A0(\str[15][5] ), .A1(n778), .B0(\str[7][5] ), .B1(n216), .Y(
        n275) );
  AO22X1 U417 ( .A0(\str[30][5] ), .A1(n783), .B0(\str[22][5] ), .B1(n781), 
        .Y(n274) );
  NOR4X1 U418 ( .A(n295), .B(n296), .C(n297), .D(n298), .Y(n289) );
  AO22X1 U419 ( .A0(\str[14][4] ), .A1(n785), .B0(\str[6][4] ), .B1(n787), .Y(
        n295) );
  AO22X1 U420 ( .A0(\str[15][4] ), .A1(n778), .B0(\str[7][4] ), .B1(n779), .Y(
        n297) );
  AO22X1 U421 ( .A0(\str[30][4] ), .A1(n783), .B0(\str[22][4] ), .B1(n781), 
        .Y(n296) );
  NOR4X1 U422 ( .A(n321), .B(n322), .C(n323), .D(n324), .Y(n315) );
  AO22X1 U423 ( .A0(\str[14][3] ), .A1(n785), .B0(\str[6][3] ), .B1(n787), .Y(
        n321) );
  AO22X1 U424 ( .A0(\str[15][3] ), .A1(n778), .B0(\str[7][3] ), .B1(n216), .Y(
        n323) );
  AO22X1 U425 ( .A0(\str[30][3] ), .A1(n783), .B0(\str[22][3] ), .B1(n781), 
        .Y(n322) );
  NOR4X1 U426 ( .A(n343), .B(n344), .C(n345), .D(n346), .Y(n337) );
  AO22X1 U427 ( .A0(\str[14][2] ), .A1(n785), .B0(\str[6][2] ), .B1(n787), .Y(
        n343) );
  AO22X1 U428 ( .A0(\str[15][2] ), .A1(n778), .B0(\str[7][2] ), .B1(n216), .Y(
        n345) );
  AO22X1 U429 ( .A0(\str[30][2] ), .A1(n783), .B0(\str[22][2] ), .B1(n781), 
        .Y(n344) );
  NOR4X1 U430 ( .A(n365), .B(n366), .C(n367), .D(n368), .Y(n359) );
  AO22X1 U431 ( .A0(\str[14][1] ), .A1(n785), .B0(\str[6][1] ), .B1(n787), .Y(
        n365) );
  AO22X1 U432 ( .A0(\str[15][1] ), .A1(n778), .B0(\str[7][1] ), .B1(n216), .Y(
        n367) );
  AO22X1 U433 ( .A0(\str[30][1] ), .A1(n783), .B0(\str[22][1] ), .B1(n781), 
        .Y(n366) );
  NOR4X1 U434 ( .A(n387), .B(n388), .C(n389), .D(n390), .Y(n381) );
  AO22X1 U435 ( .A0(\str[14][0] ), .A1(n785), .B0(\str[6][0] ), .B1(n787), .Y(
        n387) );
  AO22X1 U436 ( .A0(\str[15][0] ), .A1(n778), .B0(\str[7][0] ), .B1(n779), .Y(
        n389) );
  AO22X1 U437 ( .A0(\str[31][0] ), .A1(n777), .B0(\str[23][0] ), .B1(n776), 
        .Y(n390) );
  NOR4X1 U438 ( .A(n225), .B(n226), .C(n227), .D(n228), .Y(n223) );
  AO22X1 U439 ( .A0(\str[12][7] ), .A1(n785), .B0(\str[4][7] ), .B1(n787), .Y(
        n225) );
  AO22X1 U440 ( .A0(\str[13][7] ), .A1(n778), .B0(\str[5][7] ), .B1(n216), .Y(
        n227) );
  AO22X1 U441 ( .A0(\str[29][7] ), .A1(n777), .B0(\str[21][7] ), .B1(n220), 
        .Y(n228) );
  NOR4X1 U442 ( .A(n247), .B(n248), .C(n249), .D(n250), .Y(n246) );
  AO22X1 U443 ( .A0(\str[12][6] ), .A1(n785), .B0(\str[4][6] ), .B1(n787), .Y(
        n247) );
  AO22X1 U444 ( .A0(\str[13][6] ), .A1(n778), .B0(\str[5][6] ), .B1(n216), .Y(
        n249) );
  AO22X1 U445 ( .A0(\str[28][6] ), .A1(n782), .B0(\str[20][6] ), .B1(n780), 
        .Y(n248) );
  NOR4X1 U446 ( .A(n269), .B(n270), .C(n271), .D(n272), .Y(n268) );
  AO22X1 U447 ( .A0(\str[12][5] ), .A1(n785), .B0(\str[4][5] ), .B1(n787), .Y(
        n269) );
  AO22X1 U448 ( .A0(\str[13][5] ), .A1(n778), .B0(\str[5][5] ), .B1(n216), .Y(
        n271) );
  AO22X1 U449 ( .A0(\str[28][5] ), .A1(n783), .B0(\str[20][5] ), .B1(n781), 
        .Y(n270) );
  NOR4X1 U450 ( .A(n291), .B(n292), .C(n293), .D(n294), .Y(n290) );
  AO22X1 U451 ( .A0(\str[12][4] ), .A1(n785), .B0(\str[4][4] ), .B1(n787), .Y(
        n291) );
  AO22X1 U452 ( .A0(\str[13][4] ), .A1(n778), .B0(\str[5][4] ), .B1(n216), .Y(
        n293) );
  AO22X1 U453 ( .A0(\str[28][4] ), .A1(n783), .B0(\str[20][4] ), .B1(n781), 
        .Y(n292) );
  NOR4X1 U454 ( .A(n317), .B(n318), .C(n319), .D(n320), .Y(n316) );
  AO22X1 U455 ( .A0(\str[12][3] ), .A1(n785), .B0(\str[4][3] ), .B1(n787), .Y(
        n317) );
  AO22X1 U456 ( .A0(\str[13][3] ), .A1(n778), .B0(\str[5][3] ), .B1(n216), .Y(
        n319) );
  AO22X1 U457 ( .A0(\str[28][3] ), .A1(n783), .B0(\str[20][3] ), .B1(n781), 
        .Y(n318) );
  NOR4X1 U458 ( .A(n339), .B(n340), .C(n341), .D(n342), .Y(n338) );
  AO22X1 U459 ( .A0(\str[12][2] ), .A1(n785), .B0(\str[4][2] ), .B1(n787), .Y(
        n339) );
  AO22X1 U460 ( .A0(\str[13][2] ), .A1(n778), .B0(\str[5][2] ), .B1(n216), .Y(
        n341) );
  AO22X1 U461 ( .A0(\str[28][2] ), .A1(n783), .B0(\str[20][2] ), .B1(n781), 
        .Y(n340) );
  NOR4X1 U462 ( .A(n361), .B(n362), .C(n363), .D(n364), .Y(n360) );
  AO22X1 U463 ( .A0(\str[12][1] ), .A1(n785), .B0(\str[4][1] ), .B1(n787), .Y(
        n361) );
  AO22X1 U464 ( .A0(\str[13][1] ), .A1(n778), .B0(\str[5][1] ), .B1(n216), .Y(
        n363) );
  AO22X1 U465 ( .A0(\str[28][1] ), .A1(n783), .B0(\str[20][1] ), .B1(n781), 
        .Y(n362) );
  NOR4X1 U466 ( .A(n383), .B(n384), .C(n385), .D(n386), .Y(n382) );
  AO22X1 U467 ( .A0(\str[12][0] ), .A1(n785), .B0(\str[4][0] ), .B1(n787), .Y(
        n383) );
  AO22X1 U468 ( .A0(\str[13][0] ), .A1(n778), .B0(\str[5][0] ), .B1(n216), .Y(
        n385) );
  AO22X1 U469 ( .A0(\str[28][0] ), .A1(n783), .B0(\str[20][0] ), .B1(n781), 
        .Y(n384) );
  AOI22X1 U470 ( .A0(\str[2][7] ), .A1(n786), .B0(\str[10][7] ), .B1(n784), 
        .Y(n236) );
  AOI22X1 U471 ( .A0(\str[2][6] ), .A1(n786), .B0(\str[10][6] ), .B1(n784), 
        .Y(n258) );
  AOI22X1 U472 ( .A0(\str[2][5] ), .A1(n786), .B0(\str[10][5] ), .B1(n784), 
        .Y(n280) );
  AOI22X1 U473 ( .A0(\str[2][4] ), .A1(n786), .B0(\str[10][4] ), .B1(n784), 
        .Y(n302) );
  AOI22X1 U474 ( .A0(\str[2][3] ), .A1(n786), .B0(\str[10][3] ), .B1(n784), 
        .Y(n328) );
  AOI22X1 U475 ( .A0(\str[2][2] ), .A1(n786), .B0(\str[10][2] ), .B1(n784), 
        .Y(n350) );
  AOI22X1 U476 ( .A0(\str[2][1] ), .A1(n786), .B0(\str[10][1] ), .B1(n784), 
        .Y(n372) );
  AOI22X1 U477 ( .A0(\str[2][0] ), .A1(n786), .B0(\str[10][0] ), .B1(n784), 
        .Y(n394) );
  AOI22X1 U478 ( .A0(\str[18][7] ), .A1(n780), .B0(\str[26][7] ), .B1(n782), 
        .Y(n235) );
  AOI22X1 U479 ( .A0(\str[18][6] ), .A1(n780), .B0(\str[26][6] ), .B1(n782), 
        .Y(n257) );
  AOI22X1 U480 ( .A0(\str[18][5] ), .A1(n780), .B0(\str[26][5] ), .B1(n782), 
        .Y(n279) );
  AOI22X1 U481 ( .A0(\str[18][4] ), .A1(n780), .B0(\str[26][4] ), .B1(n782), 
        .Y(n301) );
  AOI22X1 U482 ( .A0(\str[18][3] ), .A1(n780), .B0(\str[26][3] ), .B1(n782), 
        .Y(n327) );
  AOI22X1 U483 ( .A0(\str[18][2] ), .A1(n780), .B0(\str[26][2] ), .B1(n782), 
        .Y(n349) );
  AOI22X1 U484 ( .A0(\str[18][1] ), .A1(n780), .B0(\str[26][1] ), .B1(n782), 
        .Y(n371) );
  AOI22X1 U485 ( .A0(\str[18][0] ), .A1(n780), .B0(\str[26][0] ), .B1(n782), 
        .Y(n393) );
  AOI22X1 U486 ( .A0(\str[3][7] ), .A1(n779), .B0(\str[11][7] ), .B1(n217), 
        .Y(n234) );
  AOI22X1 U487 ( .A0(\str[3][6] ), .A1(n779), .B0(\str[11][6] ), .B1(n217), 
        .Y(n256) );
  AOI22X1 U488 ( .A0(\str[3][5] ), .A1(n779), .B0(\str[11][5] ), .B1(n217), 
        .Y(n278) );
  AOI22X1 U489 ( .A0(\str[3][4] ), .A1(n779), .B0(\str[11][4] ), .B1(n217), 
        .Y(n300) );
  AOI22X1 U490 ( .A0(\str[3][3] ), .A1(n779), .B0(\str[11][3] ), .B1(n217), 
        .Y(n326) );
  AOI22X1 U491 ( .A0(\str[3][2] ), .A1(n779), .B0(\str[11][2] ), .B1(n217), 
        .Y(n348) );
  AOI22X1 U492 ( .A0(\str[3][1] ), .A1(n779), .B0(\str[11][1] ), .B1(n217), 
        .Y(n370) );
  AOI22X1 U493 ( .A0(\str[3][0] ), .A1(n779), .B0(\str[11][0] ), .B1(n778), 
        .Y(n392) );
  AOI22X1 U494 ( .A0(\str[19][7] ), .A1(n776), .B0(\str[27][7] ), .B1(n219), 
        .Y(n233) );
  AOI22X1 U495 ( .A0(\str[19][6] ), .A1(n776), .B0(\str[27][6] ), .B1(n219), 
        .Y(n255) );
  AOI22X1 U496 ( .A0(\str[19][5] ), .A1(n776), .B0(\str[27][5] ), .B1(n219), 
        .Y(n277) );
  AOI22X1 U497 ( .A0(\str[19][4] ), .A1(n776), .B0(\str[27][4] ), .B1(n219), 
        .Y(n299) );
  AOI22X1 U498 ( .A0(\str[19][3] ), .A1(n776), .B0(\str[27][3] ), .B1(n219), 
        .Y(n325) );
  AOI22X1 U499 ( .A0(\str[19][2] ), .A1(n776), .B0(\str[27][2] ), .B1(n219), 
        .Y(n347) );
  AOI22X1 U500 ( .A0(\str[19][1] ), .A1(n776), .B0(\str[27][1] ), .B1(n219), 
        .Y(n369) );
  AOI22X1 U501 ( .A0(\str[19][0] ), .A1(n776), .B0(\str[27][0] ), .B1(n777), 
        .Y(n391) );
  NAND4X1 U502 ( .A(n199), .B(n200), .C(n201), .D(n202), .Y(n198) );
  XOR2X1 U503 ( .A(\pat[0][4] ), .B(n281), .Y(n199) );
  XOR2X1 U504 ( .A(\pat[0][5] ), .B(n259), .Y(n200) );
  XOR2X1 U505 ( .A(\pat[0][6] ), .B(n237), .Y(n201) );
  NOR2X1 U506 ( .A(n65), .B(m_cnt[3]), .Y(n398) );
  NOR2X1 U507 ( .A(n709), .B(m_cnt[4]), .Y(n395) );
  NOR2X1 U508 ( .A(n65), .B(n709), .Y(n397) );
  AO22X1 U509 ( .A0(\str[31][6] ), .A1(n219), .B0(\str[23][6] ), .B1(n776), 
        .Y(n254) );
  AO22X1 U510 ( .A0(\str[31][5] ), .A1(n219), .B0(\str[23][5] ), .B1(n776), 
        .Y(n276) );
  AO22X1 U511 ( .A0(\str[31][4] ), .A1(n777), .B0(\str[23][4] ), .B1(n776), 
        .Y(n298) );
  AO22X1 U512 ( .A0(\str[31][3] ), .A1(n777), .B0(\str[23][3] ), .B1(n220), 
        .Y(n324) );
  AO22X1 U513 ( .A0(\str[31][2] ), .A1(n777), .B0(\str[23][2] ), .B1(n220), 
        .Y(n346) );
  AO22X1 U514 ( .A0(\str[31][1] ), .A1(n777), .B0(\str[23][1] ), .B1(n776), 
        .Y(n368) );
  AO22X1 U515 ( .A0(\str[29][4] ), .A1(n777), .B0(\str[21][4] ), .B1(n220), 
        .Y(n294) );
  AO22X1 U516 ( .A0(\str[29][3] ), .A1(n777), .B0(\str[21][3] ), .B1(n220), 
        .Y(n320) );
  AO22X1 U517 ( .A0(\str[29][2] ), .A1(n777), .B0(\str[21][2] ), .B1(n220), 
        .Y(n342) );
  AO22X1 U518 ( .A0(\str[29][1] ), .A1(n777), .B0(\str[21][1] ), .B1(n220), 
        .Y(n364) );
  AO22X1 U519 ( .A0(\str[29][0] ), .A1(n777), .B0(\str[21][0] ), .B1(n776), 
        .Y(n386) );
  AO22X1 U520 ( .A0(\str[29][6] ), .A1(n219), .B0(\str[21][6] ), .B1(n776), 
        .Y(n250) );
  AO22X1 U521 ( .A0(\str[29][5] ), .A1(n219), .B0(\str[21][5] ), .B1(n776), 
        .Y(n272) );
  AO22X1 U522 ( .A0(\str[30][7] ), .A1(n782), .B0(\str[22][7] ), .B1(n780), 
        .Y(n230) );
  AO22X1 U523 ( .A0(\str[30][0] ), .A1(n782), .B0(\str[22][0] ), .B1(n780), 
        .Y(n388) );
  AO22X1 U524 ( .A0(\str[28][7] ), .A1(n782), .B0(\str[20][7] ), .B1(n780), 
        .Y(n226) );
  AO22X1 U525 ( .A0(\str[24][7] ), .A1(n783), .B0(\str[16][7] ), .B1(n781), 
        .Y(n213) );
  AO22X1 U526 ( .A0(\str[24][3] ), .A1(n783), .B0(\str[16][3] ), .B1(n781), 
        .Y(n313) );
  AO22X1 U527 ( .A0(\str[24][2] ), .A1(n783), .B0(\str[16][2] ), .B1(n781), 
        .Y(n335) );
  AO22X1 U528 ( .A0(\str[24][1] ), .A1(n783), .B0(\str[16][1] ), .B1(n781), 
        .Y(n357) );
  AO22X1 U529 ( .A0(\str[24][0] ), .A1(n783), .B0(\str[16][0] ), .B1(n781), 
        .Y(n379) );
  AOI221XL U530 ( .A0(\str[1][5] ), .A1(n779), .B0(\str[9][5] ), .B1(n217), 
        .C0(n266), .Y(n263) );
  AO22X1 U531 ( .A0(\str[25][5] ), .A1(n777), .B0(\str[17][5] ), .B1(n776), 
        .Y(n266) );
  AOI221XL U532 ( .A0(\str[1][4] ), .A1(n779), .B0(\str[9][4] ), .B1(n217), 
        .C0(n288), .Y(n285) );
  AO22X1 U533 ( .A0(\str[25][4] ), .A1(n219), .B0(\str[17][4] ), .B1(n776), 
        .Y(n288) );
  NAND2X2 U534 ( .A(n791), .B(n67), .Y(n224) );
  NOR2X2 U535 ( .A(n67), .B(n791), .Y(n204) );
  NAND4BBXL U536 ( .AN(\pat[0][0] ), .BN(\pat[0][1] ), .C(\pat[0][5] ), .D(
        ctrlsig[0]), .Y(n71) );
  NOR3BXL U537 ( .AN(ctrlsig[1]), .B(starsig), .C(n797), .Y(n73) );
  NAND4X1 U538 ( .A(\pat[0][5] ), .B(\pat[0][1] ), .C(n195), .D(n196), .Y(n70)
         );
  AND2X2 U539 ( .A(\pat[0][3] ), .B(\pat[0][2] ), .Y(n195) );
  NOR4X1 U540 ( .A(patmask[3]), .B(patmask[2]), .C(patmask[1]), .D(patmask[0]), 
        .Y(n147) );
  NOR4X1 U541 ( .A(patmask[7]), .B(patmask[6]), .C(patmask[5]), .D(patmask[4]), 
        .Y(n148) );
  CLKINVX1 U542 ( .A(plen[0]), .Y(n795) );
  OR4X1 U543 ( .A(\pat[7][0] ), .B(\pat[7][4] ), .C(\pat[7][6] ), .D(
        \pat[7][7] ), .Y(n121) );
  OR4X1 U544 ( .A(\pat[2][0] ), .B(\pat[2][4] ), .C(\pat[2][6] ), .D(
        \pat[2][7] ), .Y(n153) );
  OR4X1 U545 ( .A(\pat[3][0] ), .B(\pat[3][4] ), .C(\pat[3][6] ), .D(
        \pat[3][7] ), .Y(n167) );
  ADDFXL U546 ( .A(slen[1]), .B(n794), .CI(\sub_1_root_add_90/carry[1] ), .CO(
        \sub_1_root_add_90/carry[2] ), .S(N304) );
  CLKINVX1 U547 ( .A(plen[1]), .Y(n794) );
  ADDFXL U548 ( .A(slen[2]), .B(n793), .CI(\sub_1_root_add_90/carry[2] ), .CO(
        \sub_1_root_add_90/carry[3] ), .S(N305) );
  CLKINVX1 U549 ( .A(plen[2]), .Y(n793) );
  ADDFXL U550 ( .A(slen[3]), .B(n792), .CI(\sub_1_root_add_90/carry[3] ), .CO(
        \sub_1_root_add_90/carry[4] ), .S(N306) );
  CLKINVX1 U551 ( .A(plen[3]), .Y(n792) );
  ADDHXL U552 ( .A(m_cnt[3]), .B(\r434/carry[3] ), .CO(\r434/carry[4] ), .S(
        N296) );
  OA22X1 U553 ( .A0(\str[26][0] ), .A1(n756), .B0(\str[34][0] ), .B1(n748), 
        .Y(n8) );
  OA22X1 U554 ( .A0(\str[24][0] ), .A1(n755), .B0(\str[32][0] ), .B1(n749), 
        .Y(n9) );
  OAI221XL U555 ( .A0(\str[8][0] ), .A1(n762), .B0(\str[16][0] ), .B1(n710), 
        .C0(n9), .Y(n482) );
  AOI222XL U556 ( .A0(n769), .A1(n700), .B0(n770), .B1(n668), .C0(n771), .C1(
        n684), .Y(n10) );
  OAI221XL U557 ( .A0(\str[36][0] ), .A1(n426), .B0(n791), .B1(n726), .C0(n10), 
        .Y(n435) );
  OA22X1 U558 ( .A0(\str[25][0] ), .A1(n754), .B0(\str[33][0] ), .B1(n749), 
        .Y(n11) );
  OA22X1 U559 ( .A0(\str[37][0] ), .A1(n750), .B0(\str[29][0] ), .B1(n754), 
        .Y(n12) );
  OAI221XL U560 ( .A0(n762), .A1(\str[13][0] ), .B0(n765), .B1(\str[21][0] ), 
        .C0(n12), .Y(n15) );
  OA22X1 U561 ( .A0(\str[23][0] ), .A1(n754), .B0(\str[31][0] ), .B1(n748), 
        .Y(n13) );
  OAI221XL U562 ( .A0(\str[7][0] ), .A1(n761), .B0(\str[15][0] ), .B1(n765), 
        .C0(n13), .Y(n522) );
  AOI222XL U563 ( .A0(n769), .A1(n692), .B0(n770), .B1(n660), .C0(n771), .C1(
        n676), .Y(n14) );
  OAI221XL U564 ( .A0(\str[35][0] ), .A1(n426), .B0(n730), .B1(n725), .C0(n14), 
        .Y(n459) );
  AOI222XL U565 ( .A0(n742), .A1(n525), .B0(n744), .B1(n15), .C0(n734), .C1(
        n459), .Y(n436) );
  AO22X1 U566 ( .A0(n768), .A1(\str[22][0] ), .B0(n767), .B1(\str[14][0] ), 
        .Y(n16) );
  AOI221XL U567 ( .A0(\str[30][0] ), .A1(n752), .B0(\str[38][0] ), .B1(n746), 
        .C0(n16), .Y(n17) );
  OAI221XL U568 ( .A0(n485), .A1(n433), .B0(n435), .B1(n432), .C0(n18), .Y(
        N675) );
  OA22X1 U569 ( .A0(\str[26][1] ), .A1(n754), .B0(\str[34][1] ), .B1(n747), 
        .Y(n19) );
  OA22X1 U570 ( .A0(\str[24][1] ), .A1(n754), .B0(\str[32][1] ), .B1(n749), 
        .Y(n20) );
  OAI221XL U571 ( .A0(\str[8][1] ), .A1(n762), .B0(\str[16][1] ), .B1(n766), 
        .C0(n20), .Y(n487) );
  AOI222XL U572 ( .A0(n769), .A1(n701), .B0(n770), .B1(n669), .C0(n771), .C1(
        n685), .Y(n21) );
  OAI221XL U573 ( .A0(\str[36][1] ), .A1(n426), .B0(n791), .B1(n724), .C0(n21), 
        .Y(n438) );
  OA22X1 U574 ( .A0(\str[25][1] ), .A1(n755), .B0(\str[33][1] ), .B1(n747), 
        .Y(n22) );
  OA22X1 U575 ( .A0(\str[37][1] ), .A1(n750), .B0(\str[29][1] ), .B1(n754), 
        .Y(n23) );
  OAI221XL U576 ( .A0(n762), .A1(\str[13][1] ), .B0(n765), .B1(\str[21][1] ), 
        .C0(n23), .Y(n26) );
  OA22X1 U577 ( .A0(\str[23][1] ), .A1(n755), .B0(\str[31][1] ), .B1(n749), 
        .Y(n24) );
  OAI221XL U578 ( .A0(\str[7][1] ), .A1(n761), .B0(\str[15][1] ), .B1(n766), 
        .C0(n24), .Y(n527) );
  AOI222XL U579 ( .A0(n769), .A1(n693), .B0(n770), .B1(n661), .C0(n771), .C1(
        n677), .Y(n25) );
  OAI221XL U580 ( .A0(\str[35][1] ), .A1(n426), .B0(n730), .B1(n723), .C0(n25), 
        .Y(n462) );
  AOI222XL U581 ( .A0(n742), .A1(n530), .B0(n744), .B1(n26), .C0(n734), .C1(
        n462), .Y(n439) );
  AO22X1 U582 ( .A0(n768), .A1(\str[22][1] ), .B0(n767), .B1(\str[14][1] ), 
        .Y(n27) );
  AOI221XL U583 ( .A0(\str[30][1] ), .A1(n751), .B0(\str[38][1] ), .B1(n745), 
        .C0(n27), .Y(n28) );
  OAI221XL U584 ( .A0(n490), .A1(n433), .B0(n438), .B1(n432), .C0(n29), .Y(
        N676) );
  OA22X1 U585 ( .A0(\str[26][2] ), .A1(n754), .B0(\str[34][2] ), .B1(n748), 
        .Y(n30) );
  OA22X1 U586 ( .A0(\str[24][2] ), .A1(n755), .B0(\str[32][2] ), .B1(n747), 
        .Y(n31) );
  OAI221XL U587 ( .A0(\str[8][2] ), .A1(n761), .B0(\str[16][2] ), .B1(n710), 
        .C0(n31), .Y(n492) );
  AOI222XL U588 ( .A0(n769), .A1(n702), .B0(n770), .B1(n670), .C0(n771), .C1(
        n686), .Y(n32) );
  OAI221XL U589 ( .A0(\str[36][2] ), .A1(n426), .B0(n791), .B1(n722), .C0(n32), 
        .Y(n441) );
  OA22X1 U590 ( .A0(\str[25][2] ), .A1(n755), .B0(\str[33][2] ), .B1(n748), 
        .Y(n33) );
  OA22X1 U591 ( .A0(\str[37][2] ), .A1(n750), .B0(\str[29][2] ), .B1(n754), 
        .Y(n34) );
  OAI221XL U592 ( .A0(n762), .A1(\str[13][2] ), .B0(n765), .B1(\str[21][2] ), 
        .C0(n34), .Y(n37) );
  OA22X1 U593 ( .A0(\str[23][2] ), .A1(n755), .B0(\str[31][2] ), .B1(n749), 
        .Y(n35) );
  OAI221XL U594 ( .A0(\str[7][2] ), .A1(n761), .B0(\str[15][2] ), .B1(n766), 
        .C0(n35), .Y(n532) );
  AOI222XL U595 ( .A0(n769), .A1(n694), .B0(n770), .B1(n662), .C0(n771), .C1(
        n678), .Y(n36) );
  OAI221XL U596 ( .A0(\str[35][2] ), .A1(n426), .B0(n730), .B1(n721), .C0(n36), 
        .Y(n465) );
  AOI222XL U597 ( .A0(n742), .A1(n535), .B0(n744), .B1(n37), .C0(n734), .C1(
        n465), .Y(n442) );
  AO22X1 U598 ( .A0(n768), .A1(\str[22][2] ), .B0(n767), .B1(\str[14][2] ), 
        .Y(n38) );
  AOI221XL U599 ( .A0(\str[30][2] ), .A1(n752), .B0(\str[38][2] ), .B1(n745), 
        .C0(n38), .Y(n39) );
  OAI221XL U600 ( .A0(n495), .A1(n433), .B0(n441), .B1(n432), .C0(n40), .Y(
        N677) );
  OA22X1 U601 ( .A0(\str[26][3] ), .A1(n756), .B0(\str[34][3] ), .B1(n747), 
        .Y(n41) );
  OA22X1 U602 ( .A0(\str[24][3] ), .A1(n755), .B0(\str[32][3] ), .B1(n747), 
        .Y(n42) );
  OAI221XL U603 ( .A0(\str[8][3] ), .A1(n761), .B0(\str[16][3] ), .B1(n765), 
        .C0(n42), .Y(n497) );
  AOI222XL U604 ( .A0(n769), .A1(n703), .B0(n770), .B1(n671), .C0(n771), .C1(
        n687), .Y(n43) );
  OAI221XL U605 ( .A0(\str[36][3] ), .A1(n426), .B0(n791), .B1(n720), .C0(n43), 
        .Y(n444) );
  OA22X1 U606 ( .A0(\str[25][3] ), .A1(n755), .B0(\str[33][3] ), .B1(n747), 
        .Y(n44) );
  OA22X1 U607 ( .A0(\str[37][3] ), .A1(n749), .B0(\str[29][3] ), .B1(n754), 
        .Y(n45) );
  OAI221XL U608 ( .A0(n762), .A1(\str[13][3] ), .B0(n765), .B1(\str[21][3] ), 
        .C0(n45), .Y(n48) );
  OA22X1 U609 ( .A0(\str[23][3] ), .A1(n755), .B0(\str[31][3] ), .B1(n747), 
        .Y(n46) );
  OAI221XL U610 ( .A0(\str[7][3] ), .A1(n761), .B0(\str[15][3] ), .B1(n766), 
        .C0(n46), .Y(n537) );
  AOI222XL U611 ( .A0(n769), .A1(n695), .B0(n770), .B1(n663), .C0(n771), .C1(
        n679), .Y(n47) );
  OAI221XL U612 ( .A0(\str[35][3] ), .A1(n426), .B0(n730), .B1(n719), .C0(n47), 
        .Y(n468) );
  AO22X1 U613 ( .A0(n768), .A1(\str[22][3] ), .B0(n767), .B1(\str[14][3] ), 
        .Y(n49) );
  AOI221XL U614 ( .A0(\str[30][3] ), .A1(n752), .B0(\str[38][3] ), .B1(n745), 
        .C0(n49), .Y(n50) );
  AOI2BB2X1 U615 ( .B0(n445), .B1(n740), .A0N(n429), .A1N(n50), .Y(n51) );
  OAI221XL U616 ( .A0(n500), .A1(n433), .B0(n444), .B1(n432), .C0(n51), .Y(
        N678) );
  OA22X1 U617 ( .A0(\str[26][4] ), .A1(n755), .B0(\str[34][4] ), .B1(n747), 
        .Y(n52) );
  OA22X1 U618 ( .A0(\str[24][4] ), .A1(n755), .B0(\str[32][4] ), .B1(n747), 
        .Y(n53) );
  OAI221XL U619 ( .A0(\str[8][4] ), .A1(n761), .B0(\str[16][4] ), .B1(n766), 
        .C0(n53), .Y(n502) );
  AOI222XL U620 ( .A0(n769), .A1(n704), .B0(n770), .B1(n672), .C0(n771), .C1(
        n688), .Y(n54) );
  OAI221XL U621 ( .A0(\str[36][4] ), .A1(n426), .B0(n730), .B1(n718), .C0(n54), 
        .Y(n447) );
  OA22X1 U622 ( .A0(\str[25][4] ), .A1(n755), .B0(\str[33][4] ), .B1(n747), 
        .Y(n55) );
  OA22X1 U623 ( .A0(\str[37][4] ), .A1(n750), .B0(\str[29][4] ), .B1(n754), 
        .Y(n56) );
  OAI221XL U624 ( .A0(n762), .A1(\str[13][4] ), .B0(n765), .B1(\str[21][4] ), 
        .C0(n56), .Y(n59) );
  OA22X1 U625 ( .A0(\str[23][4] ), .A1(n755), .B0(\str[31][4] ), .B1(n747), 
        .Y(n57) );
  OAI221XL U626 ( .A0(\str[7][4] ), .A1(n760), .B0(\str[15][4] ), .B1(n764), 
        .C0(n57), .Y(n542) );
  AOI222XL U627 ( .A0(n769), .A1(n696), .B0(n770), .B1(n664), .C0(n771), .C1(
        n680), .Y(n58) );
  OAI221XL U628 ( .A0(\str[35][4] ), .A1(n426), .B0(n730), .B1(n717), .C0(n58), 
        .Y(n471) );
  AOI222XL U629 ( .A0(n742), .A1(n545), .B0(n744), .B1(n59), .C0(n734), .C1(
        n471), .Y(n448) );
  AO22X1 U630 ( .A0(n768), .A1(\str[22][4] ), .B0(n767), .B1(\str[14][4] ), 
        .Y(n60) );
  AOI221XL U631 ( .A0(\str[30][4] ), .A1(n752), .B0(\str[38][4] ), .B1(n745), 
        .C0(n60), .Y(n61) );
  OAI221XL U632 ( .A0(n505), .A1(n433), .B0(n447), .B1(n432), .C0(n62), .Y(
        N679) );
  OA22X1 U633 ( .A0(\str[26][5] ), .A1(n756), .B0(\str[34][5] ), .B1(n747), 
        .Y(n63) );
  OA22X1 U634 ( .A0(\str[24][5] ), .A1(n754), .B0(\str[32][5] ), .B1(n747), 
        .Y(n64) );
  OAI221XL U635 ( .A0(\str[8][5] ), .A1(n760), .B0(\str[16][5] ), .B1(n764), 
        .C0(n64), .Y(n507) );
  AOI222XL U636 ( .A0(n769), .A1(n705), .B0(n770), .B1(n673), .C0(n771), .C1(
        n689), .Y(n66) );
  OAI221XL U637 ( .A0(\str[36][5] ), .A1(n426), .B0(n730), .B1(n716), .C0(n66), 
        .Y(n450) );
  OA22X1 U638 ( .A0(\str[25][5] ), .A1(n755), .B0(\str[33][5] ), .B1(n747), 
        .Y(n68) );
  OA22X1 U639 ( .A0(\str[37][5] ), .A1(n749), .B0(\str[29][5] ), .B1(n754), 
        .Y(n69) );
  OAI221XL U640 ( .A0(n762), .A1(\str[13][5] ), .B0(n765), .B1(\str[21][5] ), 
        .C0(n69), .Y(n401) );
  OA22X1 U641 ( .A0(\str[23][5] ), .A1(n755), .B0(\str[31][5] ), .B1(n747), 
        .Y(n399) );
  OAI221XL U642 ( .A0(\str[7][5] ), .A1(n760), .B0(\str[15][5] ), .B1(n764), 
        .C0(n399), .Y(n547) );
  AOI222XL U643 ( .A0(n769), .A1(n697), .B0(n770), .B1(n665), .C0(n771), .C1(
        n681), .Y(n400) );
  OAI221XL U644 ( .A0(\str[35][5] ), .A1(n426), .B0(n730), .B1(n715), .C0(n400), .Y(n474) );
  AOI222XL U645 ( .A0(n742), .A1(n550), .B0(n744), .B1(n401), .C0(n734), .C1(
        n474), .Y(n451) );
  AO22X1 U646 ( .A0(n768), .A1(\str[22][5] ), .B0(n767), .B1(\str[14][5] ), 
        .Y(n402) );
  AOI221XL U647 ( .A0(\str[30][5] ), .A1(n752), .B0(\str[38][5] ), .B1(n745), 
        .C0(n402), .Y(n403) );
  OAI221XL U648 ( .A0(n510), .A1(n433), .B0(n450), .B1(n432), .C0(n404), .Y(
        N680) );
  OA22X1 U649 ( .A0(\str[26][6] ), .A1(n756), .B0(\str[34][6] ), .B1(n747), 
        .Y(n405) );
  OA22X1 U650 ( .A0(\str[24][6] ), .A1(n755), .B0(\str[32][6] ), .B1(n747), 
        .Y(n406) );
  OAI221XL U651 ( .A0(\str[8][6] ), .A1(n760), .B0(\str[16][6] ), .B1(n764), 
        .C0(n406), .Y(n512) );
  AOI222XL U652 ( .A0(n769), .A1(n706), .B0(n770), .B1(n674), .C0(n771), .C1(
        n690), .Y(n407) );
  OAI221XL U653 ( .A0(\str[36][6] ), .A1(n426), .B0(n791), .B1(n714), .C0(n407), .Y(n453) );
  OA22X1 U654 ( .A0(\str[25][6] ), .A1(n754), .B0(\str[33][6] ), .B1(n748), 
        .Y(n408) );
  OA22X1 U655 ( .A0(\str[37][6] ), .A1(n749), .B0(\str[29][6] ), .B1(n754), 
        .Y(n409) );
  OAI221XL U656 ( .A0(n762), .A1(\str[13][6] ), .B0(n765), .B1(\str[21][6] ), 
        .C0(n409), .Y(n412) );
  OA22X1 U657 ( .A0(\str[23][6] ), .A1(n754), .B0(\str[31][6] ), .B1(n748), 
        .Y(n410) );
  OAI221XL U658 ( .A0(\str[7][6] ), .A1(n760), .B0(\str[15][6] ), .B1(n764), 
        .C0(n410), .Y(n552) );
  AOI222XL U659 ( .A0(n769), .A1(n698), .B0(n770), .B1(n666), .C0(n771), .C1(
        n682), .Y(n411) );
  OAI221XL U660 ( .A0(\str[35][6] ), .A1(n426), .B0(m_cnt[2]), .B1(n713), .C0(
        n411), .Y(n477) );
  AOI222XL U661 ( .A0(n742), .A1(n555), .B0(n744), .B1(n412), .C0(n734), .C1(
        n477), .Y(n454) );
  AO22X1 U662 ( .A0(n768), .A1(\str[22][6] ), .B0(n767), .B1(\str[14][6] ), 
        .Y(n413) );
  AOI221XL U663 ( .A0(\str[30][6] ), .A1(n752), .B0(\str[38][6] ), .B1(n745), 
        .C0(n413), .Y(n414) );
  OAI221XL U664 ( .A0(n515), .A1(n433), .B0(n453), .B1(n432), .C0(n415), .Y(
        N681) );
  OA22X1 U665 ( .A0(\str[26][7] ), .A1(n756), .B0(\str[34][7] ), .B1(n748), 
        .Y(n416) );
  OA22X1 U666 ( .A0(\str[24][7] ), .A1(n754), .B0(\str[32][7] ), .B1(n748), 
        .Y(n417) );
  OAI221XL U667 ( .A0(\str[8][7] ), .A1(n760), .B0(\str[16][7] ), .B1(n763), 
        .C0(n417), .Y(n517) );
  AOI222XL U668 ( .A0(n769), .A1(n707), .B0(n770), .B1(n675), .C0(n771), .C1(
        n691), .Y(n418) );
  OAI221XL U669 ( .A0(\str[36][7] ), .A1(n426), .B0(n791), .B1(n712), .C0(n418), .Y(n456) );
  OA22X1 U670 ( .A0(\str[25][7] ), .A1(n756), .B0(\str[33][7] ), .B1(n748), 
        .Y(n419) );
  OA22X1 U671 ( .A0(\str[37][7] ), .A1(n749), .B0(\str[29][7] ), .B1(n754), 
        .Y(n420) );
  OAI221XL U672 ( .A0(n762), .A1(\str[13][7] ), .B0(n765), .B1(\str[21][7] ), 
        .C0(n420), .Y(n427) );
  OA22X1 U673 ( .A0(\str[23][7] ), .A1(n755), .B0(\str[31][7] ), .B1(n748), 
        .Y(n421) );
  OAI221XL U674 ( .A0(\str[7][7] ), .A1(n759), .B0(\str[15][7] ), .B1(n763), 
        .C0(n421), .Y(n559) );
  AOI222XL U675 ( .A0(n769), .A1(n699), .B0(n770), .B1(n667), .C0(n771), .C1(
        n683), .Y(n425) );
  OAI221XL U676 ( .A0(\str[35][7] ), .A1(n426), .B0(n791), .B1(n711), .C0(n425), .Y(n480) );
  AO22X1 U677 ( .A0(n768), .A1(\str[22][7] ), .B0(n767), .B1(\str[14][7] ), 
        .Y(n428) );
  AOI221XL U678 ( .A0(\str[30][7] ), .A1(n752), .B0(\str[38][7] ), .B1(n745), 
        .C0(n428), .Y(n430) );
  AOI2BB2X1 U679 ( .B0(n457), .B1(n740), .A0N(n430), .A1N(n429), .Y(n431) );
  OAI221XL U680 ( .A0(n520), .A1(n433), .B0(n456), .B1(n432), .C0(n431), .Y(
        N682) );
  OA22X1 U681 ( .A0(\str[22][0] ), .A1(n754), .B0(\str[30][0] ), .B1(n748), 
        .Y(n434) );
  AOI222XL U682 ( .A0(n3), .A1(n570), .B0(n757), .B1(n485), .C0(n732), .C1(
        n435), .Y(n460) );
  AO22X1 U683 ( .A0(n740), .A1(n460), .B0(n436), .B1(n738), .Y(N633) );
  OA22X1 U684 ( .A0(\str[22][1] ), .A1(n754), .B0(\str[30][1] ), .B1(n748), 
        .Y(n437) );
  AOI222XL U685 ( .A0(n758), .A1(n575), .B0(n757), .B1(n490), .C0(n732), .C1(
        n438), .Y(n463) );
  AO22X1 U686 ( .A0(n739), .A1(n463), .B0(n439), .B1(n738), .Y(N634) );
  OA22X1 U687 ( .A0(\str[22][2] ), .A1(n755), .B0(\str[30][2] ), .B1(n748), 
        .Y(n440) );
  AOI222XL U688 ( .A0(n3), .A1(n580), .B0(n757), .B1(n495), .C0(n732), .C1(
        n441), .Y(n466) );
  AO22X1 U689 ( .A0(n740), .A1(n466), .B0(n442), .B1(n738), .Y(N635) );
  OA22X1 U690 ( .A0(\str[22][3] ), .A1(n755), .B0(\str[30][3] ), .B1(n748), 
        .Y(n443) );
  AOI222XL U691 ( .A0(n3), .A1(n585), .B0(n757), .B1(n500), .C0(n731), .C1(
        n444), .Y(n469) );
  AO22X1 U692 ( .A0(n740), .A1(n469), .B0(n445), .B1(n738), .Y(N636) );
  OA22X1 U693 ( .A0(\str[22][4] ), .A1(n754), .B0(\str[30][4] ), .B1(n748), 
        .Y(n446) );
  AOI222XL U694 ( .A0(n3), .A1(n590), .B0(n757), .B1(n505), .C0(n731), .C1(
        n447), .Y(n472) );
  AO22X1 U695 ( .A0(n739), .A1(n472), .B0(n448), .B1(n735), .Y(N637) );
  OA22X1 U696 ( .A0(\str[22][5] ), .A1(n755), .B0(\str[30][5] ), .B1(n748), 
        .Y(n449) );
  AOI222XL U697 ( .A0(n758), .A1(n595), .B0(n4), .B1(n510), .C0(n731), .C1(
        n450), .Y(n475) );
  AO22X1 U698 ( .A0(n739), .A1(n475), .B0(n451), .B1(n736), .Y(N638) );
  OA22X1 U699 ( .A0(\str[22][6] ), .A1(n756), .B0(\str[30][6] ), .B1(n749), 
        .Y(n452) );
  AOI222XL U700 ( .A0(n758), .A1(n600), .B0(n4), .B1(n515), .C0(n731), .C1(
        n453), .Y(n478) );
  AO22X1 U701 ( .A0(n739), .A1(n478), .B0(n454), .B1(n735), .Y(N639) );
  OA22X1 U702 ( .A0(\str[22][7] ), .A1(n755), .B0(\str[30][7] ), .B1(n749), 
        .Y(n455) );
  AOI222XL U703 ( .A0(n605), .A1(n758), .B0(n757), .B1(n520), .C0(n731), .C1(
        n456), .Y(n481) );
  AO22X1 U704 ( .A0(n739), .A1(n481), .B0(n457), .B1(n738), .Y(N640) );
  OA22X1 U705 ( .A0(\str[21][0] ), .A1(n755), .B0(\str[29][0] ), .B1(n749), 
        .Y(n458) );
  AOI222XL U706 ( .A0(n758), .A1(n612), .B0(n757), .B1(n525), .C0(n731), .C1(
        n459), .Y(n486) );
  AO22X1 U707 ( .A0(n789), .A1(n486), .B0(n460), .B1(n735), .Y(N591) );
  OA22X1 U708 ( .A0(\str[21][1] ), .A1(n754), .B0(\str[29][1] ), .B1(n749), 
        .Y(n461) );
  AOI222XL U709 ( .A0(n758), .A1(n618), .B0(n757), .B1(n530), .C0(n731), .C1(
        n462), .Y(n491) );
  AO22X1 U710 ( .A0(n740), .A1(n491), .B0(n463), .B1(n735), .Y(N592) );
  OA22X1 U711 ( .A0(\str[21][2] ), .A1(n754), .B0(\str[29][2] ), .B1(n749), 
        .Y(n464) );
  AOI222XL U712 ( .A0(n758), .A1(n624), .B0(n757), .B1(n535), .C0(n731), .C1(
        n465), .Y(n496) );
  AO22X1 U713 ( .A0(n740), .A1(n496), .B0(n466), .B1(n738), .Y(N593) );
  OA22X1 U714 ( .A0(\str[21][3] ), .A1(n756), .B0(\str[29][3] ), .B1(n748), 
        .Y(n467) );
  AOI222XL U715 ( .A0(n758), .A1(n630), .B0(n757), .B1(n540), .C0(n731), .C1(
        n468), .Y(n501) );
  AO22X1 U716 ( .A0(n789), .A1(n501), .B0(n469), .B1(n735), .Y(N594) );
  OA22X1 U717 ( .A0(\str[21][4] ), .A1(n756), .B0(\str[29][4] ), .B1(n749), 
        .Y(n470) );
  AOI222XL U718 ( .A0(n758), .A1(n636), .B0(n757), .B1(n545), .C0(n731), .C1(
        n471), .Y(n506) );
  AO22X1 U719 ( .A0(n740), .A1(n506), .B0(n472), .B1(n735), .Y(N595) );
  OA22X1 U720 ( .A0(\str[21][5] ), .A1(n756), .B0(\str[29][5] ), .B1(n749), 
        .Y(n473) );
  AOI222XL U721 ( .A0(n3), .A1(n642), .B0(n757), .B1(n550), .C0(n731), .C1(
        n474), .Y(n511) );
  AO22X1 U722 ( .A0(n740), .A1(n511), .B0(n475), .B1(n735), .Y(N596) );
  OA22X1 U723 ( .A0(\str[21][6] ), .A1(n756), .B0(\str[29][6] ), .B1(n749), 
        .Y(n476) );
  AOI222XL U724 ( .A0(n758), .A1(n648), .B0(n757), .B1(n555), .C0(n731), .C1(
        n477), .Y(n516) );
  AO22X1 U725 ( .A0(n740), .A1(n516), .B0(n478), .B1(n735), .Y(N597) );
  OA22X1 U726 ( .A0(\str[21][7] ), .A1(n756), .B0(\str[29][7] ), .B1(n749), 
        .Y(n479) );
  AOI222XL U727 ( .A0(n659), .A1(n758), .B0(n757), .B1(n565), .C0(n731), .C1(
        n480), .Y(n521) );
  AO22X1 U728 ( .A0(n740), .A1(n521), .B0(n481), .B1(n735), .Y(N598) );
  AOI2BB2X1 U729 ( .B0(n773), .B1(n668), .A0N(\str[4][0] ), .A1N(n557), .Y(
        n484) );
  AOI22X1 U730 ( .A0(n774), .A1(n700), .B0(n791), .B1(n482), .Y(n483) );
  OAI211X1 U731 ( .A0(\str[20][0] ), .A1(n772), .B0(n484), .C0(n483), .Y(n568)
         );
  AOI222XL U732 ( .A0(n744), .A1(n485), .B0(n570), .B1(n742), .C0(n734), .C1(
        n568), .Y(n526) );
  AO22X1 U733 ( .A0(n486), .A1(n737), .B0(n739), .B1(n526), .Y(N549) );
  AOI2BB2X1 U734 ( .B0(n773), .B1(n669), .A0N(\str[4][1] ), .A1N(n557), .Y(
        n489) );
  AOI22X1 U735 ( .A0(n774), .A1(n701), .B0(m_cnt[2]), .B1(n487), .Y(n488) );
  OAI211X1 U736 ( .A0(\str[20][1] ), .A1(n772), .B0(n489), .C0(n488), .Y(n573)
         );
  AOI222XL U737 ( .A0(n564), .A1(n490), .B0(n575), .B1(n742), .C0(n734), .C1(
        n573), .Y(n531) );
  AO22X1 U738 ( .A0(n491), .A1(n737), .B0(n739), .B1(n531), .Y(N550) );
  AOI2BB2X1 U739 ( .B0(n773), .B1(n670), .A0N(\str[4][2] ), .A1N(n557), .Y(
        n494) );
  AOI22X1 U740 ( .A0(n774), .A1(n702), .B0(n791), .B1(n492), .Y(n493) );
  OAI211X1 U741 ( .A0(\str[20][2] ), .A1(n772), .B0(n494), .C0(n493), .Y(n578)
         );
  AOI222XL U742 ( .A0(n564), .A1(n495), .B0(n580), .B1(n742), .C0(n733), .C1(
        n578), .Y(n536) );
  AO22X1 U743 ( .A0(n496), .A1(n737), .B0(n739), .B1(n536), .Y(N551) );
  AOI2BB2X1 U744 ( .B0(n773), .B1(n671), .A0N(\str[4][3] ), .A1N(n557), .Y(
        n499) );
  AOI22X1 U745 ( .A0(n774), .A1(n703), .B0(n730), .B1(n497), .Y(n498) );
  OAI211X1 U746 ( .A0(\str[20][3] ), .A1(n772), .B0(n499), .C0(n498), .Y(n583)
         );
  AOI222XL U747 ( .A0(n564), .A1(n500), .B0(n585), .B1(n742), .C0(n733), .C1(
        n583), .Y(n541) );
  AO22X1 U748 ( .A0(n501), .A1(n736), .B0(n739), .B1(n541), .Y(N552) );
  AOI2BB2X1 U749 ( .B0(n773), .B1(n672), .A0N(\str[4][4] ), .A1N(n557), .Y(
        n504) );
  AOI22X1 U750 ( .A0(n774), .A1(n704), .B0(n730), .B1(n502), .Y(n503) );
  OAI211X1 U751 ( .A0(\str[20][4] ), .A1(n772), .B0(n504), .C0(n503), .Y(n588)
         );
  AOI222XL U752 ( .A0(n564), .A1(n505), .B0(n590), .B1(n743), .C0(n733), .C1(
        n588), .Y(n546) );
  AO22X1 U753 ( .A0(n506), .A1(n736), .B0(n739), .B1(n546), .Y(N553) );
  AOI2BB2X1 U754 ( .B0(n773), .B1(n673), .A0N(\str[4][5] ), .A1N(n557), .Y(
        n509) );
  AOI22X1 U755 ( .A0(n774), .A1(n705), .B0(n730), .B1(n507), .Y(n508) );
  OAI211X1 U756 ( .A0(\str[20][5] ), .A1(n772), .B0(n509), .C0(n508), .Y(n593)
         );
  AOI222XL U757 ( .A0(n744), .A1(n510), .B0(n595), .B1(n743), .C0(n733), .C1(
        n593), .Y(n551) );
  AO22X1 U758 ( .A0(n511), .A1(n736), .B0(n739), .B1(n551), .Y(N554) );
  AOI2BB2X1 U759 ( .B0(n773), .B1(n674), .A0N(\str[4][6] ), .A1N(n557), .Y(
        n514) );
  AOI22X1 U760 ( .A0(n774), .A1(n706), .B0(n730), .B1(n512), .Y(n513) );
  OAI211X1 U761 ( .A0(\str[20][6] ), .A1(n772), .B0(n514), .C0(n513), .Y(n598)
         );
  AOI222XL U762 ( .A0(n744), .A1(n515), .B0(n600), .B1(n743), .C0(n733), .C1(
        n598), .Y(n556) );
  AO22X1 U763 ( .A0(n516), .A1(n736), .B0(n739), .B1(n556), .Y(N555) );
  AOI2BB2X1 U764 ( .B0(n773), .B1(n675), .A0N(\str[4][7] ), .A1N(n557), .Y(
        n519) );
  AOI22X1 U765 ( .A0(n774), .A1(n707), .B0(n730), .B1(n517), .Y(n518) );
  OAI211X1 U766 ( .A0(\str[20][7] ), .A1(n772), .B0(n519), .C0(n518), .Y(n603)
         );
  AOI222XL U767 ( .A0(n564), .A1(n520), .B0(n605), .B1(n743), .C0(n733), .C1(
        n603), .Y(n566) );
  AO22X1 U768 ( .A0(n521), .A1(n736), .B0(n739), .B1(n566), .Y(N556) );
  AOI2BB2X1 U769 ( .B0(n773), .B1(n660), .A0N(\str[3][0] ), .A1N(n557), .Y(
        n524) );
  AOI22X1 U770 ( .A0(n774), .A1(n692), .B0(n730), .B1(n522), .Y(n523) );
  OAI211X1 U771 ( .A0(\str[19][0] ), .A1(n772), .B0(n524), .C0(n523), .Y(n611)
         );
  AOI222XL U772 ( .A0(n744), .A1(n525), .B0(n612), .B1(n743), .C0(n733), .C1(
        n611), .Y(n571) );
  AO22X1 U773 ( .A0(n526), .A1(n736), .B0(n739), .B1(n571), .Y(N507) );
  AOI2BB2X1 U774 ( .B0(n773), .B1(n661), .A0N(\str[3][1] ), .A1N(n557), .Y(
        n529) );
  AOI22X1 U775 ( .A0(n774), .A1(n693), .B0(n730), .B1(n527), .Y(n528) );
  OAI211X1 U776 ( .A0(\str[19][1] ), .A1(n772), .B0(n529), .C0(n528), .Y(n617)
         );
  AOI222XL U777 ( .A0(n744), .A1(n530), .B0(n618), .B1(n743), .C0(n733), .C1(
        n617), .Y(n576) );
  AO22X1 U778 ( .A0(n531), .A1(n736), .B0(n739), .B1(n576), .Y(N508) );
  AOI2BB2X1 U779 ( .B0(n773), .B1(n662), .A0N(\str[3][2] ), .A1N(n557), .Y(
        n534) );
  AOI22X1 U780 ( .A0(n774), .A1(n694), .B0(n730), .B1(n532), .Y(n533) );
  OAI211X1 U781 ( .A0(\str[19][2] ), .A1(n772), .B0(n534), .C0(n533), .Y(n623)
         );
  AOI222XL U782 ( .A0(n744), .A1(n535), .B0(n624), .B1(n743), .C0(n733), .C1(
        n623), .Y(n581) );
  AO22X1 U783 ( .A0(n536), .A1(n736), .B0(n739), .B1(n581), .Y(N509) );
  AOI2BB2X1 U784 ( .B0(n773), .B1(n663), .A0N(\str[3][3] ), .A1N(n557), .Y(
        n539) );
  AOI22X1 U785 ( .A0(n774), .A1(n695), .B0(n730), .B1(n537), .Y(n538) );
  OAI211X1 U786 ( .A0(\str[19][3] ), .A1(n772), .B0(n539), .C0(n538), .Y(n629)
         );
  AOI222XL U787 ( .A0(n744), .A1(n540), .B0(n630), .B1(n743), .C0(n733), .C1(
        n629), .Y(n586) );
  AO22X1 U788 ( .A0(n541), .A1(n736), .B0(n739), .B1(n586), .Y(N510) );
  AOI2BB2X1 U789 ( .B0(n773), .B1(n664), .A0N(\str[3][4] ), .A1N(n557), .Y(
        n544) );
  AOI22X1 U790 ( .A0(n774), .A1(n696), .B0(n730), .B1(n542), .Y(n543) );
  OAI211X1 U791 ( .A0(\str[19][4] ), .A1(n772), .B0(n544), .C0(n543), .Y(n635)
         );
  AOI222XL U792 ( .A0(n564), .A1(n545), .B0(n636), .B1(n743), .C0(n733), .C1(
        n635), .Y(n591) );
  AO22X1 U793 ( .A0(n546), .A1(n736), .B0(n739), .B1(n591), .Y(N511) );
  AOI2BB2X1 U794 ( .B0(n773), .B1(n665), .A0N(\str[3][5] ), .A1N(n557), .Y(
        n549) );
  AOI22X1 U795 ( .A0(n774), .A1(n697), .B0(n730), .B1(n547), .Y(n548) );
  OAI211X1 U796 ( .A0(\str[19][5] ), .A1(n772), .B0(n549), .C0(n548), .Y(n641)
         );
  AOI222XL U797 ( .A0(n744), .A1(n550), .B0(n642), .B1(n743), .C0(n733), .C1(
        n641), .Y(n596) );
  AO22X1 U798 ( .A0(n551), .A1(n736), .B0(n739), .B1(n596), .Y(N512) );
  AOI2BB2X1 U799 ( .B0(n773), .B1(n666), .A0N(\str[3][6] ), .A1N(n557), .Y(
        n554) );
  AOI22X1 U800 ( .A0(n774), .A1(n698), .B0(n730), .B1(n552), .Y(n553) );
  OAI211X1 U801 ( .A0(\str[19][6] ), .A1(n772), .B0(n554), .C0(n553), .Y(n647)
         );
  AOI222XL U802 ( .A0(n744), .A1(n555), .B0(n648), .B1(n743), .C0(n67), .C1(
        n647), .Y(n601) );
  AO22X1 U803 ( .A0(n556), .A1(n736), .B0(n739), .B1(n601), .Y(N513) );
  AOI2BB2X1 U804 ( .B0(n773), .B1(n667), .A0N(\str[3][7] ), .A1N(n557), .Y(
        n562) );
  AOI22X1 U805 ( .A0(n774), .A1(n699), .B0(n559), .B1(n791), .Y(n561) );
  OAI211X1 U806 ( .A0(\str[19][7] ), .A1(n772), .B0(n562), .C0(n561), .Y(n657)
         );
  AOI222XL U807 ( .A0(n565), .A1(n744), .B0(n659), .B1(n742), .C0(n734), .C1(
        n657), .Y(n606) );
  AO22X1 U808 ( .A0(n566), .A1(n736), .B0(n739), .B1(n606), .Y(N514) );
  OA22X1 U809 ( .A0(\str[10][0] ), .A1(n766), .B0(\str[2][0] ), .B1(n759), .Y(
        n567) );
  OAI221XL U810 ( .A0(n756), .A1(\str[18][0] ), .B0(n750), .B1(\str[26][0] ), 
        .C0(n567), .Y(n569) );
  AOI222XL U811 ( .A0(n4), .A1(n570), .B0(n758), .B1(n569), .C0(n731), .C1(
        n568), .Y(n609) );
  AO22X1 U812 ( .A0(n571), .A1(n736), .B0(n1), .B1(n609), .Y(N465) );
  OA22X1 U813 ( .A0(\str[10][1] ), .A1(n766), .B0(\str[2][1] ), .B1(n759), .Y(
        n572) );
  OAI221XL U814 ( .A0(n756), .A1(\str[18][1] ), .B0(n750), .B1(\str[26][1] ), 
        .C0(n572), .Y(n574) );
  AOI222XL U815 ( .A0(n4), .A1(n575), .B0(n758), .B1(n574), .C0(n731), .C1(
        n573), .Y(n615) );
  AO22X1 U816 ( .A0(n576), .A1(n735), .B0(n1), .B1(n615), .Y(N466) );
  OA22X1 U817 ( .A0(\str[10][2] ), .A1(n766), .B0(\str[2][2] ), .B1(n759), .Y(
        n577) );
  OAI221XL U818 ( .A0(n756), .A1(\str[18][2] ), .B0(n750), .B1(\str[26][2] ), 
        .C0(n577), .Y(n579) );
  AOI222XL U819 ( .A0(n4), .A1(n580), .B0(n758), .B1(n579), .C0(n731), .C1(
        n578), .Y(n621) );
  AO22X1 U820 ( .A0(n581), .A1(n735), .B0(n1), .B1(n621), .Y(N467) );
  OA22X1 U821 ( .A0(\str[10][3] ), .A1(n766), .B0(\str[2][3] ), .B1(n708), .Y(
        n582) );
  OAI221XL U822 ( .A0(n756), .A1(\str[18][3] ), .B0(n750), .B1(\str[26][3] ), 
        .C0(n582), .Y(n584) );
  AO22X1 U823 ( .A0(n586), .A1(n735), .B0(n1), .B1(n627), .Y(N468) );
  OA22X1 U824 ( .A0(\str[10][4] ), .A1(n766), .B0(\str[2][4] ), .B1(n759), .Y(
        n587) );
  OAI221XL U825 ( .A0(n756), .A1(\str[18][4] ), .B0(n750), .B1(\str[26][4] ), 
        .C0(n587), .Y(n589) );
  AOI222XL U826 ( .A0(n757), .A1(n590), .B0(n758), .B1(n589), .C0(n731), .C1(
        n588), .Y(n633) );
  AO22X1 U827 ( .A0(n591), .A1(n735), .B0(n1), .B1(n633), .Y(N469) );
  OA22X1 U828 ( .A0(\str[10][5] ), .A1(n766), .B0(\str[2][5] ), .B1(n759), .Y(
        n592) );
  OAI221XL U829 ( .A0(n756), .A1(\str[18][5] ), .B0(n750), .B1(\str[26][5] ), 
        .C0(n592), .Y(n594) );
  AOI222XL U830 ( .A0(n757), .A1(n595), .B0(n758), .B1(n594), .C0(n731), .C1(
        n593), .Y(n639) );
  AO22X1 U831 ( .A0(n596), .A1(n735), .B0(n1), .B1(n639), .Y(N470) );
  OA22X1 U832 ( .A0(\str[10][6] ), .A1(n766), .B0(\str[2][6] ), .B1(n761), .Y(
        n597) );
  OAI221XL U833 ( .A0(n756), .A1(\str[18][6] ), .B0(n750), .B1(\str[26][6] ), 
        .C0(n597), .Y(n599) );
  AO22X1 U834 ( .A0(n601), .A1(n735), .B0(n1), .B1(n645), .Y(N471) );
  OA22X1 U835 ( .A0(\str[10][7] ), .A1(n766), .B0(\str[2][7] ), .B1(n759), .Y(
        n602) );
  OAI221XL U836 ( .A0(n756), .A1(\str[18][7] ), .B0(n750), .B1(\str[26][7] ), 
        .C0(n602), .Y(n604) );
  AOI222XL U837 ( .A0(n605), .A1(n757), .B0(n604), .B1(n758), .C0(n603), .C1(
        n732), .Y(n654) );
  AO22X1 U838 ( .A0(n606), .A1(n737), .B0(n739), .B1(n654), .Y(N472) );
  AO22X1 U839 ( .A0(n745), .A1(\str[25][0] ), .B0(n751), .B1(\str[17][0] ), 
        .Y(n607) );
  AOI221XL U840 ( .A0(\str[1][0] ), .A1(n767), .B0(\str[9][0] ), .B1(n768), 
        .C0(n607), .Y(n608) );
  OAI221XL U841 ( .A0(n612), .A1(n658), .B0(n611), .B1(n656), .C0(n610), .Y(
        N423) );
  AO22X1 U842 ( .A0(n745), .A1(\str[25][1] ), .B0(n751), .B1(\str[17][1] ), 
        .Y(n613) );
  AOI221XL U843 ( .A0(\str[1][1] ), .A1(n767), .B0(\str[9][1] ), .B1(n768), 
        .C0(n613), .Y(n614) );
  OAI221XL U844 ( .A0(n618), .A1(n658), .B0(n617), .B1(n656), .C0(n616), .Y(
        N424) );
  AO22X1 U845 ( .A0(n745), .A1(\str[25][2] ), .B0(n751), .B1(\str[17][2] ), 
        .Y(n619) );
  AOI221XL U846 ( .A0(\str[1][2] ), .A1(n767), .B0(\str[9][2] ), .B1(n768), 
        .C0(n619), .Y(n620) );
  OAI221XL U847 ( .A0(n624), .A1(n658), .B0(n623), .B1(n656), .C0(n622), .Y(
        N425) );
  AO22X1 U848 ( .A0(n746), .A1(\str[25][3] ), .B0(n751), .B1(\str[17][3] ), 
        .Y(n625) );
  AOI221XL U849 ( .A0(\str[1][3] ), .A1(n767), .B0(\str[9][3] ), .B1(n768), 
        .C0(n625), .Y(n626) );
  AOI2BB2X1 U850 ( .B0(n737), .B1(n627), .A0N(n652), .A1N(n626), .Y(n628) );
  OAI221XL U851 ( .A0(n630), .A1(n658), .B0(n629), .B1(n656), .C0(n628), .Y(
        N426) );
  AO22X1 U852 ( .A0(n745), .A1(\str[25][4] ), .B0(n753), .B1(\str[17][4] ), 
        .Y(n631) );
  AOI221XL U853 ( .A0(\str[1][4] ), .A1(n767), .B0(\str[9][4] ), .B1(n768), 
        .C0(n631), .Y(n632) );
  OAI221XL U854 ( .A0(n636), .A1(n658), .B0(n635), .B1(n656), .C0(n634), .Y(
        N427) );
  AO22X1 U855 ( .A0(n745), .A1(\str[25][5] ), .B0(n751), .B1(\str[17][5] ), 
        .Y(n637) );
  AOI221XL U856 ( .A0(\str[1][5] ), .A1(n767), .B0(\str[9][5] ), .B1(n768), 
        .C0(n637), .Y(n638) );
  OAI221XL U857 ( .A0(n642), .A1(n658), .B0(n641), .B1(n656), .C0(n640), .Y(
        N428) );
  AO22X1 U858 ( .A0(n746), .A1(\str[25][6] ), .B0(n751), .B1(\str[17][6] ), 
        .Y(n643) );
  AOI221XL U859 ( .A0(\str[1][6] ), .A1(n767), .B0(\str[9][6] ), .B1(n768), 
        .C0(n643), .Y(n644) );
  AOI2BB2X1 U860 ( .B0(n737), .B1(n645), .A0N(n652), .A1N(n644), .Y(n646) );
  OAI221XL U861 ( .A0(n648), .A1(n658), .B0(n647), .B1(n656), .C0(n646), .Y(
        N429) );
  AO22X1 U862 ( .A0(n746), .A1(\str[25][7] ), .B0(n751), .B1(\str[17][7] ), 
        .Y(n649) );
  AOI221XL U863 ( .A0(\str[1][7] ), .A1(n767), .B0(\str[9][7] ), .B1(n768), 
        .C0(n649), .Y(n653) );
  OAI221XL U864 ( .A0(n659), .A1(n658), .B0(n657), .B1(n656), .C0(n655), .Y(
        N430) );
  XNOR2X1 U865 ( .A(slen[4]), .B(\sub_1_root_add_90/carry[4] ), .Y(N307) );
  OR2X1 U866 ( .A(n795), .B(slen[0]), .Y(\sub_1_root_add_90/carry[1] ) );
  XNOR2X1 U867 ( .A(slen[0]), .B(n795), .Y(N303) );
  CLKINVX1 U868 ( .A(N303), .Y(N308) );
  XOR2X1 U869 ( .A(\add_0_root_add_90/carry[4] ), .B(N307), .Y(N312) );
endmodule


module MatchStar ( clk, starsig, ctrlsig, staridx, .pat({\pat[7][7] , 
        \pat[7][6] , \pat[7][5] , \pat[7][4] , \pat[7][3] , \pat[7][2] , 
        \pat[7][1] , \pat[7][0] , \pat[6][7] , \pat[6][6] , \pat[6][5] , 
        \pat[6][4] , \pat[6][3] , \pat[6][2] , \pat[6][1] , \pat[6][0] , 
        \pat[5][7] , \pat[5][6] , \pat[5][5] , \pat[5][4] , \pat[5][3] , 
        \pat[5][2] , \pat[5][1] , \pat[5][0] , \pat[4][7] , \pat[4][6] , 
        \pat[4][5] , \pat[4][4] , \pat[4][3] , \pat[4][2] , \pat[4][1] , 
        \pat[4][0] , \pat[3][7] , \pat[3][6] , \pat[3][5] , \pat[3][4] , 
        \pat[3][3] , \pat[3][2] , \pat[3][1] , \pat[3][0] , \pat[2][7] , 
        \pat[2][6] , \pat[2][5] , \pat[2][4] , \pat[2][3] , \pat[2][2] , 
        \pat[2][1] , \pat[2][0] , \pat[1][7] , \pat[1][6] , \pat[1][5] , 
        \pat[1][4] , \pat[1][3] , \pat[1][2] , \pat[1][1] , \pat[1][0] , 
        \pat[0][7] , \pat[0][6] , \pat[0][5] , \pat[0][4] , \pat[0][3] , 
        \pat[0][2] , \pat[0][1] , \pat[0][0] }), .str({\str[39][7] , 
        \str[39][6] , \str[39][5] , \str[39][4] , \str[39][3] , \str[39][2] , 
        \str[39][1] , \str[39][0] , \str[38][7] , \str[38][6] , \str[38][5] , 
        \str[38][4] , \str[38][3] , \str[38][2] , \str[38][1] , \str[38][0] , 
        \str[37][7] , \str[37][6] , \str[37][5] , \str[37][4] , \str[37][3] , 
        \str[37][2] , \str[37][1] , \str[37][0] , \str[36][7] , \str[36][6] , 
        \str[36][5] , \str[36][4] , \str[36][3] , \str[36][2] , \str[36][1] , 
        \str[36][0] , \str[35][7] , \str[35][6] , \str[35][5] , \str[35][4] , 
        \str[35][3] , \str[35][2] , \str[35][1] , \str[35][0] , \str[34][7] , 
        \str[34][6] , \str[34][5] , \str[34][4] , \str[34][3] , \str[34][2] , 
        \str[34][1] , \str[34][0] , \str[33][7] , \str[33][6] , \str[33][5] , 
        \str[33][4] , \str[33][3] , \str[33][2] , \str[33][1] , \str[33][0] , 
        \str[32][7] , \str[32][6] , \str[32][5] , \str[32][4] , \str[32][3] , 
        \str[32][2] , \str[32][1] , \str[32][0] , \str[31][7] , \str[31][6] , 
        \str[31][5] , \str[31][4] , \str[31][3] , \str[31][2] , \str[31][1] , 
        \str[31][0] , \str[30][7] , \str[30][6] , \str[30][5] , \str[30][4] , 
        \str[30][3] , \str[30][2] , \str[30][1] , \str[30][0] , \str[29][7] , 
        \str[29][6] , \str[29][5] , \str[29][4] , \str[29][3] , \str[29][2] , 
        \str[29][1] , \str[29][0] , \str[28][7] , \str[28][6] , \str[28][5] , 
        \str[28][4] , \str[28][3] , \str[28][2] , \str[28][1] , \str[28][0] , 
        \str[27][7] , \str[27][6] , \str[27][5] , \str[27][4] , \str[27][3] , 
        \str[27][2] , \str[27][1] , \str[27][0] , \str[26][7] , \str[26][6] , 
        \str[26][5] , \str[26][4] , \str[26][3] , \str[26][2] , \str[26][1] , 
        \str[26][0] , \str[25][7] , \str[25][6] , \str[25][5] , \str[25][4] , 
        \str[25][3] , \str[25][2] , \str[25][1] , \str[25][0] , \str[24][7] , 
        \str[24][6] , \str[24][5] , \str[24][4] , \str[24][3] , \str[24][2] , 
        \str[24][1] , \str[24][0] , \str[23][7] , \str[23][6] , \str[23][5] , 
        \str[23][4] , \str[23][3] , \str[23][2] , \str[23][1] , \str[23][0] , 
        \str[22][7] , \str[22][6] , \str[22][5] , \str[22][4] , \str[22][3] , 
        \str[22][2] , \str[22][1] , \str[22][0] , \str[21][7] , \str[21][6] , 
        \str[21][5] , \str[21][4] , \str[21][3] , \str[21][2] , \str[21][1] , 
        \str[21][0] , \str[20][7] , \str[20][6] , \str[20][5] , \str[20][4] , 
        \str[20][3] , \str[20][2] , \str[20][1] , \str[20][0] , \str[19][7] , 
        \str[19][6] , \str[19][5] , \str[19][4] , \str[19][3] , \str[19][2] , 
        \str[19][1] , \str[19][0] , \str[18][7] , \str[18][6] , \str[18][5] , 
        \str[18][4] , \str[18][3] , \str[18][2] , \str[18][1] , \str[18][0] , 
        \str[17][7] , \str[17][6] , \str[17][5] , \str[17][4] , \str[17][3] , 
        \str[17][2] , \str[17][1] , \str[17][0] , \str[16][7] , \str[16][6] , 
        \str[16][5] , \str[16][4] , \str[16][3] , \str[16][2] , \str[16][1] , 
        \str[16][0] , \str[15][7] , \str[15][6] , \str[15][5] , \str[15][4] , 
        \str[15][3] , \str[15][2] , \str[15][1] , \str[15][0] , \str[14][7] , 
        \str[14][6] , \str[14][5] , \str[14][4] , \str[14][3] , \str[14][2] , 
        \str[14][1] , \str[14][0] , \str[13][7] , \str[13][6] , \str[13][5] , 
        \str[13][4] , \str[13][3] , \str[13][2] , \str[13][1] , \str[13][0] , 
        \str[12][7] , \str[12][6] , \str[12][5] , \str[12][4] , \str[12][3] , 
        \str[12][2] , \str[12][1] , \str[12][0] , \str[11][7] , \str[11][6] , 
        \str[11][5] , \str[11][4] , \str[11][3] , \str[11][2] , \str[11][1] , 
        \str[11][0] , \str[10][7] , \str[10][6] , \str[10][5] , \str[10][4] , 
        \str[10][3] , \str[10][2] , \str[10][1] , \str[10][0] , \str[9][7] , 
        \str[9][6] , \str[9][5] , \str[9][4] , \str[9][3] , \str[9][2] , 
        \str[9][1] , \str[9][0] , \str[8][7] , \str[8][6] , \str[8][5] , 
        \str[8][4] , \str[8][3] , \str[8][2] , \str[8][1] , \str[8][0] , 
        \str[7][7] , \str[7][6] , \str[7][5] , \str[7][4] , \str[7][3] , 
        \str[7][2] , \str[7][1] , \str[7][0] , \str[6][7] , \str[6][6] , 
        \str[6][5] , \str[6][4] , \str[6][3] , \str[6][2] , \str[6][1] , 
        \str[6][0] , \str[5][7] , \str[5][6] , \str[5][5] , \str[5][4] , 
        \str[5][3] , \str[5][2] , \str[5][1] , \str[5][0] , \str[4][7] , 
        \str[4][6] , \str[4][5] , \str[4][4] , \str[4][3] , \str[4][2] , 
        \str[4][1] , \str[4][0] , \str[3][7] , \str[3][6] , \str[3][5] , 
        \str[3][4] , \str[3][3] , \str[3][2] , \str[3][1] , \str[3][0] , 
        \str[2][7] , \str[2][6] , \str[2][5] , \str[2][4] , \str[2][3] , 
        \str[2][2] , \str[2][1] , \str[2][0] , \str[1][7] , \str[1][6] , 
        \str[1][5] , \str[1][4] , \str[1][3] , \str[1][2] , \str[1][1] , 
        \str[1][0] , \str[0][7] , \str[0][6] , \str[0][5] , \str[0][4] , 
        \str[0][3] , \str[0][2] , \str[0][1] , \str[0][0] }), slen, plen, 
        stride, mstar_v, star_done );
  input [1:0] ctrlsig;
  input [3:0] staridx;
  input [5:0] slen;
  input [3:0] plen;
  output [4:0] stride;
  input clk, starsig, \pat[7][7] , \pat[7][6] , \pat[7][5] , \pat[7][4] ,
         \pat[7][3] , \pat[7][2] , \pat[7][1] , \pat[7][0] , \pat[6][7] ,
         \pat[6][6] , \pat[6][5] , \pat[6][4] , \pat[6][3] , \pat[6][2] ,
         \pat[6][1] , \pat[6][0] , \pat[5][7] , \pat[5][6] , \pat[5][5] ,
         \pat[5][4] , \pat[5][3] , \pat[5][2] , \pat[5][1] , \pat[5][0] ,
         \pat[4][7] , \pat[4][6] , \pat[4][5] , \pat[4][4] , \pat[4][3] ,
         \pat[4][2] , \pat[4][1] , \pat[4][0] , \pat[3][7] , \pat[3][6] ,
         \pat[3][5] , \pat[3][4] , \pat[3][3] , \pat[3][2] , \pat[3][1] ,
         \pat[3][0] , \pat[2][7] , \pat[2][6] , \pat[2][5] , \pat[2][4] ,
         \pat[2][3] , \pat[2][2] , \pat[2][1] , \pat[2][0] , \pat[1][7] ,
         \pat[1][6] , \pat[1][5] , \pat[1][4] , \pat[1][3] , \pat[1][2] ,
         \pat[1][1] , \pat[1][0] , \pat[0][7] , \pat[0][6] , \pat[0][5] ,
         \pat[0][4] , \pat[0][3] , \pat[0][2] , \pat[0][1] , \pat[0][0] ,
         \str[39][7] , \str[39][6] , \str[39][5] , \str[39][4] , \str[39][3] ,
         \str[39][2] , \str[39][1] , \str[39][0] , \str[38][7] , \str[38][6] ,
         \str[38][5] , \str[38][4] , \str[38][3] , \str[38][2] , \str[38][1] ,
         \str[38][0] , \str[37][7] , \str[37][6] , \str[37][5] , \str[37][4] ,
         \str[37][3] , \str[37][2] , \str[37][1] , \str[37][0] , \str[36][7] ,
         \str[36][6] , \str[36][5] , \str[36][4] , \str[36][3] , \str[36][2] ,
         \str[36][1] , \str[36][0] , \str[35][7] , \str[35][6] , \str[35][5] ,
         \str[35][4] , \str[35][3] , \str[35][2] , \str[35][1] , \str[35][0] ,
         \str[34][7] , \str[34][6] , \str[34][5] , \str[34][4] , \str[34][3] ,
         \str[34][2] , \str[34][1] , \str[34][0] , \str[33][7] , \str[33][6] ,
         \str[33][5] , \str[33][4] , \str[33][3] , \str[33][2] , \str[33][1] ,
         \str[33][0] , \str[32][7] , \str[32][6] , \str[32][5] , \str[32][4] ,
         \str[32][3] , \str[32][2] , \str[32][1] , \str[32][0] , \str[31][7] ,
         \str[31][6] , \str[31][5] , \str[31][4] , \str[31][3] , \str[31][2] ,
         \str[31][1] , \str[31][0] , \str[30][7] , \str[30][6] , \str[30][5] ,
         \str[30][4] , \str[30][3] , \str[30][2] , \str[30][1] , \str[30][0] ,
         \str[29][7] , \str[29][6] , \str[29][5] , \str[29][4] , \str[29][3] ,
         \str[29][2] , \str[29][1] , \str[29][0] , \str[28][7] , \str[28][6] ,
         \str[28][5] , \str[28][4] , \str[28][3] , \str[28][2] , \str[28][1] ,
         \str[28][0] , \str[27][7] , \str[27][6] , \str[27][5] , \str[27][4] ,
         \str[27][3] , \str[27][2] , \str[27][1] , \str[27][0] , \str[26][7] ,
         \str[26][6] , \str[26][5] , \str[26][4] , \str[26][3] , \str[26][2] ,
         \str[26][1] , \str[26][0] , \str[25][7] , \str[25][6] , \str[25][5] ,
         \str[25][4] , \str[25][3] , \str[25][2] , \str[25][1] , \str[25][0] ,
         \str[24][7] , \str[24][6] , \str[24][5] , \str[24][4] , \str[24][3] ,
         \str[24][2] , \str[24][1] , \str[24][0] , \str[23][7] , \str[23][6] ,
         \str[23][5] , \str[23][4] , \str[23][3] , \str[23][2] , \str[23][1] ,
         \str[23][0] , \str[22][7] , \str[22][6] , \str[22][5] , \str[22][4] ,
         \str[22][3] , \str[22][2] , \str[22][1] , \str[22][0] , \str[21][7] ,
         \str[21][6] , \str[21][5] , \str[21][4] , \str[21][3] , \str[21][2] ,
         \str[21][1] , \str[21][0] , \str[20][7] , \str[20][6] , \str[20][5] ,
         \str[20][4] , \str[20][3] , \str[20][2] , \str[20][1] , \str[20][0] ,
         \str[19][7] , \str[19][6] , \str[19][5] , \str[19][4] , \str[19][3] ,
         \str[19][2] , \str[19][1] , \str[19][0] , \str[18][7] , \str[18][6] ,
         \str[18][5] , \str[18][4] , \str[18][3] , \str[18][2] , \str[18][1] ,
         \str[18][0] , \str[17][7] , \str[17][6] , \str[17][5] , \str[17][4] ,
         \str[17][3] , \str[17][2] , \str[17][1] , \str[17][0] , \str[16][7] ,
         \str[16][6] , \str[16][5] , \str[16][4] , \str[16][3] , \str[16][2] ,
         \str[16][1] , \str[16][0] , \str[15][7] , \str[15][6] , \str[15][5] ,
         \str[15][4] , \str[15][3] , \str[15][2] , \str[15][1] , \str[15][0] ,
         \str[14][7] , \str[14][6] , \str[14][5] , \str[14][4] , \str[14][3] ,
         \str[14][2] , \str[14][1] , \str[14][0] , \str[13][7] , \str[13][6] ,
         \str[13][5] , \str[13][4] , \str[13][3] , \str[13][2] , \str[13][1] ,
         \str[13][0] , \str[12][7] , \str[12][6] , \str[12][5] , \str[12][4] ,
         \str[12][3] , \str[12][2] , \str[12][1] , \str[12][0] , \str[11][7] ,
         \str[11][6] , \str[11][5] , \str[11][4] , \str[11][3] , \str[11][2] ,
         \str[11][1] , \str[11][0] , \str[10][7] , \str[10][6] , \str[10][5] ,
         \str[10][4] , \str[10][3] , \str[10][2] , \str[10][1] , \str[10][0] ,
         \str[9][7] , \str[9][6] , \str[9][5] , \str[9][4] , \str[9][3] ,
         \str[9][2] , \str[9][1] , \str[9][0] , \str[8][7] , \str[8][6] ,
         \str[8][5] , \str[8][4] , \str[8][3] , \str[8][2] , \str[8][1] ,
         \str[8][0] , \str[7][7] , \str[7][6] , \str[7][5] , \str[7][4] ,
         \str[7][3] , \str[7][2] , \str[7][1] , \str[7][0] , \str[6][7] ,
         \str[6][6] , \str[6][5] , \str[6][4] , \str[6][3] , \str[6][2] ,
         \str[6][1] , \str[6][0] , \str[5][7] , \str[5][6] , \str[5][5] ,
         \str[5][4] , \str[5][3] , \str[5][2] , \str[5][1] , \str[5][0] ,
         \str[4][7] , \str[4][6] , \str[4][5] , \str[4][4] , \str[4][3] ,
         \str[4][2] , \str[4][1] , \str[4][0] , \str[3][7] , \str[3][6] ,
         \str[3][5] , \str[3][4] , \str[3][3] , \str[3][2] , \str[3][1] ,
         \str[3][0] , \str[2][7] , \str[2][6] , \str[2][5] , \str[2][4] ,
         \str[2][3] , \str[2][2] , \str[2][1] , \str[2][0] , \str[1][7] ,
         \str[1][6] , \str[1][5] , \str[1][4] , \str[1][3] , \str[1][2] ,
         \str[1][1] , \str[1][0] , \str[0][7] , \str[0][6] , \str[0][5] ,
         \str[0][4] , \str[0][3] , \str[0][2] , \str[0][1] , \str[0][0] ;
  output mstar_v, star_done;
  wire   N378, N379, N381, N382, N385, N386, N387, N388, N389, N398, N399,
         N400, N401, N402, N403, N404, N405, isstar, N409, N427, N428, N429,
         N430, N431, N438, N439, N440, N441, N442, N443, N461, N462, N463,
         N465, N466, N467, N468, N484, N485, N486, N487, N488, N550, N551,
         N552, N553, N554, N555, N556, N557, N598, N599, N600, N601, N602,
         N603, N604, N605, n28, n29, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, \add_172_2/carry[3] , \add_172_2/carry[2] ,
         \add_167/carry[4] , \add_167/carry[3] , \add_154/carry[5] ,
         \add_154/carry[4] , \add_154/carry[3] , \add_154/carry[2] ,
         \r418/carry[4] , \r418/carry[3] , \r418/carry[2] , n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n30, n31, n32, n33, n34, n35, n36,
         n37, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n168,
         n169, n170, n171, n172, n173, n174, n175, n176, n177, n178, n179,
         n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212,
         n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278,
         n279, n280, n281, n282, n283, n284, n285, n286, n287, n288, n289,
         n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333,
         n334, n335, n336, n337, n338, n339, n340, n341, n342, n343, n344,
         n345, n346, n347, n348, n349, n350, n351, n352, n353, n354, n355,
         n356, n357, n358, n359, n360, n361, n362, n363, n364, n365, n366,
         n367, n368, n369, n370, n371, n372, n373, n374, n375, n376, n377,
         n378, n379, n380, n381, n382, n383, n384, n385, n386, n387, n388,
         n389, n390, n391, n392, n393, n394, n395, n396, n397, n398, n399,
         n400, n401, n402, n403, n404, n405, n406, n407, n408, n409, n410,
         n411, n412, n413, n414, n415, n416, n417, n418, n419, n420, n421,
         n422, n423, n424, n425, n426, n427, n428, n429, n430, n431, n432,
         n433, n434, n435, n436, n437, n438, n439, n440, n441, n442, n443,
         n444, n445, n446, n447, n448, n449, n450, n451, n452, n453, n454,
         n455, n456, n457, n458, n459, n460, n461;
  wire   [4:0] pcnt;
  wire   [5:0] scnt;

  OAI31X2 U104 ( .A0(n455), .A1(n131), .A2(n71), .B0(n132), .Y(n53) );
  EDFFTRX1 \stride_reg[4]  ( .RN(n461), .D(scnt[4]), .E(n70), .CK(clk), .Q(
        stride[4]) );
  EDFFTRX1 \stride_reg[3]  ( .RN(n461), .D(scnt[3]), .E(n70), .CK(clk), .Q(
        stride[3]) );
  EDFFTRX1 \stride_reg[2]  ( .RN(n461), .D(scnt[2]), .E(n70), .CK(clk), .Q(
        stride[2]) );
  EDFFTRX1 \stride_reg[1]  ( .RN(n461), .D(scnt[1]), .E(n70), .CK(clk), .Q(
        stride[1]) );
  EDFFTRX1 \stride_reg[0]  ( .RN(n461), .D(scnt[0]), .E(n70), .CK(clk), .Q(
        stride[0]) );
  DFFX1 \pcnt_reg[4]  ( .D(n156), .CK(clk), .Q(pcnt[4]), .QN(n28) );
  DFFX1 \pcnt_reg[3]  ( .D(n153), .CK(clk), .Q(pcnt[3]), .QN(n29) );
  DFFQX1 \pcnt_reg[2]  ( .D(n154), .CK(clk), .Q(N382) );
  DFFQX1 \pcnt_reg[1]  ( .D(n155), .CK(clk), .Q(N381) );
  DFFQX1 isstar_reg ( .D(N409), .CK(clk), .Q(isstar) );
  DFFQX4 \scnt_reg[1]  ( .D(N439), .CK(clk), .Q(scnt[1]) );
  DFFQX4 \scnt_reg[5]  ( .D(N443), .CK(clk), .Q(scnt[5]) );
  DFFQX2 \scnt_reg[0]  ( .D(N438), .CK(clk), .Q(scnt[0]) );
  DFFQX2 \scnt_reg[2]  ( .D(N440), .CK(clk), .Q(scnt[2]) );
  DFFQX2 \pcnt_reg[0]  ( .D(n157), .CK(clk), .Q(n161) );
  DFFQX2 \scnt_reg[3]  ( .D(N441), .CK(clk), .Q(scnt[3]) );
  DFFQX2 \scnt_reg[4]  ( .D(N442), .CK(clk), .Q(scnt[4]) );
  OAI211X1 U3 ( .A0(n449), .A1(n202), .B0(n123), .C0(n457), .Y(N379) );
  NOR4XL U4 ( .A(\pat[0][3] ), .B(\pat[0][2] ), .C(\pat[0][1] ), .D(
        \pat[0][0] ), .Y(n64) );
  NOR4XL U5 ( .A(\pat[0][7] ), .B(\pat[0][6] ), .C(\pat[0][4] ), .D(
        \pat[0][2] ), .Y(n126) );
  NOR4XL U6 ( .A(\pat[0][7] ), .B(\pat[0][6] ), .C(\pat[0][5] ), .D(
        \pat[0][4] ), .Y(n65) );
  OR3XL U7 ( .A(scnt[4]), .B(scnt[5]), .C(scnt[3]), .Y(n145) );
  XOR2XL U8 ( .A(slen[0]), .B(scnt[0]), .Y(n152) );
  OR2XL U9 ( .A(plen[1]), .B(plen[0]), .Y(n450) );
  OAI2BB1XL U10 ( .A0N(plen[0]), .A1N(plen[1]), .B0(n450), .Y(N386) );
  NOR2X2 U11 ( .A(scnt[4]), .B(scnt[5]), .Y(n421) );
  NOR2BX2 U12 ( .AN(scnt[4]), .B(scnt[5]), .Y(n424) );
  OAI31XL U13 ( .A0(n202), .A1(n458), .A2(n459), .B0(n461), .Y(n56) );
  CLKINVX1 U14 ( .A(n69), .Y(n461) );
  OAI21X1 U15 ( .A0(n447), .A1(n458), .B0(n122), .Y(N378) );
  CLKINVX1 U16 ( .A(scnt[0]), .Y(n429) );
  CLKINVX1 U17 ( .A(scnt[2]), .Y(n427) );
  CLKBUFX3 U18 ( .A(N382), .Y(n448) );
  CLKBUFX3 U19 ( .A(N381), .Y(n447) );
  CLKBUFX3 U20 ( .A(n161), .Y(n449) );
  NAND3X1 U21 ( .A(ctrlsig[0]), .B(starsig), .C(ctrlsig[1]), .Y(n69) );
  CLKBUFX3 U22 ( .A(n35), .Y(n162) );
  NOR2X1 U23 ( .A(n160), .B(n159), .Y(n35) );
  CLKINVX1 U24 ( .A(n56), .Y(n456) );
  CLKAND2X3 U25 ( .A(n430), .B(n212), .Y(n397) );
  CLKBUFX3 U26 ( .A(n197), .Y(n205) );
  NOR2X1 U27 ( .A(n202), .B(n201), .Y(n197) );
  CLKINVX1 U28 ( .A(n54), .Y(n454) );
  NOR2X4 U29 ( .A(n160), .B(N378), .Y(n36) );
  CLKINVX1 U30 ( .A(N379), .Y(n160) );
  CLKBUFX3 U31 ( .A(n32), .Y(n164) );
  NOR2X1 U32 ( .A(N378), .B(N379), .Y(n32) );
  CLKBUFX3 U33 ( .A(n33), .Y(n163) );
  NOR2X1 U34 ( .A(n159), .B(N379), .Y(n33) );
  NOR2X2 U35 ( .A(n202), .B(n122), .Y(n86) );
  NOR2X2 U36 ( .A(n123), .B(n458), .Y(n88) );
  CLKINVX1 U37 ( .A(N378), .Y(n159) );
  XOR2X1 U38 ( .A(N601), .B(N553), .Y(n140) );
  NOR3X1 U39 ( .A(n141), .B(n69), .C(n142), .Y(n135) );
  XOR2X1 U40 ( .A(N602), .B(N554), .Y(n141) );
  XOR2X1 U41 ( .A(N604), .B(N556), .Y(n142) );
  XNOR2X1 U42 ( .A(N557), .B(N605), .Y(n133) );
  NOR4X1 U43 ( .A(n57), .B(n58), .C(n59), .D(n60), .Y(mstar_v) );
  XOR2X1 U44 ( .A(n449), .B(N385), .Y(n58) );
  XOR2X1 U45 ( .A(n447), .B(N386), .Y(n59) );
  XOR2X1 U46 ( .A(n448), .B(N387), .Y(n60) );
  XOR2X1 U47 ( .A(n455), .B(N603), .Y(n134) );
  CLKAND2X3 U48 ( .A(n393), .B(n214), .Y(n401) );
  CLKAND2X3 U49 ( .A(n390), .B(n214), .Y(n406) );
  CLKAND2X3 U50 ( .A(n211), .B(n430), .Y(n396) );
  NOR4X1 U51 ( .A(n137), .B(n138), .C(n139), .D(n140), .Y(n136) );
  XOR2X1 U52 ( .A(N599), .B(N551), .Y(n138) );
  XOR2X1 U53 ( .A(N598), .B(N550), .Y(n137) );
  XOR2X1 U54 ( .A(N600), .B(N552), .Y(n139) );
  CLKBUFX3 U55 ( .A(n392), .Y(n430) );
  NOR2X1 U56 ( .A(n427), .B(n429), .Y(n392) );
  CLKBUFX3 U57 ( .A(n400), .Y(n431) );
  AND2X2 U58 ( .A(n214), .B(n430), .Y(n400) );
  CLKBUFX3 U59 ( .A(n415), .Y(n442) );
  AND2X2 U60 ( .A(n441), .B(n211), .Y(n415) );
  CLKBUFX3 U61 ( .A(n405), .Y(n434) );
  AND2X2 U62 ( .A(n433), .B(n211), .Y(n405) );
  CLKBUFX3 U63 ( .A(n410), .Y(n438) );
  AND2X2 U64 ( .A(n437), .B(n211), .Y(n410) );
  CLKBUFX3 U65 ( .A(n399), .Y(n432) );
  AND2X2 U66 ( .A(n213), .B(n430), .Y(n399) );
  CLKBUFX3 U67 ( .A(n414), .Y(n443) );
  AND2X2 U68 ( .A(n389), .B(n212), .Y(n414) );
  CLKBUFX3 U69 ( .A(n404), .Y(n435) );
  AND2X2 U70 ( .A(n393), .B(n212), .Y(n404) );
  CLKBUFX3 U71 ( .A(n409), .Y(n439) );
  AND2X2 U72 ( .A(n390), .B(n212), .Y(n409) );
  CLKBUFX3 U73 ( .A(n412), .Y(n444) );
  AND2X2 U74 ( .A(n441), .B(n213), .Y(n412) );
  CLKBUFX3 U75 ( .A(n402), .Y(n436) );
  AND2X2 U76 ( .A(n433), .B(n213), .Y(n402) );
  CLKBUFX3 U77 ( .A(n407), .Y(n440) );
  AND2X2 U78 ( .A(n437), .B(n213), .Y(n407) );
  CLKBUFX3 U79 ( .A(n411), .Y(n445) );
  AND2X2 U80 ( .A(n389), .B(n214), .Y(n411) );
  NOR3BX2 U81 ( .AN(n52), .B(n53), .C(n54), .Y(n41) );
  NAND3X1 U82 ( .A(n53), .B(n51), .C(n456), .Y(n38) );
  CLKINVX1 U83 ( .A(N555), .Y(n455) );
  CLKINVX1 U84 ( .A(n53), .Y(n452) );
  NAND4BX1 U85 ( .AN(n71), .B(n72), .C(n73), .D(n74), .Y(n54) );
  XNOR2X1 U86 ( .A(N601), .B(n118), .Y(n72) );
  NOR3X1 U87 ( .A(n103), .B(n104), .C(n105), .Y(n73) );
  NOR4XL U88 ( .A(n75), .B(n76), .C(N555), .D(n77), .Y(n74) );
  CLKINVX1 U89 ( .A(n51), .Y(n453) );
  INVX3 U90 ( .A(n449), .Y(n203) );
  OAI211X1 U91 ( .A0(n459), .A1(n38), .B0(n45), .C0(n46), .Y(n155) );
  NAND2X1 U92 ( .A(N485), .B(n42), .Y(n45) );
  AOI22X1 U93 ( .A0(n459), .A1(n41), .B0(N465), .B1(n453), .Y(n46) );
  OAI211X1 U94 ( .A0(n202), .A1(n38), .B0(n43), .C0(n44), .Y(n154) );
  NAND2X1 U95 ( .A(N486), .B(n42), .Y(n43) );
  AOI22X1 U96 ( .A0(N461), .A1(n41), .B0(N466), .B1(n453), .Y(n44) );
  NAND2X1 U97 ( .A(n143), .B(n144), .Y(n71) );
  AND4XL U98 ( .A(n461), .B(N552), .C(N554), .D(N556), .Y(n143) );
  NOR4XL U99 ( .A(N557), .B(N553), .C(N551), .D(N550), .Y(n144) );
  CLKINVX1 U100 ( .A(n448), .Y(n202) );
  NOR2X1 U101 ( .A(star_done), .B(n452), .Y(n130) );
  CLKINVX1 U102 ( .A(n447), .Y(n201) );
  CLKBUFX3 U103 ( .A(n198), .Y(n204) );
  NOR2X1 U105 ( .A(n202), .B(n447), .Y(n198) );
  CLKBUFX3 U106 ( .A(n195), .Y(n206) );
  NOR2X1 U107 ( .A(n201), .B(n448), .Y(n195) );
  CLKBUFX3 U108 ( .A(n194), .Y(n207) );
  NOR2X1 U109 ( .A(n447), .B(n448), .Y(n194) );
  NOR3BX2 U110 ( .AN(n68), .B(n454), .C(n69), .Y(n67) );
  AND2X2 U111 ( .A(n68), .B(n454), .Y(n66) );
  NAND2X1 U112 ( .A(n93), .B(n94), .Y(n75) );
  XNOR2X1 U113 ( .A(N604), .B(n95), .Y(n94) );
  XNOR2X1 U114 ( .A(N599), .B(n99), .Y(n93) );
  NAND2X1 U115 ( .A(n96), .B(n97), .Y(n95) );
  CLKINVX1 U116 ( .A(n446), .Y(n457) );
  INVX3 U117 ( .A(n449), .Y(n458) );
  CLKINVX1 U118 ( .A(n447), .Y(n459) );
  CLKBUFX3 U119 ( .A(n82), .Y(n446) );
  NOR3X1 U120 ( .A(n458), .B(n448), .C(n459), .Y(n82) );
  NOR2X2 U121 ( .A(n122), .B(n448), .Y(n81) );
  NOR2X2 U122 ( .A(n123), .B(n449), .Y(n87) );
  NOR3X2 U123 ( .A(n447), .B(n448), .C(n458), .Y(n84) );
  NOR3X2 U124 ( .A(n447), .B(n448), .C(n449), .Y(n85) );
  NAND2X1 U125 ( .A(n447), .B(n458), .Y(n122) );
  NAND2X1 U126 ( .A(n448), .B(n459), .Y(n123) );
  ADDHXL U127 ( .A(n447), .B(n449), .CO(\r418/carry[2] ), .S(N465) );
  ADDHXL U128 ( .A(n448), .B(\r418/carry[2] ), .CO(\r418/carry[3] ), .S(N466)
         );
  NOR4X1 U129 ( .A(n145), .B(scnt[0]), .C(scnt[2]), .D(scnt[1]), .Y(n131) );
  NAND4X1 U130 ( .A(n133), .B(n134), .C(n135), .D(n136), .Y(n132) );
  NOR2X2 U131 ( .A(n427), .B(scnt[0]), .Y(n393) );
  NOR2X2 U132 ( .A(n427), .B(scnt[0]), .Y(n433) );
  NOR2X2 U133 ( .A(n429), .B(scnt[2]), .Y(n390) );
  NOR2X2 U134 ( .A(scnt[0]), .B(scnt[2]), .Y(n389) );
  NOR2X2 U135 ( .A(scnt[0]), .B(scnt[2]), .Y(n441) );
  NOR2X2 U136 ( .A(n429), .B(scnt[2]), .Y(n437) );
  NAND4X1 U137 ( .A(n61), .B(n62), .C(n63), .D(n53), .Y(n57) );
  NAND2X1 U138 ( .A(n64), .B(n65), .Y(n63) );
  XOR2X1 U139 ( .A(n28), .B(N389), .Y(n62) );
  XOR2X1 U140 ( .A(n29), .B(N388), .Y(n61) );
  INVX3 U141 ( .A(scnt[1]), .Y(n428) );
  CLKINVX1 U142 ( .A(scnt[3]), .Y(n426) );
  NOR3X2 U143 ( .A(n454), .B(isstar), .C(n53), .Y(n70) );
  NOR2X1 U144 ( .A(n124), .B(n69), .Y(N409) );
  AOI211X1 U145 ( .A0(n125), .A1(n126), .B0(isstar), .C0(n127), .Y(n124) );
  AND4X1 U146 ( .A(n460), .B(\pat[0][1] ), .C(\pat[0][3] ), .D(\pat[0][5] ), 
        .Y(n125) );
  NAND2X1 U147 ( .A(n55), .B(n53), .Y(n51) );
  AO22X1 U148 ( .A0(n456), .A1(isstar), .B0(n54), .B1(n52), .Y(n55) );
  XOR2X1 U149 ( .A(n89), .B(N603), .Y(n76) );
  NAND2X1 U150 ( .A(n90), .B(n91), .Y(n89) );
  AOI221XL U151 ( .A0(\pat[3][2] ), .A1(n81), .B0(\pat[4][2] ), .B1(n446), 
        .C0(n92), .Y(n91) );
  AOI222XL U152 ( .A0(\pat[7][2] ), .A1(n86), .B0(\pat[5][2] ), .B1(n87), .C0(
        \pat[6][2] ), .C1(n88), .Y(n90) );
  XOR2X1 U153 ( .A(n78), .B(N602), .Y(n77) );
  NAND2X1 U154 ( .A(n79), .B(n80), .Y(n78) );
  AOI221XL U155 ( .A0(\pat[3][3] ), .A1(n81), .B0(\pat[4][3] ), .B1(n446), 
        .C0(n83), .Y(n80) );
  AOI222XL U156 ( .A0(\pat[7][3] ), .A1(n86), .B0(\pat[5][3] ), .B1(n87), .C0(
        \pat[6][3] ), .C1(n88), .Y(n79) );
  NAND4X1 U157 ( .A(N404), .B(N402), .C(n130), .D(N400), .Y(n128) );
  NOR4X1 U158 ( .A(n128), .B(n129), .C(N399), .D(N398), .Y(n127) );
  OR3X2 U159 ( .A(N405), .B(N403), .C(N401), .Y(n129) );
  OAI211X1 U160 ( .A0(n38), .A1(n29), .B0(n39), .C0(n40), .Y(n153) );
  NAND2X1 U161 ( .A(N487), .B(n42), .Y(n39) );
  AOI22X1 U162 ( .A0(N462), .A1(n41), .B0(N467), .B1(n453), .Y(n40) );
  OAI211X1 U163 ( .A0(n38), .A1(n28), .B0(n47), .C0(n48), .Y(n156) );
  NAND2X1 U164 ( .A(N488), .B(n42), .Y(n47) );
  AOI22X1 U165 ( .A0(N463), .A1(n41), .B0(N468), .B1(n453), .Y(n48) );
  OAI211X1 U166 ( .A0(n458), .A1(n38), .B0(n49), .C0(n50), .Y(n157) );
  NAND2X1 U167 ( .A(N484), .B(n42), .Y(n49) );
  AOI22X1 U168 ( .A0(n449), .A1(n41), .B0(n458), .B1(n453), .Y(n50) );
  AND3X2 U169 ( .A(isstar), .B(n452), .C(n456), .Y(n42) );
  XOR2X1 U170 ( .A(n110), .B(N605), .Y(n104) );
  NAND2X1 U171 ( .A(n111), .B(n112), .Y(n110) );
  AOI221XL U172 ( .A0(\pat[3][0] ), .A1(n81), .B0(\pat[4][0] ), .B1(n446), 
        .C0(n113), .Y(n112) );
  AOI222XL U173 ( .A0(\pat[7][0] ), .A1(n86), .B0(\pat[5][0] ), .B1(n87), .C0(
        \pat[6][0] ), .C1(n88), .Y(n111) );
  XOR2X1 U174 ( .A(n114), .B(N600), .Y(n103) );
  NAND2X1 U175 ( .A(n115), .B(n116), .Y(n114) );
  AOI221XL U176 ( .A0(\pat[3][5] ), .A1(n81), .B0(\pat[4][5] ), .B1(n446), 
        .C0(n117), .Y(n116) );
  AOI222XL U177 ( .A0(\pat[7][5] ), .A1(n86), .B0(\pat[5][5] ), .B1(n87), .C0(
        \pat[6][5] ), .C1(n88), .Y(n115) );
  XOR2X1 U178 ( .A(n106), .B(N598), .Y(n105) );
  NAND2X1 U179 ( .A(n107), .B(n108), .Y(n106) );
  AOI221XL U180 ( .A0(\pat[3][7] ), .A1(n81), .B0(\pat[4][7] ), .B1(n446), 
        .C0(n109), .Y(n108) );
  AOI222XL U181 ( .A0(\pat[7][7] ), .A1(n86), .B0(\pat[5][7] ), .B1(n87), .C0(
        \pat[6][7] ), .C1(n88), .Y(n107) );
  AO22X1 U182 ( .A0(scnt[1]), .A1(n66), .B0(N427), .B1(n67), .Y(N439) );
  AO22X1 U183 ( .A0(scnt[0]), .A1(n66), .B0(n429), .B1(n67), .Y(N438) );
  AO22X1 U184 ( .A0(scnt[2]), .A1(n66), .B0(N428), .B1(n67), .Y(N440) );
  AO22X1 U185 ( .A0(scnt[5]), .A1(n66), .B0(N431), .B1(n67), .Y(N443) );
  AO22X1 U186 ( .A0(scnt[4]), .A1(n66), .B0(N430), .B1(n67), .Y(N442) );
  AO22X1 U187 ( .A0(scnt[3]), .A1(n66), .B0(N429), .B1(n67), .Y(N441) );
  AOI222XL U188 ( .A0(\pat[7][1] ), .A1(n86), .B0(\pat[5][1] ), .B1(n87), .C0(
        \pat[6][1] ), .C1(n88), .Y(n96) );
  AOI221XL U189 ( .A0(\pat[3][1] ), .A1(n81), .B0(\pat[4][1] ), .B1(n446), 
        .C0(n98), .Y(n97) );
  AO22X1 U190 ( .A0(\pat[2][1] ), .A1(n84), .B0(\pat[1][1] ), .B1(n85), .Y(n98) );
  NOR2BX1 U191 ( .AN(starsig), .B(n68), .Y(star_done) );
  NAND4X1 U192 ( .A(n146), .B(n147), .C(n148), .D(n149), .Y(n68) );
  XNOR2X1 U193 ( .A(scnt[4]), .B(slen[4]), .Y(n146) );
  XNOR2X1 U194 ( .A(scnt[3]), .B(slen[3]), .Y(n147) );
  XNOR2X1 U195 ( .A(scnt[5]), .B(slen[5]), .Y(n148) );
  NOR3X1 U196 ( .A(n150), .B(n151), .C(n152), .Y(n149) );
  XOR2X1 U197 ( .A(slen[2]), .B(scnt[2]), .Y(n150) );
  XOR2X1 U198 ( .A(slen[1]), .B(scnt[1]), .Y(n151) );
  NOR2X1 U199 ( .A(n56), .B(isstar), .Y(n52) );
  NAND2X1 U200 ( .A(n100), .B(n101), .Y(n99) );
  AOI221XL U201 ( .A0(\pat[3][6] ), .A1(n81), .B0(\pat[4][6] ), .B1(n446), 
        .C0(n102), .Y(n101) );
  AOI222XL U202 ( .A0(\pat[7][6] ), .A1(n86), .B0(\pat[5][6] ), .B1(n87), .C0(
        \pat[6][6] ), .C1(n88), .Y(n100) );
  AO22X1 U203 ( .A0(\pat[2][6] ), .A1(n84), .B0(\pat[1][6] ), .B1(n85), .Y(
        n102) );
  NAND2X1 U204 ( .A(n119), .B(n120), .Y(n118) );
  AOI221XL U205 ( .A0(\pat[3][4] ), .A1(n81), .B0(\pat[4][4] ), .B1(n446), 
        .C0(n121), .Y(n120) );
  AOI222XL U206 ( .A0(\pat[7][4] ), .A1(n86), .B0(\pat[5][4] ), .B1(n87), .C0(
        \pat[6][4] ), .C1(n88), .Y(n119) );
  AO22X1 U207 ( .A0(\pat[2][4] ), .A1(n84), .B0(\pat[1][4] ), .B1(n85), .Y(
        n121) );
  AO22X1 U208 ( .A0(\pat[2][3] ), .A1(n84), .B0(\pat[1][3] ), .B1(n85), .Y(n83) );
  AO22X1 U209 ( .A0(\pat[2][2] ), .A1(n84), .B0(\pat[1][2] ), .B1(n85), .Y(n92) );
  AO22X1 U210 ( .A0(\pat[2][7] ), .A1(n84), .B0(\pat[1][7] ), .B1(n85), .Y(
        n109) );
  AO22X1 U211 ( .A0(\pat[2][0] ), .A1(n84), .B0(\pat[1][0] ), .B1(n85), .Y(
        n113) );
  AO22X1 U212 ( .A0(\pat[2][5] ), .A1(n84), .B0(\pat[1][5] ), .B1(n85), .Y(
        n117) );
  ADDHXL U213 ( .A(scnt[1]), .B(scnt[0]), .CO(\add_154/carry[2] ), .S(N427) );
  ADDHXL U214 ( .A(scnt[2]), .B(\add_154/carry[2] ), .CO(\add_154/carry[3] ), 
        .S(N428) );
  ADDHXL U215 ( .A(scnt[3]), .B(\add_154/carry[3] ), .CO(\add_154/carry[4] ), 
        .S(N429) );
  ADDHXL U216 ( .A(scnt[4]), .B(\add_154/carry[4] ), .CO(\add_154/carry[5] ), 
        .S(N430) );
  CLKINVX1 U217 ( .A(\pat[0][0] ), .Y(n460) );
  ADDHXL U218 ( .A(staridx[1]), .B(staridx[0]), .CO(\add_172_2/carry[2] ), .S(
        N485) );
  ADDHXL U219 ( .A(staridx[2]), .B(\add_172_2/carry[2] ), .CO(
        \add_172_2/carry[3] ), .S(N486) );
  ADDHXL U220 ( .A(staridx[3]), .B(\add_172_2/carry[3] ), .CO(N488), .S(N487)
         );
  ADDHXL U221 ( .A(pcnt[3]), .B(\r418/carry[3] ), .CO(\r418/carry[4] ), .S(
        N467) );
  AO22X1 U222 ( .A0(\pat[3][0] ), .A1(n163), .B0(\pat[1][0] ), .B1(n164), .Y(
        n1) );
  AOI221XL U223 ( .A0(\pat[5][0] ), .A1(n36), .B0(\pat[7][0] ), .B1(n162), 
        .C0(n1), .Y(n4) );
  AO22X1 U224 ( .A0(\pat[2][0] ), .A1(n163), .B0(\pat[0][0] ), .B1(n164), .Y(
        n2) );
  AOI221XL U225 ( .A0(\pat[4][0] ), .A1(n36), .B0(\pat[6][0] ), .B1(n162), 
        .C0(n2), .Y(n3) );
  OAI22XL U226 ( .A0(n161), .A1(n4), .B0(n458), .B1(n3), .Y(N405) );
  AO22X1 U227 ( .A0(\pat[3][1] ), .A1(n163), .B0(\pat[1][1] ), .B1(n164), .Y(
        n5) );
  AOI221XL U228 ( .A0(\pat[5][1] ), .A1(n36), .B0(\pat[7][1] ), .B1(n162), 
        .C0(n5), .Y(n8) );
  AO22X1 U229 ( .A0(\pat[2][1] ), .A1(n163), .B0(\pat[0][1] ), .B1(n164), .Y(
        n6) );
  AOI221XL U230 ( .A0(\pat[4][1] ), .A1(n36), .B0(\pat[6][1] ), .B1(n162), 
        .C0(n6), .Y(n7) );
  OAI22XL U231 ( .A0(n161), .A1(n8), .B0(n458), .B1(n7), .Y(N404) );
  AO22X1 U232 ( .A0(\pat[3][2] ), .A1(n163), .B0(\pat[1][2] ), .B1(n164), .Y(
        n9) );
  AOI221XL U233 ( .A0(\pat[5][2] ), .A1(n36), .B0(\pat[7][2] ), .B1(n162), 
        .C0(n9), .Y(n12) );
  AO22X1 U234 ( .A0(\pat[2][2] ), .A1(n163), .B0(\pat[0][2] ), .B1(n164), .Y(
        n10) );
  AOI221XL U235 ( .A0(\pat[4][2] ), .A1(n36), .B0(\pat[6][2] ), .B1(n162), 
        .C0(n10), .Y(n11) );
  OAI22XL U236 ( .A0(n161), .A1(n12), .B0(n458), .B1(n11), .Y(N403) );
  AO22X1 U237 ( .A0(\pat[3][3] ), .A1(n163), .B0(\pat[1][3] ), .B1(n164), .Y(
        n13) );
  AOI221XL U238 ( .A0(\pat[5][3] ), .A1(n36), .B0(\pat[7][3] ), .B1(n162), 
        .C0(n13), .Y(n16) );
  AO22X1 U239 ( .A0(\pat[2][3] ), .A1(n163), .B0(\pat[0][3] ), .B1(n164), .Y(
        n14) );
  AOI221XL U240 ( .A0(\pat[4][3] ), .A1(n36), .B0(\pat[6][3] ), .B1(n162), 
        .C0(n14), .Y(n15) );
  OAI22XL U241 ( .A0(n161), .A1(n16), .B0(n458), .B1(n15), .Y(N402) );
  AO22X1 U242 ( .A0(\pat[3][4] ), .A1(n163), .B0(\pat[1][4] ), .B1(n164), .Y(
        n17) );
  AOI221XL U243 ( .A0(\pat[5][4] ), .A1(n36), .B0(\pat[7][4] ), .B1(n162), 
        .C0(n17), .Y(n20) );
  AO22X1 U244 ( .A0(\pat[2][4] ), .A1(n163), .B0(\pat[0][4] ), .B1(n164), .Y(
        n18) );
  AOI221XL U245 ( .A0(\pat[4][4] ), .A1(n36), .B0(\pat[6][4] ), .B1(n162), 
        .C0(n18), .Y(n19) );
  OAI22XL U246 ( .A0(n161), .A1(n20), .B0(n458), .B1(n19), .Y(N401) );
  AO22X1 U247 ( .A0(\pat[3][5] ), .A1(n163), .B0(\pat[1][5] ), .B1(n164), .Y(
        n21) );
  AOI221XL U248 ( .A0(\pat[5][5] ), .A1(n36), .B0(\pat[7][5] ), .B1(n162), 
        .C0(n21), .Y(n24) );
  AO22X1 U249 ( .A0(\pat[2][5] ), .A1(n163), .B0(\pat[0][5] ), .B1(n164), .Y(
        n22) );
  AOI221XL U250 ( .A0(\pat[4][5] ), .A1(n36), .B0(\pat[6][5] ), .B1(n162), 
        .C0(n22), .Y(n23) );
  OAI22XL U251 ( .A0(n161), .A1(n24), .B0(n458), .B1(n23), .Y(N400) );
  AO22X1 U252 ( .A0(\pat[3][6] ), .A1(n163), .B0(\pat[1][6] ), .B1(n164), .Y(
        n25) );
  AOI221XL U253 ( .A0(\pat[5][6] ), .A1(n36), .B0(\pat[7][6] ), .B1(n162), 
        .C0(n25), .Y(n30) );
  AO22X1 U254 ( .A0(\pat[2][6] ), .A1(n163), .B0(\pat[0][6] ), .B1(n164), .Y(
        n26) );
  AOI221XL U255 ( .A0(\pat[4][6] ), .A1(n36), .B0(\pat[6][6] ), .B1(n162), 
        .C0(n26), .Y(n27) );
  OAI22XL U256 ( .A0(n161), .A1(n30), .B0(n458), .B1(n27), .Y(N399) );
  AO22X1 U257 ( .A0(\pat[3][7] ), .A1(n163), .B0(\pat[1][7] ), .B1(n164), .Y(
        n31) );
  AOI221XL U258 ( .A0(\pat[5][7] ), .A1(n36), .B0(\pat[7][7] ), .B1(n162), 
        .C0(n31), .Y(n158) );
  AO22X1 U259 ( .A0(\pat[2][7] ), .A1(n163), .B0(\pat[0][7] ), .B1(n164), .Y(
        n34) );
  AOI221XL U260 ( .A0(\pat[4][7] ), .A1(n36), .B0(\pat[6][7] ), .B1(n162), 
        .C0(n34), .Y(n37) );
  OAI22XL U261 ( .A0(n158), .A1(n161), .B0(n458), .B1(n37), .Y(N398) );
  AO22X1 U262 ( .A0(\pat[3][0] ), .A1(n206), .B0(\pat[1][0] ), .B1(n207), .Y(
        n165) );
  AOI221XL U263 ( .A0(\pat[5][0] ), .A1(n204), .B0(\pat[7][0] ), .B1(n205), 
        .C0(n165), .Y(n168) );
  AO22X1 U264 ( .A0(\pat[2][0] ), .A1(n206), .B0(\pat[0][0] ), .B1(n207), .Y(
        n166) );
  AOI221XL U265 ( .A0(\pat[4][0] ), .A1(n204), .B0(\pat[6][0] ), .B1(n205), 
        .C0(n166), .Y(n167) );
  OAI22XL U266 ( .A0(n203), .A1(n168), .B0(n449), .B1(n167), .Y(N557) );
  AO22X1 U267 ( .A0(\pat[3][1] ), .A1(n206), .B0(\pat[1][1] ), .B1(n207), .Y(
        n169) );
  AOI221XL U268 ( .A0(\pat[5][1] ), .A1(n204), .B0(\pat[7][1] ), .B1(n205), 
        .C0(n169), .Y(n172) );
  AO22X1 U269 ( .A0(\pat[2][1] ), .A1(n206), .B0(\pat[0][1] ), .B1(n207), .Y(
        n170) );
  AOI221XL U270 ( .A0(\pat[4][1] ), .A1(n204), .B0(\pat[6][1] ), .B1(n205), 
        .C0(n170), .Y(n171) );
  OAI22XL U271 ( .A0(n203), .A1(n172), .B0(n449), .B1(n171), .Y(N556) );
  AO22X1 U272 ( .A0(\pat[3][2] ), .A1(n206), .B0(\pat[1][2] ), .B1(n207), .Y(
        n173) );
  AOI221XL U273 ( .A0(\pat[5][2] ), .A1(n204), .B0(\pat[7][2] ), .B1(n205), 
        .C0(n173), .Y(n176) );
  AO22X1 U274 ( .A0(\pat[2][2] ), .A1(n206), .B0(\pat[0][2] ), .B1(n207), .Y(
        n174) );
  AOI221XL U275 ( .A0(\pat[4][2] ), .A1(n204), .B0(\pat[6][2] ), .B1(n205), 
        .C0(n174), .Y(n175) );
  OAI22XL U276 ( .A0(n203), .A1(n176), .B0(n449), .B1(n175), .Y(N555) );
  AO22X1 U277 ( .A0(\pat[3][3] ), .A1(n206), .B0(\pat[1][3] ), .B1(n207), .Y(
        n177) );
  AOI221XL U278 ( .A0(\pat[5][3] ), .A1(n204), .B0(\pat[7][3] ), .B1(n205), 
        .C0(n177), .Y(n180) );
  AO22X1 U279 ( .A0(\pat[2][3] ), .A1(n206), .B0(\pat[0][3] ), .B1(n207), .Y(
        n178) );
  AOI221XL U280 ( .A0(\pat[4][3] ), .A1(n204), .B0(\pat[6][3] ), .B1(n205), 
        .C0(n178), .Y(n179) );
  OAI22XL U281 ( .A0(n203), .A1(n180), .B0(n449), .B1(n179), .Y(N554) );
  AO22X1 U282 ( .A0(\pat[3][4] ), .A1(n206), .B0(\pat[1][4] ), .B1(n207), .Y(
        n181) );
  AOI221XL U283 ( .A0(\pat[5][4] ), .A1(n204), .B0(\pat[7][4] ), .B1(n205), 
        .C0(n181), .Y(n184) );
  AO22X1 U284 ( .A0(\pat[2][4] ), .A1(n206), .B0(\pat[0][4] ), .B1(n207), .Y(
        n182) );
  AOI221XL U285 ( .A0(\pat[4][4] ), .A1(n204), .B0(\pat[6][4] ), .B1(n205), 
        .C0(n182), .Y(n183) );
  OAI22XL U286 ( .A0(n203), .A1(n184), .B0(n449), .B1(n183), .Y(N553) );
  AO22X1 U287 ( .A0(\pat[3][5] ), .A1(n206), .B0(\pat[1][5] ), .B1(n207), .Y(
        n185) );
  AOI221XL U288 ( .A0(\pat[5][5] ), .A1(n204), .B0(\pat[7][5] ), .B1(n205), 
        .C0(n185), .Y(n188) );
  AO22X1 U289 ( .A0(\pat[2][5] ), .A1(n206), .B0(\pat[0][5] ), .B1(n207), .Y(
        n186) );
  AOI221XL U290 ( .A0(\pat[4][5] ), .A1(n204), .B0(\pat[6][5] ), .B1(n205), 
        .C0(n186), .Y(n187) );
  OAI22XL U291 ( .A0(n203), .A1(n188), .B0(n449), .B1(n187), .Y(N552) );
  AO22X1 U292 ( .A0(\pat[3][6] ), .A1(n206), .B0(\pat[1][6] ), .B1(n207), .Y(
        n189) );
  AOI221XL U293 ( .A0(\pat[5][6] ), .A1(n204), .B0(\pat[7][6] ), .B1(n205), 
        .C0(n189), .Y(n192) );
  AO22X1 U294 ( .A0(\pat[2][6] ), .A1(n206), .B0(\pat[0][6] ), .B1(n207), .Y(
        n190) );
  AOI221XL U295 ( .A0(\pat[4][6] ), .A1(n204), .B0(\pat[6][6] ), .B1(n205), 
        .C0(n190), .Y(n191) );
  OAI22XL U296 ( .A0(n203), .A1(n192), .B0(n449), .B1(n191), .Y(N551) );
  AO22X1 U297 ( .A0(\pat[3][7] ), .A1(n206), .B0(\pat[1][7] ), .B1(n207), .Y(
        n193) );
  AOI221XL U298 ( .A0(\pat[5][7] ), .A1(n204), .B0(\pat[7][7] ), .B1(n205), 
        .C0(n193), .Y(n200) );
  AO22X1 U299 ( .A0(\pat[2][7] ), .A1(n206), .B0(\pat[0][7] ), .B1(n207), .Y(
        n196) );
  AOI221XL U300 ( .A0(\pat[4][7] ), .A1(n204), .B0(\pat[6][7] ), .B1(n205), 
        .C0(n196), .Y(n199) );
  OAI22XL U301 ( .A0(n200), .A1(n203), .B0(n449), .B1(n199), .Y(N550) );
  NOR2X1 U302 ( .A(scnt[3]), .B(scnt[1]), .Y(n214) );
  NOR2X1 U303 ( .A(n426), .B(scnt[1]), .Y(n213) );
  NOR2X1 U304 ( .A(n428), .B(n426), .Y(n212) );
  NOR2X1 U305 ( .A(n428), .B(scnt[3]), .Y(n211) );
  AO22X1 U306 ( .A0(\str[31][0] ), .A1(n397), .B0(\str[23][0] ), .B1(n396), 
        .Y(n208) );
  AOI221XL U307 ( .A0(\str[21][0] ), .A1(n431), .B0(\str[29][0] ), .B1(n432), 
        .C0(n208), .Y(n219) );
  AO22X1 U308 ( .A0(\str[28][0] ), .A1(n436), .B0(\str[20][0] ), .B1(n401), 
        .Y(n209) );
  AOI221XL U309 ( .A0(\str[22][0] ), .A1(n434), .B0(\str[30][0] ), .B1(n435), 
        .C0(n209), .Y(n218) );
  AO22X1 U310 ( .A0(\str[25][0] ), .A1(n440), .B0(\str[17][0] ), .B1(n406), 
        .Y(n210) );
  AOI221XL U311 ( .A0(\str[19][0] ), .A1(n438), .B0(\str[27][0] ), .B1(n439), 
        .C0(n210), .Y(n217) );
  AO22X1 U312 ( .A0(\str[24][0] ), .A1(n444), .B0(\str[16][0] ), .B1(n445), 
        .Y(n215) );
  AOI221XL U313 ( .A0(\str[18][0] ), .A1(n442), .B0(\str[26][0] ), .B1(n443), 
        .C0(n215), .Y(n216) );
  NAND4X1 U314 ( .A(n219), .B(n218), .C(n217), .D(n216), .Y(n234) );
  AO22X1 U315 ( .A0(\str[35][0] ), .A1(n437), .B0(\str[34][0] ), .B1(n441), 
        .Y(n220) );
  AOI221XL U316 ( .A0(\str[38][0] ), .A1(n433), .B0(\str[39][0] ), .B1(n430), 
        .C0(n220), .Y(n223) );
  AO22X1 U317 ( .A0(\str[33][0] ), .A1(n390), .B0(\str[32][0] ), .B1(n389), 
        .Y(n221) );
  AOI221XL U318 ( .A0(\str[36][0] ), .A1(n393), .B0(\str[37][0] ), .B1(n430), 
        .C0(n221), .Y(n222) );
  OAI22XL U319 ( .A0(n428), .A1(n223), .B0(scnt[1]), .B1(n222), .Y(n233) );
  AO22X1 U320 ( .A0(\str[15][0] ), .A1(n397), .B0(\str[7][0] ), .B1(n396), .Y(
        n224) );
  AOI221XL U321 ( .A0(\str[5][0] ), .A1(n431), .B0(\str[13][0] ), .B1(n432), 
        .C0(n224), .Y(n231) );
  AO22X1 U322 ( .A0(\str[12][0] ), .A1(n436), .B0(\str[4][0] ), .B1(n401), .Y(
        n225) );
  AOI221XL U323 ( .A0(\str[6][0] ), .A1(n434), .B0(\str[14][0] ), .B1(n435), 
        .C0(n225), .Y(n230) );
  AO22X1 U324 ( .A0(\str[9][0] ), .A1(n440), .B0(\str[1][0] ), .B1(n406), .Y(
        n226) );
  AOI221XL U325 ( .A0(\str[3][0] ), .A1(n438), .B0(\str[11][0] ), .B1(n439), 
        .C0(n226), .Y(n229) );
  AO22X1 U326 ( .A0(\str[8][0] ), .A1(n444), .B0(\str[0][0] ), .B1(n445), .Y(
        n227) );
  AOI221XL U327 ( .A0(\str[2][0] ), .A1(n442), .B0(\str[10][0] ), .B1(n443), 
        .C0(n227), .Y(n228) );
  NAND4X1 U328 ( .A(n231), .B(n230), .C(n229), .D(n228), .Y(n232) );
  AOI222XL U329 ( .A0(n234), .A1(n424), .B0(n233), .B1(scnt[5]), .C0(n232), 
        .C1(n421), .Y(n235) );
  CLKINVX1 U330 ( .A(n235), .Y(N605) );
  AO22X1 U331 ( .A0(\str[31][1] ), .A1(n397), .B0(\str[23][1] ), .B1(n396), 
        .Y(n236) );
  AOI221XL U332 ( .A0(\str[21][1] ), .A1(n431), .B0(\str[29][1] ), .B1(n432), 
        .C0(n236), .Y(n243) );
  AO22X1 U333 ( .A0(\str[28][1] ), .A1(n436), .B0(\str[20][1] ), .B1(n401), 
        .Y(n237) );
  AOI221XL U334 ( .A0(\str[22][1] ), .A1(n434), .B0(\str[30][1] ), .B1(n435), 
        .C0(n237), .Y(n242) );
  AO22X1 U335 ( .A0(\str[25][1] ), .A1(n440), .B0(\str[17][1] ), .B1(n406), 
        .Y(n238) );
  AOI221XL U336 ( .A0(\str[19][1] ), .A1(n438), .B0(\str[27][1] ), .B1(n439), 
        .C0(n238), .Y(n241) );
  AO22X1 U337 ( .A0(\str[24][1] ), .A1(n444), .B0(\str[16][1] ), .B1(n445), 
        .Y(n239) );
  AOI221XL U338 ( .A0(\str[18][1] ), .A1(n442), .B0(\str[26][1] ), .B1(n443), 
        .C0(n239), .Y(n240) );
  NAND4X1 U339 ( .A(n243), .B(n242), .C(n241), .D(n240), .Y(n258) );
  AO22X1 U340 ( .A0(\str[35][1] ), .A1(n437), .B0(\str[34][1] ), .B1(n441), 
        .Y(n244) );
  AOI221XL U341 ( .A0(\str[38][1] ), .A1(n433), .B0(\str[39][1] ), .B1(n430), 
        .C0(n244), .Y(n247) );
  AO22X1 U342 ( .A0(\str[33][1] ), .A1(n390), .B0(\str[32][1] ), .B1(n389), 
        .Y(n245) );
  AOI221XL U343 ( .A0(\str[36][1] ), .A1(n393), .B0(\str[37][1] ), .B1(n430), 
        .C0(n245), .Y(n246) );
  OAI22XL U344 ( .A0(n428), .A1(n247), .B0(scnt[1]), .B1(n246), .Y(n257) );
  AO22X1 U345 ( .A0(\str[15][1] ), .A1(n397), .B0(\str[7][1] ), .B1(n396), .Y(
        n248) );
  AOI221XL U346 ( .A0(\str[5][1] ), .A1(n431), .B0(\str[13][1] ), .B1(n432), 
        .C0(n248), .Y(n255) );
  AO22X1 U347 ( .A0(\str[12][1] ), .A1(n436), .B0(\str[4][1] ), .B1(n401), .Y(
        n249) );
  AOI221XL U348 ( .A0(\str[6][1] ), .A1(n434), .B0(\str[14][1] ), .B1(n435), 
        .C0(n249), .Y(n254) );
  AO22X1 U349 ( .A0(\str[9][1] ), .A1(n440), .B0(\str[1][1] ), .B1(n406), .Y(
        n250) );
  AOI221XL U350 ( .A0(\str[3][1] ), .A1(n438), .B0(\str[11][1] ), .B1(n439), 
        .C0(n250), .Y(n253) );
  AO22X1 U351 ( .A0(\str[8][1] ), .A1(n444), .B0(\str[0][1] ), .B1(n445), .Y(
        n251) );
  AOI221XL U352 ( .A0(\str[2][1] ), .A1(n442), .B0(\str[10][1] ), .B1(n443), 
        .C0(n251), .Y(n252) );
  NAND4X1 U353 ( .A(n255), .B(n254), .C(n253), .D(n252), .Y(n256) );
  AOI222XL U354 ( .A0(n258), .A1(n424), .B0(n257), .B1(scnt[5]), .C0(n256), 
        .C1(n421), .Y(n259) );
  CLKINVX1 U355 ( .A(n259), .Y(N604) );
  AO22X1 U356 ( .A0(\str[31][2] ), .A1(n397), .B0(\str[23][2] ), .B1(n396), 
        .Y(n260) );
  AOI221XL U357 ( .A0(\str[21][2] ), .A1(n431), .B0(\str[29][2] ), .B1(n432), 
        .C0(n260), .Y(n267) );
  AO22X1 U358 ( .A0(\str[28][2] ), .A1(n436), .B0(\str[20][2] ), .B1(n401), 
        .Y(n261) );
  AOI221XL U359 ( .A0(\str[22][2] ), .A1(n434), .B0(\str[30][2] ), .B1(n435), 
        .C0(n261), .Y(n266) );
  AO22X1 U360 ( .A0(\str[25][2] ), .A1(n440), .B0(\str[17][2] ), .B1(n406), 
        .Y(n262) );
  AOI221XL U361 ( .A0(\str[19][2] ), .A1(n438), .B0(\str[27][2] ), .B1(n439), 
        .C0(n262), .Y(n265) );
  AO22X1 U362 ( .A0(\str[24][2] ), .A1(n444), .B0(\str[16][2] ), .B1(n445), 
        .Y(n263) );
  AOI221XL U363 ( .A0(\str[18][2] ), .A1(n442), .B0(\str[26][2] ), .B1(n443), 
        .C0(n263), .Y(n264) );
  NAND4X1 U364 ( .A(n267), .B(n266), .C(n265), .D(n264), .Y(n282) );
  AO22X1 U365 ( .A0(\str[35][2] ), .A1(n437), .B0(\str[34][2] ), .B1(n441), 
        .Y(n268) );
  AOI221XL U366 ( .A0(\str[38][2] ), .A1(n433), .B0(\str[39][2] ), .B1(n430), 
        .C0(n268), .Y(n271) );
  AO22X1 U367 ( .A0(\str[33][2] ), .A1(n390), .B0(\str[32][2] ), .B1(n389), 
        .Y(n269) );
  AOI221XL U368 ( .A0(\str[36][2] ), .A1(n393), .B0(\str[37][2] ), .B1(n430), 
        .C0(n269), .Y(n270) );
  OAI22XL U369 ( .A0(n428), .A1(n271), .B0(scnt[1]), .B1(n270), .Y(n281) );
  AO22X1 U370 ( .A0(\str[15][2] ), .A1(n397), .B0(\str[7][2] ), .B1(n396), .Y(
        n272) );
  AOI221XL U371 ( .A0(\str[5][2] ), .A1(n431), .B0(\str[13][2] ), .B1(n432), 
        .C0(n272), .Y(n279) );
  AO22X1 U372 ( .A0(\str[12][2] ), .A1(n436), .B0(\str[4][2] ), .B1(n401), .Y(
        n273) );
  AOI221XL U373 ( .A0(\str[6][2] ), .A1(n434), .B0(\str[14][2] ), .B1(n435), 
        .C0(n273), .Y(n278) );
  AO22X1 U374 ( .A0(\str[9][2] ), .A1(n440), .B0(\str[1][2] ), .B1(n406), .Y(
        n274) );
  AOI221XL U375 ( .A0(\str[3][2] ), .A1(n438), .B0(\str[11][2] ), .B1(n439), 
        .C0(n274), .Y(n277) );
  AO22X1 U376 ( .A0(\str[8][2] ), .A1(n444), .B0(\str[0][2] ), .B1(n445), .Y(
        n275) );
  AOI221XL U377 ( .A0(\str[2][2] ), .A1(n442), .B0(\str[10][2] ), .B1(n443), 
        .C0(n275), .Y(n276) );
  NAND4X1 U378 ( .A(n279), .B(n278), .C(n277), .D(n276), .Y(n280) );
  AOI222XL U379 ( .A0(n282), .A1(n424), .B0(n281), .B1(scnt[5]), .C0(n280), 
        .C1(n421), .Y(n283) );
  CLKINVX1 U380 ( .A(n283), .Y(N603) );
  AO22X1 U381 ( .A0(\str[31][3] ), .A1(n397), .B0(\str[23][3] ), .B1(n396), 
        .Y(n284) );
  AOI221XL U382 ( .A0(\str[21][3] ), .A1(n431), .B0(\str[29][3] ), .B1(n432), 
        .C0(n284), .Y(n291) );
  AO22X1 U383 ( .A0(\str[28][3] ), .A1(n436), .B0(\str[20][3] ), .B1(n401), 
        .Y(n285) );
  AOI221XL U384 ( .A0(\str[22][3] ), .A1(n434), .B0(\str[30][3] ), .B1(n435), 
        .C0(n285), .Y(n290) );
  AO22X1 U385 ( .A0(\str[25][3] ), .A1(n440), .B0(\str[17][3] ), .B1(n406), 
        .Y(n286) );
  AOI221XL U386 ( .A0(\str[19][3] ), .A1(n438), .B0(\str[27][3] ), .B1(n439), 
        .C0(n286), .Y(n289) );
  AO22X1 U387 ( .A0(\str[24][3] ), .A1(n444), .B0(\str[16][3] ), .B1(n445), 
        .Y(n287) );
  AOI221XL U388 ( .A0(\str[18][3] ), .A1(n442), .B0(\str[26][3] ), .B1(n443), 
        .C0(n287), .Y(n288) );
  NAND4X1 U389 ( .A(n291), .B(n290), .C(n289), .D(n288), .Y(n306) );
  AO22X1 U390 ( .A0(\str[35][3] ), .A1(n437), .B0(\str[34][3] ), .B1(n441), 
        .Y(n292) );
  AOI221XL U391 ( .A0(\str[38][3] ), .A1(n433), .B0(\str[39][3] ), .B1(n430), 
        .C0(n292), .Y(n295) );
  AO22X1 U392 ( .A0(\str[33][3] ), .A1(n390), .B0(\str[32][3] ), .B1(n389), 
        .Y(n293) );
  AOI221XL U393 ( .A0(\str[36][3] ), .A1(n393), .B0(\str[37][3] ), .B1(n430), 
        .C0(n293), .Y(n294) );
  OAI22XL U394 ( .A0(n428), .A1(n295), .B0(scnt[1]), .B1(n294), .Y(n305) );
  AO22X1 U395 ( .A0(\str[15][3] ), .A1(n397), .B0(\str[7][3] ), .B1(n396), .Y(
        n296) );
  AOI221XL U396 ( .A0(\str[5][3] ), .A1(n431), .B0(\str[13][3] ), .B1(n432), 
        .C0(n296), .Y(n303) );
  AO22X1 U397 ( .A0(\str[12][3] ), .A1(n436), .B0(\str[4][3] ), .B1(n401), .Y(
        n297) );
  AOI221XL U398 ( .A0(\str[6][3] ), .A1(n434), .B0(\str[14][3] ), .B1(n435), 
        .C0(n297), .Y(n302) );
  AO22X1 U399 ( .A0(\str[9][3] ), .A1(n440), .B0(\str[1][3] ), .B1(n406), .Y(
        n298) );
  AOI221XL U400 ( .A0(\str[3][3] ), .A1(n438), .B0(\str[11][3] ), .B1(n439), 
        .C0(n298), .Y(n301) );
  AO22X1 U401 ( .A0(\str[8][3] ), .A1(n444), .B0(\str[0][3] ), .B1(n445), .Y(
        n299) );
  AOI221XL U402 ( .A0(\str[2][3] ), .A1(n442), .B0(\str[10][3] ), .B1(n443), 
        .C0(n299), .Y(n300) );
  NAND4X1 U403 ( .A(n303), .B(n302), .C(n301), .D(n300), .Y(n304) );
  AOI222XL U404 ( .A0(n306), .A1(n424), .B0(n305), .B1(scnt[5]), .C0(n304), 
        .C1(n421), .Y(n307) );
  CLKINVX1 U405 ( .A(n307), .Y(N602) );
  AO22X1 U406 ( .A0(\str[31][4] ), .A1(n397), .B0(\str[23][4] ), .B1(n396), 
        .Y(n308) );
  AOI221XL U407 ( .A0(\str[21][4] ), .A1(n431), .B0(\str[29][4] ), .B1(n432), 
        .C0(n308), .Y(n315) );
  AO22X1 U408 ( .A0(\str[28][4] ), .A1(n436), .B0(\str[20][4] ), .B1(n401), 
        .Y(n309) );
  AOI221XL U409 ( .A0(\str[22][4] ), .A1(n434), .B0(\str[30][4] ), .B1(n435), 
        .C0(n309), .Y(n314) );
  AO22X1 U410 ( .A0(\str[25][4] ), .A1(n440), .B0(\str[17][4] ), .B1(n406), 
        .Y(n310) );
  AOI221XL U411 ( .A0(\str[19][4] ), .A1(n438), .B0(\str[27][4] ), .B1(n439), 
        .C0(n310), .Y(n313) );
  AO22X1 U412 ( .A0(\str[24][4] ), .A1(n444), .B0(\str[16][4] ), .B1(n445), 
        .Y(n311) );
  AOI221XL U413 ( .A0(\str[18][4] ), .A1(n442), .B0(\str[26][4] ), .B1(n443), 
        .C0(n311), .Y(n312) );
  NAND4X1 U414 ( .A(n315), .B(n314), .C(n313), .D(n312), .Y(n330) );
  AO22X1 U415 ( .A0(\str[35][4] ), .A1(n437), .B0(\str[34][4] ), .B1(n441), 
        .Y(n316) );
  AOI221XL U416 ( .A0(\str[38][4] ), .A1(n433), .B0(\str[39][4] ), .B1(n430), 
        .C0(n316), .Y(n319) );
  AO22X1 U417 ( .A0(\str[33][4] ), .A1(n390), .B0(\str[32][4] ), .B1(n389), 
        .Y(n317) );
  AOI221XL U418 ( .A0(\str[36][4] ), .A1(n393), .B0(\str[37][4] ), .B1(n430), 
        .C0(n317), .Y(n318) );
  OAI22XL U419 ( .A0(n428), .A1(n319), .B0(scnt[1]), .B1(n318), .Y(n329) );
  AO22X1 U420 ( .A0(\str[15][4] ), .A1(n397), .B0(\str[7][4] ), .B1(n396), .Y(
        n320) );
  AOI221XL U421 ( .A0(\str[5][4] ), .A1(n431), .B0(\str[13][4] ), .B1(n432), 
        .C0(n320), .Y(n327) );
  AO22X1 U422 ( .A0(\str[12][4] ), .A1(n436), .B0(\str[4][4] ), .B1(n401), .Y(
        n321) );
  AOI221XL U423 ( .A0(\str[6][4] ), .A1(n434), .B0(\str[14][4] ), .B1(n435), 
        .C0(n321), .Y(n326) );
  AO22X1 U424 ( .A0(\str[9][4] ), .A1(n440), .B0(\str[1][4] ), .B1(n406), .Y(
        n322) );
  AOI221XL U425 ( .A0(\str[3][4] ), .A1(n438), .B0(\str[11][4] ), .B1(n439), 
        .C0(n322), .Y(n325) );
  AO22X1 U426 ( .A0(\str[8][4] ), .A1(n444), .B0(\str[0][4] ), .B1(n445), .Y(
        n323) );
  AOI221XL U427 ( .A0(\str[2][4] ), .A1(n442), .B0(\str[10][4] ), .B1(n443), 
        .C0(n323), .Y(n324) );
  NAND4X1 U428 ( .A(n327), .B(n326), .C(n325), .D(n324), .Y(n328) );
  AOI222XL U429 ( .A0(n330), .A1(n424), .B0(n329), .B1(scnt[5]), .C0(n328), 
        .C1(n421), .Y(n331) );
  CLKINVX1 U430 ( .A(n331), .Y(N601) );
  AO22X1 U431 ( .A0(\str[31][5] ), .A1(n397), .B0(\str[23][5] ), .B1(n396), 
        .Y(n332) );
  AOI221XL U432 ( .A0(\str[21][5] ), .A1(n431), .B0(\str[29][5] ), .B1(n432), 
        .C0(n332), .Y(n339) );
  AO22X1 U433 ( .A0(\str[28][5] ), .A1(n436), .B0(\str[20][5] ), .B1(n401), 
        .Y(n333) );
  AOI221XL U434 ( .A0(\str[22][5] ), .A1(n434), .B0(\str[30][5] ), .B1(n435), 
        .C0(n333), .Y(n338) );
  AO22X1 U435 ( .A0(\str[25][5] ), .A1(n440), .B0(\str[17][5] ), .B1(n406), 
        .Y(n334) );
  AOI221XL U436 ( .A0(\str[19][5] ), .A1(n438), .B0(\str[27][5] ), .B1(n439), 
        .C0(n334), .Y(n337) );
  AO22X1 U437 ( .A0(\str[24][5] ), .A1(n444), .B0(\str[16][5] ), .B1(n445), 
        .Y(n335) );
  AOI221XL U438 ( .A0(\str[18][5] ), .A1(n442), .B0(\str[26][5] ), .B1(n443), 
        .C0(n335), .Y(n336) );
  NAND4X1 U439 ( .A(n339), .B(n338), .C(n337), .D(n336), .Y(n354) );
  AO22X1 U440 ( .A0(\str[35][5] ), .A1(n437), .B0(\str[34][5] ), .B1(n441), 
        .Y(n340) );
  AOI221XL U441 ( .A0(\str[38][5] ), .A1(n433), .B0(\str[39][5] ), .B1(n430), 
        .C0(n340), .Y(n343) );
  AO22X1 U442 ( .A0(\str[33][5] ), .A1(n390), .B0(\str[32][5] ), .B1(n389), 
        .Y(n341) );
  AOI221XL U443 ( .A0(\str[36][5] ), .A1(n393), .B0(\str[37][5] ), .B1(n430), 
        .C0(n341), .Y(n342) );
  OAI22XL U444 ( .A0(n428), .A1(n343), .B0(scnt[1]), .B1(n342), .Y(n353) );
  AO22X1 U445 ( .A0(\str[15][5] ), .A1(n397), .B0(\str[7][5] ), .B1(n396), .Y(
        n344) );
  AOI221XL U446 ( .A0(\str[5][5] ), .A1(n431), .B0(\str[13][5] ), .B1(n432), 
        .C0(n344), .Y(n351) );
  AO22X1 U447 ( .A0(\str[12][5] ), .A1(n436), .B0(\str[4][5] ), .B1(n401), .Y(
        n345) );
  AOI221XL U448 ( .A0(\str[6][5] ), .A1(n434), .B0(\str[14][5] ), .B1(n435), 
        .C0(n345), .Y(n350) );
  AO22X1 U449 ( .A0(\str[9][5] ), .A1(n440), .B0(\str[1][5] ), .B1(n406), .Y(
        n346) );
  AOI221XL U450 ( .A0(\str[3][5] ), .A1(n438), .B0(\str[11][5] ), .B1(n439), 
        .C0(n346), .Y(n349) );
  AO22X1 U451 ( .A0(\str[8][5] ), .A1(n444), .B0(\str[0][5] ), .B1(n445), .Y(
        n347) );
  AOI221XL U452 ( .A0(\str[2][5] ), .A1(n442), .B0(\str[10][5] ), .B1(n443), 
        .C0(n347), .Y(n348) );
  NAND4X1 U453 ( .A(n351), .B(n350), .C(n349), .D(n348), .Y(n352) );
  AOI222XL U454 ( .A0(n354), .A1(n424), .B0(n353), .B1(scnt[5]), .C0(n352), 
        .C1(n421), .Y(n355) );
  CLKINVX1 U455 ( .A(n355), .Y(N600) );
  AO22X1 U456 ( .A0(\str[31][6] ), .A1(n397), .B0(\str[23][6] ), .B1(n396), 
        .Y(n356) );
  AOI221XL U457 ( .A0(\str[21][6] ), .A1(n431), .B0(\str[29][6] ), .B1(n432), 
        .C0(n356), .Y(n363) );
  AO22X1 U458 ( .A0(\str[28][6] ), .A1(n436), .B0(\str[20][6] ), .B1(n401), 
        .Y(n357) );
  AOI221XL U459 ( .A0(\str[22][6] ), .A1(n434), .B0(\str[30][6] ), .B1(n435), 
        .C0(n357), .Y(n362) );
  AO22X1 U460 ( .A0(\str[25][6] ), .A1(n440), .B0(\str[17][6] ), .B1(n406), 
        .Y(n358) );
  AOI221XL U461 ( .A0(\str[19][6] ), .A1(n438), .B0(\str[27][6] ), .B1(n439), 
        .C0(n358), .Y(n361) );
  AO22X1 U462 ( .A0(\str[24][6] ), .A1(n444), .B0(\str[16][6] ), .B1(n445), 
        .Y(n359) );
  AOI221XL U463 ( .A0(\str[18][6] ), .A1(n442), .B0(\str[26][6] ), .B1(n443), 
        .C0(n359), .Y(n360) );
  NAND4X1 U464 ( .A(n363), .B(n362), .C(n361), .D(n360), .Y(n378) );
  AO22X1 U465 ( .A0(\str[35][6] ), .A1(n437), .B0(\str[34][6] ), .B1(n441), 
        .Y(n364) );
  AOI221XL U466 ( .A0(\str[38][6] ), .A1(n433), .B0(\str[39][6] ), .B1(n430), 
        .C0(n364), .Y(n367) );
  AO22X1 U467 ( .A0(\str[33][6] ), .A1(n390), .B0(\str[32][6] ), .B1(n389), 
        .Y(n365) );
  AOI221XL U468 ( .A0(\str[36][6] ), .A1(n393), .B0(\str[37][6] ), .B1(n430), 
        .C0(n365), .Y(n366) );
  OAI22XL U469 ( .A0(n428), .A1(n367), .B0(scnt[1]), .B1(n366), .Y(n377) );
  AO22X1 U470 ( .A0(\str[15][6] ), .A1(n397), .B0(\str[7][6] ), .B1(n396), .Y(
        n368) );
  AOI221XL U471 ( .A0(\str[5][6] ), .A1(n431), .B0(\str[13][6] ), .B1(n432), 
        .C0(n368), .Y(n375) );
  AO22X1 U472 ( .A0(\str[12][6] ), .A1(n436), .B0(\str[4][6] ), .B1(n401), .Y(
        n369) );
  AOI221XL U473 ( .A0(\str[6][6] ), .A1(n434), .B0(\str[14][6] ), .B1(n435), 
        .C0(n369), .Y(n374) );
  AO22X1 U474 ( .A0(\str[9][6] ), .A1(n440), .B0(\str[1][6] ), .B1(n406), .Y(
        n370) );
  AOI221XL U475 ( .A0(\str[3][6] ), .A1(n438), .B0(\str[11][6] ), .B1(n439), 
        .C0(n370), .Y(n373) );
  AO22X1 U476 ( .A0(\str[8][6] ), .A1(n444), .B0(\str[0][6] ), .B1(n445), .Y(
        n371) );
  AOI221XL U477 ( .A0(\str[2][6] ), .A1(n442), .B0(\str[10][6] ), .B1(n443), 
        .C0(n371), .Y(n372) );
  NAND4X1 U478 ( .A(n375), .B(n374), .C(n373), .D(n372), .Y(n376) );
  AOI222XL U479 ( .A0(n378), .A1(n424), .B0(n377), .B1(scnt[5]), .C0(n376), 
        .C1(n421), .Y(n379) );
  CLKINVX1 U480 ( .A(n379), .Y(N599) );
  AO22X1 U481 ( .A0(\str[31][7] ), .A1(n397), .B0(\str[23][7] ), .B1(n396), 
        .Y(n380) );
  AOI221XL U482 ( .A0(\str[21][7] ), .A1(n431), .B0(\str[29][7] ), .B1(n432), 
        .C0(n380), .Y(n387) );
  AO22X1 U483 ( .A0(\str[28][7] ), .A1(n436), .B0(\str[20][7] ), .B1(n401), 
        .Y(n381) );
  AOI221XL U484 ( .A0(\str[22][7] ), .A1(n434), .B0(\str[30][7] ), .B1(n435), 
        .C0(n381), .Y(n386) );
  AO22X1 U485 ( .A0(\str[25][7] ), .A1(n440), .B0(\str[17][7] ), .B1(n406), 
        .Y(n382) );
  AOI221XL U486 ( .A0(\str[19][7] ), .A1(n438), .B0(\str[27][7] ), .B1(n439), 
        .C0(n382), .Y(n385) );
  AO22X1 U487 ( .A0(\str[24][7] ), .A1(n444), .B0(\str[16][7] ), .B1(n445), 
        .Y(n383) );
  AOI221XL U488 ( .A0(\str[18][7] ), .A1(n442), .B0(\str[26][7] ), .B1(n443), 
        .C0(n383), .Y(n384) );
  NAND4X1 U489 ( .A(n387), .B(n386), .C(n385), .D(n384), .Y(n423) );
  AO22X1 U490 ( .A0(\str[35][7] ), .A1(n437), .B0(\str[34][7] ), .B1(n441), 
        .Y(n388) );
  AOI221XL U491 ( .A0(\str[38][7] ), .A1(n433), .B0(\str[39][7] ), .B1(n430), 
        .C0(n388), .Y(n395) );
  AO22X1 U492 ( .A0(\str[33][7] ), .A1(n390), .B0(\str[32][7] ), .B1(n389), 
        .Y(n391) );
  AOI221XL U493 ( .A0(\str[36][7] ), .A1(n393), .B0(\str[37][7] ), .B1(n430), 
        .C0(n391), .Y(n394) );
  OAI22XL U494 ( .A0(n428), .A1(n395), .B0(scnt[1]), .B1(n394), .Y(n422) );
  AO22X1 U495 ( .A0(\str[15][7] ), .A1(n397), .B0(\str[7][7] ), .B1(n396), .Y(
        n398) );
  AOI221XL U496 ( .A0(\str[5][7] ), .A1(n431), .B0(\str[13][7] ), .B1(n432), 
        .C0(n398), .Y(n419) );
  AO22X1 U497 ( .A0(\str[12][7] ), .A1(n436), .B0(\str[4][7] ), .B1(n401), .Y(
        n403) );
  AOI221XL U498 ( .A0(\str[6][7] ), .A1(n434), .B0(\str[14][7] ), .B1(n435), 
        .C0(n403), .Y(n418) );
  AO22X1 U499 ( .A0(\str[9][7] ), .A1(n440), .B0(\str[1][7] ), .B1(n406), .Y(
        n408) );
  AOI221XL U500 ( .A0(\str[3][7] ), .A1(n438), .B0(\str[11][7] ), .B1(n439), 
        .C0(n408), .Y(n417) );
  AO22X1 U501 ( .A0(\str[8][7] ), .A1(n444), .B0(\str[0][7] ), .B1(n445), .Y(
        n413) );
  AOI221XL U502 ( .A0(\str[2][7] ), .A1(n442), .B0(\str[10][7] ), .B1(n443), 
        .C0(n413), .Y(n416) );
  NAND4X1 U503 ( .A(n419), .B(n418), .C(n417), .D(n416), .Y(n420) );
  AOI222XL U504 ( .A0(n424), .A1(n423), .B0(scnt[5]), .B1(n422), .C0(n421), 
        .C1(n420), .Y(n425) );
  CLKINVX1 U505 ( .A(n425), .Y(N598) );
  XOR2X1 U506 ( .A(pcnt[4]), .B(\add_167/carry[4] ), .Y(N463) );
  AND2X1 U507 ( .A(\add_167/carry[3] ), .B(pcnt[3]), .Y(\add_167/carry[4] ) );
  XOR2X1 U508 ( .A(pcnt[3]), .B(\add_167/carry[3] ), .Y(N462) );
  AND2X1 U509 ( .A(n447), .B(n448), .Y(\add_167/carry[3] ) );
  XOR2X1 U510 ( .A(n448), .B(n447), .Y(N461) );
  XOR2X1 U511 ( .A(\r418/carry[4] ), .B(pcnt[4]), .Y(N468) );
  CLKINVX1 U512 ( .A(plen[0]), .Y(N385) );
  OR2X1 U513 ( .A(n450), .B(plen[2]), .Y(n451) );
  OAI2BB1X1 U514 ( .A0N(n450), .A1N(plen[2]), .B0(n451), .Y(N387) );
  NOR2X1 U515 ( .A(n451), .B(plen[3]), .Y(N389) );
  AO21X1 U516 ( .A0(n451), .A1(plen[3]), .B0(N389), .Y(N388) );
  XOR2X1 U517 ( .A(\add_154/carry[5] ), .B(scnt[5]), .Y(N431) );
  CLKINVX1 U518 ( .A(staridx[0]), .Y(N484) );
endmodule


module SendIdx ( clk, rst, match_v, m_done, m_idx, head20, head2e, mstar_v, 
        star_done, stride, o_idx, valid, match );
  input [4:0] m_idx;
  input [4:0] stride;
  output [4:0] o_idx;
  input clk, rst, match_v, m_done, head20, head2e, mstar_v, star_done;
  output valid, match;
  wire   N4, N5, N25, N26, N27, N28, N29, N35, N36, N37, N38, N39, n6, n7, n8,
         n9, n10, N24, \add_0_root_sub_0_root_add_33/carry[4] ,
         \add_0_root_sub_0_root_add_33/carry[3] ,
         \add_0_root_sub_0_root_add_33/carry[2] ,
         \add_0_root_sub_0_root_add_33/carry[1] , n1, n2, n3, n4, n5, n11, n12,
         n20, n21, n22;

  DFFRX1 valid_reg ( .D(N5), .CK(clk), .RN(n22), .QN(n12) );
  DFFRX1 \o_idx_reg[0]  ( .D(N35), .CK(clk), .RN(n22), .QN(n1) );
  DFFRX1 \o_idx_reg[1]  ( .D(N36), .CK(clk), .RN(n22), .QN(n2) );
  DFFRX1 \o_idx_reg[2]  ( .D(N37), .CK(clk), .RN(n22), .QN(n3) );
  DFFRX1 \o_idx_reg[3]  ( .D(N38), .CK(clk), .RN(n22), .QN(n4) );
  DFFRX1 \o_idx_reg[4]  ( .D(N39), .CK(clk), .RN(n22), .QN(n5) );
  DFFRX1 match_reg ( .D(N4), .CK(clk), .RN(n22), .QN(n11) );
  INVX12 U3 ( .A(n11), .Y(match) );
  INVX12 U4 ( .A(n5), .Y(o_idx[4]) );
  INVX12 U5 ( .A(n4), .Y(o_idx[3]) );
  INVX12 U6 ( .A(n3), .Y(o_idx[2]) );
  INVX12 U7 ( .A(n2), .Y(o_idx[1]) );
  INVX12 U8 ( .A(n1), .Y(o_idx[0]) );
  INVX16 U9 ( .A(n12), .Y(valid) );
  NOR2X1 U10 ( .A(n20), .B(match_v), .Y(n6) );
  OR2X1 U11 ( .A(match_v), .B(mstar_v), .Y(N4) );
  CLKINVX1 U12 ( .A(mstar_v), .Y(n20) );
  CLKINVX1 U13 ( .A(head2e), .Y(n21) );
  AND3X2 U14 ( .A(n8), .B(n20), .C(match_v), .Y(n7) );
  NAND3BX1 U15 ( .AN(m_idx[1]), .B(n9), .C(n10), .Y(n8) );
  NOR3X1 U16 ( .A(m_idx[2]), .B(m_idx[4]), .C(m_idx[3]), .Y(n10) );
  OAI2BB2XL U17 ( .B0(n21), .B1(m_idx[0]), .A0N(m_idx[0]), .A1N(head20), .Y(n9) );
  AO22X1 U18 ( .A0(stride[0]), .A1(n6), .B0(N25), .B1(n7), .Y(N35) );
  AO22X1 U19 ( .A0(stride[1]), .A1(n6), .B0(N26), .B1(n7), .Y(N36) );
  AO22X1 U20 ( .A0(stride[2]), .A1(n6), .B0(N27), .B1(n7), .Y(N37) );
  AO22X1 U21 ( .A0(stride[3]), .A1(n6), .B0(N28), .B1(n7), .Y(N38) );
  AO22X1 U22 ( .A0(stride[4]), .A1(n6), .B0(N29), .B1(n7), .Y(N39) );
  XOR3X1 U23 ( .A(m_idx[4]), .B(N24), .C(
        \add_0_root_sub_0_root_add_33/carry[4] ), .Y(N29) );
  OR3X2 U24 ( .A(star_done), .B(m_done), .C(N4), .Y(N5) );
  ADDFXL U25 ( .A(m_idx[1]), .B(N24), .CI(
        \add_0_root_sub_0_root_add_33/carry[1] ), .CO(
        \add_0_root_sub_0_root_add_33/carry[2] ), .S(N26) );
  ADDFXL U26 ( .A(m_idx[2]), .B(N24), .CI(
        \add_0_root_sub_0_root_add_33/carry[2] ), .CO(
        \add_0_root_sub_0_root_add_33/carry[3] ), .S(N27) );
  ADDFXL U27 ( .A(m_idx[3]), .B(N24), .CI(
        \add_0_root_sub_0_root_add_33/carry[3] ), .CO(
        \add_0_root_sub_0_root_add_33/carry[4] ), .S(N28) );
  INVX3 U28 ( .A(rst), .Y(n22) );
  AND2X1 U29 ( .A(m_idx[0]), .B(N24), .Y(
        \add_0_root_sub_0_root_add_33/carry[1] ) );
  XOR2X1 U30 ( .A(N24), .B(m_idx[0]), .Y(N25) );
  CLKINVX1 U31 ( .A(head20), .Y(N24) );
endmodule


module SME ( clk, reset, chardata, isstring, ispattern, valid, match, 
        match_index );
  input [7:0] chardata;
  output [4:0] match_index;
  input clk, reset, isstring, ispattern;
  output valid, match;
  wire   m_done, match_v, star_done, mstar_v, pcnt_clr, \str[39][7] ,
         \str[39][6] , \str[39][5] , \str[39][4] , \str[39][3] , \str[39][2] ,
         \str[39][1] , \str[39][0] , \str[38][7] , \str[38][6] , \str[38][5] ,
         \str[38][4] , \str[38][3] , \str[38][2] , \str[38][1] , \str[38][0] ,
         \str[37][7] , \str[37][6] , \str[37][5] , \str[37][4] , \str[37][3] ,
         \str[37][2] , \str[37][1] , \str[37][0] , \str[36][7] , \str[36][6] ,
         \str[36][5] , \str[36][4] , \str[36][3] , \str[36][2] , \str[36][1] ,
         \str[36][0] , \str[35][7] , \str[35][6] , \str[35][5] , \str[35][4] ,
         \str[35][3] , \str[35][2] , \str[35][1] , \str[35][0] , \str[34][7] ,
         \str[34][6] , \str[34][5] , \str[34][4] , \str[34][3] , \str[34][2] ,
         \str[34][1] , \str[34][0] , \str[33][7] , \str[33][6] , \str[33][5] ,
         \str[33][4] , \str[33][3] , \str[33][2] , \str[33][1] , \str[33][0] ,
         \str[32][7] , \str[32][6] , \str[32][5] , \str[32][4] , \str[32][3] ,
         \str[32][2] , \str[32][1] , \str[32][0] , \str[31][7] , \str[31][6] ,
         \str[31][5] , \str[31][4] , \str[31][3] , \str[31][2] , \str[31][1] ,
         \str[31][0] , \str[30][7] , \str[30][6] , \str[30][5] , \str[30][4] ,
         \str[30][3] , \str[30][2] , \str[30][1] , \str[30][0] , \str[29][7] ,
         \str[29][6] , \str[29][5] , \str[29][4] , \str[29][3] , \str[29][2] ,
         \str[29][1] , \str[29][0] , \str[28][7] , \str[28][6] , \str[28][5] ,
         \str[28][4] , \str[28][3] , \str[28][2] , \str[28][1] , \str[28][0] ,
         \str[27][7] , \str[27][6] , \str[27][5] , \str[27][4] , \str[27][3] ,
         \str[27][2] , \str[27][1] , \str[27][0] , \str[26][7] , \str[26][6] ,
         \str[26][5] , \str[26][4] , \str[26][3] , \str[26][2] , \str[26][1] ,
         \str[26][0] , \str[25][7] , \str[25][6] , \str[25][5] , \str[25][4] ,
         \str[25][3] , \str[25][2] , \str[25][1] , \str[25][0] , \str[24][7] ,
         \str[24][6] , \str[24][5] , \str[24][4] , \str[24][3] , \str[24][2] ,
         \str[24][1] , \str[24][0] , \str[23][7] , \str[23][6] , \str[23][5] ,
         \str[23][4] , \str[23][3] , \str[23][2] , \str[23][1] , \str[23][0] ,
         \str[22][7] , \str[22][6] , \str[22][5] , \str[22][4] , \str[22][3] ,
         \str[22][2] , \str[22][1] , \str[22][0] , \str[21][7] , \str[21][6] ,
         \str[21][5] , \str[21][4] , \str[21][3] , \str[21][2] , \str[21][1] ,
         \str[21][0] , \str[20][7] , \str[20][6] , \str[20][5] , \str[20][4] ,
         \str[20][3] , \str[20][2] , \str[20][1] , \str[20][0] , \str[19][7] ,
         \str[19][6] , \str[19][5] , \str[19][4] , \str[19][3] , \str[19][2] ,
         \str[19][1] , \str[19][0] , \str[18][7] , \str[18][6] , \str[18][5] ,
         \str[18][4] , \str[18][3] , \str[18][2] , \str[18][1] , \str[18][0] ,
         \str[17][7] , \str[17][6] , \str[17][5] , \str[17][4] , \str[17][3] ,
         \str[17][2] , \str[17][1] , \str[17][0] , \str[16][7] , \str[16][6] ,
         \str[16][5] , \str[16][4] , \str[16][3] , \str[16][2] , \str[16][1] ,
         \str[16][0] , \str[15][7] , \str[15][6] , \str[15][5] , \str[15][4] ,
         \str[15][3] , \str[15][2] , \str[15][1] , \str[15][0] , \str[14][7] ,
         \str[14][6] , \str[14][5] , \str[14][4] , \str[14][3] , \str[14][2] ,
         \str[14][1] , \str[14][0] , \str[13][7] , \str[13][6] , \str[13][5] ,
         \str[13][4] , \str[13][3] , \str[13][2] , \str[13][1] , \str[13][0] ,
         \str[12][7] , \str[12][6] , \str[12][5] , \str[12][4] , \str[12][3] ,
         \str[12][2] , \str[12][1] , \str[12][0] , \str[11][7] , \str[11][6] ,
         \str[11][5] , \str[11][4] , \str[11][3] , \str[11][2] , \str[11][1] ,
         \str[11][0] , \str[10][7] , \str[10][6] , \str[10][5] , \str[10][4] ,
         \str[10][3] , \str[10][2] , \str[10][1] , \str[10][0] , \str[9][7] ,
         \str[9][6] , \str[9][5] , \str[9][4] , \str[9][3] , \str[9][2] ,
         \str[9][1] , \str[9][0] , \str[8][7] , \str[8][6] , \str[8][5] ,
         \str[8][4] , \str[8][3] , \str[8][2] , \str[8][1] , \str[8][0] ,
         \str[7][7] , \str[7][6] , \str[7][5] , \str[7][4] , \str[7][3] ,
         \str[7][2] , \str[7][1] , \str[7][0] , \str[6][7] , \str[6][6] ,
         \str[6][5] , \str[6][4] , \str[6][3] , \str[6][2] , \str[6][1] ,
         \str[6][0] , \str[5][7] , \str[5][6] , \str[5][5] , \str[5][4] ,
         \str[5][3] , \str[5][2] , \str[5][1] , \str[5][0] , \str[4][7] ,
         \str[4][6] , \str[4][5] , \str[4][4] , \str[4][3] , \str[4][2] ,
         \str[4][1] , \str[4][0] , \str[3][7] , \str[3][6] , \str[3][5] ,
         \str[3][4] , \str[3][3] , \str[3][2] , \str[3][1] , \str[3][0] ,
         \str[2][7] , \str[2][6] , \str[2][5] , \str[2][4] , \str[2][3] ,
         \str[2][2] , \str[2][1] , \str[2][0] , \str[1][7] , \str[1][6] ,
         \str[1][5] , \str[1][4] , \str[1][3] , \str[1][2] , \str[1][1] ,
         \str[1][0] , \str[0][7] , \str[0][6] , \str[0][5] , \str[0][4] ,
         \str[0][3] , \str[0][2] , \str[0][1] , \str[0][0] , \pat[7][7] ,
         \pat[7][6] , \pat[7][5] , \pat[7][4] , \pat[7][3] , \pat[7][2] ,
         \pat[7][1] , \pat[7][0] , \pat[6][7] , \pat[6][6] , \pat[6][5] ,
         \pat[6][4] , \pat[6][3] , \pat[6][2] , \pat[6][1] , \pat[6][0] ,
         \pat[5][7] , \pat[5][6] , \pat[5][5] , \pat[5][4] , \pat[5][3] ,
         \pat[5][2] , \pat[5][1] , \pat[5][0] , \pat[4][7] , \pat[4][6] ,
         \pat[4][5] , \pat[4][4] , \pat[4][3] , \pat[4][2] , \pat[4][1] ,
         \pat[4][0] , \pat[3][7] , \pat[3][6] , \pat[3][5] , \pat[3][4] ,
         \pat[3][3] , \pat[3][2] , \pat[3][1] , \pat[3][0] , \pat[2][7] ,
         \pat[2][6] , \pat[2][5] , \pat[2][4] , \pat[2][3] , \pat[2][2] ,
         \pat[2][1] , \pat[2][0] , \pat[1][7] , \pat[1][6] , \pat[1][5] ,
         \pat[1][4] , \pat[1][3] , \pat[1][2] , \pat[1][1] , \pat[1][0] ,
         \pat[0][7] , \pat[0][6] , \pat[0][5] , \pat[0][4] , \pat[0][3] ,
         \pat[0][2] , \pat[0][1] , \pat[0][0] , starsig, head20, head2e;
  wire   [1:0] ctrlsig;
  wire   [5:0] scnt;
  wire   [3:0] plen;
  wire   [5:0] slen;
  wire   [7:0] patmask;
  wire   [3:0] staridx;
  wire   [4:0] m_idx;
  wire   [4:0] stride;

  Controller ctrl1 ( .clk(clk), .rst(reset), .isstr(isstring), .ispat(
        ispattern), .ctrlsig(ctrlsig), .valid(valid) );
  LenCounter lcnt1 ( .clk(clk), .rst(reset), .ctrlsig(ctrlsig[0]), .pcnt_clr(
        pcnt_clr), .isstr(isstring), .ispat(ispattern), .scnt(scnt), .plen(
        plen) );
  String str1 ( .clk(clk), .rst(reset), .isstr(isstring), .scnt(scnt), .slen(
        slen), .data(chardata), .str({\str[39][7] , \str[39][6] , \str[39][5] , 
        \str[39][4] , \str[39][3] , \str[39][2] , \str[39][1] , \str[39][0] , 
        \str[38][7] , \str[38][6] , \str[38][5] , \str[38][4] , \str[38][3] , 
        \str[38][2] , \str[38][1] , \str[38][0] , \str[37][7] , \str[37][6] , 
        \str[37][5] , \str[37][4] , \str[37][3] , \str[37][2] , \str[37][1] , 
        \str[37][0] , \str[36][7] , \str[36][6] , \str[36][5] , \str[36][4] , 
        \str[36][3] , \str[36][2] , \str[36][1] , \str[36][0] , \str[35][7] , 
        \str[35][6] , \str[35][5] , \str[35][4] , \str[35][3] , \str[35][2] , 
        \str[35][1] , \str[35][0] , \str[34][7] , \str[34][6] , \str[34][5] , 
        \str[34][4] , \str[34][3] , \str[34][2] , \str[34][1] , \str[34][0] , 
        \str[33][7] , \str[33][6] , \str[33][5] , \str[33][4] , \str[33][3] , 
        \str[33][2] , \str[33][1] , \str[33][0] , \str[32][7] , \str[32][6] , 
        \str[32][5] , \str[32][4] , \str[32][3] , \str[32][2] , \str[32][1] , 
        \str[32][0] , \str[31][7] , \str[31][6] , \str[31][5] , \str[31][4] , 
        \str[31][3] , \str[31][2] , \str[31][1] , \str[31][0] , \str[30][7] , 
        \str[30][6] , \str[30][5] , \str[30][4] , \str[30][3] , \str[30][2] , 
        \str[30][1] , \str[30][0] , \str[29][7] , \str[29][6] , \str[29][5] , 
        \str[29][4] , \str[29][3] , \str[29][2] , \str[29][1] , \str[29][0] , 
        \str[28][7] , \str[28][6] , \str[28][5] , \str[28][4] , \str[28][3] , 
        \str[28][2] , \str[28][1] , \str[28][0] , \str[27][7] , \str[27][6] , 
        \str[27][5] , \str[27][4] , \str[27][3] , \str[27][2] , \str[27][1] , 
        \str[27][0] , \str[26][7] , \str[26][6] , \str[26][5] , \str[26][4] , 
        \str[26][3] , \str[26][2] , \str[26][1] , \str[26][0] , \str[25][7] , 
        \str[25][6] , \str[25][5] , \str[25][4] , \str[25][3] , \str[25][2] , 
        \str[25][1] , \str[25][0] , \str[24][7] , \str[24][6] , \str[24][5] , 
        \str[24][4] , \str[24][3] , \str[24][2] , \str[24][1] , \str[24][0] , 
        \str[23][7] , \str[23][6] , \str[23][5] , \str[23][4] , \str[23][3] , 
        \str[23][2] , \str[23][1] , \str[23][0] , \str[22][7] , \str[22][6] , 
        \str[22][5] , \str[22][4] , \str[22][3] , \str[22][2] , \str[22][1] , 
        \str[22][0] , \str[21][7] , \str[21][6] , \str[21][5] , \str[21][4] , 
        \str[21][3] , \str[21][2] , \str[21][1] , \str[21][0] , \str[20][7] , 
        \str[20][6] , \str[20][5] , \str[20][4] , \str[20][3] , \str[20][2] , 
        \str[20][1] , \str[20][0] , \str[19][7] , \str[19][6] , \str[19][5] , 
        \str[19][4] , \str[19][3] , \str[19][2] , \str[19][1] , \str[19][0] , 
        \str[18][7] , \str[18][6] , \str[18][5] , \str[18][4] , \str[18][3] , 
        \str[18][2] , \str[18][1] , \str[18][0] , \str[17][7] , \str[17][6] , 
        \str[17][5] , \str[17][4] , \str[17][3] , \str[17][2] , \str[17][1] , 
        \str[17][0] , \str[16][7] , \str[16][6] , \str[16][5] , \str[16][4] , 
        \str[16][3] , \str[16][2] , \str[16][1] , \str[16][0] , \str[15][7] , 
        \str[15][6] , \str[15][5] , \str[15][4] , \str[15][3] , \str[15][2] , 
        \str[15][1] , \str[15][0] , \str[14][7] , \str[14][6] , \str[14][5] , 
        \str[14][4] , \str[14][3] , \str[14][2] , \str[14][1] , \str[14][0] , 
        \str[13][7] , \str[13][6] , \str[13][5] , \str[13][4] , \str[13][3] , 
        \str[13][2] , \str[13][1] , \str[13][0] , \str[12][7] , \str[12][6] , 
        \str[12][5] , \str[12][4] , \str[12][3] , \str[12][2] , \str[12][1] , 
        \str[12][0] , \str[11][7] , \str[11][6] , \str[11][5] , \str[11][4] , 
        \str[11][3] , \str[11][2] , \str[11][1] , \str[11][0] , \str[10][7] , 
        \str[10][6] , \str[10][5] , \str[10][4] , \str[10][3] , \str[10][2] , 
        \str[10][1] , \str[10][0] , \str[9][7] , \str[9][6] , \str[9][5] , 
        \str[9][4] , \str[9][3] , \str[9][2] , \str[9][1] , \str[9][0] , 
        \str[8][7] , \str[8][6] , \str[8][5] , \str[8][4] , \str[8][3] , 
        \str[8][2] , \str[8][1] , \str[8][0] , \str[7][7] , \str[7][6] , 
        \str[7][5] , \str[7][4] , \str[7][3] , \str[7][2] , \str[7][1] , 
        \str[7][0] , \str[6][7] , \str[6][6] , \str[6][5] , \str[6][4] , 
        \str[6][3] , \str[6][2] , \str[6][1] , \str[6][0] , \str[5][7] , 
        \str[5][6] , \str[5][5] , \str[5][4] , \str[5][3] , \str[5][2] , 
        \str[5][1] , \str[5][0] , \str[4][7] , \str[4][6] , \str[4][5] , 
        \str[4][4] , \str[4][3] , \str[4][2] , \str[4][1] , \str[4][0] , 
        \str[3][7] , \str[3][6] , \str[3][5] , \str[3][4] , \str[3][3] , 
        \str[3][2] , \str[3][1] , \str[3][0] , \str[2][7] , \str[2][6] , 
        \str[2][5] , \str[2][4] , \str[2][3] , \str[2][2] , \str[2][1] , 
        \str[2][0] , \str[1][7] , \str[1][6] , \str[1][5] , \str[1][4] , 
        \str[1][3] , \str[1][2] , \str[1][1] , \str[1][0] , \str[0][7] , 
        \str[0][6] , \str[0][5] , \str[0][4] , \str[0][3] , \str[0][2] , 
        \str[0][1] , \str[0][0] }) );
  Pattern pat1 ( .clk(clk), .ctrlsig(ctrlsig[0]), .ispat(ispattern), .plen(
        plen), .data(chardata), .pat({\pat[7][7] , \pat[7][6] , \pat[7][5] , 
        \pat[7][4] , \pat[7][3] , \pat[7][2] , \pat[7][1] , \pat[7][0] , 
        \pat[6][7] , \pat[6][6] , \pat[6][5] , \pat[6][4] , \pat[6][3] , 
        \pat[6][2] , \pat[6][1] , \pat[6][0] , \pat[5][7] , \pat[5][6] , 
        \pat[5][5] , \pat[5][4] , \pat[5][3] , \pat[5][2] , \pat[5][1] , 
        \pat[5][0] , \pat[4][7] , \pat[4][6] , \pat[4][5] , \pat[4][4] , 
        \pat[4][3] , \pat[4][2] , \pat[4][1] , \pat[4][0] , \pat[3][7] , 
        \pat[3][6] , \pat[3][5] , \pat[3][4] , \pat[3][3] , \pat[3][2] , 
        \pat[3][1] , \pat[3][0] , \pat[2][7] , \pat[2][6] , \pat[2][5] , 
        \pat[2][4] , \pat[2][3] , \pat[2][2] , \pat[2][1] , \pat[2][0] , 
        \pat[1][7] , \pat[1][6] , \pat[1][5] , \pat[1][4] , \pat[1][3] , 
        \pat[1][2] , \pat[1][1] , \pat[1][0] , \pat[0][7] , \pat[0][6] , 
        \pat[0][5] , \pat[0][4] , \pat[0][3] , \pat[0][2] , \pat[0][1] , 
        \pat[0][0] }), .patmask(patmask), .starsig(starsig), .staridx(staridx), 
        .pcnt_clr(pcnt_clr) );
  Match mat1 ( .clk(clk), .ctrlsig(ctrlsig), .starsig(starsig), .str({
        \str[39][7] , \str[39][6] , \str[39][5] , \str[39][4] , \str[39][3] , 
        \str[39][2] , \str[39][1] , \str[39][0] , \str[38][7] , \str[38][6] , 
        \str[38][5] , \str[38][4] , \str[38][3] , \str[38][2] , \str[38][1] , 
        \str[38][0] , \str[37][7] , \str[37][6] , \str[37][5] , \str[37][4] , 
        \str[37][3] , \str[37][2] , \str[37][1] , \str[37][0] , \str[36][7] , 
        \str[36][6] , \str[36][5] , \str[36][4] , \str[36][3] , \str[36][2] , 
        \str[36][1] , \str[36][0] , \str[35][7] , \str[35][6] , \str[35][5] , 
        \str[35][4] , \str[35][3] , \str[35][2] , \str[35][1] , \str[35][0] , 
        \str[34][7] , \str[34][6] , \str[34][5] , \str[34][4] , \str[34][3] , 
        \str[34][2] , \str[34][1] , \str[34][0] , \str[33][7] , \str[33][6] , 
        \str[33][5] , \str[33][4] , \str[33][3] , \str[33][2] , \str[33][1] , 
        \str[33][0] , \str[32][7] , \str[32][6] , \str[32][5] , \str[32][4] , 
        \str[32][3] , \str[32][2] , \str[32][1] , \str[32][0] , \str[31][7] , 
        \str[31][6] , \str[31][5] , \str[31][4] , \str[31][3] , \str[31][2] , 
        \str[31][1] , \str[31][0] , \str[30][7] , \str[30][6] , \str[30][5] , 
        \str[30][4] , \str[30][3] , \str[30][2] , \str[30][1] , \str[30][0] , 
        \str[29][7] , \str[29][6] , \str[29][5] , \str[29][4] , \str[29][3] , 
        \str[29][2] , \str[29][1] , \str[29][0] , \str[28][7] , \str[28][6] , 
        \str[28][5] , \str[28][4] , \str[28][3] , \str[28][2] , \str[28][1] , 
        \str[28][0] , \str[27][7] , \str[27][6] , \str[27][5] , \str[27][4] , 
        \str[27][3] , \str[27][2] , \str[27][1] , \str[27][0] , \str[26][7] , 
        \str[26][6] , \str[26][5] , \str[26][4] , \str[26][3] , \str[26][2] , 
        \str[26][1] , \str[26][0] , \str[25][7] , \str[25][6] , \str[25][5] , 
        \str[25][4] , \str[25][3] , \str[25][2] , \str[25][1] , \str[25][0] , 
        \str[24][7] , \str[24][6] , \str[24][5] , \str[24][4] , \str[24][3] , 
        \str[24][2] , \str[24][1] , \str[24][0] , \str[23][7] , \str[23][6] , 
        \str[23][5] , \str[23][4] , \str[23][3] , \str[23][2] , \str[23][1] , 
        \str[23][0] , \str[22][7] , \str[22][6] , \str[22][5] , \str[22][4] , 
        \str[22][3] , \str[22][2] , \str[22][1] , \str[22][0] , \str[21][7] , 
        \str[21][6] , \str[21][5] , \str[21][4] , \str[21][3] , \str[21][2] , 
        \str[21][1] , \str[21][0] , \str[20][7] , \str[20][6] , \str[20][5] , 
        \str[20][4] , \str[20][3] , \str[20][2] , \str[20][1] , \str[20][0] , 
        \str[19][7] , \str[19][6] , \str[19][5] , \str[19][4] , \str[19][3] , 
        \str[19][2] , \str[19][1] , \str[19][0] , \str[18][7] , \str[18][6] , 
        \str[18][5] , \str[18][4] , \str[18][3] , \str[18][2] , \str[18][1] , 
        \str[18][0] , \str[17][7] , \str[17][6] , \str[17][5] , \str[17][4] , 
        \str[17][3] , \str[17][2] , \str[17][1] , \str[17][0] , \str[16][7] , 
        \str[16][6] , \str[16][5] , \str[16][4] , \str[16][3] , \str[16][2] , 
        \str[16][1] , \str[16][0] , \str[15][7] , \str[15][6] , \str[15][5] , 
        \str[15][4] , \str[15][3] , \str[15][2] , \str[15][1] , \str[15][0] , 
        \str[14][7] , \str[14][6] , \str[14][5] , \str[14][4] , \str[14][3] , 
        \str[14][2] , \str[14][1] , \str[14][0] , \str[13][7] , \str[13][6] , 
        \str[13][5] , \str[13][4] , \str[13][3] , \str[13][2] , \str[13][1] , 
        \str[13][0] , \str[12][7] , \str[12][6] , \str[12][5] , \str[12][4] , 
        \str[12][3] , \str[12][2] , \str[12][1] , \str[12][0] , \str[11][7] , 
        \str[11][6] , \str[11][5] , \str[11][4] , \str[11][3] , \str[11][2] , 
        \str[11][1] , \str[11][0] , \str[10][7] , \str[10][6] , \str[10][5] , 
        \str[10][4] , \str[10][3] , \str[10][2] , \str[10][1] , \str[10][0] , 
        \str[9][7] , \str[9][6] , \str[9][5] , \str[9][4] , \str[9][3] , 
        \str[9][2] , \str[9][1] , \str[9][0] , \str[8][7] , \str[8][6] , 
        \str[8][5] , \str[8][4] , \str[8][3] , \str[8][2] , \str[8][1] , 
        \str[8][0] , \str[7][7] , \str[7][6] , \str[7][5] , \str[7][4] , 
        \str[7][3] , \str[7][2] , \str[7][1] , \str[7][0] , \str[6][7] , 
        \str[6][6] , \str[6][5] , \str[6][4] , \str[6][3] , \str[6][2] , 
        \str[6][1] , \str[6][0] , \str[5][7] , \str[5][6] , \str[5][5] , 
        \str[5][4] , \str[5][3] , \str[5][2] , \str[5][1] , \str[5][0] , 
        \str[4][7] , \str[4][6] , \str[4][5] , \str[4][4] , \str[4][3] , 
        \str[4][2] , \str[4][1] , \str[4][0] , \str[3][7] , \str[3][6] , 
        \str[3][5] , \str[3][4] , \str[3][3] , \str[3][2] , \str[3][1] , 
        \str[3][0] , \str[2][7] , \str[2][6] , \str[2][5] , \str[2][4] , 
        \str[2][3] , \str[2][2] , \str[2][1] , \str[2][0] , \str[1][7] , 
        \str[1][6] , \str[1][5] , \str[1][4] , \str[1][3] , \str[1][2] , 
        \str[1][1] , \str[1][0] , \str[0][7] , \str[0][6] , \str[0][5] , 
        \str[0][4] , \str[0][3] , \str[0][2] , \str[0][1] , \str[0][0] }), 
        .pat({\pat[7][7] , \pat[7][6] , \pat[7][5] , \pat[7][4] , \pat[7][3] , 
        \pat[7][2] , \pat[7][1] , \pat[7][0] , \pat[6][7] , \pat[6][6] , 
        \pat[6][5] , \pat[6][4] , \pat[6][3] , \pat[6][2] , \pat[6][1] , 
        \pat[6][0] , \pat[5][7] , \pat[5][6] , \pat[5][5] , \pat[5][4] , 
        \pat[5][3] , \pat[5][2] , \pat[5][1] , \pat[5][0] , \pat[4][7] , 
        \pat[4][6] , \pat[4][5] , \pat[4][4] , \pat[4][3] , \pat[4][2] , 
        \pat[4][1] , \pat[4][0] , \pat[3][7] , \pat[3][6] , \pat[3][5] , 
        \pat[3][4] , \pat[3][3] , \pat[3][2] , \pat[3][1] , \pat[3][0] , 
        \pat[2][7] , \pat[2][6] , \pat[2][5] , \pat[2][4] , \pat[2][3] , 
        \pat[2][2] , \pat[2][1] , \pat[2][0] , \pat[1][7] , \pat[1][6] , 
        \pat[1][5] , \pat[1][4] , \pat[1][3] , \pat[1][2] , \pat[1][1] , 
        \pat[1][0] , \pat[0][7] , \pat[0][6] , \pat[0][5] , \pat[0][4] , 
        \pat[0][3] , \pat[0][2] , \pat[0][1] , \pat[0][0] }), .slen(slen), 
        .plen(plen), .patmask(patmask), .m_done(m_done), .match_v(match_v), 
        .m_idx(m_idx), .head20(head20), .head2e(head2e) );
  MatchStar mats1 ( .clk(clk), .starsig(starsig), .ctrlsig(ctrlsig), .staridx(
        staridx), .pat({\pat[7][7] , \pat[7][6] , \pat[7][5] , \pat[7][4] , 
        \pat[7][3] , \pat[7][2] , \pat[7][1] , \pat[7][0] , \pat[6][7] , 
        \pat[6][6] , \pat[6][5] , \pat[6][4] , \pat[6][3] , \pat[6][2] , 
        \pat[6][1] , \pat[6][0] , \pat[5][7] , \pat[5][6] , \pat[5][5] , 
        \pat[5][4] , \pat[5][3] , \pat[5][2] , \pat[5][1] , \pat[5][0] , 
        \pat[4][7] , \pat[4][6] , \pat[4][5] , \pat[4][4] , \pat[4][3] , 
        \pat[4][2] , \pat[4][1] , \pat[4][0] , \pat[3][7] , \pat[3][6] , 
        \pat[3][5] , \pat[3][4] , \pat[3][3] , \pat[3][2] , \pat[3][1] , 
        \pat[3][0] , \pat[2][7] , \pat[2][6] , \pat[2][5] , \pat[2][4] , 
        \pat[2][3] , \pat[2][2] , \pat[2][1] , \pat[2][0] , \pat[1][7] , 
        \pat[1][6] , \pat[1][5] , \pat[1][4] , \pat[1][3] , \pat[1][2] , 
        \pat[1][1] , \pat[1][0] , \pat[0][7] , \pat[0][6] , \pat[0][5] , 
        \pat[0][4] , \pat[0][3] , \pat[0][2] , \pat[0][1] , \pat[0][0] }), 
        .str({\str[39][7] , \str[39][6] , \str[39][5] , \str[39][4] , 
        \str[39][3] , \str[39][2] , \str[39][1] , \str[39][0] , \str[38][7] , 
        \str[38][6] , \str[38][5] , \str[38][4] , \str[38][3] , \str[38][2] , 
        \str[38][1] , \str[38][0] , \str[37][7] , \str[37][6] , \str[37][5] , 
        \str[37][4] , \str[37][3] , \str[37][2] , \str[37][1] , \str[37][0] , 
        \str[36][7] , \str[36][6] , \str[36][5] , \str[36][4] , \str[36][3] , 
        \str[36][2] , \str[36][1] , \str[36][0] , \str[35][7] , \str[35][6] , 
        \str[35][5] , \str[35][4] , \str[35][3] , \str[35][2] , \str[35][1] , 
        \str[35][0] , \str[34][7] , \str[34][6] , \str[34][5] , \str[34][4] , 
        \str[34][3] , \str[34][2] , \str[34][1] , \str[34][0] , \str[33][7] , 
        \str[33][6] , \str[33][5] , \str[33][4] , \str[33][3] , \str[33][2] , 
        \str[33][1] , \str[33][0] , \str[32][7] , \str[32][6] , \str[32][5] , 
        \str[32][4] , \str[32][3] , \str[32][2] , \str[32][1] , \str[32][0] , 
        \str[31][7] , \str[31][6] , \str[31][5] , \str[31][4] , \str[31][3] , 
        \str[31][2] , \str[31][1] , \str[31][0] , \str[30][7] , \str[30][6] , 
        \str[30][5] , \str[30][4] , \str[30][3] , \str[30][2] , \str[30][1] , 
        \str[30][0] , \str[29][7] , \str[29][6] , \str[29][5] , \str[29][4] , 
        \str[29][3] , \str[29][2] , \str[29][1] , \str[29][0] , \str[28][7] , 
        \str[28][6] , \str[28][5] , \str[28][4] , \str[28][3] , \str[28][2] , 
        \str[28][1] , \str[28][0] , \str[27][7] , \str[27][6] , \str[27][5] , 
        \str[27][4] , \str[27][3] , \str[27][2] , \str[27][1] , \str[27][0] , 
        \str[26][7] , \str[26][6] , \str[26][5] , \str[26][4] , \str[26][3] , 
        \str[26][2] , \str[26][1] , \str[26][0] , \str[25][7] , \str[25][6] , 
        \str[25][5] , \str[25][4] , \str[25][3] , \str[25][2] , \str[25][1] , 
        \str[25][0] , \str[24][7] , \str[24][6] , \str[24][5] , \str[24][4] , 
        \str[24][3] , \str[24][2] , \str[24][1] , \str[24][0] , \str[23][7] , 
        \str[23][6] , \str[23][5] , \str[23][4] , \str[23][3] , \str[23][2] , 
        \str[23][1] , \str[23][0] , \str[22][7] , \str[22][6] , \str[22][5] , 
        \str[22][4] , \str[22][3] , \str[22][2] , \str[22][1] , \str[22][0] , 
        \str[21][7] , \str[21][6] , \str[21][5] , \str[21][4] , \str[21][3] , 
        \str[21][2] , \str[21][1] , \str[21][0] , \str[20][7] , \str[20][6] , 
        \str[20][5] , \str[20][4] , \str[20][3] , \str[20][2] , \str[20][1] , 
        \str[20][0] , \str[19][7] , \str[19][6] , \str[19][5] , \str[19][4] , 
        \str[19][3] , \str[19][2] , \str[19][1] , \str[19][0] , \str[18][7] , 
        \str[18][6] , \str[18][5] , \str[18][4] , \str[18][3] , \str[18][2] , 
        \str[18][1] , \str[18][0] , \str[17][7] , \str[17][6] , \str[17][5] , 
        \str[17][4] , \str[17][3] , \str[17][2] , \str[17][1] , \str[17][0] , 
        \str[16][7] , \str[16][6] , \str[16][5] , \str[16][4] , \str[16][3] , 
        \str[16][2] , \str[16][1] , \str[16][0] , \str[15][7] , \str[15][6] , 
        \str[15][5] , \str[15][4] , \str[15][3] , \str[15][2] , \str[15][1] , 
        \str[15][0] , \str[14][7] , \str[14][6] , \str[14][5] , \str[14][4] , 
        \str[14][3] , \str[14][2] , \str[14][1] , \str[14][0] , \str[13][7] , 
        \str[13][6] , \str[13][5] , \str[13][4] , \str[13][3] , \str[13][2] , 
        \str[13][1] , \str[13][0] , \str[12][7] , \str[12][6] , \str[12][5] , 
        \str[12][4] , \str[12][3] , \str[12][2] , \str[12][1] , \str[12][0] , 
        \str[11][7] , \str[11][6] , \str[11][5] , \str[11][4] , \str[11][3] , 
        \str[11][2] , \str[11][1] , \str[11][0] , \str[10][7] , \str[10][6] , 
        \str[10][5] , \str[10][4] , \str[10][3] , \str[10][2] , \str[10][1] , 
        \str[10][0] , \str[9][7] , \str[9][6] , \str[9][5] , \str[9][4] , 
        \str[9][3] , \str[9][2] , \str[9][1] , \str[9][0] , \str[8][7] , 
        \str[8][6] , \str[8][5] , \str[8][4] , \str[8][3] , \str[8][2] , 
        \str[8][1] , \str[8][0] , \str[7][7] , \str[7][6] , \str[7][5] , 
        \str[7][4] , \str[7][3] , \str[7][2] , \str[7][1] , \str[7][0] , 
        \str[6][7] , \str[6][6] , \str[6][5] , \str[6][4] , \str[6][3] , 
        \str[6][2] , \str[6][1] , \str[6][0] , \str[5][7] , \str[5][6] , 
        \str[5][5] , \str[5][4] , \str[5][3] , \str[5][2] , \str[5][1] , 
        \str[5][0] , \str[4][7] , \str[4][6] , \str[4][5] , \str[4][4] , 
        \str[4][3] , \str[4][2] , \str[4][1] , \str[4][0] , \str[3][7] , 
        \str[3][6] , \str[3][5] , \str[3][4] , \str[3][3] , \str[3][2] , 
        \str[3][1] , \str[3][0] , \str[2][7] , \str[2][6] , \str[2][5] , 
        \str[2][4] , \str[2][3] , \str[2][2] , \str[2][1] , \str[2][0] , 
        \str[1][7] , \str[1][6] , \str[1][5] , \str[1][4] , \str[1][3] , 
        \str[1][2] , \str[1][1] , \str[1][0] , \str[0][7] , \str[0][6] , 
        \str[0][5] , \str[0][4] , \str[0][3] , \str[0][2] , \str[0][1] , 
        \str[0][0] }), .slen(slen), .plen(plen), .stride(stride), .mstar_v(
        mstar_v), .star_done(star_done) );
  SendIdx si1 ( .clk(clk), .rst(reset), .match_v(match_v), .m_done(m_done), 
        .m_idx(m_idx), .head20(head20), .head2e(head2e), .mstar_v(mstar_v), 
        .star_done(star_done), .stride(stride), .o_idx(match_index), .valid(
        valid), .match(match) );
  OR4X1 U2 ( .A(match_v), .B(m_done), .C(star_done), .D(mstar_v), .Y(pcnt_clr)
         );
endmodule

