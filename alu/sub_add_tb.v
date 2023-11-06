`timescale 1ns / 1ps
module sub_add_tb;

   // Inputs
    reg [31:0] In1;
    reg [31:0] In2;
    reg [3:0] opcode;
    reg [4:0] SR_Bit;
    reg [2:0] SR_Cont;

    //output
    wire [31:0] Out;

    alu_simple uut(
        .In1(In1),
        .In2(In2),
        .Out(Out),
        .opcode(opcode), 
        .SR_Cont(SR_Cont), 
        .SR_Bit(SR_Bit)
    );

    initial begin
        In1 = 0 ;
        In2 = 0;
        opcode = 0;
        SR_Bit = 0;
        SR_Cont = 0;

         #100;
        // Test addition
        // opcode = 4'b0000; // Addition opcode
        // In1 = -15;
        // In2 = -20;
        // SR_Bit = 5; // Random shift for testing, not needed for addition
        // SR_Cont = 3'b000; // No shift operation
        // #10;
        // if (Out != (In1 + In2)) $display("Addition Test Failed!");

        // // Test subtraction
        opcode = 4'b0001; // Subtraction opcode
        In1 = -30;
        In2 = -10;
        SR_Bit = 2; // Random shift for testing, not needed for subtraction
        SR_Cont = 3'b000; // No shift operation
        #10;
        if (Out != (In1 - In2)) begin
            $display("Out=%d, In1=%d, In2=%d", Out, In1, In2);
            $display("Subtraction Test Failed!");
        end

    end
endmodule
