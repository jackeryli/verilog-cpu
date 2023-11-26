module multiplier (In1, In2, Out, S, Flags);
    input signed [31:0] In1, In2;
    input S;
    output wire signed [31:0] Out;
    output wire [3:0] Flags;
    wire [3:0] fgs;
    wire signed [63:0] full_product;
    
    assign full_product=In1*In2;
    assign Out = full_product[31:0];

    // Overflow occurs if the sign of the higher and lower parts of the product do not match
    assign fgs[3] = full_product[63];
    assign fgs[2] = (full_product == 64'b0);
    assign fgs[1] = |full_product[63:32];
    assign fgs[0] = (full_product[63:32] != {32{Out[31]}});
    assign Flags = S ? fgs : 4'bx;
endmodule
