module class2_tree6(input wire [50:0] i, output wire [0:0] o);

wire [0:0] new_1;
wire [0:0] new_3;
wire [0:0] new_5;
wire [0:0] new_6;
wire [0:0] new_7;
wire [0:0] new_9;
wire [0:0] new_10;
wire [0:0] new_11;
wire [0:0] new_13;
wire [0:0] new_16;
wire [0:0] new_17;
wire [0:0] new_18;
wire [0:0] new_20;
wire [0:0] new_21;
wire [0:0] new_22;
assign new_22 = i[3] ? 0 : 0;
assign new_21 = i[4] ? 0 : 0;
assign new_20 = i[4] ? 0 : 0;
assign new_18 = i[49] ? 0 : 0;
assign new_17 = i[30] ? 0 : 0;
assign new_16 = i[5] ? new_21 : new_22;
assign new_13 = i[0] ? 0 : new_20;
assign new_11 = i[24] ? new_17 : new_18;
assign new_10 = i[9] ? 0 : new_16;
assign new_9 = i[48] ? new_13 : 0;
assign new_7 = i[38] ? new_11 : 0;
assign new_6 = i[8] ? new_9 : new_10;
assign new_5 = i[48] ? new_7 : 0;
assign new_3 = i[39] ? new_5 : new_6;
assign new_1 = i[40] ? new_3 : 0;
assign o = i[10] ? new_1 : 0;


endmodule
