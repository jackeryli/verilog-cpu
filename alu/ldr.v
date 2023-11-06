// ALU result will not be used. Instread, it will load from memory by memory controller,
// and finally through LDR MUX to register bank
module ldr (In, Out);
input [31:0] In;
output [31:0] Out;

assign Out = In;

endmodule
