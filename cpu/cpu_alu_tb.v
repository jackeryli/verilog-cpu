`timescale 1ns/1ps

module Cpu_ALU_tb;

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
    
    $readmemb("alu_instruction_set.txt", cpu.ram.memory);

    #100

    #10 rst = 1;

    #100

    #1000 $finish;
  end

endmodule
