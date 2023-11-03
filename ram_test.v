module RAM_tb;
//use register for testbench
reg clk, rst;
reg write_enable, read_enable;
reg [15:0] address;
// reg [31:0] in_out;
reg [31:0] data_input;
wire [31:0] data_output;
// reg [31:0] WriteRAM;

RAM_2_16x32 uut(
    // .data_io(in_out),
    .write_enable(write_enable),
    // .WriteRAM(WriteRAM),
    .data_input(data_input),
    .data_output(data_output),
    .read_enable(read_enable),
    .address(address),
    .clk(clk),
    .rst(rst)
);

initial begin
    // $monitor($time,,,
    // "Data=%d",data_output);
clk = 0;
rst = 0;
data_input = 0;
write_enable = 0;
read_enable = 0;
#10 rst = 1;
#10 rst = 0;//reset finish

#10//write enable test
data_input = 20; //in adr 30 write 10
address = 66;
write_enable = 0;

#10
//read adr 30
write_enable = 1;

#10
write_enable = 0;
read_enable = 1;

#10
address = 55;


// $finish();
end

always #5 clk = ~clk;
endmodule