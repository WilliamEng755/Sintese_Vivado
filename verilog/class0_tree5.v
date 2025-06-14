module class0_tree5(input wire [50:0] i, output wire [0:0] o);

wire [0:0] new_1;
wire [0:0] new_3;
wire [0:0] new_4;
wire [0:0] new_5;
wire [0:0] new_8;
wire [0:0] new_9;
wire [0:0] new_10;
wire [0:0] new_13;
wire [0:0] new_14;
wire [0:0] new_15;
wire [0:0] new_16;
wire [0:0] new_17;
wire [0:0] new_18;
wire [0:0] new_19;
wire [0:0] new_20;
wire [0:0] new_21;
wire [0:0] new_22;
wire [0:0] new_23;
wire [0:0] new_24;
assign new_24 = i[5] ? 0 : 0;
assign new_23 = i[1] ? 0 : 0;
assign new_22 = i[1] ? 0 : 0;
assign new_21 = i[4] ? 0 : 0;
assign new_20 = i[1] ? 0 : 0;
assign new_19 = i[4] ? 0 : 0;
assign new_18 = i[0] ? 0 : 0;
assign new_17 = i[14] ? 0 : 0;
assign new_16 = i[8] ? new_23 : new_24;
assign new_15 = i[8] ? new_21 : new_22;
assign new_14 = i[8] ? new_19 : new_20;
assign new_13 = i[20] ? new_17 : new_18;
assign new_10 = i[0] ? new_15 : new_16;
assign new_9 = i[34] ? new_13 : new_14;
assign new_8 = i[1] ? 0 : 0;
assign new_5 = i[19] ? new_9 : new_10;
assign new_4 = i[10] ? 0 : new_8;
assign new_3 = i[13] ? new_5 : 0;
assign new_1 = i[25] ? new_3 : new_4;
assign o = i[50] ? new_1 : 0;


endmodule
