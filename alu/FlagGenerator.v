module FlagGenerator (
    input S,
    input signed [31:0] Result,
    // input Carry,
    // input Overflow,
    output reg [3:0] Flags
);

always @(S or Result) begin
    if(S == 1'b1) begin
        Flags[3] = Result[31];
        Flags[2] = (Result == 32'b0);
        Flags[1] = Result[32];
        Flags[0] = (~Result[32]& In1[31] & ~In2[31])|(Result[32] & ~In1[31] & In2[31]);
    end
    else
        Flags = 4'b0000;
end

endmodule
