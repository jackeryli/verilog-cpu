module RAM_2_16x32 (
    data_input,
    data_output,
    RW,
    address
);
integer i=0;
input [31:0] data_input;
input [15:0] address;
input RW;
output reg [31:0] data_output;

reg [31:0] memory [0:65535];

always @(*)
    begin
        // Write to memory
        if (RW == 1'b1) begin
            memory[address] = data_input;
        end
        // Read from memory
        else if (RW == 1'b0) begin
            data_output = memory[address];
        end
        else data_output= 32'b0;
    end
endmodule