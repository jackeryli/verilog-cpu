module adder (In1, In2, Out, Carry, Overflow);
    input signed [31:0] In1, In2;
    output wire [31:0] Out;
    output Carry;
    output Overflow;

    wire signed [31:0] sum;

    assign Out = In1 + In2;
    assign {Carry, sum} = In1 + In2;
    assign Overflow = (In1[31] ~^ In2[31]) & (sum[31] ^ In1[31]);
endmodule
