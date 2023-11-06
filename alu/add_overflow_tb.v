`timescale 1ns / 1ps
module add_overflow_tb;

   // Inputs
    reg [31:0] In1;
    reg [31:0] In2;
    reg [3:0] opcode;
    reg [4:0] SR_Bit;
    reg [2:0] SR_Cont;

    //output
    wire [31:0] Out;

    alu_simple uut(
        .In1(In1),
        .In2(In2),
        .Out(Out),
        .opcode(opcode), 
        .SR_Cont(SR_Cont), 
        .SR_Bit(SR_Bit)
    );

	initial begin
        In1 = 0 ;
        In2 = 0;
        opcode = 0;
        SR_Bit = 0;
        SR_Cont = 0;

         #100;

	opcode = 4'b0000; // addition opcode
        In1 = -2147483647;//max value for 32 bits
        In2 = -2147483647;
        SR_Bit = 2; // Random shift for testing, not needed for subtraction
        SR_Cont = 3'b000; // No shift operation
        #10;
	$display("Out=%d, In1=%d, In2=%d", Out, In1, In2);
	end
endmodule
