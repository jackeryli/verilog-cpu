module cmp (In1, In2, Out, Carry, Overflow);
input signed [31:0] In1, In2;
output [31:0] Out;
output Carry;
output Overflow;

adder a(In1, 1 + ~In2, Out, Carry, Overflow);

endmodule
