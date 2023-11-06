module mov_imm (Immediate, Out);
  input [15:0] Immediate;
  output [31:0] Out;
  assign Out = {{16{1'b0}}, Immediate};
endmodule
