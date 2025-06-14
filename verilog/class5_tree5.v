module class5_tree5(input wire [50:0] i, output wire [0:0] o);

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
wire [0:0] new_19;
wire [0:0] new_20;
wire [0:0] new_22;
wire [0:0] new_24;
wire [0:0] new_25;
wire [0:0] new_26;
assign new_26 = i[3] ? 0 : 0;
assign new_25 = i[9] ? 0 : 0;
assign new_24 = i[1] ? 0 : 0;
assign new_22 = i[8] ? 0 : 0;
assign new_20 = i[1] ? 0 : 0;
assign new_19 = i[31] ? 0 : 0;
assign new_17 = i[8] ? new_25 : new_26;
assign new_15 = i[8] ? 0 : new_24;
assign new_14 = i[0] ? 0 : new_22;
assign new_13 = i[27] ? new_19 : new_20;
assign new_11 = i[4] ? new_17 : 0;
assign new_10 = i[0] ? new_15 : 0;
assign new_9 = i[30] ? new_13 : new_14;
assign new_8 = i[1] ? new_11 : 0;
assign new_5 = i[38] ? new_9 : new_10;
assign new_4 = i[0] ? 0 : new_8;
assign new_3 = i[48] ? new_5 : 0;
assign new_1 = i[39] ? new_3 : new_4;
assign o = i[10] ? new_1 : 0;


endmodule
