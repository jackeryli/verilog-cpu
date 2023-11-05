module alu(In1, In2, In3, Out, opcode, Cond, S, SR_Cont, SR_Bit, flag, Imm, mem);
input [31:0] In1, In2;
reg In3;
input [3:0] opcode, Cond;
input S;
input [4:0] SR_Bit;
input [2:0] SR_Cont;
input [15:0] Imm;
input [31:0] mem [0:(1<<16)];
output reg [31:0] Out;
inout reg [3:0] flag;
always @ * begin
    case (SR_Cont)
        default: In3 = In2;
        3'b001: right_shifter #(SR_Bit) rs (In2, In3);
        3'b010: left_shifter #(SR_Bit) ls (In2, In3);
        3'b011: right_rotator #(SR_Bit) rr (In2, In3);
    endcase
    case (opcode)
        4'b0000: adder(In1, In3, Out);
        4'b0001: substractor(In1, In3, Out);
        4'b0010: multiplier(In1, In3, Out);
        4'b0011: bitwise_or(In1, In3, Out);
        4'b0100: bitwise_and(In1, In3, Out);
        4'b0101: bitwise_xor(In1, In3, Out);
        4'b0110: mov(In1, Imm);
        4'b0111: mov(In1, In2);
        4'b1011: cmp(In1, In2, flag);
        4'b1101: ldr(In1, In2, mem);
        4'b1110: str(In1, In2, mem);
        default: In2 = In2;
    endcase
end
endmodule
