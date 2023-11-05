module str (In1, In2, mem);
input [31:0] In1, In2;
output [31:0] mem [0:(1<<16)];
assign mem[In1] = In2;
endmodule
