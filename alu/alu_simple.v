module alu_simple (In1, In2, Out, Instr);
input [31:0] In1, In2, Instr;
reg [31:0] In3;
output reg [31:0] Out;
always @ * begin
    case (Instr[2:0])
        3'b001: right_shifter(In2, In3);
        3'b010: left_shifter(In2, In3);
        3'b011: right_rotator(In2, In3);
        default: In3 = In2;
    endcase
    case (Instr[27:24])
        4'b0000: adder(In1, In3, Out);
        4'b0001: substractor(In1, In3, Out);
        4'b0010: multiplier(In1, In3, Out);
        4'b0011: bitwise_or(In1, In3, Out);
        4'b0100: bitwise_and(In1, In3, Out);
        4'b0101: bitwise_xor(In1, In3, Out);
        default: Out = Out;
    endcase
end
endmodule