module substractor (In1, In2, Out, S, Flags);
    input signed [31:0] In1, In2;
    input S;
    output wire signed [31:0] Out;
    output wire [3:0] Flags;
    wire [3:0] fgs;
    wire [32:0] Result;
    assign Result = {1'b0,In1} - {1'b0,In2};
    assign Out = Result[31:0];

    assign fgs[3] = (In1 < In2);
    assign fgs[2] = (In1 == In2);
    assign fgs[1] = (In1[31]& In2[31]& (In1<In2)) ? 1'b1: // both negative
                        (~In1[31]& ~In2[31]& (In1<In2)) ? 1'b1: // both positive
                        (In1[31]& ~In2[31]) ? 1'b1: 1'b0; // -ve - +ve
    assign fgs[0] = (~Result[31]& In1[31] & ~In2[31])|(Result[31] & ~In1[31] & In2[31]);
    assign Flags = S ? fgs : 4'bx;
endmodule
