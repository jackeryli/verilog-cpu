module cmp (In1, In2, flag, S);
input signed [31:0] In1, In2;
input S;
output [3:0] flag;
wire signed [31:0] result, negIn2, sum;
wire carry;

assign negIn2 = ~In2 + 1; // Taking two's complement for subtraction
assign result = In1 + negIn2;
assign {carry, sum} = In1 + In2;

assign flag[3] = result[31];
assign flag[2] = (result == 32'b0);
assign flag[1] = carry;
assign flag[0] = (In1[31] ~^ In2[31]) & (sum[31] ^ In1[31]);
endmodule
