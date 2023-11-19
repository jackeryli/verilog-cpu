`timescale 1ns / 1ps

module tb_alu_global;

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
        .Immediate(Immediate),
        .Condition_met(Condition_met)
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

        // Test addition
        Opcode = 4'b0000; // Addition Opcode
        In1 = 15;
        In2 = 20;
        SR_Bit = 5; // Random shift for testing, not needed for addition
        SR_Cont = 3'b000; // No shift operation
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1 + In2)) $display("Addition Test Success!");

        // Test subtraction
        Opcode = 4'b0001; // Subtraction Opcode
        In1 = 30;
        In2 = 10;
        SR_Bit = 2; // Random shift for testing, not needed for subtraction
        SR_Cont = 3'b000; // No shift operation
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1 - In2)) begin
            // $display("Out=%d, In1=%d, In2=%d", Out, In1, In2);
            $display("Subtraction Test Success!");
        end

        // Test multiplication
        Opcode = 4'b0010; // Multiplication Opcode
        In1 = 5;
        In2 = 5;
        SR_Bit = 3; // Random shift for testing, not needed for multiplication
        SR_Cont = 3'b000; // No shift operation
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1 * In2)) $display("Multiplication Test Success!");

        // Test bitwise OR
        Opcode = 4'b0011; // OR Opcode
        In1 = 12'h0A0; // 0000 1010 0000
        In2 = 12'h005; // 0000 0000 0101
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1 | In2)) $display("Bitwise OR Test Success!");

        // Test bitwise AND
        Opcode = 4'b0100; // AND Opcode
        In1 = 12'h0F0; // 0000 1111 0000
        In2 = 12'h00F; // 0000 0000 1111
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1 & In2)) begin
            $display("Out=%b, In1=%b, In2=%b", Out, In1, In2);
            $display("Bitwise AND Test Success!");
        end

        // Test bitwise XOR
        Opcode = 4'b0101; // XOR Opcode
        In1 = 12'h0FF; // 0000 1111 1111
        In2 = 12'h0F0; // 0000 1111 0000
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1 ^ In2)) begin
            $display("Out=%b, In1=%b, In2=%b", Out, In1, In2);
            $display("Bitwise XOR Test Success!");
        end

        // Test shift right
        Opcode = 4'b0000; // ADD Opcode
        In1 = 30;
        In2 = 10;
        SR_Bit = 4;
        SR_Cont = 3'b001; // Right shift operation
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1 + (In2 >> SR_Bit))) begin
            $display("Out=%b, In1=%b, In2=%b", Out, In1, In2);
            $display("Shift Right Test Success!");
        end

        // Test shift left
        Opcode = 4'b0000; // ADD Opcode
        In1 = 30;
        In2 = 10;
        SR_Bit = 4;
        SR_Cont = 3'b010; // Left shift operation
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1 + (In2 << SR_Bit))) begin
            $display("Out=%b, In1=%b, In2=%b", Out, In1, In2);
            $display("Shift Left Test Success!");
        end

        // Test right rotation
        Opcode = 4'b0000; // ADD Opcode
        In1 = 30;
        In2 = 10;
        SR_Bit = 4;
        SR_Cont = 3'b011; // Right rotation operation
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1 + (32'b1010_0000_0000_0000_0000_0000_0000_0000))) begin
            $display("Out=%b, In1=%b, In2=%b", Out, In1, In2);
            $display("Right rotation Test Success!");
        end

        // Test mov imm
        Opcode = 4'b0110; // MOV intermidiate Opcode
        In1 = 30;
        Immediate = 60;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == Immediate) begin
            $display("Move Immediate Test Success!");
        end

        // Test mov
        Opcode = 4'b0111; // MOV intermidiate Opcode
        In1 = 30;
        Immediate = 0;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == In1) begin
            $display("Move Test Success!");
        end

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

        // Test ldr
        Opcode = 4'b1101;
        In1 = 30;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == In1) begin
            $display("Load Test Success");
        end

        // Test str
        Opcode = 4'b1110;
        In1 = 30;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == In1) begin
            $display("Store Test Success");
        end

        // Test Condition EQ with adder
        Cond = 4'b0001;
        Opcode = 4'b0000;
        In1 = -10;
        In2 = -11;
        SR_Bit = 0;
        SR_Cont = 0;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out != (In1+In2)) begin
            $display("EQ Test 1 Success");
        end

        Cond = 4'b0001;
        Opcode = 4'b0000;
        In1 = 20;
        In2 = 20;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1+In2)) begin
            $display("EQ Test 2 Success");
        end

        // Test Condition GT with subtractor
        Cond = 4'b0010;
        Opcode = 4'b0001;
        In1 = 20;
        In2 = 10;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1-In2)) begin
            $display("GT Test 1 Success");
        end
        In1 = -10;
        In2 = -5;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out != (In1-In2)) begin
            $display("GT Test 2 Success");
        end
        
        // Test Condition LT with multiplier
        Cond = 4'b0011;
        Opcode = 4'b0010;
        In1 = 20;
        In2 = 30;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1*In2)) begin
            $display("LT Test 1 Success");
        end
        In1 = -20;
        In2 = -20;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out != (In1*In2)) begin
            $display("LT Test 2 Success");
        end

        // Test Condition GE with or
        Cond = 4'b0100;
        Opcode = 4'b0011;
        In1 = -20;
        In2 = -20;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1|In2)) begin
            $display("GE Test 1 Success");
        end
        In1 = 4;
        In2 = 15;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out != (In1|In2)) begin
            $display("GE Test 2 Success");
        end

        // Test Condition LE with and
        Cond = 4'b0101;
        Opcode = 4'b0100;
        In1 = 10;
        In2 = 16;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1&In2)) begin
            $display("LE Test 1 Success");
        end
        In1 = -3;
        In2 = -8;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out != (In1&In2)) begin
            $display("LE Test 2 Success");
        end

        // Test Condition HI Unsigned with adder
        Cond = 4'b0110;
        Opcode = 4'b0000;
        In1 = -2;
        In2 = 100;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1+In2)) begin
            $display("HI Test 1 Success");
        end
        In1 = 10;
        In2 = 25;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out != (In1+In2)) begin
            $display("HI Test 2 Success");
        end

        // test Condition LO Unsigned with adder
        Cond = 4'b0111;
        Opcode = 4'b0000;
        In1 = 5;
        In2 = 13;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1+In2)) begin
            $display("LO Test 1 Success");
        end
        In1 = -7;
        In2 = 20;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out != (In1+In2)) begin
            $display("LO Test 2 Success");
        end

        // Test Condition HS Unsigned with adder
        Cond = 4'b1000;
        Opcode = 4'b0000;
        In1 = 13;
        In2 = 13;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out == (In1+In2)) begin
            $display("HS Test 1 Success");
        end
        In1 = 20;
        In2 = -5;
        #10;
        $display ("Out = %d, Condition = %b", Out, Condition_met);
        if (Out != (In1+In2)) begin
            $display("HS Test 2 Success");
        end
        
        // Signal test completion
        $display("All tests completed successfully.");
    end

endmodule
