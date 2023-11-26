module multiplier_tb;
    reg signed [31:0] In1, In2;
    wire [31:0] Out;
    wire Overflow;

    // Instantiate the adder module
    multiplier uut (
        .In1(In1),
        .In2(In2),
        .Out(Out),
        .Overflow(Overflow)
    );

    initial begin
        // Test case 1: Positive numbers
        In1 = 5;
        In2 = 7;
        #10;
        $display("Test Case 1: In1 = %d, In2 = %d, Out = %b, out = %d, Overflow = %b", In1, In2, Out,Out,Overflow);

        // Test case 2: Negative numbers
        In1 = 1;
        In2 = -5;
        #10;
        $display("Test Case 2: In1 = %d, In2 = %d, Out = %b, out = %d, Overflow = %b", In1, In2, Out,Out,Overflow);

        // Test case 3: Overflow test
        In1 = 2147483647; // Maximum positive signed 32-bit number
        In2 = 1999999999;
        #10;
        $display("Test Case 3: In1 = %d, In2 = %d, Out = %b, out = %d, Overflow = %b", In1, In2, Out,Out,Overflow);

        // Test case 4: Negative overflow test
        In1 = -2147483648; // Minimum negative signed 32-bit number
        In2 = -1;
        #10;
        $display("Test Case 4: In1 = %d, In2 = %d, Out = %b, out = %d, Overflow = %b", In1, In2, Out,Out,Overflow);

        // Add more test cases as needed

        $finish;
    end
endmodule
