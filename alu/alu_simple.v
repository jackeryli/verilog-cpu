module alu_simple (In1, In2, Out, opcode, SR_Cont, SR_Bit);
input [31:0] In1, In2;
reg [31:0] In3;
input [3:0] opcode;
input [4:0] SR_Bit;
input [2:0] SR_Cont;
output reg [31:0] Out;
wire [31:0] add_out, sub_out, mul_out, bor_out, band_out, bxor_out, rs_out, ls_out, rr_out;

right_shifter rs (In2, SR_Bit, rs_out);
left_shifter ls (In2, SR_Bit, ls_out);
right_rotator rr (In2, SR_Bit, rr_out);

assign In3 = (SR_Cont == 3'b001) ? rs_out :
            (SR_Cont == 3'b010) ? ls_out :
            (SR_Cont == 3'b011) ? rr_out :
            In2;

adder add (In1, In3, add_out);
substractor sub (In1, In3, sub_out);
multiplier mul (In1, In3, mul_out);
bitwise_or bor (In1, In3, bor_out);
bitwise_and band (In1, In3, band_out);
bitwise_xor bxor (In1, In3, bxor_out);

always @ * begin
    case (opcode)
        4'b0000: Out = add_out;
        4'b0001: Out = sub_out;
        4'b0010: Out = mul_out;
        4'b0011: Out = bor_out;
        4'b0100: Out = band_out;
        4'b0101: Out = bor_out;
        default: Out = Out;
    endcase
end
endmodule