module right_rotator (In, Out);
    input [31:0] In;
    output wire [31:0] Out;
    parameter SR_Bit = 1;
    assign Out = {In[31-SR_Bit:0], In[31:SR_Bit]};
endmodule
