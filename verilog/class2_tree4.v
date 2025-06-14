module class2_tree4(input wire [50:0] i, output wire [0:0] o);

wire [0:0] new_1;
wire [0:0] new_3;
wire [0:0] new_5;
wire [0:0] new_6;
wire [0:0] new_7;
wire [0:0] new_9;
wire [0:0] new_10;
wire [0:0] new_11;
wire [0:0] new_14;
wire [0:0] new_16;
wire [0:0] new_17;
wire [0:0] new_19;
wire [0:0] new_22;
assign new_22 = i[3] ? 0 : 0;
assign new_19 = i[48] ? 0 : 0;
assign new_17 = i[48] ? 0 : 0;
assign new_16 = i[5] ? 0 : new_22;
assign new_14 = i[4] ? new_19 : 0;
assign new_11 = i[31] ? new_17 : 0;
assign new_10 = i[9] ? 0 : new_16;
assign new_9 = i[0] ? 0 : new_14;
assign new_7 = i[30] ? new_11 : 0;
assign new_6 = i[8] ? new_9 : new_10;
assign new_5 = i[38] ? new_7 : 0;
assign new_3 = i[39] ? new_5 : new_6;
assign new_1 = i[40] ? new_3 : 0;
assign o = i[10] ? new_1 : 0;


endmodule
