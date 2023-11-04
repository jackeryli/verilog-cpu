module mov_imm (In, imm);
input [15:0] imm;
output [31:0] In;
assign In = {16{1'b0}, imm};
endmodule