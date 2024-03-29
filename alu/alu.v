module Alu (In1, In2, Out, Opcode, Cond, S, SR_Cont, SR_Bit, Flags, Immediate, Condition_met);
input signed [31:0] In1, In2;
wire signed [31:0] In3;
input [3:0] Opcode, Cond;
input S;
input [4:0] SR_Bit;
input [2:0] SR_Cont;
input [15:0] Immediate;
output reg signed [31:0] Out;
output reg [3:0] Flags;

wire signed [31:0] add_out, sub_out, mul_out, bor_out, band_out, bxor_out, rs_out, ls_out, rr_out;
wire [31:0] move_imm_out;
wire [31:0] move_out;
wire [31:0] load_out;
wire [31:0] store_out;
wire add_carry, add_overflow;
wire cmp_carry, cmp_overflow;
wire signed [31:0] cmp_out;
wire [3:0] cmp_flags, fg_flags, add_flags, sub_flags, mul_flags, bor_flags, band_flags, bxor_flags;

output wire Condition_met;
wire [31:0] Un_In1, Un_In2;

reg carry, overflow;
reg flag_enable;

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

adder add (In1, In3, add_out, S, add_flags);
substractor sub (In1, In3, sub_out, S, sub_flags);
multiplier mul (In1, In3, mul_out, S, mul_flags);
bitwise_or bor (In1, In3, bor_out, S, bor_flags);
bitwise_and band (In1, In3, band_out, S, band_flags);
bitwise_xor bxor (In1, In3, bxor_out, S, bxor_flags);
mov_imm movi (Immediate, move_imm_out);
mov mov (In1, move_out);
ldr load(In1, load_out);
str store(In1, store_out);
cmp compare(In1, In2, cmp_out, cmp_flags);
// assign In2 = In3;

always @ (*) begin
    Out = 32'bx;
    carry = 1'b0;
    overflow = 1'b0;
    // flag_enable = S;
    if (Opcode == 4'b1111) begin
        Out = Out;
        Flags = 4'bx;
    end
    else if (Condition_met) begin
        case (Opcode)
            4'b0000: begin
                Out = add_out;
                Flags = add_flags;
            end
            4'b0001: begin
                Out = sub_out;
                Flags = sub_flags;
            end
            4'b0010: begin
                Out = mul_out;
                Flags = mul_flags;
            end
            4'b0011: begin
                Out = bor_out;
                Flags = bor_flags;
            end
            4'b0100: begin
                Out = band_out;
                Flags = band_flags;
            end
            4'b0101: begin
                Out = bxor_out;
                Flags = bxor_flags;
            end
            4'b0110: Out = move_imm_out;
            4'b0111: Out = move_out;
            4'b1011: begin
                // carry = cmp_carry;
                // overflow = cmp_overflow;
                Flags = cmp_flags;
                // flag_enable = 1'b1; //reconsider
            end
            4'b1101: Out = load_out;
            default: Out = store_out;
        endcase
    end
    else begin
        Out = 32'bx;
        Flags = 4'bx;
    end
end

endmodule
