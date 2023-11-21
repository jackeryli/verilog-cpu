`timescale 1ns/1ps

module Cpu_tb;

  // Inputs
  reg clk;
  reg rst;

  // Instantiate the CPU module
  Cpu cpu (
    .clk(clk),
    .rst(rst)
  );

  integer i;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset generation
  initial begin

    rst = 0;

    $readmemb("ldr_instruction_set.txt", cpu.ram.memory);

    #100

    #10 rst = 1;

    #5
    // Loop to display register values
    for (i = 0; i < 16; i = i + 1) begin
      $display("reg %d = %b", i, cpu.register.registers[i]);
    end

    #5
    for (i = 0; i < 16; i = i + 1) begin
      $display("reg %d = %b", i, cpu.register.registers[i]);
    end

    #5
    for (i = 0; i < 16; i = i + 1) begin
      $display("reg %d = %b", i, cpu.register.registers[i]);
    end

  end

  // Add other test scenarios here...

  // Simulation duration
  initial #1000 $finish;

endmodule
