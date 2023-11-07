module tb_alu;

    // Inputs
    reg signed [31:0] In1;
    reg signed [31:0] In2;
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
        SR_Bit = 0;
        SR_Cont = 0;
        S = 1;
        Cond = 4'b0000;

        // Wait for global reset
        #100;

        // Test Compare
        Opcode = 4'b1011; // Compare Opcode
        In1 = 15;
        In2 = 20;
        SR_Bit = 5; // Random shift for testing, not needed for addition
        SR_Cont = 3'b000; // No shift operation
        #10;
        $display("Out=%b, In1=%d, In2=%d", Out, In1, In2);
        $display("Flags = %b", Flags);

        // Test Compare
        Opcode = 4'b1011; // Compare Opcode
        In1 = 32'd5;
        In2 = 32'd5;
        SR_Bit = 5; // Random shift for testing, not needed for addition
        SR_Cont = 3'b000; // No shift operation
        #10;
        $display("Out=%b, In1=%d, In2=%d", Out, In1, In2);
        $display("Flags = %b", Flags);

        // Test Compare
        Opcode = 4'b1011; // Compare Opcode
        In1 = 32'd30;
        In2 = 32'd25;
        SR_Bit = 5; // Random shift for testing, not needed for addition
        SR_Cont = 3'b000; // No shift operation
        #10;
        $display("Out=%b, In1=%d, In2=%d", Out, In1, In2);
        $display("Flags = %b", Flags);

        // Test Compare
        Opcode = 4'b1011; // Compare Opcode
        In1 = 32'd0;
        In2 = 32'd2147483648;
        SR_Bit = 5; // Random shift for testing, not needed for addition
        SR_Cont = 3'b000; // No shift operation
        #10;
        $display("Out=%b, In1=%d, In2=%d", Out, In1, In2);
        $display("Flags = %b", Flags);



        $finish;
    end
endmodule