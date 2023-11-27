module FlagGenerator (
    input S,
    // input signed [31:0] Result,
    input signed [31:0] In1,
    input signed [31:0] In2,
    // input Carry,
    // input Overflow,
    output reg [3:0] Flags
);

wire signed [32:0] Result;
assign Result = {1'b0,In1} - {1'b0,In2};
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
