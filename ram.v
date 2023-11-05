module RAM_2_16x32 (
    data_input,
    data_output,
    // data_io,
    write_enable,
    read_enable,
    address
    // clk
);
parameter words_num = 32, address_bus = 16;
integer i=0;
// input clk,rst;
input [words_num-1:0] data_input;
input [address_bus-1:0] address;
input write_enable, read_enable;
output reg [words_num-1:0] data_output;
// reg [words_num-1:0] WriteRAM;

// inout [words_num-1:0] data_io;

reg [words_num-1:0] memory [0:(1<<address_bus)]; //32-bits memory with 2^16 words

// always @(posedge clk or posedge rst)
always @(*)
    begin
        // if(rst) begin
        //     for (i=0;i<(1<<address_bus);i=i+1) begin
        //         memory[i]<=32'b0;
        //     end
        // end
        if (write_enable) begin
            memory[address] <= data_input;
            // data_output <= 32'b0;
        end
        else if (read_enable) begin
            data_output <= memory[address];
        end
        else begin
            data_output <= 32'b0;
        end
    end
//  assign data_output = read_enable? WriteRAM: 32'bz;
endmodule
