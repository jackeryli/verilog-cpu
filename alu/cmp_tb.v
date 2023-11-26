`timescale 1ns / 1ps

module cmp_tb;

  // Inputs
  reg signed [31:0] In1;
  reg signed [31:0] In2;
  wire signed [31:0] Out;

  // Output
  wire [3:0] Flags;

  // Instantiate the Unit Under Test (UUT)
  cmp uut (
    .In1(In1), 
    .In2(In2), 
    .Out(Out),
    .Flags(Flags)
  );

  initial begin
    // Initialize Inputs
    In1 = 0;
    In2 = 0;
    #100;
    // Wait 100 ns for global reset to finish
    #20;
      
    // Add stimulus 
    In1 = 32'd10; In2 = 32'd15;
    #10; // Wait for 10 ns
    $display("Test 1: In1 = %b, In2 = %b, Flags = %b", In1, In2, Flags);
    $display("Test 1: In1 = %d, In2 = %d, Out = %d, Flags = %d", In1, In2, Out, Flags);

    In1 = 32'd10; In2 = -32'd15;
    #10; // Wait for 10 ns
    $display("Test 1: In1 = %b, In2 = %b, Flags = %b", In1, In2, Flags);
    $display("Test 1: In1 = %d, In2 = %d, Out = %d, Flags = %d", In1, In2, Out, Flags);

    In1 = 32'd7; In2 = -32'd2;
    #10;
    $display("Test 1: In1 = %b, In2 = %b, Flags = %b", In1, In2, Flags);
    $display("Test 1: In1 = %d, In2 = %d, Out = %d, Flags = %d", In1, In2, Out, Flags);

    In1 = 32'd5; In2 = 32'd5;
    #10;
    $display("Test 1: In1 = %b, In2 = %b, Flags = %b", In1, In2, Flags);
    $display("Test 1: In1 = %d, In2 = %d, Out = %d, Flags = %d", In1, In2, Out, Flags);

    In1 = 32'd0; In2 = 32'd2147483647;
    #10;
    $display("Test 1: In1 = %b, In2 = %b, Flags = %b", In1, In2, Flags);
    $display("Test 1: In1 = %d, In2 = %d, Out = %d, Flags = %d", In1, In2, Out, Flags);

    In1 = -32'd32768; In2 = 32'd32767;
    #10;
    $display("Test 1: In1 = %b, In2 = %b, Flags = %b", In1, In2, Flags);
    $display("Test 1: In1 = %d, In2 = %d, Out = %d, Flags = %d", In1, In2, Out, Flags);

    In1 = 32'd2147483647; In2 = -32'd21444;
    #10;
    $display("Test 1: In1 = %b, In2 = %b, Flags = %b", In1, In2, Flags);
    $display("Test 1: In1 = %d, In2 = %d, Out = %d, Flags = %d", In1, In2, Out, Flags);

    In1 = 32'd2147483647; In2 = -32'd2147483647;
    #10;
    $display("Test 1: In1 = %b, In2 = %b, Flags = %b", In1, In2, Flags);
    $display("Test 1: In1 = %d, In2 = %d, Out = %d, Flags = %d", In1, In2, Out, Flags);
    
    $display("All tests completed successfully."); // End simulation
  end
      
endmodule
