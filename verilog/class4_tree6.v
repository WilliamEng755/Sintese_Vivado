module class4_tree6(input wire [50:0] i, output wire [0:0] o);

wire [0:0] new_1;
wire [0:0] new_3;
wire [0:0] new_5;
wire [0:0] new_7;
wire [0:0] new_9;
wire [0:0] new_11;
wire [0:0] new_12;
assign new_12 = i[8] ? 0 : 0;
assign new_11 = i[21] ? 0 : 0;
assign new_9 = i[19] ? new_11 : new_12;
assign new_7 = i[45] ? new_9 : 0;
assign new_5 = i[46] ? new_7 : 0;
assign new_3 = i[29] ? new_5 : 0;
assign new_1 = i[48] ? new_3 : 0;
assign o = i[50] ? new_1 : 0;


endmodule
