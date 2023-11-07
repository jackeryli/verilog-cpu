module mov_imm (Immediate, Out);
  input [15:0] Immediate;
  output wire [31:0] Out;
  assign Out = {16'b0, Immediate};
endmodule
