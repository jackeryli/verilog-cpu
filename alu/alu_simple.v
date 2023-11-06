module alu_simple (In1, In2, Out, Opcode, SR_Cont, SR_Bit, S, Flags, Immediate);
input signed [31:0] In1, In2;
input [3:0] Opcode;
input [4:0] SR_Bit;
input [2:0] SR_Cont;
input S;
input [15:0] Immediate;
output reg [31:0] Out;

// The 4-bit Flags register ({N, Z, C, V}) are set by a CMP instruction
// or when the S option is set to one (bit # 23 of the instruction). 
// N=1 if the result is negative
// Z=1 if the result is zero
// C=1 if the result generates a carry
// V=1 if the result generates an overflow
output wire [3:0] Flags;

wire [31:0] add_out, sub_out, mul_out, bor_out, band_out, bxor_out, rs_out, ls_out, rr_out;
wire [31:0] move_imm_out;
wire [31:0] move_out;
wire [31:0] load_out;
wire [31:0] store_out;

wire add_carry, add_overflow;

reg signed [31:0] In3;
reg carry, overflow;

// TODO: ALU should recognize the optional Cond bits (the four MSB of the instruction) as per the following table;

right_shifter rs (In2, SR_Bit, rs_out);
left_shifter ls (In2, SR_Bit, ls_out);
right_rotator rr (In2, SR_Bit, rr_out);

assign In3 = (SR_Cont == 3'b001) ? rs_out :
            (SR_Cont == 3'b010) ? ls_out :
            (SR_Cont == 3'b011) ? rr_out :
            In2;

adder add (In1, In3, add_out, add_carry, add_overflow);
substractor sub (In1, In3, sub_out);
multiplier mul (In1, In3, mul_out);
bitwise_or bor (In1, In3, bor_out);
bitwise_and band (In1, In3, band_out);
bitwise_xor bxor (In1, In3, bxor_out);
mov_imm movi (Immediate, move_imm_out);
mov mov (In1, move_out);
ldr load(In1, load_out);
str store(In1, store_out);

always @ * begin
    case (Opcode)
        4'b0000: begin
            Out = add_out;
            carry = add_carry;
            overflow = add_overflow;
        end
        4'b0001: Out = sub_out;
        4'b0010: Out = mul_out;
        4'b0011: Out = bor_out;
        4'b0100: Out = band_out;
        4'b0101: Out = bxor_out;
        4'b0110: Out = move_imm_out;
        4'b0111: Out = move_out;
        // TODO: CMP R1, R2
        4'b1101: Out = load_out;
        4'b1110: Out = store_out;
        default: Out = Out;
    endcase
end

FlagGenerator fg (S, Out, carry, overflow, Flags);

endmodule