module RAM_2_16x32 (
    data_input,
    data_output,
    write_enable,
    read_enable,
    address
);
parameter words_num = 32, address_bus = 16;
integer i=0;
input [words_num-1:0] data_input;
input [address_bus-1:0] address;
input write_enable, read_enable;
output reg [words_num-1:0] data_output;


reg [words_num-1:0] memory [0:(1<<address_bus)];

always @(*)
    begin
        if (write_enable) begin
            memory[address] = data_input;
        end
        else if (read_enable) begin
            data_output = memory[address];
        end
        else begin
            data_output = 32'b0;
        end
    end
endmodule