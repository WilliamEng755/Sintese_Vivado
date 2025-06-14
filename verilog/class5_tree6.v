module class5_tree6(input wire [50:0] i, output wire [0:0] o);

wire [0:0] new_1;
wire [0:0] new_3;
wire [0:0] new_4;
wire [0:0] new_5;
wire [0:0] new_8;
wire [0:0] new_9;
wire [0:0] new_10;
wire [0:0] new_11;
wire [0:0] new_13;
wire [0:0] new_14;
wire [0:0] new_15;
wire [0:0] new_17;
wire [0:0] new_18;
wire [0:0] new_19;
wire [0:0] new_21;
wire [0:0] new_24;
wire [0:0] new_25;
wire [0:0] new_28;
assign new_28 = i[3] ? 0 : 0;
assign new_25 = i[5] ? 0 : 0;
assign new_24 = i[4] ? 0 : 0;
assign new_21 = i[40] ? 0 : 0;
assign new_19 = i[30] ? 0 : 0;
assign new_18 = i[5] ? 0 : new_28;
assign new_17 = i[48] ? new_25 : 0;
assign new_15 = i[8] ? 0 : new_24;
assign new_14 = i[21] ? new_21 : 0;
assign new_13 = i[46] ? new_19 : 0;
assign new_11 = i[4] ? new_17 : new_18;
assign new_10 = i[0] ? new_15 : 0;
assign new_9 = i[1] ? new_13 : new_14;
assign new_8 = i[1] ? new_11 : 0;
assign new_5 = i[38] ? new_9 : new_10;
assign new_4 = i[0] ? 0 : new_8;
assign new_3 = i[48] ? new_5 : 0;
assign new_1 = i[39] ? new_3 : new_4;
assign o = i[10] ? new_1 : 0;


endmodule
