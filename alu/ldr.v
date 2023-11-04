module ldr (In, Out, mem);
input [31:0] In;
input [31:0] mem [0:15];
output [31:0] Out;
assign Out = mem[In];
endmodule
