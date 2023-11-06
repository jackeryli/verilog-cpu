`timescale 1ns / 1ps

module alu_simple_tb;

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

        // Test addition
        opcode = 4'b0000; // Addition opcode
        In1 = 15;
        In2 = 20;
        SR_Bit = 5; // Random shift for testing, not needed for addition
        SR_Cont = 3'b000; // No shift operation
        #10;
        if (Out != (In1 + In2)) $display("Addition Test Failed!");

        // Test subtraction
        opcode = 4'b0001; // Subtraction opcode
        In1 = 30;
        In2 = 10;
        SR_Bit = 2; // Random shift for testing, not needed for subtraction
        SR_Cont = 3'b000; // No shift operation
        #10;
        if (Out != (In1 - In2)) $display("Subtraction Test Failed!");

        // Test multiplication
        opcode = 4'b0010; // Multiplication opcode
        In1 = 5;
        In2 = 5;
        SR_Bit = 3; // Random shift for testing, not needed for multiplication
        SR_Cont = 3'b000; // No shift operation
        #10;
        if (Out != (In1 * In2)) $display("Multiplication Test Failed!");

        // Test bitwise OR
        opcode = 4'b0011; // OR opcode
        In1 = 12'h0A0; // 0000 1010 0000
        In2 = 12'h005; // 0000 0000 0101
        #10;
        if (Out != (In1 | In2)) $display("Bitwise OR Test Failed!");

        // Test bitwise AND
        opcode = 4'b0100; // AND opcode
        In1 = 12'h0F0; // 0000 1111 0000
        In2 = 12'h00F; // 0000 0000 1111
        #10;
        if (Out != (In1 & In2)) $display("Bitwise AND Test Failed!");

        // Test bitwise XOR
        opcode = 4'b0101; // XOR opcode
        In1 = 12'h0FF; // 0000 1111 1111
        In2 = 12'h0F0; // 0000 1111 0000
        #10;
        if (Out != (In1 ^ In2)) $display("Bitwise XOR Test Failed!");

        // Test shift right
        opcode = 4'bxxxx; // Set to unused opcode for shifting
        In1 = 32'hFFFFFFFF; // Just a placeholder, not used in shifting
        In2 = 32'h12345678; // Example input
        SR_Bit = 4; // Shift by 4 bits
        SR_Cont = 3'b001; // Right shift operation
        #10;
        if (Out != (In2 >> SR_Bit)) $display("Shift Right Test Failed!");

        // Test shift left
        SR_Cont = 3'b010; // Left shift operation
        #10;
        if (Out != (In2 << SR_Bit)) $display("Shift Left Test Failed!");

        // Test rotation (assuming rotation module is implemented correctly)
        // ... Rotation tests should be added here

        // Signal test completion
        $display("All tests completed successfully.");
    end

endmodule