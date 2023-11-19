module adder (In1, In2, Out, Carry, Overflow);
    input signed [31:0] In1, In2;
    output wire [31:0] Out;
    output Carry;
    output Overflow;

    wire signed [32:0] sum;

    assign Out = In1 + In2;

    assign sum = {1'b0,In1} + {1'b0,In2};
    assign Carry = sum[32]; // This carry should work
    assign Overflow = (In1[31] ~^ In2[31]) & (sum[31] ^ In1[31]);
endmodule
