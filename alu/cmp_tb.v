`timescale 1ns / 1ps

module cmp_tb;

  // Inputs
  reg signed [31:0] In1;
  reg signed [31:0] In2;
  reg S;
  reg signed [31:0] num;
  reg signed [32:0] sum;

  // Output
  wire [3:0] flag;

  // Instantiate the Unit Under Test (UUT)
  cmp uut (
    .In1(In1), 
    .In2(In2), 
    .S(S), 
    .flag(flag)
  );

  initial begin
    // Initialize Inputs
    In1 = 0;
    In2 = 0;
    S = 0;
    num = -32'd15;
    #100;
    $display("Number is %d in decimal and %b in binary", num, num);
    // Wait 100 ns for global reset to finish
    #20;
      
    // Add stimulus here
    In1 = 32'd10; In2 = -32'd15; S = 0; sum = In1+In2; // Positive vs Negative
    #10; // Wait for 10 ns
    $display("Test 1: In1 = %d, In2 = %d, Flags = %b, Sum = %d", In1, In2, flag, sum);

    In1 = 32'd7; In2 = -32'd2; S = 0; sum = In1+In2; // Negative vs Positive
    #10;
    $display("Test 2: In1 = %b, In2 = %b, Flags = %b, Sum = %b", In1, In2, flag, sum);

    In1 = 32'd5; In2 = 32'd5; S = 0; // Equal numbers
    #10;
    $display("Test 3: In1 = %d, In2 = %d, Flags = %b", In1, In2, flag);

    In1 = 32'd0; In2 = -32'd1; S = 0; // Zero vs Negative
    #10;
    $display("Test 4: In1 = %d, In2 = %d, Flags = %b", In1, In2, flag);

    In1 = -32'd32768; In2 = 32'd32767; S = 0; // Overflow condition
    #10;
    $display("Test 5: In1 = %d, In2 = %d, Flags = %b", In1, In2, flag);

    // Add more tests as needed
    // ...

    $display("All tests completed successfully."); // End simulation
  end
      
endmodule
