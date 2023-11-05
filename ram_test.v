module RAM_tb;
reg RW;
reg [15:0] address;
reg [31:0] data_input;
wire [31:0] data_output;

RAM_2_16x32 uut(
    .data_input(data_input),
    .data_output(data_output),
    .RW(RW),
    .address(address)
);

initial begin
    #5 RW=1; address=65536'd0; data_input=32'hAAAAAAA0;
    #5 RW=1; address=65536'd1; data_input=32'hAAAAAAA1;
    #5 RW=1; address=65536'd2; data_input=32'hAAAAAAA2;
    #5 RW=1; address=65536'd3; data_input=32'hAAAAAAA3;
    #5 RW=1; address=65536'd4; data_input=32'hAAAAAAA4;
    #5 RW=1; address=65536'd5; data_input=32'hAAAAAAA5;
    #5 RW=1; address=65536'd6; data_input=32'hAAAAAAA6;
    #5 RW=1; address=65536'd7; data_input=32'hAAAAAAA7;

    #100

    $writememh("ram_data.txt", uut.memory);
    #100

    #5 RW=0; address=65536'd0; #5 $display("Mermoy at %d: %h", address, data_output);
    #5 RW=0; address=65536'd1; #5 $display("Mermoy at %d: %h", address, data_output);
    #5 RW=0; address=65536'd2; #5 $display("Mermoy at %d: %h", address, data_output);
    #5 RW=0; address=65536'd3; #5 $display("Mermoy at %d: %h", address, data_output);
    #5 RW=0; address=65536'd4; #5 $display("Mermoy at %d: %h", address, data_output);
    #5 RW=0; address=65536'd5; #5 $display("Mermoy at %d: %h", address, data_output);
    #5 RW=0; address=65536'd6; #5 $display("Mermoy at %d: %h", address, data_output);
    #5 RW=0; address=65536'd7; #5 $display("Mermoy at %d: %h", address, data_output);

    $finish;
end
endmodule