module sub_tb;
    reg signed [31:0] In1, In2;
    wire [31:0] Out;
    reg S;
    wire [3:0] Flags;
    wire [32:0] Result;

    // Instantiate the adder module
    substractor uut (
        .In1(In1),
        .In2(In2),
        .Out(Out),
        .S(S),
        .Flags(Flags)
        // .Carry(Carry),
        // .Overflow(Overflow)
    );
    
    initial begin
        // Test case 5
        In1 = 10; // Minimum negative signed 32-bit number
        In2 = 30;
        S = 1'b0;
        #10;
        $display("Test Case 5: In1 = %d, In2 = %d, Out = %b, Flags = %b", In1, In2, Out, Flags);
        // Add more test cases as needed
    end
endmodule
