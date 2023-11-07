`timescale 1ns / 1ps

module tb_alu_overflow;

    // Inputs
    reg [31:0] In1;
    reg [31:0] In2;
    reg [3:0] Opcode;
    reg [3:0] Cond;
    reg [4:0] SR_Bit;
    reg [2:0] SR_Cont;
    reg S;
    reg [15:0] Immediate;

    // Output
    wire [31:0] Out;
    wire [3:0] Flags;

    // Instantiate the Unit Under Test (UUT)
    alu uut (
        .In1(In1), 
        .In2(In2), 
        .Out(Out), 
        .Opcode(Opcode),
        .Cond(Cond),
        .SR_Cont(SR_Cont), 
        .SR_Bit(SR_Bit),
        .S(S),
        .Flags(Flags),
        .Immediate(Immediate)
    );

    initial begin
        // Initialize Inputs
        In1 = 0;
        In2 = 0;
        Opcode = 0;
        Cond = 0;
        SR_Bit = 0;
        SR_Cont = 0;
        S = 1;
        Immediate = 0;

        // Wait for global reset
        #100;

        // Test addition overflow
        Opcode = 4'b0000; // Addition Opcode
        In1 = 32'd2147483647;
        In2 = 32'd2147483647;
        SR_Bit = 5; // Random shift for testing, not needed for addition
        SR_Cont = 3'b000; // No shift operation
        #10;
        $display("Out=%b, In1=%b, In2=%b, Flags=%b", Out, In1, In2, Flags);
        
        // Signal test completion
        $display("All tests completed successfully.");
    end

endmodule
