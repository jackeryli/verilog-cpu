module bitwise_or (In1, In2, Out);
    input [31:0] In1, In2;
    output wire [31:0] Out;
    assign Out = In1 | In2;
endmodule
