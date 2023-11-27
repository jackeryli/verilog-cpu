module bitwise_xor (In1, In2, Out, S, Flags);
    input [31:0] In1, In2;
    output wire [31:0] Out;
    input S;
    output [3:0] Flags;
    wire [3:0] fgs;
    assign Out = In1 ^ In2;
    assign fgs[3] = Out[31];
    assign fgs[2] = (Out == 32'b0);
    assign fgs[1:0] = 2'b00;
    assign Flags = S ? fgs : 4'bxx00;
endmodule
