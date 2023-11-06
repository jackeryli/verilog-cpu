module RAM_2_16x32 (
    data_input,
    data_output,
    RW,
    address
);
parameter words_num = 32, address_bus = 32;
integer i=0;
input [words_num-1:0] data_input;
input [address_bus-1:0] address;
input RW;
output reg [words_num-1:0] data_output;

reg [words_num-1:0] memory [0:(1<<address_bus)];

always @(*)
    begin
        // Write to memory
        if (RW == 1'b1) begin
            memory[address] = data_input;
        end
        // Read from memory
        else begin
            data_output = memory[address];
        end
    end
endmodule