module alu (In1, In2, Out, Opcode, Cond, S, SR_Cont, SR_Bit, Flags, Imm, mem);
input signed [31:0] In1, In2;
wire signed [31:0] In3;
input [3:0] Opcode, Cond;
input S;
input [4:0] SR_Bit;
input [2:0] SR_Cont;
input [15:0] Imm;
input [31:0] mem [0:(1<<16)];
output reg [31:0] Out;
output reg [3:0] Flags;
wire [31:0] add_out, sub_out, mul_out, bor_out, band_out, bxor_out, rs_out, ls_out, rr_out, move_imm_out, load_out, store_out;
wire add_carry, add_overflow;
reg carry, overflow;
wire [3:0] cmp_out;
wire [31:0] Un_In1, Un_In2;

assign Un_In1 = In1;
assign Un_In2 = In2;


assign Condition_met =  (Cond == 4'b0000) ? 1'b1 : // No Condition
                        (Cond == 4'b0001 && In1 == In2) ? 1'b1 : // EQ - Equal
                        (Cond == 4'b0010 && In1 > In2) ? 1'b1 : // GT - Greater Than
                        (Cond == 4'b0011 && In1 < In2) ? 1'b1 : // LT - Less Than
                        (Cond == 4'b0100 && In1 >= In2) ? 1'b1 : // GE - Greater Than or Equal To
                        (Cond == 4'b0101 && In1 <= In2) ? 1'b1 : // LE - Less Than or Equal To
                        // Unsigned comparisons
                        (Cond == 4'b0110 && Un_In1 > Un_In2) ? 1'b1 : // HI - Unsigned Higher
                        (Cond == 4'b0111 && Un_In1 < Un_In2) ? 1'b1 : // LO - Unsigned Lower
                        (Cond == 4'b1000 && Un_In1 >= Un_In2) ? 1'b1 : // HS - Unsigned Higher or Same
                        1'b0;

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
mov_imm movi (Imm, move_imm_out);
mov mov (In1, move_out);
ldr load(In1, load_out);
str store(In1, store_out);
cmp compare(In1, In3, cmp_out);

always @ * begin
    if (Condition_met) begin
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
            4'b1011: Flags = cmp_out;
            4'b1101: Out = load_out;
            4'b1110: Out = store_out;
            default: ;
        endcase
    end
end

FlagGenerator fg (S, Out, carry, overflow, Flags);

endmodule
