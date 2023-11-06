`timescale 1ns / 1ps

module multiplier_tb;

    // Inputs
    reg [31:0] In1;
    reg [31:0] In2;
    reg [3:0] opcode;
    reg [4:0] SR_Bit;
    reg [2:0] SR_Cont;

    // Output
    wire [31:0] Out;

    // Instantiate the Unit Under Test (UUT)
    alu_simple uut (
        .In1(In1), 
        .In2(In2), 
        .Out(Out), 
        .opcode(opcode), 
        .SR_Cont(SR_Cont), 
        .SR_Bit(SR_Bit)
    );
    initial begin
        // Initialize Inputs
        In1 = 0;
        In2 = 0;
        opcode = 0;
        SR_Bit = 0;
        SR_Cont = 0;

        // Wait for global reset
        #100;

        opcode = 4'b0010; // Multiplication opcode
        In1 = 3479807;
        In2 = 312578093;
        SR_Bit = 3; // Random shift for testing, not needed for multiplication
        SR_Cont = 3'b000; // No shift operation
        #10;
        if (Out != (In1 * In2)) $display("Multiplication Test Failed!");

    end

endmodule
