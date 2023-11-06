module str (In1, In2, mem);
input [31:0] In1, In2;
output reg [31:0] mem [0:(1<<16)];

always@(In1 or In2) begin
    mem[In1] = In2;
end

endmodule
