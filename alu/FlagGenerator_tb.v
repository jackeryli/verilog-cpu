module FlagGenerator_tb;

    reg S;
    reg signed [31:0] Result;
    reg Carry;
    reg Overflow;
    wire [3:0] Flag;

    // Instantiate the FlagGenerator module
    FlagGenerator uut (
        .S(S),
        .Result(Result),
        .Carry(Carry),
        .Overflow(Overflow),
        .Flag(Flag)
    );

    initial begin
        // Test case 1: Positive Result, Carry, and Overflow
        S = 1'b1;
        Result = 8'h7F; // Positive 8-bit number
        Carry = 1'b1;
        Overflow = 1'b0;
        #10;
        $display("Test Case 1: S = %b, Result = %h, Carry = %b, Overflow = %b, Flag = %b", S, Result, Carry, Overflow, Flag);

        // Test case 2: Zero Result
        S = 1'b0;
        Result = 32'b0;
        Carry = 1'b0;
        Overflow = 1'b1;
        #10;
        $display("Test Case 2: S = %b, Result = %h, Carry = %b, Overflow = %b, Flag = %b", S, Result, Carry, Overflow, Flag);

        // Test case 4: S = 0, Positive Result, Carry, and Overflow
        S = 1'b0;
        Result = 32'h7F7F7F7F; // Positive 32-bit number
        Carry = 1'b1;
        Overflow = 1'b0;
        #10;
        $display("Test Case 4: S = %b, Result = %h, Carry = %b, Overflow = %b, Flag = %b", S, Result, Carry, Overflow, Flag);

        // Test case 5: S = 1, Zero Result
        S = 1'b1;
        Result = 32'b0;
        Carry = 1'b0;
        Overflow = 1'b0;
        #10;
        $display("Test Case 5: S = %b, Result = %h, Carry = %b, Overflow = %b, Flag = %b", S, Result, Carry, Overflow, Flag);

        // Test case 6: S = 0, Negative Result, Carry, and Overflow
        S = 1'b0;
        Result = -32'h7F7F7F7F; // Negative 32-bit number
        Carry = 1'b1;
        Overflow = 1'b1;
        #10;
        $display("Test Case 6: S = %b, Result = %h, Carry = %b, Overflow = %b, Flag = %b", S, Result, Carry, Overflow, Flag);

        // Test case 7: S = 1, Zero Result, No Carry, and No Overflow
        S = 1'b1;
        Result = 32'b0;
        Carry = 1'b0;
        Overflow = 1'b0;
        #10;
        $display("Test Case 7: S = %b, Result = %h, Carry = %b, Overflow = %b, Flag = %b", S, Result, Carry, Overflow, Flag);

        // Test case 8: S = 1, Maximum Positive Result, No Carry, No Overflow
        S = 1'b1;
        Result = 32'h7FFFFFFF; // Maximum positive 32-bit number
        Carry = 1'b0;
        Overflow = 1'b0;
        #10;
        $display("Test Case 8: S = %b, Result = %h, Carry = %b, Overflow = %b, Flag = %b", S, Result, Carry, Overflow, Flag);


        $finish;
    end

endmodule
