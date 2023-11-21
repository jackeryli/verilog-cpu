module Mux_2x1(
    In1,
    In2,
    Sel,
    Out
);

parameter N = 32;

input [N-1:0] In1;
input [N-1:0] In2;
input Sel;
output [N-1:0] Out;

assign Out = (Sel == 1'b1) ? In1 : In2;

endmodule