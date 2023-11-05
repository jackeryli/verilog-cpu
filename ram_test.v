module RAM_tb;
reg write_enable, read_enable;
reg [15:0] address;
reg [31:0] data_input;
wire [31:0] data_output;

RAM_2_16x32 uut(
    .write_enable(write_enable),
    .data_input(data_input),
    .data_output(data_output),
    .read_enable(read_enable),
    .address(address)
);

initial begin
data_input = 0;
write_enable = 0;
read_enable = 0;

#10
data_input = 20;
address = 66;
write_enable = 0;

#10
write_enable = 1;

#10
write_enable = 0;
read_enable = 1;

#10
read_enable = 0;
data_input = 1;
address = 55;

#10
write_enable = 1;

#10
write_enable = 0;
read_enable = 1;
#10
read_enable = 0;


end
endmodule