/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : Q-2019.12
// Date      : Wed Mar 17 22:42:53 2021
/////////////////////////////////////////////////////////////


module SET_DW01_add_0_DW01_add_1 ( A, B, CI, SUM, CO );
  input [7:0] A;
  input [7:0] B;
  output [7:0] SUM;
  input CI;
  output CO;
  wire   n1, n2;
  wire   [7:1] carry;

  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(n1), .CO(carry[3]), .S(SUM[2]) );
  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  XOR3X1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .Y(SUM[7]) );
  AND2X2 U1 ( .A(A[1]), .B(n2), .Y(n1) );
  AND2XL U2 ( .A(B[0]), .B(A[0]), .Y(n2) );
  XOR2XL U3 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
  XOR2XL U4 ( .A(A[1]), .B(n2), .Y(SUM[1]) );
endmodule


module SET ( clk, rst, en, central, radius, mode, busy, valid, candidate );
  input [23:0] central;
  input [11:0] radius;
  input [1:0] mode;
  output [7:0] candidate;
  input clk, rst, en;
  output busy, valid;
  wire   n595, n596, n597, n598, n599, n600, n601, fin, \x[0][3] , \x[0][2] ,
         \x[0][1] , \x[0][0] , \x[1][3] , \x[1][2] , \x[1][0] , \x[2][3] ,
         \x[2][2] , \x[2][0] , \y[0][3] , \y[0][2] , \y[0][0] , \y[1][3] ,
         \y[1][2] , \y[1][0] , \y[2][3] , \y[2][2] , \y[2][1] , \y[2][0] ,
         \r[0][3] , \r[0][2] , \r[0][1] , \r[0][0] , \r[1][3] , \r[1][2] ,
         \r[1][1] , \r[1][0] , \r[2][3] , \r[2][2] , \r[2][1] , \r[2][0] , N61,
         N62, N63, N76, N77, N78, N79, iscand, iscand_AB, iscand_AC, N300,
         N301, N302, N303, N304, N305, N306, N307, N360, n242, n243, n244,
         n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277,
         n280, n281, n282, n293, n294, n295, n297, n298, n299, n300, n301,
         n302, N364, N363, N362, N361, \mult_101/n13 , \mult_101/n12 ,
         \mult_101/n10 , \mult_101/n9 , \mult_101/n8 , \mult_101/n7 ,
         \mult_101/n4 , \mult_101/n3 , \mult_101/n2 , \mult_101/n1 ,
         \add_0_root_add_2_root_add_196_2/B[0] ,
         \add_0_root_add_2_root_add_196_2/B[1] ,
         \add_0_root_add_2_root_add_196_2/B[2] ,
         \add_0_root_add_2_root_add_196_2/B[3] ,
         \add_0_root_add_2_root_add_196_2/B[4] ,
         \add_0_root_add_2_root_add_196_2/B[5] ,
         \add_0_root_add_2_root_add_196_2/B[6] ,
         \add_0_root_add_2_root_add_196_2/B[7] ,
         \add_0_root_add_2_root_add_196_2/A[0] ,
         \add_0_root_add_2_root_add_196_2/A[1] ,
         \add_0_root_add_2_root_add_196_2/A[7] ,
         \add_3_root_add_2_root_add_196_2/B[0] ,
         \add_3_root_add_2_root_add_196_2/B[1] , n303, n304, n305, n306, n307,
         n308, n309, n310, n311, n312, n313, n314, n315, n316, n317, n318,
         n319, n320, n321, n322, n323, n324, n325, n326, n327, n328, n329,
         n330, n331, n332, n333, n334, n338, n339, n340, n341, n343, n345,
         n347, n349, n352, n354, n355, n356, n357, n358, n359, n360, n361,
         n362, n363, n364, n365, n366, n367, n368, n369, n370, n371, n372,
         n373, n374, n375, n376, n377, n378, n379, n380, n381, n382, n383,
         n384, n385, n386, n387, n388, n389, n390, n391, n392, n393, n394,
         n395, n396, n397, n398, n399, n400, n401, n402, n403, n404, n405,
         n406, n407, n408, n409, n410, n411, n412, n413, n414, n415, n416,
         n417, n418, n419, n420, n421, n422, n423, n424, n425, n426, n427,
         n428, n429, n430, n431, n432, n433, n434, n435, n436, n437, n438,
         n439, n440, n441, n442, n443, n444, n445, n446, n447, n448, n449,
         n450, n451, n452, n453, n454, n455, n456, n457, n458, n459, n460,
         n461, n462, n463, n464, n465, n466, n467, n468, n469, n470, n471,
         n472, n473, n474, n475, n476, n477, n478, n479, n480, n481, n482,
         n483, n484, n485, n486, n487, n488, n489, n490, n491, n492, n493,
         n494, n495, n496, n497, n498, n499, n500, n501, n502, n503, n504,
         n505, n506, n507, n508, n509, n510, n511, n512, n513, n514, n515,
         n516, n517, n518, n519, n520, n521, n522, n523, n524, n525, n526,
         n527, n528, n529, n530, n531, n532, n533, n534, n535, n536, n537,
         n538, n539, n540, n541, n542, n543, n544, n545, n546, n547, n548,
         n549, n550, n551, n552, n553, n554, n555, n556, n557, n558, n559,
         n560, n561, n562, n563, n564, n565, n566, n567, n568, n569, n570,
         n571, n572, n573, n574, n575, n576, n577, n578, n579, n580, n581,
         n582, n583, n584, n585, n586, n587, n588, n589, n590, n591, n592,
         n593, n594;
  wire   [3:0] ycnt;
  wire   [3:0] mcnt;
  wire   [3:0] xcnt;
  wire   [3:0] inmul;
  wire   [7:0] mul;
  wire   [7:0] dst;
  wire   [7:0] dst_tmp;
  wire   [7:0] r2_A;
  wire   [7:0] r2_B;
  wire   [7:0] r2_C;
  wire   [1:0] pre_iscand;
  wire   [7:1] \add_0_root_add_2_root_add_196_2/carry ;
  wire   [7:1] \add_3_root_add_2_root_add_196_2/carry ;

  SET_DW01_add_0_DW01_add_1 add_118 ( .A({dst[7:6], n354, dst[4:0]}), .B({
        mul[7:2], 1'b0, mul[0]}), .CI(1'b0), .SUM(dst_tmp) );
  EDFFX1 \r2_A_reg[7]  ( .D(mul[7]), .E(n362), .CK(clk), .Q(r2_A[7]) );
  EDFFX1 \r2_A_reg[6]  ( .D(mul[6]), .E(n362), .CK(clk), .Q(r2_A[6]) );
  DFFQX1 \pre_iscand_reg[1]  ( .D(n298), .CK(clk), .Q(pre_iscand[1]) );
  DFFQX1 \pre_iscand_reg[0]  ( .D(n297), .CK(clk), .Q(pre_iscand[0]) );
  DFFRX1 \r_reg[0][0]  ( .D(n274), .CK(clk), .RN(n366), .Q(\r[0][0] ) );
  DFFRX1 \r_reg[2][0]  ( .D(n266), .CK(clk), .RN(n365), .Q(\r[2][0] ) );
  DFFRX1 \r_reg[2][3]  ( .D(n269), .CK(clk), .RN(n366), .Q(\r[2][3] ) );
  DFFRX1 \r_reg[1][0]  ( .D(n270), .CK(clk), .RN(n365), .Q(\r[1][0] ) );
  DFFX1 \ycnt_reg[3]  ( .D(n302), .CK(clk), .QN(n579) );
  DFFRX1 \mod_reg[1]  ( .D(mode[1]), .CK(clk), .RN(n593), .Q(n581) );
  DFFRX1 \mod_reg[0]  ( .D(mode[0]), .CK(clk), .RN(n593), .Q(n580), .QN(n331)
         );
  EDFFX1 \xcnt_reg[3]  ( .D(N63), .E(n281), .CK(clk), .Q(xcnt[3]) );
  EDFFX1 \r2_C_reg[3]  ( .D(mul[3]), .E(n295), .CK(clk), .QN(n315) );
  EDFFX1 \r2_A_reg[4]  ( .D(mul[4]), .E(n362), .CK(clk), .QN(n310) );
  EDFFX1 \r2_A_reg[3]  ( .D(mul[3]), .E(n362), .CK(clk), .QN(n316) );
  EDFFX1 \r2_B_reg[3]  ( .D(mul[3]), .E(n361), .CK(clk), .QN(n314) );
  EDFFX1 \r2_C_reg[0]  ( .D(mul[0]), .E(n295), .CK(clk), .Q(r2_C[0]) );
  EDFFX1 \r2_A_reg[0]  ( .D(mul[0]), .E(n362), .CK(clk), .Q(r2_A[0]) );
  EDFFX1 \r2_C_reg[7]  ( .D(mul[7]), .E(n295), .CK(clk), .Q(r2_C[7]) );
  EDFFX1 \r2_B_reg[7]  ( .D(mul[7]), .E(n361), .CK(clk), .Q(r2_B[7]) );
  EDFFX1 \r2_C_reg[6]  ( .D(mul[6]), .E(n295), .CK(clk), .Q(r2_C[6]) );
  EDFFX1 \r2_B_reg[6]  ( .D(mul[6]), .E(n361), .CK(clk), .Q(r2_B[6]) );
  EDFFX1 \r2_A_reg[5]  ( .D(mul[5]), .E(n362), .CK(clk), .Q(r2_A[5]), .QN(n325) );
  EDFFX1 \r2_C_reg[2]  ( .D(n356), .E(n295), .CK(clk), .Q(r2_C[2]), .QN(n306)
         );
  EDFFX1 \r2_A_reg[2]  ( .D(n356), .E(n362), .CK(clk), .Q(r2_A[2]), .QN(n307)
         );
  DFFRX1 \r_reg[0][3]  ( .D(n277), .CK(clk), .RN(n593), .Q(\r[0][3] ) );
  DFFRX1 \r_reg[0][2]  ( .D(n276), .CK(clk), .RN(n366), .Q(\r[0][2] ) );
  DFFRX1 \r_reg[0][1]  ( .D(n275), .CK(clk), .RN(n365), .Q(\r[0][1] ) );
  DFFRX1 \r_reg[1][3]  ( .D(n273), .CK(clk), .RN(n366), .Q(\r[1][3] ) );
  DFFRX1 \r_reg[1][2]  ( .D(n272), .CK(clk), .RN(n365), .Q(\r[1][2] ) );
  DFFRX1 \r_reg[1][1]  ( .D(n271), .CK(clk), .RN(n366), .Q(\r[1][1] ) );
  DFFRX1 \r_reg[2][2]  ( .D(n268), .CK(clk), .RN(n365), .Q(\r[2][2] ) );
  DFFRX1 \r_reg[2][1]  ( .D(n267), .CK(clk), .RN(n366), .Q(\r[2][1] ) );
  DFFRX1 \y_reg[0][3]  ( .D(n265), .CK(clk), .RN(n593), .Q(\y[0][3] ) );
  DFFRX1 \y_reg[1][3]  ( .D(n261), .CK(clk), .RN(n366), .Q(\y[1][3] ) );
  DFFRX1 \y_reg[2][3]  ( .D(n257), .CK(clk), .RN(n366), .Q(\y[2][3] ) );
  DFFRX1 \x_reg[0][3]  ( .D(n253), .CK(clk), .RN(n366), .Q(\x[0][3] ) );
  DFFRX1 \x_reg[1][3]  ( .D(n249), .CK(clk), .RN(n365), .Q(\x[1][3] ) );
  DFFRX1 \x_reg[2][3]  ( .D(n245), .CK(clk), .RN(n365), .Q(\x[2][3] ) );
  DFFQX1 \dst_reg[6]  ( .D(n586), .CK(clk), .Q(dst[6]) );
  EDFFX1 \r2_C_reg[4]  ( .D(mul[4]), .E(n295), .CK(clk), .QN(n324) );
  EDFFX1 \r2_B_reg[4]  ( .D(mul[4]), .E(n361), .CK(clk), .QN(n308) );
  EDFFX1 \r2_B_reg[0]  ( .D(mul[0]), .E(n361), .CK(clk), .Q(r2_B[0]) );
  EDFFX1 \r2_C_reg[5]  ( .D(mul[5]), .E(n295), .CK(clk), .Q(r2_C[5]), .QN(n309) );
  EDFFX1 \r2_B_reg[5]  ( .D(mul[5]), .E(n361), .CK(clk), .Q(r2_B[5]), .QN(n318) );
  EDFFX1 \r2_B_reg[2]  ( .D(n356), .E(n361), .CK(clk), .Q(r2_B[2]), .QN(n305)
         );
  DFFRX1 \x_reg[0][2]  ( .D(n252), .CK(clk), .RN(n365), .Q(\x[0][2] ), .QN(
        n328) );
  DFFRX1 \y_reg[2][2]  ( .D(n256), .CK(clk), .RN(n366), .Q(\y[2][2] ), .QN(
        n329) );
  DFFRX1 \y_reg[0][1]  ( .D(n263), .CK(clk), .RN(n366), .QN(n582) );
  DFFRX1 \y_reg[1][1]  ( .D(n259), .CK(clk), .RN(n366), .QN(n584) );
  DFFRX1 \x_reg[1][1]  ( .D(n247), .CK(clk), .RN(n365), .QN(n583) );
  DFFRX1 \x_reg[2][1]  ( .D(n243), .CK(clk), .RN(n365), .QN(n585) );
  EDFFX1 \xcnt_reg[2]  ( .D(N62), .E(n281), .CK(clk), .Q(xcnt[2]) );
  DFFQX1 \dst_reg[0]  ( .D(n592), .CK(clk), .Q(dst[0]) );
  DFFRX1 \y_reg[0][2]  ( .D(n264), .CK(clk), .RN(n366), .Q(\y[0][2] ) );
  DFFRX1 \y_reg[1][2]  ( .D(n260), .CK(clk), .RN(n366), .Q(\y[1][2] ) );
  DFFRX1 \x_reg[1][2]  ( .D(n248), .CK(clk), .RN(n365), .Q(\x[1][2] ) );
  DFFRX1 \x_reg[2][2]  ( .D(n244), .CK(clk), .RN(n365), .Q(\x[2][2] ) );
  DFFQX2 \dst_reg[3]  ( .D(n589), .CK(clk), .Q(dst[3]) );
  DFFQX2 \ycnt_reg[2]  ( .D(n280), .CK(clk), .Q(ycnt[2]) );
  DFFQX2 \dst_reg[4]  ( .D(n588), .CK(clk), .Q(dst[4]) );
  DFFRX1 \y_reg[0][0]  ( .D(n262), .CK(clk), .RN(n366), .Q(\y[0][0] ), .QN(
        n312) );
  DFFRX1 \y_reg[1][0]  ( .D(n258), .CK(clk), .RN(n366), .Q(\y[1][0] ), .QN(
        n332) );
  DFFRX1 \y_reg[2][0]  ( .D(n254), .CK(clk), .RN(n366), .Q(\y[2][0] ), .QN(
        n304) );
  DFFRX1 \x_reg[1][0]  ( .D(n246), .CK(clk), .RN(n365), .Q(\x[1][0] ), .QN(
        n311) );
  DFFRX1 \x_reg[2][0]  ( .D(n242), .CK(clk), .RN(n365), .Q(\x[2][0] ), .QN(
        n330) );
  DFFRX1 \y_reg[2][1]  ( .D(n255), .CK(clk), .RN(n366), .Q(\y[2][1] ), .QN(
        n323) );
  DFFRX1 \x_reg[0][1]  ( .D(n251), .CK(clk), .RN(n365), .Q(\x[0][1] ), .QN(
        n322) );
  DFFQX2 \ycnt_reg[1]  ( .D(n300), .CK(clk), .Q(ycnt[1]) );
  EDFFX1 \xcnt_reg[1]  ( .D(N61), .E(n281), .CK(clk), .Q(xcnt[1]) );
  EDFFX1 \xcnt_reg[0]  ( .D(n594), .E(n281), .CK(clk), .Q(xcnt[0]), .QN(n313)
         );
  DFFRX1 \x_reg[0][0]  ( .D(n250), .CK(clk), .RN(n365), .Q(\x[0][0] ), .QN(
        n303) );
  DFFQX1 \dst_reg[2]  ( .D(n590), .CK(clk), .Q(dst[2]) );
  DFFQX1 \dst_reg[7]  ( .D(n320), .CK(clk), .Q(dst[7]) );
  DFFQX1 \ycnt_reg[0]  ( .D(n299), .CK(clk), .Q(ycnt[0]) );
  DFFQX2 \mcnt_reg[3]  ( .D(N79), .CK(clk), .Q(mcnt[3]) );
  DFFQX2 \mcnt_reg[0]  ( .D(N76), .CK(clk), .Q(mcnt[0]) );
  DFFQX1 \dst_reg[1]  ( .D(n591), .CK(clk), .Q(dst[1]) );
  DFFQX1 \mcnt_reg[1]  ( .D(N77), .CK(clk), .Q(mcnt[1]) );
  DFFX1 \dst_reg[5]  ( .D(n587), .CK(clk), .Q(n354), .QN(n355) );
  DFFQX1 \mcnt_reg[2]  ( .D(N78), .CK(clk), .Q(mcnt[2]) );
  DFFTRX1 \candidate_reg[3]  ( .D(N303), .RN(n368), .CK(clk), .Q(n599), .QN(
        n352) );
  DFFQX1 valid_reg ( .D(fin), .CK(clk), .Q(n595) );
  DFFTRX1 \candidate_reg[4]  ( .D(N304), .RN(n368), .CK(clk), .Q(n598), .QN(
        n349) );
  DFFRX2 busy_reg ( .D(n301), .CK(clk), .RN(n365), .QN(n282) );
  DFFTRX1 \candidate_reg[5]  ( .D(N305), .RN(n368), .CK(clk), .Q(n597), .QN(
        n347) );
  DFFTRX1 \candidate_reg[6]  ( .D(N306), .RN(n368), .CK(clk), .Q(n596), .QN(
        n345) );
  DFFTRX1 \candidate_reg[2]  ( .D(N302), .RN(n368), .CK(clk), .Q(n600), .QN(
        n343) );
  DFFTRX2 \candidate_reg[7]  ( .D(N307), .RN(n368), .CK(clk), .QN(n334) );
  DFFTRX1 \candidate_reg[1]  ( .D(N301), .RN(n368), .CK(clk), .Q(n601), .QN(
        n341) );
  DFFQXL \r2_A_reg[1]  ( .D(n340), .CK(clk), .Q(r2_A[1]) );
  DFFQXL \r2_C_reg[1]  ( .D(n339), .CK(clk), .Q(r2_C[1]) );
  DFFQXL \r2_B_reg[1]  ( .D(n338), .CK(clk), .Q(r2_B[1]) );
  DFFTRX1 \candidate_reg[0]  ( .D(N300), .RN(n368), .CK(clk), .QN(n333) );
  INVX4 U240 ( .A(dst[1]), .Y(n432) );
  XOR2X1 U241 ( .A(\add_3_root_add_2_root_add_196_2/B[0] ), .B(candidate[0]), 
        .Y(\add_0_root_add_2_root_add_196_2/B[0] ) );
  OAI222XL U242 ( .A0(n303), .A1(n363), .B0(n330), .B1(n388), .C0(n311), .C1(
        n364), .Y(n567) );
  INVX16 U243 ( .A(n282), .Y(busy) );
  AND2X2 U244 ( .A(mcnt[3]), .B(n455), .Y(n317) );
  AND2X2 U245 ( .A(inmul[1]), .B(\mult_101/n13 ), .Y(n319) );
  OR3X2 U246 ( .A(n358), .B(n359), .C(n360), .Y(n320) );
  AND2X2 U247 ( .A(mcnt[0]), .B(n440), .Y(n321) );
  AND2X2 U248 ( .A(mcnt[0]), .B(mcnt[3]), .Y(n326) );
  OR2X1 U249 ( .A(n404), .B(n581), .Y(n327) );
  INVX12 U250 ( .A(n334), .Y(candidate[7]) );
  INVX16 U251 ( .A(n333), .Y(candidate[0]) );
  NOR2BX1 U252 ( .AN(r2_B[1]), .B(n361), .Y(n338) );
  NOR2BX1 U253 ( .AN(r2_C[1]), .B(n295), .Y(n339) );
  NOR2BX1 U254 ( .AN(r2_A[1]), .B(n362), .Y(n340) );
  INVX12 U255 ( .A(n341), .Y(candidate[1]) );
  XOR2XL U256 ( .A(candidate[7]), .B(
        \add_3_root_add_2_root_add_196_2/carry [7]), .Y(
        \add_0_root_add_2_root_add_196_2/B[7] ) );
  AND2XL U257 ( .A(candidate[0]), .B(\add_3_root_add_2_root_add_196_2/B[0] ), 
        .Y(\add_3_root_add_2_root_add_196_2/carry [1]) );
  INVX12 U258 ( .A(n343), .Y(candidate[2]) );
  XOR2XL U259 ( .A(n600), .B(\add_3_root_add_2_root_add_196_2/carry [2]), .Y(
        \add_0_root_add_2_root_add_196_2/B[2] ) );
  INVX12 U260 ( .A(n345), .Y(candidate[6]) );
  XOR2XL U261 ( .A(n596), .B(\add_3_root_add_2_root_add_196_2/carry [6]), .Y(
        \add_0_root_add_2_root_add_196_2/B[6] ) );
  INVX12 U262 ( .A(n347), .Y(candidate[5]) );
  XOR2XL U263 ( .A(n597), .B(\add_3_root_add_2_root_add_196_2/carry [5]), .Y(
        \add_0_root_add_2_root_add_196_2/B[5] ) );
  AND2XL U264 ( .A(\add_3_root_add_2_root_add_196_2/carry [5]), .B(n597), .Y(
        \add_3_root_add_2_root_add_196_2/carry [6]) );
  INVX12 U265 ( .A(n349), .Y(candidate[4]) );
  XOR2XL U266 ( .A(n598), .B(\add_3_root_add_2_root_add_196_2/carry [4]), .Y(
        \add_0_root_add_2_root_add_196_2/B[4] ) );
  AND2XL U267 ( .A(\add_3_root_add_2_root_add_196_2/carry [4]), .B(n598), .Y(
        \add_3_root_add_2_root_add_196_2/carry [5]) );
  BUFX12 U268 ( .A(n595), .Y(valid) );
  INVX12 U269 ( .A(n352), .Y(candidate[3]) );
  XOR2XL U270 ( .A(n599), .B(\add_3_root_add_2_root_add_196_2/carry [3]), .Y(
        \add_0_root_add_2_root_add_196_2/B[3] ) );
  AND2XL U271 ( .A(\add_3_root_add_2_root_add_196_2/carry [3]), .B(n599), .Y(
        \add_3_root_add_2_root_add_196_2/carry [4]) );
  ADDFX2 U272 ( .A(\mult_101/n7 ), .B(\mult_101/n10 ), .CI(\mult_101/n4 ), 
        .CO(\mult_101/n3 ), .S(mul[4]) );
  NAND3X1 U273 ( .A(n531), .B(n532), .C(n533), .Y(inmul[1]) );
  OAI222XL U274 ( .A0(n383), .A1(n494), .B0(n385), .B1(n495), .C0(n384), .C1(
        n496), .Y(n486) );
  OAI222XL U275 ( .A0(n383), .A1(n521), .B0(n385), .B1(n522), .C0(n384), .C1(
        n523), .Y(n520) );
  ADDFXL U276 ( .A(\add_0_root_add_2_root_add_196_2/A[7] ), .B(
        \add_0_root_add_2_root_add_196_2/B[4] ), .CI(
        \add_0_root_add_2_root_add_196_2/carry [4]), .CO(
        \add_0_root_add_2_root_add_196_2/carry [5]), .S(N304) );
  ADDFXL U277 ( .A(\add_0_root_add_2_root_add_196_2/A[7] ), .B(
        \add_0_root_add_2_root_add_196_2/B[6] ), .CI(
        \add_0_root_add_2_root_add_196_2/carry [6]), .CO(
        \add_0_root_add_2_root_add_196_2/carry [7]), .S(N306) );
  NAND2X2 U278 ( .A(n321), .B(n569), .Y(n384) );
  NAND3X2 U279 ( .A(n383), .B(n384), .C(n385), .Y(n372) );
  CLKINVX1 U280 ( .A(n379), .Y(n570) );
  NOR2BX1 U281 ( .AN(n517), .B(n388), .Y(n539) );
  NOR2BX1 U282 ( .AN(n529), .B(n383), .Y(n554) );
  AND2X2 U283 ( .A(inmul[1]), .B(mul[0]), .Y(\mult_101/n13 ) );
  NOR2BX1 U284 ( .AN(n516), .B(n364), .Y(n541) );
  MXI2X1 U285 ( .A(n435), .B(n436), .S0(n580), .Y(n434) );
  ADDFXL U286 ( .A(\add_0_root_add_2_root_add_196_2/A[7] ), .B(
        \add_0_root_add_2_root_add_196_2/B[3] ), .CI(
        \add_0_root_add_2_root_add_196_2/carry [3]), .CO(
        \add_0_root_add_2_root_add_196_2/carry [4]), .S(N303) );
  NOR2X1 U287 ( .A(n441), .B(mcnt[3]), .Y(n569) );
  OAI22X1 U288 ( .A0(n416), .A1(n417), .B0(r2_C[7]), .B1(n418), .Y(n412) );
  AOI32XL U289 ( .A0(n419), .A1(n420), .A2(n421), .B0(n422), .B1(n423), .Y(
        n416) );
  CLKINVX1 U290 ( .A(\mult_101/n1 ), .Y(mul[7]) );
  INVX1 U291 ( .A(mcnt[1]), .Y(n440) );
  AOI32XL U292 ( .A0(n442), .A1(n443), .A2(n444), .B0(n445), .B1(n446), .Y(
        n437) );
  NOR2X1 U293 ( .A(n399), .B(n327), .Y(n436) );
  OAI221X1 U294 ( .A0(n437), .A1(n438), .B0(r2_B[7]), .B1(n418), .C0(n439), 
        .Y(n399) );
  XOR2X1 U295 ( .A(inmul[1]), .B(\mult_101/n13 ), .Y(n356) );
  NAND2X2 U296 ( .A(n326), .B(n571), .Y(n383) );
  NOR2BX1 U297 ( .AN(n518), .B(n363), .Y(n544) );
  XOR2X1 U298 ( .A(inmul[1]), .B(\mult_101/n13 ), .Y(mul[2]) );
  CLKINVX1 U299 ( .A(n503), .Y(n501) );
  NAND2X1 U300 ( .A(mul[0]), .B(inmul[3]), .Y(\mult_101/n10 ) );
  AND2X2 U301 ( .A(inmul[2]), .B(mul[0]), .Y(\mult_101/n12 ) );
  OAI21XL U302 ( .A0(n447), .A1(n425), .B0(r2_B[6]), .Y(n446) );
  ADDFXL U303 ( .A(\add_0_root_add_2_root_add_196_2/A[7] ), .B(
        \add_0_root_add_2_root_add_196_2/B[2] ), .CI(
        \add_0_root_add_2_root_add_196_2/carry [2]), .CO(
        \add_0_root_add_2_root_add_196_2/carry [3]), .S(N302) );
  NOR2X1 U304 ( .A(n440), .B(mcnt[2]), .Y(n571) );
  NOR2X1 U305 ( .A(n566), .B(\y[2][0] ), .Y(n529) );
  NOR2X1 U306 ( .A(n313), .B(\x[0][0] ), .Y(n518) );
  OAI21XL U307 ( .A0(\y[2][2] ), .A1(n503), .B0(n504), .Y(n502) );
  OA21XL U308 ( .A0(n501), .A1(n329), .B0(n502), .Y(n493) );
  CLKINVX1 U309 ( .A(mcnt[0]), .Y(n455) );
  CLKINVX1 U310 ( .A(mcnt[2]), .Y(n441) );
  NAND3X1 U311 ( .A(n505), .B(n506), .C(n507), .Y(inmul[2]) );
  CLKINVX1 U312 ( .A(ycnt[0]), .Y(n566) );
  NOR2XL U313 ( .A(n570), .B(n575), .Y(N77) );
  NOR2XL U314 ( .A(n528), .B(n385), .Y(n558) );
  NAND2XL U315 ( .A(n424), .B(n425), .Y(n422) );
  ADDHX1 U316 ( .A(\mult_101/n12 ), .B(n319), .CO(\mult_101/n4 ), .S(mul[3])
         );
  NOR2XL U317 ( .A(n404), .B(n414), .Y(\add_0_root_add_2_root_add_196_2/A[1] )
         );
  XOR2XL U318 ( .A(\add_0_root_add_2_root_add_196_2/B[0] ), .B(
        \add_0_root_add_2_root_add_196_2/A[0] ), .Y(N300) );
  NOR2XL U319 ( .A(n372), .B(n370), .Y(n382) );
  NOR2X1 U320 ( .A(n517), .B(n388), .Y(n540) );
  AOI2BB1X1 U321 ( .A0N(n518), .A1N(n322), .B0(n357), .Y(n484) );
  AOI21X1 U322 ( .A0(n322), .A1(n518), .B0(xcnt[1]), .Y(n357) );
  XOR2XL U323 ( .A(n497), .B(\y[0][2] ), .Y(n526) );
  XOR2XL U324 ( .A(n499), .B(\y[1][2] ), .Y(n525) );
  XNOR2XL U325 ( .A(\y[0][2] ), .B(n497), .Y(n523) );
  XNOR2XL U326 ( .A(\y[1][2] ), .B(n499), .Y(n522) );
  NOR4XL U327 ( .A(n455), .B(mcnt[1]), .C(mcnt[2]), .D(mcnt[3]), .Y(n294) );
  NAND4XL U328 ( .A(mcnt[3]), .B(mcnt[0]), .C(n440), .D(n441), .Y(n405) );
  INVX1 U329 ( .A(mcnt[3]), .Y(n380) );
  XOR2XL U330 ( .A(n328), .B(n484), .Y(n513) );
  OAI222XL U331 ( .A0(n513), .A1(n363), .B0(n514), .B1(n388), .C0(n515), .C1(
        n364), .Y(n508) );
  XOR2XL U332 ( .A(\x[0][2] ), .B(n484), .Y(n510) );
  OAI222XL U333 ( .A0(n363), .A1(n510), .B0(n388), .B1(n511), .C0(n364), .C1(
        n512), .Y(n509) );
  AOI211XL U334 ( .A0(r2_C[1]), .A1(n432), .B0(n433), .C0(r2_C[0]), .Y(n430)
         );
  AOI211XL U335 ( .A0(r2_A[1]), .A1(n432), .B0(n433), .C0(r2_A[0]), .Y(n464)
         );
  OAI222XL U336 ( .A0(n363), .A1(n471), .B0(n388), .B1(n472), .C0(n364), .C1(
        n473), .Y(n470) );
  INVX1 U337 ( .A(dst[0]), .Y(n433) );
  OAI222XL U338 ( .A0(n477), .A1(n363), .B0(n478), .B1(n388), .C0(n479), .C1(
        n364), .Y(n469) );
  NAND2XL U339 ( .A(r2_C[5]), .B(n355), .Y(n420) );
  NAND2XL U340 ( .A(r2_A[5]), .B(n355), .Y(n457) );
  OAI211XL U341 ( .A0(dst[3]), .A1(n306), .B0(n429), .C0(n315), .Y(n428) );
  OAI211XL U342 ( .A0(r2_A[2]), .A1(n426), .B0(n462), .C0(n463), .Y(n456) );
  OAI211XL U343 ( .A0(dst[3]), .A1(n307), .B0(n429), .C0(n316), .Y(n463) );
  XOR3X1 U344 ( .A(\add_0_root_add_2_root_add_196_2/A[7] ), .B(
        \add_0_root_add_2_root_add_196_2/B[7] ), .C(
        \add_0_root_add_2_root_add_196_2/carry [7]), .Y(N307) );
  AND2XL U345 ( .A(\add_3_root_add_2_root_add_196_2/carry [6]), .B(n596), .Y(
        \add_3_root_add_2_root_add_196_2/carry [7]) );
  AND2XL U346 ( .A(\add_3_root_add_2_root_add_196_2/carry [2]), .B(n600), .Y(
        \add_3_root_add_2_root_add_196_2/carry [3]) );
  NOR2XL U347 ( .A(r2_C[1]), .B(n432), .Y(n431) );
  NOR2XL U348 ( .A(r2_A[1]), .B(n432), .Y(n465) );
  NAND3XL U349 ( .A(mcnt[2]), .B(n455), .C(mcnt[1]), .Y(n381) );
  MX2XL U350 ( .A(\x[0][0] ), .B(central[20]), .S0(en), .Y(n250) );
  MX2XL U351 ( .A(\x[0][1] ), .B(central[21]), .S0(en), .Y(n251) );
  MX2XL U352 ( .A(\y[2][0] ), .B(central[0]), .S0(en), .Y(n254) );
  MX2XL U353 ( .A(\y[2][1] ), .B(central[1]), .S0(en), .Y(n255) );
  AND2XL U354 ( .A(xcnt[0]), .B(N360), .Y(N361) );
  AOI2BB1XL U355 ( .A0N(ycnt[0]), .A1N(n392), .B0(n398), .Y(n395) );
  AND2XL U356 ( .A(xcnt[1]), .B(N360), .Y(N362) );
  OAI211XL U357 ( .A0(mcnt[3]), .A1(n381), .B0(n405), .C0(n406), .Y(n400) );
  NAND2XL U358 ( .A(ycnt[0]), .B(n397), .Y(n394) );
  OAI211XL U359 ( .A0(n575), .A1(n441), .B0(n576), .C0(n392), .Y(N78) );
  MXI2XL U360 ( .A(n397), .B(n398), .S0(ycnt[0]), .Y(n396) );
  NOR3XL U361 ( .A(n572), .B(n566), .C(n363), .Y(fin) );
  NAND2X2 U362 ( .A(n317), .B(n571), .Y(n388) );
  AND2X2 U363 ( .A(mul[7]), .B(n370), .Y(n358) );
  AND2XL U364 ( .A(dst[7]), .B(n371), .Y(n359) );
  AND2XL U365 ( .A(dst_tmp[7]), .B(n372), .Y(n360) );
  AND4X2 U366 ( .A(n379), .B(n380), .C(n381), .D(n382), .Y(n371) );
  NAND3X2 U367 ( .A(n363), .B(n364), .C(n388), .Y(n370) );
  CLKINVX1 U368 ( .A(\add_0_root_add_2_root_add_196_2/A[1] ), .Y(n369) );
  CLKBUFX3 U369 ( .A(n593), .Y(n365) );
  CLKBUFX3 U370 ( .A(n593), .Y(n366) );
  CLKBUFX3 U371 ( .A(n386), .Y(n363) );
  NAND2X1 U372 ( .A(n570), .B(n569), .Y(n386) );
  ADDFXL U373 ( .A(\add_0_root_add_2_root_add_196_2/A[1] ), .B(
        \add_0_root_add_2_root_add_196_2/B[1] ), .CI(
        \add_0_root_add_2_root_add_196_2/carry [1]), .CO(
        \add_0_root_add_2_root_add_196_2/carry [2]), .S(N301) );
  INVX3 U374 ( .A(n368), .Y(n367) );
  NAND4BX2 U375 ( .AN(n562), .B(n563), .C(n564), .D(n565), .Y(mul[0]) );
  AOI222XL U376 ( .A0(n361), .A1(\r[1][0] ), .B0(n567), .B1(n313), .C0(n568), 
        .C1(n566), .Y(n563) );
  CLKBUFX3 U377 ( .A(n387), .Y(n364) );
  NAND3X1 U378 ( .A(mcnt[0]), .B(n569), .C(mcnt[1]), .Y(n387) );
  AND3X2 U379 ( .A(n571), .B(mcnt[0]), .C(n380), .Y(n295) );
  ADDFXL U380 ( .A(iscand), .B(iscand_AB), .CI(iscand_AC), .CO(
        \add_3_root_add_2_root_add_196_2/B[1] ), .S(
        \add_3_root_add_2_root_add_196_2/B[0] ) );
  ADDFXL U381 ( .A(n601), .B(\add_3_root_add_2_root_add_196_2/B[1] ), .CI(
        \add_3_root_add_2_root_add_196_2/carry [1]), .CO(
        \add_3_root_add_2_root_add_196_2/carry [2]), .S(
        \add_0_root_add_2_root_add_196_2/B[1] ) );
  ADDFXL U382 ( .A(\add_0_root_add_2_root_add_196_2/A[7] ), .B(
        \add_0_root_add_2_root_add_196_2/B[5] ), .CI(
        \add_0_root_add_2_root_add_196_2/carry [5]), .CO(
        \add_0_root_add_2_root_add_196_2/carry [6]), .S(N305) );
  CLKBUFX3 U383 ( .A(n293), .Y(n361) );
  NOR3BXL U384 ( .AN(n571), .B(mcnt[0]), .C(mcnt[3]), .Y(n293) );
  INVX3 U385 ( .A(dst[6]), .Y(n425) );
  CLKBUFX3 U386 ( .A(n294), .Y(n362) );
  INVX3 U387 ( .A(en), .Y(n368) );
  NAND3X2 U388 ( .A(n570), .B(n441), .C(mcnt[3]), .Y(n385) );
  ADDFX2 U389 ( .A(\mult_101/n8 ), .B(inmul[3]), .CI(\mult_101/n2 ), .CO(
        \mult_101/n1 ), .S(mul[6]) );
  ADDFX2 U390 ( .A(inmul[2]), .B(\mult_101/n9 ), .CI(\mult_101/n3 ), .CO(
        \mult_101/n2 ), .S(mul[5]) );
  AND2X1 U391 ( .A(\add_0_root_add_2_root_add_196_2/A[0] ), .B(
        \add_0_root_add_2_root_add_196_2/B[0] ), .Y(
        \add_0_root_add_2_root_add_196_2/carry [1]) );
  CLKINVX1 U392 ( .A(n369), .Y(\add_0_root_add_2_root_add_196_2/A[7] ) );
  NAND2BX1 U393 ( .AN(inmul[1]), .B(inmul[2]), .Y(\mult_101/n7 ) );
  NAND2X1 U394 ( .A(inmul[2]), .B(inmul[3]), .Y(\mult_101/n8 ) );
  NAND2X1 U395 ( .A(inmul[3]), .B(inmul[1]), .Y(\mult_101/n9 ) );
  AND2X1 U396 ( .A(xcnt[2]), .B(N360), .Y(N363) );
  AND2X1 U397 ( .A(N360), .B(xcnt[3]), .Y(N364) );
  CLKINVX1 U398 ( .A(n373), .Y(n586) );
  AOI222XL U399 ( .A0(mul[6]), .A1(n370), .B0(dst[6]), .B1(n371), .C0(
        dst_tmp[6]), .C1(n372), .Y(n373) );
  CLKINVX1 U400 ( .A(n374), .Y(n587) );
  AOI222XL U401 ( .A0(mul[5]), .A1(n370), .B0(n354), .B1(n371), .C0(dst_tmp[5]), .C1(n372), .Y(n374) );
  CLKINVX1 U402 ( .A(n375), .Y(n588) );
  AOI222XL U403 ( .A0(mul[4]), .A1(n370), .B0(dst[4]), .B1(n371), .C0(
        dst_tmp[4]), .C1(n372), .Y(n375) );
  CLKINVX1 U404 ( .A(n376), .Y(n589) );
  AOI222XL U405 ( .A0(mul[3]), .A1(n370), .B0(dst[3]), .B1(n371), .C0(
        dst_tmp[3]), .C1(n372), .Y(n376) );
  CLKINVX1 U406 ( .A(n377), .Y(n590) );
  AOI222XL U407 ( .A0(n356), .A1(n370), .B0(dst[2]), .B1(n371), .C0(dst_tmp[2]), .C1(n372), .Y(n377) );
  AO22X1 U408 ( .A0(n371), .A1(dst[1]), .B0(dst_tmp[1]), .B1(n372), .Y(n591)
         );
  CLKINVX1 U409 ( .A(n378), .Y(n592) );
  AOI222XL U410 ( .A0(mul[0]), .A1(n370), .B0(dst[0]), .B1(n371), .C0(
        dst_tmp[0]), .C1(n372), .Y(n378) );
  CLKINVX1 U411 ( .A(rst), .Y(n593) );
  CLKINVX1 U412 ( .A(N361), .Y(n594) );
  MXI2X1 U413 ( .A(n389), .B(n390), .S0(n579), .Y(n302) );
  NAND3X1 U414 ( .A(ycnt[1]), .B(n391), .C(ycnt[2]), .Y(n390) );
  OA21XL U415 ( .A0(ycnt[2]), .A1(n392), .B0(n393), .Y(n389) );
  OAI21XL U416 ( .A0(valid), .A1(n282), .B0(n368), .Y(n301) );
  MXI2X1 U417 ( .A(n394), .B(n395), .S0(ycnt[1]), .Y(n300) );
  NAND2X1 U418 ( .A(n396), .B(busy), .Y(n299) );
  OAI22XL U419 ( .A0(n282), .A1(n399), .B0(n400), .B1(n401), .Y(n298) );
  OAI22XL U420 ( .A0(n282), .A1(n402), .B0(n403), .B1(n404), .Y(n297) );
  OA21XL U421 ( .A0(n282), .A1(n405), .B0(n400), .Y(n403) );
  NAND2X1 U422 ( .A(busy), .B(n392), .Y(n281) );
  MXI2X1 U423 ( .A(n407), .B(n393), .S0(ycnt[2]), .Y(n280) );
  OA21XL U424 ( .A0(ycnt[1]), .A1(n392), .B0(n395), .Y(n393) );
  NOR2X1 U425 ( .A(n282), .B(n397), .Y(n398) );
  NAND2X1 U426 ( .A(ycnt[1]), .B(n391), .Y(n407) );
  CLKINVX1 U427 ( .A(n394), .Y(n391) );
  NOR2BX1 U428 ( .AN(xcnt[3]), .B(n392), .Y(n397) );
  CLKMX2X2 U429 ( .A(\r[0][3] ), .B(radius[11]), .S0(n367), .Y(n277) );
  CLKMX2X2 U430 ( .A(\r[0][2] ), .B(radius[10]), .S0(n367), .Y(n276) );
  CLKMX2X2 U431 ( .A(\r[0][1] ), .B(radius[9]), .S0(n367), .Y(n275) );
  CLKMX2X2 U432 ( .A(\r[0][0] ), .B(radius[8]), .S0(n367), .Y(n274) );
  CLKMX2X2 U433 ( .A(\r[1][3] ), .B(radius[7]), .S0(n367), .Y(n273) );
  CLKMX2X2 U434 ( .A(\r[1][2] ), .B(radius[6]), .S0(n367), .Y(n272) );
  CLKMX2X2 U435 ( .A(\r[1][1] ), .B(radius[5]), .S0(n367), .Y(n271) );
  CLKMX2X2 U436 ( .A(\r[1][0] ), .B(radius[4]), .S0(n367), .Y(n270) );
  CLKMX2X2 U437 ( .A(\r[2][3] ), .B(radius[3]), .S0(n367), .Y(n269) );
  CLKMX2X2 U438 ( .A(\r[2][2] ), .B(radius[2]), .S0(n367), .Y(n268) );
  CLKMX2X2 U439 ( .A(\r[2][1] ), .B(radius[1]), .S0(n367), .Y(n267) );
  CLKMX2X2 U440 ( .A(\r[2][0] ), .B(radius[0]), .S0(n367), .Y(n266) );
  CLKMX2X2 U441 ( .A(\y[0][3] ), .B(central[19]), .S0(n367), .Y(n265) );
  CLKMX2X2 U442 ( .A(\y[0][2] ), .B(central[18]), .S0(en), .Y(n264) );
  MXI2X1 U443 ( .A(n408), .B(n582), .S0(n368), .Y(n263) );
  CLKINVX1 U444 ( .A(central[17]), .Y(n408) );
  CLKMX2X2 U445 ( .A(\y[0][0] ), .B(central[16]), .S0(en), .Y(n262) );
  CLKMX2X2 U446 ( .A(\y[1][3] ), .B(central[11]), .S0(en), .Y(n261) );
  CLKMX2X2 U447 ( .A(\y[1][2] ), .B(central[10]), .S0(en), .Y(n260) );
  MXI2X1 U448 ( .A(n409), .B(n584), .S0(n368), .Y(n259) );
  CLKINVX1 U449 ( .A(central[9]), .Y(n409) );
  CLKMX2X2 U450 ( .A(\y[1][0] ), .B(central[8]), .S0(en), .Y(n258) );
  CLKMX2X2 U451 ( .A(\y[2][3] ), .B(central[3]), .S0(en), .Y(n257) );
  CLKMX2X2 U452 ( .A(\y[2][2] ), .B(central[2]), .S0(en), .Y(n256) );
  CLKMX2X2 U453 ( .A(\x[0][3] ), .B(central[23]), .S0(en), .Y(n253) );
  CLKMX2X2 U454 ( .A(\x[0][2] ), .B(central[22]), .S0(en), .Y(n252) );
  CLKMX2X2 U455 ( .A(\x[1][3] ), .B(central[15]), .S0(n367), .Y(n249) );
  CLKMX2X2 U456 ( .A(\x[1][2] ), .B(central[14]), .S0(n367), .Y(n248) );
  MXI2X1 U457 ( .A(n410), .B(n583), .S0(n368), .Y(n247) );
  CLKINVX1 U458 ( .A(central[13]), .Y(n410) );
  CLKMX2X2 U459 ( .A(\x[1][0] ), .B(central[12]), .S0(en), .Y(n246) );
  CLKMX2X2 U460 ( .A(\x[2][3] ), .B(central[7]), .S0(n367), .Y(n245) );
  CLKMX2X2 U461 ( .A(\x[2][2] ), .B(central[6]), .S0(n367), .Y(n244) );
  MXI2X1 U462 ( .A(n411), .B(n585), .S0(n368), .Y(n243) );
  CLKINVX1 U463 ( .A(central[5]), .Y(n411) );
  CLKMX2X2 U464 ( .A(\x[2][0] ), .B(central[4]), .S0(en), .Y(n242) );
  NOR4X1 U465 ( .A(pre_iscand[0]), .B(n401), .C(n412), .D(n413), .Y(
        \add_0_root_add_2_root_add_196_2/A[0] ) );
  NOR4X1 U466 ( .A(pre_iscand[1]), .B(n404), .C(n412), .D(n413), .Y(iscand_AC)
         );
  NOR4BX1 U467 ( .AN(n412), .B(n401), .C(n404), .D(n413), .Y(iscand_AB) );
  NAND3X1 U468 ( .A(n581), .B(n415), .C(n580), .Y(n413) );
  CLKINVX1 U469 ( .A(pre_iscand[1]), .Y(n401) );
  NOR2BX1 U470 ( .AN(r2_C[7]), .B(dst[7]), .Y(n417) );
  OAI21XL U471 ( .A0(n424), .A1(n425), .B0(r2_C[6]), .Y(n423) );
  AOI32X1 U472 ( .A0(dst[4]), .A1(n324), .A2(n420), .B0(n309), .B1(n354), .Y(
        n424) );
  AOI2BB2X1 U473 ( .B0(n425), .B1(r2_C[6]), .A0N(n324), .A1N(dst[4]), .Y(n421)
         );
  OAI211X1 U474 ( .A0(r2_C[2]), .A1(n426), .B0(n427), .C0(n428), .Y(n419) );
  OAI222XL U475 ( .A0(dst[3]), .A1(n315), .B0(dst[2]), .B1(n306), .C0(n430), 
        .C1(n431), .Y(n427) );
  NAND2X1 U476 ( .A(n434), .B(n414), .Y(iscand) );
  NAND3BX1 U477 ( .AN(n399), .B(n581), .C(n331), .Y(n414) );
  CLKINVX1 U478 ( .A(n405), .Y(n439) );
  NOR2BX1 U479 ( .AN(r2_B[7]), .B(dst[7]), .Y(n438) );
  NAND2X1 U480 ( .A(n447), .B(n425), .Y(n445) );
  AOI32X1 U481 ( .A0(dst[4]), .A1(n308), .A2(n443), .B0(n318), .B1(n354), .Y(
        n447) );
  AOI2BB2X1 U482 ( .B0(n425), .B1(r2_B[6]), .A0N(n308), .A1N(dst[4]), .Y(n444)
         );
  NAND2X1 U483 ( .A(r2_B[5]), .B(n355), .Y(n443) );
  OAI211X1 U484 ( .A0(r2_B[2]), .A1(n426), .B0(n448), .C0(n449), .Y(n442) );
  OAI211X1 U485 ( .A0(dst[3]), .A1(n305), .B0(n429), .C0(n314), .Y(n449) );
  OAI222XL U486 ( .A0(dst[3]), .A1(n314), .B0(dst[2]), .B1(n305), .C0(n450), 
        .C1(n451), .Y(n448) );
  NOR2X1 U487 ( .A(r2_B[1]), .B(n432), .Y(n451) );
  AOI211X1 U488 ( .A0(r2_B[1]), .A1(n432), .B0(n433), .C0(r2_B[0]), .Y(n450)
         );
  CLKINVX1 U489 ( .A(pre_iscand[0]), .Y(n404) );
  CLKINVX1 U490 ( .A(n402), .Y(n435) );
  OAI211X1 U491 ( .A0(n452), .A1(n453), .B0(n380), .C0(n454), .Y(n402) );
  AOI2BB1X1 U492 ( .A0N(n418), .A1N(r2_A[7]), .B0(n381), .Y(n454) );
  AND2X1 U493 ( .A(r2_A[7]), .B(n418), .Y(n453) );
  CLKINVX1 U494 ( .A(dst[7]), .Y(n418) );
  AOI32X1 U495 ( .A0(n456), .A1(n457), .A2(n458), .B0(n459), .B1(n460), .Y(
        n452) );
  OAI21XL U496 ( .A0(n461), .A1(n425), .B0(r2_A[6]), .Y(n460) );
  NAND2X1 U497 ( .A(n461), .B(n425), .Y(n459) );
  AOI32X1 U498 ( .A0(dst[4]), .A1(n310), .A2(n457), .B0(n325), .B1(n354), .Y(
        n461) );
  AOI2BB2X1 U499 ( .B0(n425), .B1(r2_A[6]), .A0N(n310), .A1N(dst[4]), .Y(n458)
         );
  OR2X1 U500 ( .A(dst[2]), .B(dst[3]), .Y(n429) );
  OAI222XL U501 ( .A0(dst[3]), .A1(n316), .B0(dst[2]), .B1(n307), .C0(n464), 
        .C1(n465), .Y(n462) );
  NAND2X1 U502 ( .A(dst[2]), .B(dst[3]), .Y(n426) );
  NAND3X1 U503 ( .A(n466), .B(n467), .C(n468), .Y(inmul[3]) );
  AOI222XL U504 ( .A0(n295), .A1(\r[2][3] ), .B0(n361), .B1(\r[1][3] ), .C0(
        n362), .C1(\r[0][3] ), .Y(n468) );
  MXI2X1 U505 ( .A(n469), .B(n470), .S0(xcnt[3]), .Y(n467) );
  XOR2X1 U506 ( .A(\x[1][3] ), .B(n474), .Y(n473) );
  XOR2X1 U507 ( .A(\x[2][3] ), .B(n475), .Y(n472) );
  XOR2X1 U508 ( .A(\x[0][3] ), .B(n476), .Y(n471) );
  XNOR2X1 U509 ( .A(\x[1][3] ), .B(n474), .Y(n479) );
  AOI2BB2X1 U510 ( .B0(n480), .B1(\x[1][2] ), .A0N(xcnt[2]), .A1N(n481), .Y(
        n474) );
  NOR2X1 U511 ( .A(\x[1][2] ), .B(n480), .Y(n481) );
  XNOR2X1 U512 ( .A(\x[2][3] ), .B(n475), .Y(n478) );
  AOI2BB2X1 U513 ( .B0(n482), .B1(\x[2][2] ), .A0N(xcnt[2]), .A1N(n483), .Y(
        n475) );
  NOR2X1 U514 ( .A(\x[2][2] ), .B(n482), .Y(n483) );
  XNOR2X1 U515 ( .A(\x[0][3] ), .B(n476), .Y(n477) );
  OA21XL U516 ( .A0(n484), .A1(n328), .B0(n485), .Y(n476) );
  AO21X1 U517 ( .A0(n328), .A1(n484), .B0(xcnt[2]), .Y(n485) );
  MXI2X1 U518 ( .A(n486), .B(n487), .S0(n579), .Y(n466) );
  OAI222XL U519 ( .A0(n488), .A1(n383), .B0(n489), .B1(n385), .C0(n490), .C1(
        n384), .Y(n487) );
  XNOR2X1 U520 ( .A(\y[0][3] ), .B(n491), .Y(n490) );
  XNOR2X1 U521 ( .A(\y[1][3] ), .B(n492), .Y(n489) );
  XNOR2X1 U522 ( .A(\y[2][3] ), .B(n493), .Y(n488) );
  XOR2X1 U523 ( .A(\y[0][3] ), .B(n491), .Y(n496) );
  AOI2BB2X1 U524 ( .B0(n497), .B1(\y[0][2] ), .A0N(ycnt[2]), .A1N(n498), .Y(
        n491) );
  NOR2X1 U525 ( .A(\y[0][2] ), .B(n497), .Y(n498) );
  XOR2X1 U526 ( .A(\y[1][3] ), .B(n492), .Y(n495) );
  AOI2BB2X1 U527 ( .B0(n499), .B1(\y[1][2] ), .A0N(ycnt[2]), .A1N(n500), .Y(
        n492) );
  NOR2X1 U528 ( .A(\y[1][2] ), .B(n499), .Y(n500) );
  XOR2X1 U529 ( .A(\y[2][3] ), .B(n493), .Y(n494) );
  CLKINVX1 U530 ( .A(ycnt[2]), .Y(n504) );
  AOI222XL U531 ( .A0(n295), .A1(\r[2][2] ), .B0(n361), .B1(\r[1][2] ), .C0(
        n362), .C1(\r[0][2] ), .Y(n507) );
  MXI2X1 U532 ( .A(n508), .B(n509), .S0(xcnt[2]), .Y(n506) );
  XNOR2X1 U533 ( .A(\x[1][2] ), .B(n480), .Y(n512) );
  XNOR2X1 U534 ( .A(\x[2][2] ), .B(n482), .Y(n511) );
  XOR2X1 U535 ( .A(n480), .B(\x[1][2] ), .Y(n515) );
  ACHCONX2 U536 ( .A(n583), .B(n516), .CI(xcnt[1]), .CON(n480) );
  XOR2X1 U537 ( .A(n482), .B(\x[2][2] ), .Y(n514) );
  ACHCONX2 U538 ( .A(n585), .B(n517), .CI(xcnt[1]), .CON(n482) );
  MXI2X1 U539 ( .A(n519), .B(n520), .S0(ycnt[2]), .Y(n505) );
  XOR2X1 U540 ( .A(\y[2][2] ), .B(n501), .Y(n521) );
  OAI222XL U541 ( .A0(n524), .A1(n383), .B0(n525), .B1(n385), .C0(n526), .C1(
        n384), .Y(n519) );
  ACHCONX2 U542 ( .A(n582), .B(n527), .CI(ycnt[1]), .CON(n497) );
  ACHCONX2 U543 ( .A(n584), .B(n528), .CI(ycnt[1]), .CON(n499) );
  XOR2X1 U544 ( .A(n329), .B(n501), .Y(n524) );
  OAI21XL U545 ( .A0(n529), .A1(n323), .B0(n530), .Y(n503) );
  AO21X1 U546 ( .A0(n323), .A1(n529), .B0(ycnt[1]), .Y(n530) );
  AOI222XL U547 ( .A0(n295), .A1(\r[2][1] ), .B0(n361), .B1(\r[1][1] ), .C0(
        n362), .C1(\r[0][1] ), .Y(n533) );
  MXI2X1 U548 ( .A(n534), .B(n535), .S0(xcnt[1]), .Y(n532) );
  NAND3X1 U549 ( .A(n536), .B(n537), .C(n538), .Y(n535) );
  MXI2X1 U550 ( .A(n539), .B(n540), .S0(n585), .Y(n538) );
  MXI2X1 U551 ( .A(n541), .B(n542), .S0(n583), .Y(n537) );
  MXI2X1 U552 ( .A(n543), .B(n544), .S0(\x[0][1] ), .Y(n536) );
  NAND3X1 U553 ( .A(n545), .B(n546), .C(n547), .Y(n534) );
  MXI2X1 U554 ( .A(n540), .B(n539), .S0(n585), .Y(n547) );
  MXI2X1 U555 ( .A(n542), .B(n541), .S0(n583), .Y(n546) );
  NOR2X1 U556 ( .A(n516), .B(n364), .Y(n542) );
  MXI2X1 U557 ( .A(n544), .B(n543), .S0(\x[0][1] ), .Y(n545) );
  NOR2X1 U558 ( .A(n518), .B(n363), .Y(n543) );
  MXI2X1 U559 ( .A(n548), .B(n549), .S0(ycnt[1]), .Y(n531) );
  NAND3X1 U560 ( .A(n550), .B(n551), .C(n552), .Y(n549) );
  MXI2X1 U561 ( .A(n553), .B(n554), .S0(\y[2][1] ), .Y(n552) );
  MXI2X1 U562 ( .A(n555), .B(n556), .S0(n582), .Y(n551) );
  MXI2X1 U563 ( .A(n557), .B(n558), .S0(n584), .Y(n550) );
  NAND3X1 U564 ( .A(n559), .B(n560), .C(n561), .Y(n548) );
  MXI2X1 U565 ( .A(n554), .B(n553), .S0(\y[2][1] ), .Y(n561) );
  NOR2X1 U566 ( .A(n529), .B(n383), .Y(n553) );
  MXI2X1 U567 ( .A(n556), .B(n555), .S0(n582), .Y(n560) );
  NOR2X1 U568 ( .A(n527), .B(n384), .Y(n556) );
  MXI2X1 U569 ( .A(n558), .B(n557), .S0(n584), .Y(n559) );
  NOR3X1 U570 ( .A(n555), .B(n541), .C(n544), .Y(n565) );
  NOR2X1 U571 ( .A(n313), .B(\x[1][0] ), .Y(n516) );
  NOR2BX1 U572 ( .AN(n527), .B(n384), .Y(n555) );
  NOR2X1 U573 ( .A(n566), .B(\y[0][0] ), .Y(n527) );
  NOR3X1 U574 ( .A(n539), .B(n554), .C(n557), .Y(n564) );
  NOR2BX1 U575 ( .AN(n528), .B(n385), .Y(n557) );
  NOR2X1 U576 ( .A(n566), .B(\y[1][0] ), .Y(n528) );
  NOR2X1 U577 ( .A(n313), .B(\x[2][0] ), .Y(n517) );
  OAI222XL U578 ( .A0(n304), .A1(n383), .B0(n332), .B1(n385), .C0(n312), .C1(
        n384), .Y(n568) );
  AO22X1 U579 ( .A0(\r[2][0] ), .A1(n295), .B0(\r[0][0] ), .B1(n362), .Y(n562)
         );
  OR3X1 U580 ( .A(ycnt[1]), .B(ycnt[2]), .C(n579), .Y(n572) );
  OAI22XL U581 ( .A0(n573), .A1(n364), .B0(n574), .B1(n380), .Y(N79) );
  OA21XL U582 ( .A0(mcnt[2]), .A1(n573), .B0(n575), .Y(n574) );
  NAND3X1 U583 ( .A(n571), .B(mcnt[0]), .C(n406), .Y(n576) );
  AOI21X1 U584 ( .A0(n440), .A1(n406), .B0(N76), .Y(n575) );
  NOR2X1 U585 ( .A(n573), .B(mcnt[0]), .Y(N76) );
  CLKINVX1 U586 ( .A(n406), .Y(n573) );
  NOR2X1 U587 ( .A(n415), .B(n282), .Y(n406) );
  XOR2X1 U588 ( .A(N364), .B(n577), .Y(N63) );
  NOR2BX1 U589 ( .AN(N363), .B(n578), .Y(n577) );
  XNOR2X1 U590 ( .A(N363), .B(n578), .Y(N62) );
  NAND2X1 U591 ( .A(N362), .B(N361), .Y(n578) );
  XOR2X1 U592 ( .A(N362), .B(N361), .Y(N61) );
  NOR2X1 U593 ( .A(xcnt[3]), .B(n392), .Y(N360) );
  NAND2X1 U594 ( .A(n415), .B(busy), .Y(n392) );
  NOR3X1 U595 ( .A(n379), .B(n441), .C(n380), .Y(n415) );
  NAND2X1 U596 ( .A(n455), .B(n440), .Y(n379) );
endmodule

