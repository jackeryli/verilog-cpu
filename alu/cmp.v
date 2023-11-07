module cmp (In1, In2, Out, Carry, Overflow);
input signed [31:0] In1, In2;
output [31:0] Out;
output Carry;
output Overflow;

wire signed [31:0] result, negIn2;
wire signed [32:0] sum;
wire carry;

// assign negIn2 = ~In2 + 1; // Taking two's complement for subtraction
assign result = In1 - In2;
assign sum = {1'b0,In1} + {1'b0,In2};

assign Carry = sum[32];
assign Out = result;
assign Overflow = (In1[31] ~^ In2[31]) & (sum[31] ^ In1[31]);

endmodule
