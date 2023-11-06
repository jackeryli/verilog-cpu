module Mux_2x1(
    input [31:0] In1,
    input [31:0] In2,
    input Sel,
    output [31:0] Out
);

    assign Out = (Sel == 1'b1) ? In1 : In2;

endmodule