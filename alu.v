module alu(In1, In2, Out, opcode, S, SR_Cont, SR_Bit, N, Z, C, V, Imm);
input [31:0] In1;
input [3:0] opcode;
input S;
input [4:0] SR_Bit;
input [2:0] SR_Cont;
input [15:0] Imm;
output reg [31:0] Out;
output reg N, Z, C, V;
input [31:0] In2;
always @ * begin
case (SR_Cont)
default: In2 = In2;
3'b001: In2 = {SR_Bit{1'b0}, In2[31:SR_Bit]};
3'b010: In2 = {In2[31-SR_Bit:0], SR_Bit{1'b0}};
3'b011: In2 = {In2[31-SR_Bit:0], In2[31:SR_Bit]};
endcase
casex (opcode)
4'b0000: Out = In1 + In2;
4'b0001: Out = In1 - In2;
4'b0010: Out = In1 * In2;
4'b0011: Out = In1 | In2;
4'b0100: Out = In1 & In2;
4'b0101: Out = In1 ^ In2;
4'b0110: Out = {16{1'b0}, Imm};
4'b0111: Out = In1;
4'b1011: 
4'b1101: 
endcase
end
endmodule
