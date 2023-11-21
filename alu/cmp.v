module cmp (In1, In2, Out, Flags);
input signed [31:0] In1, In2;
output [31:0] Out;
output [3:0] Flags;
output Carry;
output Overflow;
wire signed [32:0] Result;
assign Result = {1'b0,In1} - {1'b0,In2};
assign Flags[3] = Result[31];
assign Flags[2] = (Result == 33'b0);
assign Flags[1] = Result[32];
assign Flags[0] = (~Result[32]& In1[31] & ~In2[31])|(Result[32] & ~In1[31] & In2[31]);

//adder a(In1, 1 + ~In2, Out, Carry, Overflow);

endmodule
