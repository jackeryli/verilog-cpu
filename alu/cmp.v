module cmp (In1, In2, Out, Flags);
input signed [31:0] In1, In2;
output wire [31:0] Out;
output wire [3:0] Flags;
// output Carry;
// output Overflow;
wire [32:0] Result;
wire [32:0] Un_In1, Un_In2;
// assign Un_In1 = In1[31]? {1'b1, In1} : {1'b0, In1};
// assign Un_In2 = In2[31]? {1'b1, In2} : {1'b0, In2};
// assign Un_In1 = {1'b0, In1};
// assign Un_In2 = {1'b0, In2};
// assign Result = {1'b0,In1} - {1'b0,In2};
// assign Result = Un_In1 - Un_In2;
// assign Out = Result[31:0];
assign Out = In1 - In2;
assign Flags[3] = (In1 < In2);
assign Flags[2] = (In1 == In2);
assign Flags[1] = (In1[31]& In2[31]& (In1<In2)) ? 1'b1: // both negative
                    (~In1[31]& ~In2[31]& (In1<In2)) ? 1'b1: // both positive
                    (In1[31]& ~In2[31]) ? 1'b1: 1'b0; // -ve - +ve
assign Flags[0] = (~Out[31]& In1[31] & ~In2[31])|(Out[31] & ~In1[31] & In2[31]);

endmodule
