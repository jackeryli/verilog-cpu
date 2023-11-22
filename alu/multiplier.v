module multiplier (In1, In2, Out, Overflow);
    input signed [31:0] In1, In2;
    output wire signed [31:0] Out;
    output wire Overflow;
    wire signed [63:0] full_product;
    assign Out = full_product[31:0];  

    // Overflow occurs if the sign of the higher and lower parts of the product do not match
    
    assign Overflow = (full_product[63:32] != {32{Out[31]}});

endmodule
