module Mux42(
input [1:0] s,
input signed [15:0] a,
input signed [15:0] b,
input signed [15:0] c,
input signed [15:0] d,
output signed [15:0] r
);

wire [15:0] TA;
wire [15:0] TB;

Mux X (
	.in_0(a),
.in_1(b),
.sel(s[0]),
.out_result(TA)
);

Mux Y (
	.in_0(c),
.in_1(d),
.sel(s[0]),
.out_result(TB)
);

Mux Z (
	.in_0(TA),
.in_1(TB),
.sel(s[1]),
.out_result(r)
);


endmodule