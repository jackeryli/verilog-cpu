module right_rotator (In, SR_Bit, Out);
    parameter N = 32;

    input [N-1:0] In;
    input [4:0] SR_Bit;
    output wire [N-1:0] Out;
    
    assign Out = In << (N-1-SR_Bit) | In >> SR_Bit;
endmodule
