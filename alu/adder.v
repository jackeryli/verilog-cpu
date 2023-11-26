module adder (In1, In2, Out, S, Flags);
    input signed [31:0] In1, In2;
    input S;
    output wire signed [31:0] Out;
    output wire [3:0] Flags;
    wire [3:0] fgs;
    wire [32:0] Result;
    wire [31:0] Un_In1, Un_In2;

    assign Un_In1 = {1'b0, In1};
    assign Un_In2 = {1'b0, In2};
    assign Result = Un_In1 + Un_In2;
    assign Out = In1 + In2;
    assign fgs[3] = ((In1[31] ~^ In2[31]) & (Result[31] ^ In1[31])) ? (In1[31]) : 
                        Result[31];
    assign fgs[2] = (Result == 33'b0);
    assign fgs[1] = Result[32];
    assign fgs[0] = (In1[31] ~^ In2[31]) & (Result[31] ^ In1[31]);
    assign Flags = S ? fgs : 4'bx;
endmodule
