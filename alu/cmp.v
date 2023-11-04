module cmp (In1, In2, flag);
input [31:0] In1, In2;
output reg [3:0] flag;
integer result;
assign result = In1-In2;
always @ * begin
    if (result < 0)
        flag = 4'b1000;
    else if (result == 0)
        flag = 4'b0100;
    else if (result >= 2**32)
        flag = 4'b0010;
    else if ((result > 0 && In1<0 && In2<0)||(result<0 && In1>0 && In2>0))
        flag = 4'b0001;
    else
        flag = 4'b0000;
end
endmodule
