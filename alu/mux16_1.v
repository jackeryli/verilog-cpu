module mux16_1 (In, Out, sel);
input [31:0] In [0:15];
input [3:0] sel;
output reg [31:0] Out;
always @ * begin
    case (sel)
    4'b0000: Out = In[0];
    4'b0001: Out = In[1];
    4'b0010: Out = In[2];
    4'b0011: Out = In[3];
    4'b0100: Out = In[4];
    4'b0101: Out = In[5];
    4'b0110: Out = In[6];
    4'b0111: Out = In[7];
    4'b1000: Out = In[8];
    4'b1001: Out = In[9];
    4'b1010: Out = In[10];
    4'b1011: Out = In[11];
    4'b1100: Out = In[12];
    4'b1101: Out = In[13];
    4'b1110: Out = In[14];
    4'b1111: Out = In[15];
    endcase
end
endmodule
